CREATE ROLE nextcloud;
ALTER ROLE nextcloud WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5640f5501a953f74b5b200fdae3d52737';
CREATE DATABASE nextclouddb OWNER nextcloud;
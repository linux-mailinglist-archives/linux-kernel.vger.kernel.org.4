Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E271A5FBAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJKTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJKTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:01:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99638263D;
        Tue, 11 Oct 2022 12:00:58 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 85796197F;
        Tue, 11 Oct 2022 19:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 85796197F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665514858; bh=hJ7ssfMtbgBA0SjAT4Inkea7XgTAme5JsmDhLulk9CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izd2KXK0byOUWqK4osKVPxpVo1gFsR3ysSOqkhz7JmcfjcbbheW1WC3zwNvA3vfQ+
         YnnMG2uBU1E5/W5CO5sghZslhWVrZP9jhpKoQ8bQDzOHjYr5vpNLKILrQvNNK3JJbU
         4bWwzVa57JN6LhRCbQZ68hH6whcKkp2XKfdAFEmb9ryRDCB6AGYhGfuWylAu8szsew
         LJwPUyWgKCowqB3oGkdF8ZtczeRJVcY2d+E3145VA+oavC1LlwkoKDjBGedbgosa+h
         1lE87foFiyZ+b4c7zI809K2LADx4s0ZQeviJklJy//MOV0vmqVwiCP+sQIBWyQ4lTv
         eGDpOjAeICpcg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 4/6] docs: sphinx-pre-install: don't require the RTD theme
Date:   Tue, 11 Oct 2022 13:00:45 -0600
Message-Id: <20221011190047.749145-5-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221011190047.749145-1-corbet@lwn.net>
References: <20221011190047.749145-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't default to the RTD theme anymore, so sphinx-pre-install need not
insist on installing it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/requirements.txt | 1 -
 scripts/sphinx-pre-install            | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 2c573541ab71..335b53df35e2 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,4 +1,3 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
-sphinx_rtd_theme
 Sphinx==2.4.4
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index ec84fc62774e..1fb88fdceec3 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -362,7 +362,6 @@ sub give_debian_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
-		"sphinx_rtd_theme"	=> "python3-sphinx-rtd-theme",
 		"ensurepip"		=> "python3-venv",
 		"virtualenv"		=> "virtualenv",
 		"dot"			=> "graphviz",
@@ -397,7 +396,6 @@ sub give_redhat_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
-		"sphinx_rtd_theme"	=> "python3-sphinx_rtd_theme",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -475,7 +473,6 @@ sub give_opensuse_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
-		"sphinx_rtd_theme"	=> "python3-sphinx_rtd_theme",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -523,7 +520,6 @@ sub give_mageia_hints()
 {
 	my %map = (
 		"python-sphinx"		=> "python3-sphinx",
-		"sphinx_rtd_theme"	=> "python3-sphinx_rtd_theme",
 		"virtualenv"		=> "python3-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "ImageMagick",
@@ -567,7 +563,6 @@ sub give_mageia_hints()
 sub give_arch_linux_hints()
 {
 	my %map = (
-		"sphinx_rtd_theme"	=> "python-sphinx_rtd_theme",
 		"virtualenv"		=> "python-virtualenv",
 		"dot"			=> "graphviz",
 		"convert"		=> "imagemagick",
@@ -598,7 +593,6 @@ sub give_arch_linux_hints()
 sub give_gentoo_hints()
 {
 	my %map = (
-		"sphinx_rtd_theme"	=> "dev-python/sphinx_rtd_theme",
 		"virtualenv"		=> "dev-python/virtualenv",
 		"dot"			=> "media-gfx/graphviz",
 		"convert"		=> "media-gfx/imagemagick",
@@ -895,7 +889,6 @@ sub recommend_sphinx_version($)
 	$verbose_warn_install = 0;
 
 	add_package("python-sphinx", 0);
-	check_python_module("sphinx_rtd_theme", 1);
 
 	check_distros();
 
@@ -968,7 +961,6 @@ sub check_needs()
 	check_perl_module("Pod::Usage", 0);
 	check_program("make", 0);
 	check_program("gcc", 0);
-	check_python_module("sphinx_rtd_theme", 1) if (!$virtualenv);
 	check_program("dot", 1);
 	check_program("convert", 1);
 
-- 
2.37.2


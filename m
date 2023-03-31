Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC36D222C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCaOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:15:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F92139
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:15:43 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bz27so21782784qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680272142;
        h=mime-version:user-agent:date:message-id:cc:subject:from:to:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XZHHZx5ox+zEBkcSJ8e6zeeJqxn3l/oa2vvojQG+IJU=;
        b=MCqZjtfnCgXy8Oc5c3zr5+QXzxQ/aUVcQN3GxASlgiC49QwKbpl+mj8a233f9J3zLF
         2/kPva3y1dVPfCh8ZpRi1kjA6XYrZbcluGclTXkS8IueSoND3LeZ+lG2c4mGkfdWhCrS
         OhTXfiwpDfRN/1TnKdoNBKya7z7pBPR6255Axg/jj+MGJiX/HndmFaMbqY1tb91IdknJ
         Uym6xMTsJ4mXLWJ0nHRkw4hb7r9i+ZTVZJXApaEhGnJncP3F9wui1A9tcVAJrXRKPaW/
         g5v3Xaea9d3xJrUshadNqFbExFPaVSTrQVAMG6+zLSS42fKcvZjumXV1IU9SKREquMea
         B17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272142;
        h=mime-version:user-agent:date:message-id:cc:subject:from:to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZHHZx5ox+zEBkcSJ8e6zeeJqxn3l/oa2vvojQG+IJU=;
        b=qbgAzE4Q35CljlrNiAYi2APMPGlyuaEO4L65U+8Nuh3H5dnI2rhpz1wVoDqMWVZVDp
         DT+uDU9+fvX70nlypJ7Uy3Oevhi/SgcTv7pC/1Hvw/KMb59Gwm8ESCUcsI3tkZ/LWeLj
         9JfeG+t6tT3KxgchvVx+jzwTZhCCo88osNFVCZYUHWsa1aWSCzwha3xyMZEjfab0Shj4
         F/ZCfqzxINGO6/rExra+yWqRCbzKQh5Q3zanzk7ZZraFyBHTf4yOvWfak5zP58TSUUkZ
         qodRN48DchezMnOftRT8gvOkMs2FI1LMatJQZFwGlvGwH/5MMwg1k1orkxBHgXNWlOv0
         yr7Q==
X-Gm-Message-State: AO0yUKUvnxjyHnJhhOXH4gCt8wjD5EgnPY8EWA1iWH13CUZkIglbRH/j
        +2uD40geUEHJ7HLdTjMfFCe4yMkzrg==
X-Google-Smtp-Source: AK7set81D8j0QK9VlqCNcVglEHjIyxyoeykiaBDqv6ZLT6zn8QOkVEqBXQnAb4+WSV84U1SHAX/mhQ==
X-Received: by 2002:a05:622a:1648:b0:3da:b84f:c421 with SMTP id y8-20020a05622a164800b003dab84fc421mr43697046qtj.2.1680272142402;
        Fri, 31 Mar 2023 07:15:42 -0700 (PDT)
Received: from [120.7.1.38] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id d4-20020a0cf6c4000000b005dd8b9345d5sm604195qvo.109.2023.03.31.07.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:15:41 -0700 (PDT)
To:     Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH] 3 small patches for the 6.3 build scripts
Cc:     Woody Suwalski <terraluna977@gmail.com>
Message-ID: <b99224fb-85f8-8526-7148-988df800a6ad@gmail.com>
Date:   Fri, 31 Mar 2023 10:15:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101 Firefox/91.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EFFDAB38339A894115CA75E4"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EFFDAB38339A894115CA75E4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

1. Fix a spell typo in mkdebian script.

Fixes: spelling error in scripts/package/mkdebian
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/package/mkdebian    2023-03-30 18:46:06.008350787 -0400
+++ b/scripts/package/mkdebian    2023-03-31 09:31:28.063637332 -0400
@@ -175,7 +175,7 @@ EOF

  # Generate copyright file
  cat <<EOF > debian/copyright
-This is a packacked upstream version of the Linux kernel.
+This is a packaged upstream version of the Linux kernel.

  The sources may be found at most Linux archive sites, including:
  https://www.kernel.org/pub/linux/kernel


2. Fix an invalid user-mode subarch architecture name.
The x86 32-bit architecture name should be i386, not x86.
The SUBARCH tag is used in UM arch check in scripts/tags.sh.

Fixes: incorrect user mode subarch tag in scripts/subarch.include
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/subarch.include    2023-02-19 17:24:22.000000000 -0500
+++ b/scripts/subarch.include    2023-03-30 11:18:05.357082494 -0400
@@ -4,7 +4,7 @@
  # then ARCH is assigned, getting whatever value it gets normally, and
  # SUBARCH is subsequently ignored.

-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/x86_64/x86/ \
                    -e s/sun4u/sparc64/ \
                    -e s/arm.*/arm/ -e s/sa110/arm/ \
                    -e s/s390x/s390/ \

3.In 6.3 the mkdebian script started to wipe the debian directory.
On my build system I have been installing a "real" changelog file with 
build history
into the unpacked/patched kernel tree before calling "make bindeb-pkg".
It seems that a workaround could be to copy the real changelog into 
another directory,
e.g. patches/, and then if the patches/changelog file exists, move it to 
the debian/
directory and skip creation of a stock changelog file.

Fixes: in Debian packaging use a real changelog file if provided
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/package/mkdebian    2023-03-31 09:38:14.620023584 -0400
+++ b/scripts/package/mkdebian    2023-03-31 09:38:55.704050033 -0400
@@ -164,14 +164,18 @@ echo $debarch > debian/arch
  extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC 
libelf-dev:native)"
  extra_build_depends="$extra_build_depends, $(if_enabled_echo 
CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"

-# Generate a simple changelog template
-cat <<EOF > debian/changelog
+if [ ! -s patches/changelog ]; then
+    # Generate a simple changelog template
+    cat <<EOF > debian/changelog
  $sourcename ($packageversion) $distribution; urgency=low

    * Custom built Linux kernel.

   -- $maintainer  $(date -R)
  EOF
+else
+    mv patches/changelog debian
+fi

  # Generate copyright file
  cat <<EOF > debian/copyright

Thanks, Woody



--------------EFFDAB38339A894115CA75E4
Content-Type: text/x-patch;
 name="[PATCH]mkdebian_spell.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="[PATCH]mkdebian_spell.patch"

Fixes: spelling error in scripts/package/mkdebian
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/package/mkdebian	2023-03-30 18:46:06.008350787 -0400
+++ b/scripts/package/mkdebian	2023-03-31 09:31:28.063637332 -0400
@@ -175,7 +175,7 @@ EOF
 
 # Generate copyright file
 cat <<EOF > debian/copyright
-This is a packacked upstream version of the Linux kernel.
+This is a packaged upstream version of the Linux kernel.
 
 The sources may be found at most Linux archive sites, including:
 https://www.kernel.org/pub/linux/kernel

--------------EFFDAB38339A894115CA75E4
Content-Type: text/x-patch;
 name="[PATCH]subarch_i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="[PATCH]subarch_i386.patch"

Fixes: incorrect user mode subarch tag in scripts/subarch.include
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/subarch.include	2023-02-19 17:24:22.000000000 -0500
+++ b/scripts/subarch.include	2023-03-30 11:18:05.357082494 -0400
@@ -4,7 +4,7 @@
 # then ARCH is assigned, getting whatever value it gets normally, and
 # SUBARCH is subsequently ignored.
 
-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/x86_64/x86/ \
 				  -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ \

--------------EFFDAB38339A894115CA75E4
Content-Type: text/x-patch;
 name="[PATCH]mkdebian_changelog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="[PATCH]mkdebian_changelog.patch"

Fixes: in Debian packaging use a real changelog file if provided
Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/scripts/package/mkdebian	2023-03-31 09:38:14.620023584 -0400
+++ b/scripts/package/mkdebian	2023-03-31 09:38:55.704050033 -0400
@@ -164,14 +164,18 @@ echo $debarch > debian/arch
 extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
 extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
 
-# Generate a simple changelog template
-cat <<EOF > debian/changelog
+if [ ! -s patches/changelog ]; then
+	# Generate a simple changelog template
+	cat <<EOF > debian/changelog
 $sourcename ($packageversion) $distribution; urgency=low
 
   * Custom built Linux kernel.
 
  -- $maintainer  $(date -R)
 EOF
+else
+	mv patches/changelog debian
+fi
 
 # Generate copyright file
 cat <<EOF > debian/copyright

--------------EFFDAB38339A894115CA75E4--

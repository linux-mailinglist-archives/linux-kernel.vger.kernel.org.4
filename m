Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F370649184
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLJXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLJXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:02:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74291402E;
        Sat, 10 Dec 2022 15:02:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 21so6157178pfw.4;
        Sat, 10 Dec 2022 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbQVHhDJyzijvT4x1l1d64e6Tgo3Ph+ZZvjIzYq/8P0=;
        b=BC51zln0pmZC6OGmdhqN2MW43ldQkZqt7n/UKeTJ2K5nyKNKixaasUFdg1UtQr/7Dy
         7dwNkuh7zWWPAZ3DR1gk7EH9nwVHvm2vP1BBAeK/f3luz0TviH5CTGJOhY8mD7UF7e1P
         xjS/w5zerB9WfgCmdrewkqOkW30R5ptrhehbA9gwHFlWTgumHLf5h2HBCjOojKyn2Ryz
         0qY+ywf3tuBtmsHlktfEeUuUkWOb6AF6UwksylVoOcedPUeFzOQj0bHq3poA+6rUxHkW
         WTAfLI1sqbuEnJ4hD2vp8Zt6lJBjWJ8f/u6ig8rB9N56Jezq4pdfC4KjNhKcj0Melnj7
         t6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbQVHhDJyzijvT4x1l1d64e6Tgo3Ph+ZZvjIzYq/8P0=;
        b=KlTE8NTK7lPOnr22VVdSfkalf186aLmXOWbr/j3JtJgwSeFe/xzsg3HHm9+GDokjAS
         8jVJttogs/CmdD/bx03M+no8nQlsj5oFO6WfKndEd6AYu11X6YJZUzPBWJXo6F28O5sU
         vj+zcQy9ZH144w+1Rpxmnmrb78ILI82TCkavpSoK5kObwTay7zot2lcQuoAN+dDYqC0F
         1WjleDyoUfllBR7UjZ8F5Kjsg5lMKhpnZG6jsGf9XILoppF6XRHwvSvMUf3n/3AugsZ7
         3Q8vN6j5oCuicy+hNdC33twPDrZgw2Th+vaNUMI90dBUUvJH4l3k5s2AqfqSHr6Y5YCr
         ZqHA==
X-Gm-Message-State: ANoB5plLMgm7jqOrKEcDV7TKGh7Z/cPWE73LOQNyuQmTBuIlevIe4e6M
        hhVJrPMNJv/7AIwREJSCcPE=
X-Google-Smtp-Source: AA0mqf69H0IH7rB1HqJxeoajFYEA7oWnuviAeVEtYkeQoTZagMb+BHeXO24tP/bnf9r379qO3dgZxw==
X-Received: by 2002:aa7:9089:0:b0:566:900d:8242 with SMTP id i9-20020aa79089000000b00566900d8242mr2345930pfa.3.1670713347279;
        Sat, 10 Dec 2022 15:02:27 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79acc000000b0057725613627sm3283714pfp.142.2022.12.10.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 15:02:26 -0800 (PST)
Date:   Sun, 11 Dec 2022 12:02:18 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v2] scripts/tags.sh: choose which directories to exclude from
 being indexed
Message-ID: <Y5UP+tnnxNgoi6A2@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5T66yWNVAZNIaJ0@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's common for drivers that share same physical components to also
duplicate source code (or at least portions of it). A good example is
both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
file called atombios.h.

While their contents aren't the same, a lot of their structs have
the exact same names which makes navigating through the code base a bit
messy as cscope will show up 'references' across drivers which aren't
exactly correct.

This patch makes it possible for the devs to specify which folders
they don't want to include into database as part of the
find_other_sources func if a makefile variable IGNOREDIRS is present,
otherwise the original behaviour is kept.

Example:
        make ARCH=x86 IGNOREDIRS=drivers/gpu/drm/radeon,tools cscope

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v2: change approach to include everything unless specified by the
  IGNOREDIRS variable: (Req: Vipin Sharma)
- v1: https://lore.kernel.org/lkml/Y5OKDvbGk4Kro6MK@mail.google.com/
---
 Documentation/kbuild/kbuild.rst |  7 +++++++
 scripts/tags.sh                 | 11 +++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..5f99f30e20d8 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -278,6 +278,13 @@ To get all available archs you can also specify all. E.g.::
 
     $ make ALLSOURCE_ARCHS=all tags
 
+IGNOREDIRS
+---------------
+For tags/TAGS/cscope targets, you can choose which directories won't
+be included in the databases, separated by comma. E.g.:
+
+    $ make IGNOREDIRS=drivers/gpu/drm/radeon,tools cscope
+
 KBUILD_BUILD_TIMESTAMP
 ----------------------
 Setting this to a date string overrides the timestamp used in the
diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..554721e9cad2 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -59,10 +59,17 @@ find_include_sources()
 }
 
 # find sources in rest of tree
-# we could benefit from a list of dirs to search in here
 find_other_sources()
 {
-	find ${tree}* $ignore \
+	local loc_ignore=${ignore}
+	if [ -n "${IGNOREDIRS}" ]; then
+		exp_ignored_dirs=$(sed 's/,/ /g' <<< ${IGNOREDIRS})
+		for i in ${exp_ignored_dirs}; do
+			loc_ignore="${loc_ignore} ( -path $i ) -prune -o"
+		done
+	fi
+
+	find ${tree}* ${loc_ignore} \
 	     \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
 	       -name "$1" -not -type l -print;
 }
-- 
2.38.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EF65C7D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjACUDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjACUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:03:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0957C140A7;
        Tue,  3 Jan 2023 12:03:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jn22so33743665plb.13;
        Tue, 03 Jan 2023 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8pcmuonN+UPPt9cmF4NX78AveTfQL9Fb1MLveIduoE=;
        b=jkLGFFO8+Ncdr+JTqPLzpv/WoBKqm9vRdqXUnfflH2/zvCrF/p3nMdYk9jdVSe+B7g
         XtpT42DUgZB2Sn+1rLdiPYbHliJPuzHK1jZcLXP9Dw0YOmDEJPjbgdp4w8Z/OsIzS+h2
         KtyEkBf99fdCIJWl7M2PAAJ8L7kvBQeCqeJkelVD1ASmMNslVe8lr33wAqw0luP0qQtj
         OedssMr9oa6iUY35WUgIkVIFcEjDvEqjK3WNKZKm3Ct5pvO8AHWczw5+mxOrwi8gUaAr
         nXZ+eZ5e2+8zrRqcScLfoqp1Dz20lbOvGCxnCpub3GR5JVH1WNvZPEphAF/Vz5w0MJ6K
         TIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8pcmuonN+UPPt9cmF4NX78AveTfQL9Fb1MLveIduoE=;
        b=QPrZ4544xs+tBiJxqy1Ktb6SmhKhAXX9qDgY3KiohZLlGubb7liaFMdChRN8WjKAgf
         Z2G63PHUfSjWlE1hILigW/iJRFLhAAEm/FCgEQnodWSaVz31Znh9H/DaPPTrStYciOzv
         7vcBUlcau3aK9J29KJ+PfjnVLqbBI+t8X6NxBHxoAtwk88VORzcXkII/UnS1fHuhp9Yj
         dHifrCUesBvFt3iaUGMkOjgp2HTeCQtz6peo5ujXnex3I8Y18hLgQl8fMH5x/Qlzdiuq
         krMX9fkLAspCoLgcdLv1VDDkfJcKm9yjq+VLvPreRWmG6WUoQtffRNqi4Kej7SliSicj
         bqPw==
X-Gm-Message-State: AFqh2kp/3SZYItWdWgpts05Yje9kn5vvyfonJHlE1PBpjxVzs+3vEai1
        MbiBWH3Aog/j1GcrZIkn17k=
X-Google-Smtp-Source: AMrXdXuCthXxzHEN+zTEW6sH37VtiYU63bNpVQuA7kInozlY5IXAd6NkqnJRjVZtzA5aT6IesVUjGw==
X-Received: by 2002:a17:902:6acb:b0:191:40a9:60f6 with SMTP id i11-20020a1709026acb00b0019140a960f6mr10836769plt.0.1672776206043;
        Tue, 03 Jan 2023 12:03:26 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001929827731esm12894682plb.201.2023.01.03.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 12:03:25 -0800 (PST)
Date:   Wed, 4 Jan 2023 09:03:18 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, corbet@lwn.net,
        cristian.ciocaltea@collabora.com, gregkh@linuxfoundation.org,
        vipinsh@google.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v3 RESEND] scripts/tags.sh: choose which directories to
 exclude from being indexed
Message-ID: <Y7SKBqxULPofEry7@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Add IGNORE_DIRS variable, which specifies which directories
to be ignored from indexing.

Example:
        make ARCH=x86 IGNORE_DIRS="drivers/gpu/drm/radeon tools" cscope

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v3: change commit message wording and rst syntax (Req Bagas Sanjaya)
      change makefile variable scope to global, use blank space
      separator and change variable name to IGNORE_DIRS.
      (Req: Vipin Sharma)
- v2: change approach to include everything unless specified by the 
  IGNOREDIRS variable: (Req: Vipin Sharma)
- v1: https://lore.kernel.org/lkml/Y5OKDvbGk4Kro6MK@mail.google.com/

Additional notes (if relevant):
- Patch v3 was reviewed-by Vipin Sharma here:
  https://lore.kernel.org/lkml/CAHVum0eNp5Dup_KyrS2N0zu5TfrtcCxphRnLuBFZa5PxahVg7A@mail.gmail.com/
---
 Documentation/kbuild/kbuild.rst | 7 +++++++
 scripts/tags.sh                 | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..5202186728b4 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -278,6 +278,13 @@ To get all available archs you can also specify all. E.g.::
 
     $ make ALLSOURCE_ARCHS=all tags
 
+IGNORE_DIRS
+-----------
+For tags/TAGS/cscope targets, you can choose which directories won't
+be included in the databases, separated by blank space. E.g.::
+
+    $ make IGNORE_DIRS="drivers/gpu/drm/radeon tools" cscope
+
 KBUILD_BUILD_TIMESTAMP
 ----------------------
 Setting this to a date string overrides the timestamp used in the
diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..1ad45f17179a 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -17,6 +17,13 @@ ignore="$(echo "$RCS_FIND_IGNORE" | sed 's|\\||g' )"
 # tags and cscope files should also ignore MODVERSION *.mod.c files
 ignore="$ignore ( -name *.mod.c ) -prune -o"
 
+# ignore arbitrary directories
+if [ -n "${IGNORE_DIRS}" ]; then
+	for i in ${IGNORE_DIRS}; do
+		ignore="${ignore} ( -path $i ) -prune -o"
+	done
+fi
+
 # Use make KBUILD_ABS_SRCTREE=1 {tags|cscope}
 # to force full paths for a non-O= build
 if [ "${srctree}" = "." -o -z "${srctree}" ]; then
-- 
2.38.1


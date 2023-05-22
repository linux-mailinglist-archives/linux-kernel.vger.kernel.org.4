Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355D70B2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEVAzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 20:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 20:55:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075ACF;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1afa6afcf4fso8871095ad.0;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684716910; x=1687308910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeHWs4TMvYrjLFyahG6AgBgtUUvTSDY2RBDGAImwGlQ=;
        b=FpLsxQo4y63m6KB06pOjVUSYuEGRiijRveD2UWMz6LnLA5cPSss4NbN7tlyclIphoT
         ODrCalDiTqyP2SNtZyVFok4M/UITNbsKV2Qyoi9TIzZCC690fVx19JNJHbGz8jhnOEhv
         bbgqNQLHF5mmod0B/ngjLo6sGg5keftVfoyCupJ48SQc1SnfL9zf/NfUmhOYH/vactMK
         tcDaJnf50Ds6hk3jsgd3CZT9w8aA+KmGZYciBzwsPflJ7UVi3/nqjvzRGW1qTs1ZLv7+
         KTUmPDNIJYZGECHdDDbOyt7Y+weQjHi8mrhZa4alSexx/SNR/ph6QaMaGHybuMlnFSYu
         NRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684716910; x=1687308910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeHWs4TMvYrjLFyahG6AgBgtUUvTSDY2RBDGAImwGlQ=;
        b=kvM3n3q1qLE2QC2dw3QV7ucnMTBmXD6s0YhHly+nwy0XRpeDgfct93FF58RJGeL1s3
         /DrduSXuNSAtAyBlb9guwk+BpSR6S6PN9Jmxw4/vsYhiBSby6ecCCwLBYvVzY/OxGctk
         zGM29ba0FQdlYJZjG+xKF2kP5GPM82n6C+IiZ7PpKrQA3v9ZG71xE99JVRh4vFAoAue5
         xKg/2+md5DV3VnUSFpoF+eITzjUNIv8dg/r4SsWaVWeJR/JVrO8HX0T/Cs3/W2eeJf2T
         pQe29S1mvuAOmf7B95uPFQxkaW1kkyWjJThjvwW4MxXFSthGsUfS9Q914Msr40+7QX6T
         /3Dw==
X-Gm-Message-State: AC+VfDz555rj0HPUE7LrfEu/A9/chET4pOqdtInKqZLT1SeRkaxFzhso
        mKxPWiVjUmH4tl68vw4Ao7s=
X-Google-Smtp-Source: ACHHUZ7tvhoMMrHxpg7XBV+jKF18nfPu0Ne0ZbSbjusMa2iE78nkJ6Rjtcj4VF9uL0fGQsDh0tQDIg==
X-Received: by 2002:a17:903:32c8:b0:1ad:cba5:5505 with SMTP id i8-20020a17090332c800b001adcba55505mr11079227plr.14.1684716910299;
        Sun, 21 May 2023 17:55:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902b28200b0019ee045a2b3sm3472331plr.308.2023.05.21.17.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 17:55:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2463C106939; Mon, 22 May 2023 07:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 1/2] fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX identifier
Date:   Mon, 22 May 2023 07:54:34 +0700
Message-Id: <20230522005434.22133-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522005434.22133-1-bagasdotme@gmail.com>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9922; i=bagasdotme@gmail.com; h=from:subject; bh=ENYRulR8xCF2JJMyQYtBQI3u1s5NMgEVv0myAKHeNJ8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDClZe73Eex/zPNrwSsavT2xyRnu9nVqG6aQla4/lVLzeu +DoY/UNHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjItHhGhlVcf3kuHerlOhGz f/PVVfvkzq912XXm+7pZnokPJtuv8PnJyLDkTkbnvs/7b5Yfcqx7Z+DqViX3IVTDdA1zU/fEdme VaSwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notice refers to full GPL 2.0 text on now defunct MIT FTP site [1].
Replace it with appropriate SPDX license identifier.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pali Rohár <pali@kernel.org>
Link: https://web.archive.org/web/20020809115410/ftp://prep.ai.mit.edu/pub/gnu/GPL [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/udf/balloc.c    | 6 +-----
 fs/udf/dir.c       | 6 +-----
 fs/udf/directory.c | 6 +-----
 fs/udf/file.c      | 6 +-----
 fs/udf/ialloc.c    | 6 +-----
 fs/udf/inode.c     | 6 +-----
 fs/udf/lowlevel.c  | 6 +-----
 fs/udf/misc.c      | 6 +-----
 fs/udf/namei.c     | 6 +-----
 fs/udf/partition.c | 6 +-----
 fs/udf/super.c     | 6 +-----
 fs/udf/symlink.c   | 6 +-----
 fs/udf/truncate.c  | 6 +-----
 fs/udf/unicode.c   | 6 +-----
 14 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 14b9db4c80f03f..ab3ffc355949dc 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * balloc.c
  *
@@ -5,11 +6,6 @@
  *	Block allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2001 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 212393b12c2266..f6533f93851b95 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * dir.c
  *
@@ -5,11 +6,6 @@
  *  Directory handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2004 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 654536d2b60976..1c775e072b2fef 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * directory.c
  *
  * PURPOSE
  *	Directory related functions
  *
- * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
  */
 
 #include "udfdecl.h"
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8238f742377bab..b871b85457e5bb 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * file.c
  *
@@ -5,11 +6,6 @@
  *  File handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-1999 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 8d50121778a57d..5f7ac8c8479873 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ialloc.c
  *
@@ -5,11 +6,6 @@
  *	Inode allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1e71e04ae8f6b9..28cdfc57d946e3 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * inode.c
  *
@@ -5,11 +6,6 @@
  *  Inode handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
index c87ed942d07653..9d847a7a0905dd 100644
--- a/fs/udf/lowlevel.c
+++ b/fs/udf/lowlevel.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * lowlevel.c
  *
@@ -5,11 +6,6 @@
  *  Low Level Device Routines for the UDF filesystem
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 3777468d06ce58..0788593b6a1d8b 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * misc.c
  *
@@ -5,11 +6,6 @@
  *	Miscellaneous routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fd20423d3ed24c..49e1e0fe3feeb2 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * namei.c
  *
@@ -5,11 +6,6 @@
  *      Inode name handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *      This file is distributed under the terms of the GNU General Public
- *      License (GPL). Copies of the GPL can be obtained from:
- *              ftp://prep.ai.mit.edu/pub/gnu/GPL
- *      Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2004 Ben Fennema
  *  (C) 1999-2000 Stelias Computing Inc
  *
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 5bcfe78d5cabe9..af877991edc13a 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * partition.c
  *
@@ -5,11 +6,6 @@
  *      Partition handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *      This file is distributed under the terms of the GNU General Public
- *      License (GPL). Copies of the GPL can be obtained from:
- *              ftp://prep.ai.mit.edu/pub/gnu/GPL
- *      Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *
  * HISTORY
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6304e3c5c3d969..928a04d9d9e0ad 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * super.c
  *
@@ -15,11 +16,6 @@
  *    https://www.iso.org/
  *
  * COPYRIGHT
- *  This file is distributed under the terms of the GNU General Public
- *  License (GPL). Copies of the GPL can be obtained from:
- *    ftp://prep.ai.mit.edu/pub/gnu/GPL
- *  Each contributing author retains all rights to their own work.
- *
  *  (C) 1998 Dave Boynton
  *  (C) 1998-2004 Ben Fennema
  *  (C) 2000 Stelias Computing Inc
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index a34c8c4e6d2109..779b5c2c75f61e 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * symlink.c
  *
@@ -5,11 +6,6 @@
  *	Symlink handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1998-2001 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 2e7ba234bab8b8..a686c10fd709d1 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * truncate.c
  *
@@ -5,11 +6,6 @@
  *	Truncate handling routines for the OSTA-UDF(tm) filesystem.
  *
  * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
- *
  *  (C) 1999-2004 Ben Fennema
  *  (C) 1999 Stelias Computing Inc
  *
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b530b..ae6e809fa3aac7 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * unicode.c
  *
@@ -11,11 +12,6 @@
  *	UTF-8 is explained in the IETF RFC XXXX.
  *		ftp://ftp.internic.net/rfc/rfcxxxx.txt
  *
- * COPYRIGHT
- *	This file is distributed under the terms of the GNU General Public
- *	License (GPL). Copies of the GPL can be obtained from:
- *		ftp://prep.ai.mit.edu/pub/gnu/GPL
- *	Each contributing author retains all rights to their own work.
  */
 
 #include "udfdecl.h"
-- 
An old man doll... just what I always wanted! - Clara


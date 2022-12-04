Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B04641A93
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 04:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiLDDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 22:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 22:07:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2119284
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:07:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so2825721edj.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqguz0l3sOnKCX9uNWi6KHal1xhF9Ndsb++tkk5U3I0=;
        b=pFbLTCtb4ddOoEmstdp5qiSFnQEJHAz7VlJeeepgmYV7SEBum//QN7dbKuBf16MUsQ
         LNmZQI8x1czBZ91+8wPZgH8Q9+nSeA8SLKtuFqMcHPwK+4IzhVDaaEX7qk+/R6CGqfbt
         4JGiV0oAIf6M01XrvP5N7tuGYZ54VK5B9ZKh563wv3Hr0VLsmFrPLA+wCu8Sb200HTQ8
         tHHqz0vbX9CcFdNmR5PgDfFO5RkVPxpVSh3WPW+kJybRoA1l7Ksnhrii2owrUElbRLFp
         YDOR9ovZ8vhe5Cvv6mcAxDjuetR+Y+kt4IhbMGx5kyLhSFB23/SY5tTupp3kE1XRlK2s
         LDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqguz0l3sOnKCX9uNWi6KHal1xhF9Ndsb++tkk5U3I0=;
        b=0EwFeTMkG4C74ZnPi0p48Hnw5/fe8Q9rwnNrbQ04paH81FUk9tP6LBTrAdUIm6Mfi1
         CfB6M5dLd3wSpDq+rFut8eyFugQi3zn/tjojKHmd+Eh+EtAveR6bXXoiPZ2q9M4OBeDL
         tT+LvO1wvaodAemiAgDHDg8/aHang9PSxcIM9uC1wj/F958emZdemX+KxZrRc+rJqa+B
         d/qHgxTlJtHEEQiHXZOP4pB2m+Pj9JJzzUU3LKdP5dEg+vRqwwfihINuvKgWDoS0JL0d
         h9hHvXW69Aw0aYMedvPtXkJSHCkPKY519ggNCBBbBZfIKtnUZ1hNpQ/QO7TGiu557mAV
         LqDw==
X-Gm-Message-State: ANoB5pnpgNcrzHfsxmPXDl/ySUGrRouEhOR8TKdZBONYmmfsRZz1yGLf
        gJukbcQRTLpnCxR8pvd66G2vcL/aw1q8qSIAgdlz7UwfKNM=
X-Google-Smtp-Source: AA0mqf4M/nWrTNRhkhkmCMOhPcW0Zk59DXL+FeOJNxx9xu+11KIXacCxBFMyav50x3V072rWvCIzB7xfOF1rzbov9kM=
X-Received: by 2002:aa7:d7d4:0:b0:46b:7f11:10a4 with SMTP id
 e20-20020aa7d7d4000000b0046b7f1110a4mr20296620eds.59.1670123226311; Sat, 03
 Dec 2022 19:07:06 -0800 (PST)
MIME-Version: 1.0
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Sun, 4 Dec 2022 14:06:58 +1100
Message-ID: <CAEYL+X9WUbbo1U+vw6Ybd6wPz7VPiGA1kgM-fQU5D_+Qe25vmQ@mail.gmail.com>
Subject: PATCH [2/2] gcn-gqr: remove "struct file *" argument of
 proc_dointvec() call
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From bc3ccabbe4f6e8a56c9b2ab5cb8fe9915739283a Mon Sep 17 00:00:00 2001
From: Albert Herranz <albert_herranz@yahoo.es>
Date: Thu, 1 Oct 2009 19:12:08 +0200
Subject: [PATCH 2/2] gcn-gqr: remove "struct file *" argument of
 proc_dointvec() call

Adhere to the function parameter changes introduced in
commit 8d65af789f3e2cf4cfbdbf71a0f7a61ebcd41d38.

While at it, use 'struct ctl_table' instead of 'ctl_table'.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/misc/gcn-gqr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/gcn-gqr.c b/drivers/misc/gcn-gqr.c
index 66482653f8ef..ff390eb79a06 100644
--- a/drivers/misc/gcn-gqr.c
+++ b/drivers/misc/gcn-gqr.c
@@ -37,7 +37,7 @@ static struct ctl_table_header *gqr_table_header;
 #define MFSPR_CASE(i) case (i): (*((u32 *)table->data) = mfspr(SPR_GQR##i))
 #define MTSPR_CASE(i) case (i): mtspr(SPR_GQR##i, *((u32 *)table->data))

-static int proc_dogqr(ctl_table *table, int write, struct file *file,
+static int proc_dogqr(struct ctl_table *table, int write,
        void __user *buffer, size_t *lenp, loff_t *ppos)
 {
  int r;
@@ -57,7 +57,7 @@ static int proc_dogqr(ctl_table *table, int write,
struct file *file,
  }
  }

- r = proc_dointvec(table, write, file, buffer, lenp, ppos);
+ r = proc_dointvec(table, write, buffer, lenp, ppos);

  if ((r == 0) && write) {  /* if they are writing, update the reg */
  switch (table->data - (void *)gqr_values) {
@@ -86,7 +86,7 @@ static int proc_dogqr(ctl_table *table, int write,
struct file *file,
  .proc_handler = &proc_dogqr       \
  }

-static ctl_table gqr_members[] = {
+static struct ctl_table gqr_members[] = {
  DECLARE_GQR(0),
  DECLARE_GQR(1),
  DECLARE_GQR(2),
@@ -98,7 +98,7 @@ static ctl_table gqr_members[] = {
  { .ctl_name = 0 }
 };

-static ctl_table gqr_table[] = {
+static struct ctl_table gqr_table[] = {
  {
  .ctl_name = CTL_UNNUMBERED,
  .procname = "gqr",
-- 
2.38.1

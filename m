Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F26EBB12
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDVUA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:00:23 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5E199A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 13:00:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2a8dc00ade2so27651441fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 13:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682193619; x=1684785619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4de9YCcQ8wvq6ChwmsYT8Nh2orwqJ0P0/zKvV4GBJI=;
        b=j9Jvy5GHBcTUBbiFxzFoqXYTzbIToXf1fSzNfB7UXA67b6F8yFaagqlAwZPkrt1ugo
         BxhgXt71EHkIK/La7Yj8iWWLz61fsD03gv2G44YUOqgn3UxOT4zXCc3PDvTh34RRjR3J
         /v9wtF9Qh9C873YJTXpYKHLtS5jt5Eqc6DQKEDzofpDbw9ktSYGreKW7UJ0wzTVwNIXN
         3g4eWUDG4WmvNQjvdbfD/jEMczIGcJocwOJtlU2i/hAgJWBgtijEIiFgQPBgxIHpg5lH
         D3eKQg5ixwk0ysTqFoXNo+DUavMa8xlD74iA/yvifmNODlQ2jNLG67XiXU1/YqkgEblc
         ssFA==
X-Gm-Message-State: AAQBX9fgWNHX7RPqhlqePzzJaMcz3D4d49dTOv5F9Nn4Zwqe9MZ1rlTq
        CcjqjHBVNiHKv4V+GRmfROc=
X-Google-Smtp-Source: AKy350Z+8cao3O2b8jKurJij0P1liANQkMuqt0M2KKptCo+zkp5rwi0xwjDqfTnVGVntIvVSyS2CFA==
X-Received: by 2002:a2e:8e8f:0:b0:2a7:6b95:1d62 with SMTP id z15-20020a2e8e8f000000b002a76b951d62mr1663907ljk.52.1682193618893;
        Sat, 22 Apr 2023 13:00:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:709:7e94:afb:ceb7:df2:e96c])
        by smtp.googlemail.com with ESMTPSA id s14-20020a2e83ce000000b002a8c897efb9sm1104125ljh.131.2023.04.22.13.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:00:18 -0700 (PDT)
From:   =?UTF-8?q?Bo=20Svang=C3=A5rd?= <bo.svangard@sylog.se>
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bo=20Svang=C3=A5rd?= <bo.svangard@sylog.se>
Subject: [PATCH] misc/xilinx_sdfec: remove redundant _{open, release} function
Date:   Sat, 22 Apr 2023 21:59:33 +0200
Message-Id: <20230422195933.523874-1-bo.svangard@sylog.se>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions are redundant as they are empty and performed by the misc
driver.

Signed-off-by: Bo Svangård <bo.svangard@sylog.se>
---
 drivers/misc/xilinx_sdfec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index cb9506f9cbd0..270ff4c5971a 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -855,16 +855,6 @@ static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
 	return 0;
 }
 
-static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
-{
-	return 0;
-}
-
-static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
-{
-	return 0;
-}
-
 static int xsdfec_start(struct xsdfec_dev *xsdfec)
 {
 	u32 regread;
@@ -1030,8 +1020,6 @@ static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
-	.open = xsdfec_dev_open,
-	.release = xsdfec_dev_release,
 	.unlocked_ioctl = xsdfec_dev_ioctl,
 	.poll = xsdfec_poll,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.40.0


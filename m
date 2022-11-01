Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD961459E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKAIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAIYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:24:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8213EB2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:24:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c25so6280720ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upOGKHHQ7dIQHp3Kn+biBaH/EQv9dJ5DonoGy784LMc=;
        b=FJIHR75D7fjRmjC2G/ZU4xqmLXvxy/Wxbrm9UdBE/elbHHWLKbAuiq9GrCoE1LgNK4
         beQp4nOlkNByRrIzQ5bbW/XR1PnyTth8p2KzAme00XV974/Hm1JGPdy4z73doCjSwbzb
         fyHd9poulfzuOq4KglGUAs9DkV0FLERmA+l61b56o41MUdL/656b1XohmM/xbo7bCfH5
         M6djE3o/bZ+bq+MXZOf2t58q+YAx8HdJIoQPDhfKnYLEG9YzZxFbZQwENKBseVWeiMPZ
         y38QYI6YTnXL8ZoisVer4rX0xw77PfGQhvZ7gpIKYbTBQeD5oroRVeiMafBUCLFJaRHW
         zpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upOGKHHQ7dIQHp3Kn+biBaH/EQv9dJ5DonoGy784LMc=;
        b=c+V7JoGBZXmG4zpVZJ0H3EWjId7YUyDWvnmYmDpMR4UxdZv0w1r6tyPUvDYkhLtRMt
         1CcbJ2no7SxSQ7PoB4MOIUzm063iZ+GYssYtlI926+ZUeVeieWZqRscMVU+mbMGMwuJv
         oeVUAWvw1njJUd3bWLC1u4NK5jeFvn89NOnBYf22TS1f153wnpSMoZDTAeYNCeTOWNAo
         3x0OEGU/hOgMT1LpZKqqGUOcoFcJnxr0sMQDOObw95Nws7XMPkGogbAOLS21iuu+EVma
         nVceGQ9QcIbWve81OMVbzC+18cgePgPjdjbYEVT8Yu+12sib7Mdu8FBGjicrdZQDb2R1
         /Rhw==
X-Gm-Message-State: ACrzQf1zhEhVAXmlVRVGPAP9J/FPYco9xWtc5FSPYVv2/o7QC8DBvXti
        G3F1R+Mmr5j1uPiSWD9QVkbHJTyXhb6/xg==
X-Google-Smtp-Source: AMsMyM6G9cysSeLqrx8ejcK15Lykfn64yabbrcoK34rsEToMmuLB0pTLgSHofnxQVXdU6NjINgXP+w==
X-Received: by 2002:a2e:84ca:0:b0:25d:77e0:2566 with SMTP id q10-20020a2e84ca000000b0025d77e02566mr7235820ljh.78.1667291059343;
        Tue, 01 Nov 2022 01:24:19 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id v11-20020ac258eb000000b004acd6e441cesm1582063lfo.205.2022.11.01.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:24:18 -0700 (PDT)
Date:   Tue, 1 Nov 2022 08:24:18 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH v2] staging: vt6655: change variable name wTimeStampOff
Message-ID: <Y2DXsnrQjQeP2PfO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the variable name wTimeStampOff to adhear to Linux kernel coding
style, which does not allow naming variables in CamelCase. error is
reported by checkpatch

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 1e5036121665..9bdcf2337235 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -54,7 +54,7 @@
  */
 #define CRITICAL_PACKET_LEN      256
 
-static const unsigned short wTimeStampOff[2][MAX_RATE] = {
+static const unsigned short time_stamp_off[2][MAX_RATE] = {
 	{384, 288, 226, 209, 54, 43, 37, 31, 28, 25, 24, 23}, /* Long Preamble */
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23}, /* Short Preamble */
 };
@@ -130,7 +130,7 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
-	return cpu_to_le16(wTimeStampOff[priv->preamble_type % 2]
+	return cpu_to_le16(time_stamp_off[priv->preamble_type % 2]
 							[rate % MAX_RATE]);
 }
 
-- 
2.34.1


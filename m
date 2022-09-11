Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B96C5B4FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIKQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIKQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F91713CEB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc7so15079737ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GsdpeDwqiQ59y1KF9qjXgzUuhoO/WMpaF1rt8+KLfKc=;
        b=jEAk2DZ1D4pSbzFy8lLdAgFAIiZb75w2RbVNn5hDJNmFW1f6L3TQAr6G6Tt9lfOQgk
         vH+f3/7roALGxkIoUit65Ng9lf/Uh9Rhbf2QO3x81r32u8sMp7mq5RbnbkYwN+o/1Hvl
         ub9IWalSSz5UTwpMPK1hIXYk9NNipRjKQkQTJ09e306nd4i4I5ITLehbzzVNas0X4/3l
         4hKLhpO7n0RyiRHVlLo/BDNw2fup4jbMagMbNY2fm7TxJ09UaWawn/nt/kVqvEGCJU+U
         f7z4ZtlSvkw74qNkvaLKiQCbiQy+JT95/SAPp3M/ox7wQTUjbXGkGwnl00OJKplef6w0
         Ymmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GsdpeDwqiQ59y1KF9qjXgzUuhoO/WMpaF1rt8+KLfKc=;
        b=Cvwp2hagvQ2xLu9i49vi8vOYWYXdK1nnm4cy/ERS9FmKfWoSgtq52MWX6ZvIC2HPVU
         SqhNBK4TQpRhJMr1OFD3JnpcqGEffxNQYmPCIIrIXbkaIDormP3MSsxxZqJEJZd1BYa6
         HxAwC7bzDF9zz6KCBujxDSB+lZBDgVfCx3tL7eNLsBBC+9w8EhkQYXJVcYwfF1+msKcP
         tdDKbn0WCLsMdZLfAFW8FUcEp4ruHqVWZ3n7yHkzPKx0UKSo/q4ir1u4p3tv2X4tRwl8
         n3DdbwqfLkdpkNswLTp976TbIz184DOv2Z+LNRscxV3S76kizHLf762AA606eTpe+5sR
         3EUA==
X-Gm-Message-State: ACgBeo3bSSD5Nu3A9q9GcBQS6Bov3LDXDEtWSbPA8AinWdtbwiXX8yTW
        k5+jkB/J3Dsvd/b3yu6ilfM=
X-Google-Smtp-Source: AA6agR75KgWe00X/90kNewrayvjKNnBiAKF5xum9uin/07Ow4IuT5iJzfv1899rRu1u5SkMRyhNXaA==
X-Received: by 2002:a17:907:9729:b0:77c:3742:137a with SMTP id jg41-20020a170907972900b0077c3742137amr3000202ejc.630.1662913200779;
        Sun, 11 Sep 2022 09:20:00 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: rename odm_SignalScaleMapping()
Date:   Sun, 11 Sep 2022 18:19:44 +0200
Message-Id: <20220911161949.11293-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911161949.11293-1-straube.linux@gmail.com>
References: <20220911161949.11293-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename odm_SignalScaleMapping() to avoid camel case.

odm_SignalScaleMapping -> odm_signal_scale_mapping

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 035d94b3458e..cd6af491d5a8 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -13,7 +13,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 		return 100 + AntPower;
 }
 
-static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
+static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
 	s32 RetSig = 0;
 
@@ -200,10 +200,10 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
 	/* It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp(). */
 	if (isCCKrate) {
-		pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
+		pPhyInfo->SignalStrength = (u8)(odm_signal_scale_mapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
 	} else {
 		if (rf_rx_num != 0)
-			pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, total_rssi /= rf_rx_num));
+			pPhyInfo->SignalStrength = (u8)(odm_signal_scale_mapping(dm_odm, total_rssi /= rf_rx_num));
 	}
 
 	/* For 88E HW Antenna Diversity */
-- 
2.37.3


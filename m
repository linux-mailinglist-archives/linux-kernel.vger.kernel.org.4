Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A896D36BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDBJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDBJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C65FF9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:51:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-930bc91df7bso77010666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429116; x=1683021116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kLb8IQUT4+CAKzjeCA5AxiV6CvhrMng8FzIucyahWM=;
        b=GmlE4ygRZEOIOnMBg94rr+q76rKLFyj+RlkqpMsBHVrx0rPeQYQIs/dR0nyxdf/EAa
         AnUd8eYZLWB58oL5RYTQJTwWW21ZuqnxQmtSKTd7wQDtsnJAd6F7Go5sXXFiEpeNZc8v
         kjSUdQV2J4v+Ecvh3Q9CpHCopfvzw9SJ9xsqprSUS9fxKul+Sq20RaGrzmQYB+uHToHU
         ivPO38uZm4xVQEcwTKsKt7EpN8RVHfZPG313eoINCLtRz+BtbxBKS41hD3T025tRXnDG
         WUrzGZWr/s/1epGq3pnqHJ4+OFPs9Qi3YazOmzJuc/xxaEBZC5sIreYwbdZVAqaDBGo8
         yvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429116; x=1683021116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kLb8IQUT4+CAKzjeCA5AxiV6CvhrMng8FzIucyahWM=;
        b=3/cZ+Blaau3IEH9ArgDGKepjlTLjUyn078JPZU6HyKpCQeoMFrPkTcG33h/BbzWoPN
         o2wsPh8nuBH8eTAwFkRZ5gAKuoZVpQ00v0fupAquXfvBKFiQQ6vxzQu4sG0B+EL2LY7N
         OH0vrhCg8wVKHtU5V8hzr5IveMAIK/rmHuju+WOlR45GNP3r8IJECygIDVpJOCxBgZi+
         6+A46Kpf8vrk1GBVXL+K4H34kPmzMgusNkaXpjAvh1fxrQZNzPz9IJtqEzEBsfa3sDNL
         192Dx2XmZv9422NrXL7LQE/r6kN4XpIMXLc/+8OxvEaWPjzRWAiZJPOarSlorbmxOzIS
         pVvQ==
X-Gm-Message-State: AAQBX9eRMVB4lgyWx5IxTml1ZGBfptQRdehr/Hw+RNPD81Wge4oLHfiy
        BzDfNZ1Aat4SOTNNs5A8UDzpnztsZPc=
X-Google-Smtp-Source: AKy350Y0s0AYsZKidB2zTZIkSdH9NklojZ8K5orQJCFvh/z4GPo/V0Uq3CQEHZEzg4k2UHASeTjzKw==
X-Received: by 2002:a17:906:2098:b0:930:7f40:c1bb with SMTP id 24-20020a170906209800b009307f40c1bbmr9702476ejq.4.1680429116281;
        Sun, 02 Apr 2023 02:51:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709064e5100b009312cc428e4sm3026075ejw.165.2023.04.02.02.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:51:55 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:51:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] staging: rtl8192e: Remove local variable Value and
 powerlevelOFDM24G
Message-ID: <2076dc2f8f5afc11cbab23bc3f5d4ace9bf33bfd.1680427945.git.philipp.g.hortmann@gmail.com>
References: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerlevelOFDM24G is set to priv->pwr_track. Then Value is set to
powerlevelOFDM24G and then only once used. Remove both variables to
increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: No changes just rebased
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a21b3798db48..cde41111012a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -516,10 +516,8 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	bool	viviflag = false;
 	struct dcmd_txcmd tx_cmd;
-	u8	powerlevelOFDM24G;
 	int	i = 0, j = 0, k = 0;
 	u8	tmp_report[5] = {0, 0, 0, 0, 0};
-	u32	Value;
 	u8	Pwr_Flag;
 	u16	Avg_TSSI_Meas, tssi_13dBm, Avg_TSSI_Meas_from_driver = 0;
 	u32	delta = 0;
@@ -528,14 +526,11 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
 
-	powerlevelOFDM24G = priv->pwr_track >> 24;
-	Value = powerlevelOFDM24G;
-
 	for (j = 0; j <= 30; j++) {
 
 		tx_cmd.op	= TXCMD_SET_TX_PWR_TRACKING;
 		tx_cmd.length	= 4;
-		tx_cmd.value	= Value;
+		tx_cmd.value	= priv->pwr_track >> 24;
 		rtl92e_send_cmd_pkt(dev, DESC_PACKET_TYPE_NORMAL, (u8 *)&tx_cmd,
 				    sizeof(struct dcmd_txcmd));
 		mdelay(1);
-- 
2.40.0


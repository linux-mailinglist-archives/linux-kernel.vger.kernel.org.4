Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64267FFB4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjA2O7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjA2O7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5C20063
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so6434176wmo.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WroMkucCpLGqjqrZpH1DMrJTtDPZ7FSu1W1GIcgL1g=;
        b=X/HTvBQYbteda5FdLw4N/ZB3BS19y2meYdFCWFfNeZNYQwu+21qu0o2Z8yiuSpI5x6
         dmsf1HVYY8i8xe/JLlOk0qZxE0ORyhCx+GOgXuNcGCzcb+6bjZS5BSg/vt+P7srPXFQB
         1I91VCaZlx2vgUdyjRFZT9T88xCtBqhTxVhvmtQh/vpBSasdRVJVPWEVPeOrwtIYLZAa
         PG+Ieq3N1M6J3O+6yotHZKduHTT/xlKG7EcfDDpfWkAbAU9hVmTyp4SSyovVlebZxC7F
         0T4J7t6t0FgCO1Bu3fyKGPWF49PE7gOB5jkjNK4LgZNtRvxU/YXVYGX7pzIujY+M+zhS
         nNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WroMkucCpLGqjqrZpH1DMrJTtDPZ7FSu1W1GIcgL1g=;
        b=R96IGqQcZBpEsLGPqENCS8ijL/GvX6u5xqo/hAYGMyGv/IaILSh8VBm3Yr4XoMKV5M
         eyZIIF1W7BTzGdUyqzFOGGxcABa09IwaAqpEcAvHxShvv2PvjcdQ+U3G6X4Em6ooj+Fp
         whSAoh0wtqdVlKX5zKYmSVSCI775bk8rm9qz9vkFpDlvtCc3vfJ7ZaDCInYodBXWLbVD
         1dXVNbvZ37loylHVWRc2QKxoGdS8DGP9FDFSpTBIcHAyjUEw8fQtojaZZ+BXBvFSARFJ
         1Zbg6m5NV8Nss9T6yWw9OP8b7SrD2yRfAOg9bHNfcLIN/55hQkWqB0J0Sv/2gFxj1PlM
         KYwg==
X-Gm-Message-State: AFqh2krcX+RBD5if+lfkg84ih+7fPjAuzQ1qSmvNLjjjiaVt92jiDBLC
        ABfTrWndICQodSvLReogbbw=
X-Google-Smtp-Source: AMrXdXt355fNAe/vAMLxvjDm5OboASfMp2STAWRvuPmYCw67xPRiaa2hbTEibEul1Awwq43qhMPLqw==
X-Received: by 2002:a05:600c:5120:b0:3db:21b8:5f53 with SMTP id o32-20020a05600c512000b003db21b85f53mr9979012wms.1.1675004347589;
        Sun, 29 Jan 2023 06:59:07 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc1d668866sm13212415wma.10.2023.01.29.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:59:07 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:59:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Rename TPPoll_CQ, AcmHwCtrl and
 AcmHw_BeqEn
Message-ID: <f6731b36c0f3f22213436ba01abc8f1c685844ad.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TPPoll_CQ to TP_POLL_CQ and AcmHwCtrl to ACM_HW_CTRL and
AcmHw_BeqEn to ACM_HW_BEQ_EN to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h     |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 374f61e931f5..eba8364d0ff2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -76,7 +76,7 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 
 	} while (frag_offset < len);
 
-	rtl92e_writeb(dev, TP_POLL, TPPoll_CQ);
+	rtl92e_writeb(dev, TP_POLL, TP_POLL_CQ);
 Failed:
 	return rt_status;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 37d304a0f4c1..dc6e694840af 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -216,12 +216,12 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 		union aci_aifsn *pAciAifsn = (union aci_aifsn *)&
 					      (qos_parameters->aifs[0]);
 		u8 acm = pAciAifsn->f.acm;
-		u8 AcmCtrl = rtl92e_readb(dev, AcmHwCtrl);
+		u8 AcmCtrl = rtl92e_readb(dev, ACM_HW_CTRL);
 
 		if (acm) {
 			switch (eACI) {
 			case AC0_BE:
-				AcmCtrl |= AcmHw_BeqEn;
+				AcmCtrl |= ACM_HW_BEQ_EN;
 				break;
 
 			case AC2_VI:
@@ -235,7 +235,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 		} else {
 			switch (eACI) {
 			case AC0_BE:
-				AcmCtrl &= (~AcmHw_BeqEn);
+				AcmCtrl &= (~ACM_HW_BEQ_EN);
 				break;
 
 			case AC2_VI:
@@ -243,14 +243,14 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				break;
 
 			case AC3_VO:
-				AcmCtrl &= (~AcmHw_BeqEn);
+				AcmCtrl &= (~ACM_HW_BEQ_EN);
 				break;
 
 			default:
 				break;
 			}
 		}
-		rtl92e_writeb(dev, AcmHwCtrl, AcmCtrl);
+		rtl92e_writeb(dev, ACM_HW_CTRL, AcmCtrl);
 		break;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 1cb723f71f43..c3b573090d39 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -129,7 +129,7 @@ enum _RTL8192PCI_HW {
 #define	IMR_ROK				BIT0
 	ISR			= 0x0f8,
 	TP_POLL			= 0x0fd,
-#define TPPoll_CQ		BIT5
+#define TP_POLL_CQ		BIT5
 	PSR			= 0x0ff,
 	CPU_GEN			= 0x100,
 #define	CPU_CCK_LOOPBACK	0x00030000
@@ -142,8 +142,8 @@ enum _RTL8192PCI_HW {
 #define	CPU_GEN_PWR_STB_CPU	0x00000004
 #define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF
 #define CPU_GEN_NO_LOOPBACK_SET	0x00080000
-	AcmHwCtrl		= 0x171,
-#define	AcmHw_BeqEn		BIT1
+	ACM_HW_CTRL		= 0x171,
+#define	ACM_HW_BEQ_EN		BIT1
 #define	AcmHw_ViqEn		BIT2
 #define	AcmHw_VoqEn		BIT3
 	RQPN1			= 0x180,
-- 
2.39.1


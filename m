Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFA67FFAB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA2O7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjA2O7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273316ADB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso1561597wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6/SXN7va6FFFDQOTORqHE36jhhud+i2AemfQKfdFEY=;
        b=GIPatdy4NNF54VmSgtRWCbTWaYim4FAv0x9sZqX/fJCmwWcQr4CFp0o0i3m8H9fE25
         bhU+IivlegVU/KN0HMBM5RK9c0gb/iUcTXaWtqHa249pPlAe9tq655yggUhdT+4BElro
         QUemw5ArYBDdhEcFu+E45IUPJtY+2Uc89yY/j2QaDg+sQiH1r9fiRa4cIXbdoONhJLgL
         W0TiBCHWnxddOgi+mqV8lYBq7WQ0SVqh4WLYC2T1fLcYbKjIKmN3IhZ4YmSmkTb6qAas
         u3Dgr+ks5UVqf03Cq4NHaFGS1iz5BrlQPAeoVXD9gNsamVHk1F0gN0ptAiLGPPzjX8NF
         ss0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6/SXN7va6FFFDQOTORqHE36jhhud+i2AemfQKfdFEY=;
        b=k5d5pw63hod/7lezeDqcn73aFjCsERt2qvYaYvHEqu2DEvkCOPCgmaoSyJfdtbB78R
         x8cYP9mIt63IkHGKd+7L4eenbOSdaJif1UI2tbBQCTOjjvlQk/3WV7OFS0EScGZ3KaHW
         VIKIo+YjTfqK5AAWSZVvW82kOQzk1OqrnRtxkfL9DMOgdFr1r2RxIm2z3fsHTD1cNHwb
         1OKFCO0ttvxX6x4bRugtnxAWCwW1ryQ06uHsPud3c70bGafM9ge10zrc0aY4FQsPzbtB
         NzNdmcGVwEFEV5692IgAxOkdXoLb+eB3Iq1NkvtyJ60rmwSDF3lsOlowTxTwfRkmH5kD
         /lsQ==
X-Gm-Message-State: AO0yUKUMPbAH/iMqUipOCA7hHSWiM4+DcVEIxOSXlPegdBELqhi7Vn8A
        WYImbprDD0W0kUM6iT7SZHeDuLKPJTc=
X-Google-Smtp-Source: AK7set9/w9KMokZiGm0QIDkCXEllayYh8Ok6sV+VcvBktUv3hgu5kYKcgariKG145UxNKhV8WRM/Ew==
X-Received: by 2002:a05:600c:1f18:b0:3dc:53fc:c8b3 with SMTP id bd24-20020a05600c1f1800b003dc53fcc8b3mr558719wmb.3.1675004325427;
        Sun, 29 Jan 2023 06:58:45 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003dc22ee5a2bsm11688082wmo.39.2023.01.29.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:44 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:43 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove unused constants in
 _RTL8192Pci_HW
Message-ID: <7eef6b217c00d123ee7194191209ff3bee707f8c.1675003608.git.philipp.g.hortmann@gmail.com>
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

Remove unused constants in and after _RTL8192Pci_HW of r8192E_hw.h. A
part of the constants would need to be renamed because of CamelCase on
others spaces are missing before and after "<<".

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 148 +-----------------
 1 file changed, 1 insertion(+), 147 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index cc1e62f7074d..13c0e5218ecf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -41,72 +41,39 @@ enum baseband_config {
 #define EEPROM_CID_WHQL					0xFE
 enum _RTL8192Pci_HW {
 	MAC0			= 0x000,
-	MAC1			= 0x001,
-	MAC2			= 0x002,
-	MAC3			= 0x003,
 	MAC4			= 0x004,
-	MAC5			= 0x005,
 	PCIF			= 0x009,
-#define MXDMA2_16bytes		0x000
-#define MXDMA2_32bytes		0x001
-#define MXDMA2_64bytes		0x010
-#define MXDMA2_128bytes		0x011
-#define MXDMA2_256bytes		0x100
-#define MXDMA2_512bytes		0x101
-#define MXDMA2_1024bytes	0x110
 #define MXDMA2_NoLimit		0x7
 
-#define	MULRW_SHIFT		3
 #define	MXDMA2_RX_SHIFT		4
 #define	MXDMA2_TX_SHIFT		0
 	PMR			= 0x00c,
 	EPROM_CMD		= 0x00e,
-#define EPROM_CMD_RESERVED_MASK BIT5
+
 #define EPROM_CMD_9356SEL	BIT4
 #define EPROM_CMD_OPERATING_MODE_SHIFT 6
-#define EPROM_CMD_OPERATING_MODE_MASK ((1<<7)|(1<<6))
-#define EPROM_CMD_CONFIG 0x3
 #define EPROM_CMD_NORMAL 0
-#define EPROM_CMD_LOAD 1
 #define EPROM_CMD_PROGRAM 2
 #define EPROM_CS_BIT 3
 #define EPROM_CK_BIT 2
 #define EPROM_W_BIT 1
 #define EPROM_R_BIT 0
 
-	AFR			 = 0x010,
-#define AFR_CardBEn		(1<<0)
-#define AFR_CLKRUN_SEL		(1<<1)
-#define AFR_FuncRegEn		(1<<2)
-
 	ANAPAR			= 0x17,
 #define	BB_GLOBAL_RESET_BIT	0x1
 	BB_GLOBAL_RESET		= 0x020,
 	BSSIDR			= 0x02E,
 	CMDR			= 0x037,
-#define		CR_RST					0x10
 #define		CR_RE					0x08
 #define		CR_TE					0x04
-#define		CR_MulRW				0x01
 	SIFS		= 0x03E,
-	TCR			= 0x040,
 	RCR			= 0x044,
-#define RCR_FILTER_MASK (BIT0 | BIT1 | BIT2 | BIT3 | BIT5 | BIT12 |	\
-			BIT18 | BIT19 | BIT20 | BIT21 | BIT22 | BIT23)
 #define RCR_ONLYERLPKT		BIT31
-#define RCR_ENCS2		BIT30
-#define RCR_ENCS1		BIT29
-#define RCR_ENMBID		BIT27
-#define RCR_ACKTXBW		(BIT24|BIT25)
 #define RCR_CBSSID		BIT23
-#define RCR_APWRMGT		BIT22
 #define	RCR_ADD3		BIT21
 #define RCR_AMF			BIT20
-#define RCR_ACF			BIT19
 #define RCR_ADF			BIT18
-#define RCR_RXFTH		BIT13
 #define RCR_AICV		BIT12
-#define	RCR_ACRC32		BIT5
 #define	RCR_AB			BIT3
 #define	RCR_AM			BIT2
 #define	RCR_APM			BIT1
@@ -115,8 +82,6 @@ enum _RTL8192Pci_HW {
 #define RCR_FIFO_OFFSET		13
 	SLOT_TIME		= 0x049,
 	ACK_TIMEOUT		= 0x04c,
-	PIFS_TIME		= 0x04d,
-	USTIME			= 0x04e,
 	EDCAPARA_BE		= 0x050,
 	EDCAPARA_BK		= 0x054,
 	EDCAPARA_VO		= 0x058,
@@ -125,53 +90,25 @@ enum _RTL8192Pci_HW {
 #define	AC_PARAM_ECW_MAX_OFFSET		12
 #define	AC_PARAM_ECW_MIN_OFFSET			8
 #define	AC_PARAM_AIFS_OFFSET				0
-	RFPC			= 0x05F,
-	CWRR			= 0x060,
 	BCN_TCFG		= 0x062,
 #define BCN_TCFG_CW_SHIFT		8
 #define BCN_TCFG_IFS			0
 	BCN_INTERVAL		= 0x070,
 	ATIMWND			= 0x072,
 	BCN_DRV_EARLY_INT	= 0x074,
-#define	BCN_DRV_EARLY_INT_SWBCN_SHIFT	8
-#define	BCN_DRV_EARLY_INT_TIME_SHIFT	0
 	BCN_DMATIME		= 0x076,
 	BCN_ERR_THRESH		= 0x078,
 	RWCAM			= 0x0A0,
-#define   CAM_CM_SecCAMPolling		BIT31
-#define   CAM_CM_SecCAMClr			BIT30
-#define   CAM_CM_SecCAMWE			BIT16
-#define   CAM_VALID			       BIT15
-#define   CAM_NOTVALID			0x0000
-#define   CAM_USEDK				BIT5
-
-#define   CAM_NONE				0x0
-#define   CAM_WEP40				0x01
-#define   CAM_TKIP				0x02
-#define   CAM_AES				0x04
-#define   CAM_WEP104			0x05
-
 #define   TOTAL_CAM_ENTRY				32
-
-#define   CAM_CONFIG_USEDK	true
-#define   CAM_CONFIG_NO_USEDK	false
-#define   CAM_WRITE		BIT16
-#define   CAM_READ		0x00000000
-#define   CAM_POLLINIG		BIT31
-#define   SCR_UseDK		0x01
 	WCAMI			= 0x0A4,
-	RCAMO			= 0x0A8,
 	SECR			= 0x0B0,
 #define	SCR_TxUseDK			BIT0
 #define   SCR_RxUseDK			BIT1
 #define   SCR_TxEncEnable		BIT2
 #define   SCR_RxDecEnable		BIT3
-#define   SCR_SKByA2				BIT4
 #define   SCR_NoSKMC				BIT5
 	SWREGULATOR	= 0x0BD,
 	INTA_MASK		= 0x0f4,
-#define IMR8190_DISABLED		0x0
-#define IMR_ATIMEND			BIT28
 #define IMR_TBDOK			BIT27
 #define IMR_TBDER			BIT26
 #define IMR_TXFOVW			BIT15
@@ -192,29 +129,9 @@ enum _RTL8192Pci_HW {
 #define	IMR_ROK				BIT0
 	ISR			= 0x0f8,
 	TPPoll			= 0x0fd,
-#define TPPoll_BKQ		BIT0
-#define TPPoll_BEQ		BIT1
-#define TPPoll_VIQ		BIT2
-#define TPPoll_VOQ		BIT3
-#define TPPoll_BQ		BIT4
 #define TPPoll_CQ		BIT5
-#define TPPoll_MQ		BIT6
-#define TPPoll_HQ		BIT7
-#define TPPoll_HCCAQ		BIT8
-#define TPPoll_StopBK	BIT9
-#define TPPoll_StopBE	BIT10
-#define TPPoll_StopVI		BIT11
-#define TPPoll_StopVO	BIT12
-#define TPPoll_StopMgt	BIT13
-#define TPPoll_StopHigh	BIT14
-#define TPPoll_StopHCCA	BIT15
-#define TPPoll_SHIFT		8
-
 	PSR			= 0x0ff,
-#define PSR_GEN			0x0
-#define PSR_CPU			0x1
 	CPU_GEN			= 0x100,
-	BB_RESET			= 0x101,
 #define	CPU_CCK_LOOPBACK	0x00030000
 #define	CPU_GEN_SYSTEM_RESET	0x00000001
 #define	CPU_GEN_FIRMWARE_RESET	0x00000008
@@ -225,31 +142,13 @@ enum _RTL8192Pci_HW {
 #define	CPU_GEN_PWR_STB_CPU	0x00000004
 #define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF
 #define CPU_GEN_NO_LOOPBACK_SET	0x00080000
-#define	CPU_GEN_GPIO_UART		0x00007000
-
-	LED1Cfg			= 0x154,
-	LED0Cfg			= 0x155,
-
-	AcmAvg			= 0x170,
 	AcmHwCtrl		= 0x171,
-#define	AcmHw_HwEn		BIT0
 #define	AcmHw_BeqEn		BIT1
 #define	AcmHw_ViqEn		BIT2
 #define	AcmHw_VoqEn		BIT3
-#define	AcmHw_BeqStatus		BIT4
-#define	AcmHw_ViqStatus		BIT5
-#define	AcmHw_VoqStatus		BIT6
-	AcmFwCtrl		= 0x172,
-#define	AcmFw_BeqStatus		BIT0
-#define	AcmFw_ViqStatus		BIT1
-#define	AcmFw_VoqStatus		BIT2
-	VOAdmTime		= 0x174,
-	VIAdmTime		= 0x178,
-	BEAdmTime		= 0x17C,
 	RQPN1			= 0x180,
 	RQPN2			= 0x184,
 	RQPN3			= 0x188,
-	QPRR			= 0x1E0,
 	QPNR			= 0x1F0,
 	BQDA			= 0x200,
 	HQDA			= 0x204,
@@ -260,40 +159,13 @@ enum _RTL8192Pci_HW {
 	VIQDA			= 0x218,
 	BEQDA			= 0x21C,
 	BKQDA			= 0x220,
-	RCQDA			= 0x224,
 	RDQDA			= 0x228,
 
-	MAR0			= 0x240,
-	MAR4			= 0x244,
-
-	CCX_PERIOD		= 0x250,
-	CLM_RESULT		= 0x251,
-	NHM_PERIOD		= 0x252,
-
-	NHM_THRESHOLD0		= 0x253,
-	NHM_THRESHOLD1		= 0x254,
-	NHM_THRESHOLD2		= 0x255,
-	NHM_THRESHOLD3		= 0x256,
-	NHM_THRESHOLD4		= 0x257,
-	NHM_THRESHOLD5		= 0x258,
-	NHM_THRESHOLD6		= 0x259,
-
-	MCTRL			= 0x25A,
-
-	NHM_RPI_COUNTER0	= 0x264,
-	NHM_RPI_COUNTER1	= 0x265,
-	NHM_RPI_COUNTER2	= 0x266,
-	NHM_RPI_COUNTER3	= 0x267,
-	NHM_RPI_COUNTER4	= 0x268,
-	NHM_RPI_COUNTER5	= 0x269,
-	NHM_RPI_COUNTER6	= 0x26A,
-	NHM_RPI_COUNTER7	= 0x26B,
 	WFCRC0		  = 0x2f0,
 	WFCRC1		  = 0x2f4,
 	WFCRC2		  = 0x2f8,
 
 	BW_OPMODE		= 0x300,
-#define	BW_OPMODE_11J			BIT0
 #define	BW_OPMODE_5G			BIT1
 #define	BW_OPMODE_20MHZ			BIT2
 	IC_VERRSION		= 0x301,
@@ -304,7 +176,6 @@ enum _RTL8192Pci_HW {
 #define MSR_LINK_SHIFT     0
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-#define MSR_LINK_ENEDCA	   (1<<4)
 
 #define	MSR_NOLINK					0x00
 #define	MSR_ADHOC					0x01
@@ -316,12 +187,7 @@ enum _RTL8192Pci_HW {
 #define RETRY_LIMIT_LONG_SHIFT 0
 	TSFR			= 0x308,
 	RRSR			= 0x310,
-#define RRSR_RSC_OFFSET				21
 #define RRSR_SHORT_OFFSET			23
-#define RRSR_RSC_DUPLICATE			0x600000
-#define RRSR_RSC_UPSUBCHNL			0x400000
-#define RRSR_RSC_LOWSUBCHNL			0x200000
-#define RRSR_SHORT				0x800000
 #define RRSR_1M					BIT0
 #define RRSR_2M					BIT1
 #define RRSR_5_5M				BIT2
@@ -334,14 +200,6 @@ enum _RTL8192Pci_HW {
 #define RRSR_36M				BIT9
 #define RRSR_48M				BIT10
 #define RRSR_54M				BIT11
-#define RRSR_MCS0				BIT12
-#define RRSR_MCS1				BIT13
-#define RRSR_MCS2				BIT14
-#define RRSR_MCS3				BIT15
-#define RRSR_MCS4				BIT16
-#define RRSR_MCS5				BIT17
-#define RRSR_MCS6				BIT18
-#define RRSR_MCS7				BIT19
 #define BRSR_AckShortPmb			BIT23
 	UFWP			= 0x318,
 	RATR0			= 0x320,
@@ -393,10 +251,6 @@ enum _RTL8192Pci_HW {
 ;
 
 #define GPI 0x108
-#define GPO 0x109
-#define GPE 0x10a
-
-#define	 HWSET_MAX_SIZE_92S				128
 
 #define	ANAPAR_FOR_8192PciE				0x17
 
-- 
2.39.1


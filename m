Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBF65B385
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjABOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjABOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:47:00 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2093.outbound.protection.outlook.com [40.92.103.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E565E8;
        Mon,  2 Jan 2023 06:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcuc2TszlR+yah5cfqYg3cOQbMSmYp0vu4MtYcyizcBIWwO5Nyo7nnLj55s8CfiTDea6DWSUsD2pmoaLFBHmo2uniVLEX2o+IkXu6MtA53GFgRkjNwGU3bmuH5G2KHlCFna4qVBz6GDXYqj1Hc800kaREVh7rfJCCvE4Eu/ctHP6AP3ChTwBY4/rm3gViJJKOYhhY9AiFbnclOMIJSCFck3ZWZxCkocdG30dupZ6QPpt6514QMul+dDcqXc6Xum/wjWkq3cZc5k7rEmudjpU0ACxbZh5aFY+XTlWrNOlETGW+ogBknOJoZfXSfLfJbsb/z9WT5agFwPBk/9cmB24TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQUbrmMNNYrvHRXeGi9a9FXrDhRZ4NV7kKsuKyXQTAQ=;
 b=Lx1BD+hG+b5/zuOt/GnTBwIYRFH/fM7TeIeAHWzL0+FE6tFnsoCO8ddVPy651oO0Js9MeU9FJ4xwNKDxUKHRIKAHpDf5c4+KA/Kwac87mCx1lsvK0YH3C8fsO2SB8ySxZucvxXiFgh3vLhI3ens57xavdA8/H/wh7IxUtG7+Qmjs3y1CGL43cPRI6UpUCVvi9QglCi5tDlLpx8uGOUpdRel42nB1CX8jrM14XYkqtbDLiyBuI13TUZS5FR34AdaKq5RQ8kTGIOW6iTuO5r4yXh39/uefMjEFk2Ztu8NUnxPH9EeQxTR3lQdDRPPgY9UgCds8LLIU+Sui5BBZH5ckGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQUbrmMNNYrvHRXeGi9a9FXrDhRZ4NV7kKsuKyXQTAQ=;
 b=Pd7ODrvbzu0GRlOSQq5fnSsloDm4EunJcFfaFPyIpCGj8GRLk8m8mKfWRW0bPUnNzbQCEtjZHayLZ31HmSSwq9n2l+mra9tHuaQRiaqf4qLRDVGLXer+Hi9/jE0i63+sS7Iqd75rtKgSJNoADQlptzJ3ASD2VTOFmFzxuBDWB2j/pt1N8KJMUq2+414uuHDuexN18Hjms1G/gyeKLoW76K25jxTmjFLACg7oNMrF7onL2BQtf2ZlmAPWIuN6Udc/aB1VeBX6G4rto/7waYGKF29b9kAQFaTKvXKiV+qi3czR5n3xXxqQvHT9/5zT8bPGQEk2yhasYmCTpvwJzsRyRA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB9277.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 14:46:51 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 14:46:51 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: [PATCH v2 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Thread-Topic: [PATCH v2 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Thread-Index: AQHZHrkMuK4g+OysPUWm6aVQADl1dg==
Date:   Mon, 2 Jan 2023 14:46:51 +0000
Message-ID: <E376F3F1-CA88-47B3-B3D1-EEF0B283D25D@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
In-Reply-To: <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lE+doef27XN+R3eLz67aI62vxHZFpk3vwOnVbrHr9y1HW2VNOe0cXUIxLoCQmNwl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB9277:EE_
x-ms-office365-filtering-correlation-id: fb39b637-d25a-428a-01ed-08daecd02f0f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oib+/PRz/NwHYRxnvymmuhQa2MWdX5195KEa32UcERqobRPvMmUoCthSJGQhrI9pV5CQH69HfDi12Cc1rjDAFIxbb53+ysETXFKvIl9IUrll1eMKvIYfsl2KOeWW1jvEo7O16AsAyn7xpzIAZ8MaDbjo2Of6zeH4Lz7VaFXixvo6xtXza6CsyCRb178kMx1ZoqQYpjNpPbrEP1lYqGYpK0OiDRu3wrdH663o8J9f04BiD0OAXf8ZSORzI/2oEDFStUReP33nKDLg7R6QjX0G0qBw6lz5/3r35lF8F+GoU6sBOErFZ/Fsv1fO4F5X9zxFNFqPFqP8fgUr1rPEOlgT3oOo1MwNKV6JSJh+NAbzD4Fxbc8odCe/lGPbXeRRgIKsjzUU/GvKKEA4RmoTLIB2YSlGktj3/6D885v4XpazxqlmQ49nd6H9mYesx+pQsku6Q2cWyvZ40Xw0snSONPZgsmaQ1pPPDGD1sf6GOZhqQltC0ULgOKKOBsY2vU5KYJZ0t4CNxqj6P5th7dLa87gkhcPFWHGgdk4Hr+dTrGoMZghs6XfxEI7IJxVgVT2S2Y9TqeG7DbJpgsnLyjheVAWJVE12K+OQYNnZh+7c1eOB13g=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RAhL63y5v4vvJ55N9R05JNum1YLBaZKXfPaZ61hfFxl4dKTW/IBBlk5C+BPl?=
 =?us-ascii?Q?dlFtj2189ETtYc4M9JHYOUCPhsD3knCXI4QRY2RVAQNEjN/lwbsFNTXbeRoQ?=
 =?us-ascii?Q?IjOediG5kMBm3KsJkRxNp5vL7IWg4OWpnxGWd8cCJRcOviaTpHaPdZtigUtq?=
 =?us-ascii?Q?26imiBTaHwY3WmwxJ7xBXismJ1GD11H+sRbqLCn6WeggA5/Jtm2wFBNU8LpU?=
 =?us-ascii?Q?KFUmrNRbhwTgUvpzTzYmng/LX+C6pfKQQRx1RD3af+p4Foi+kW8uXvkNnKd/?=
 =?us-ascii?Q?JuuqZTSIp7z8kPbbt92OtbQo9Q3m2qlxaPvaLvyj2ov3gYHCzhVRUPUQrBBb?=
 =?us-ascii?Q?99I6fCoDEhDkoo+S2Ms3/IH6XMrC56SRW1G2ywoqlFwYdwNkKlllA6v1XhY5?=
 =?us-ascii?Q?fG0aBo575OotaDkeIjcPPfFKuPSKY5cYRxc71pB1puZVkjrOnqeBBRHgu81z?=
 =?us-ascii?Q?Q5y5UC7ZEu0X2LdGosQzbeYzZviIhTW5nUo7v8/0RFZIX/2QrhuWR/AEDj3n?=
 =?us-ascii?Q?LbiGRliMgQpov360muJeNRatViZCrYfI5XFgxY8/Ley85mKPUSOBjb5XR1s3?=
 =?us-ascii?Q?kAfO3jwmD0i0bYKK2Yi5jxmoj83VPq6GsLPfNOsr66ZZYZh0O/+BWNpADK2K?=
 =?us-ascii?Q?H96lK866Z8vXH2j6MwO5GArMOlJOMM0alv8C1eBfeSYkSLOMIs9WiJhC3kh3?=
 =?us-ascii?Q?thLUvwyo9XxyYcQkREQXx5JfzmfWLy+1ax7OZtrjCaFF5gcv/RUpJtjzOg2z?=
 =?us-ascii?Q?Hxl9ixeEUrEsImHdRlSLBqK7LjuNy69QIMXXaxDw1Nbe5Gnbp5ev655PCXkW?=
 =?us-ascii?Q?bwTTcPgHfujUjWw10KHdWdeu2jdSFZsoTpCwzpEM3Nd9O6R/h8X2PC1pR0+b?=
 =?us-ascii?Q?w6iEnDuGds4NHJuU2zVVfJeCY39H/AS3c9aWZDQRUBrivgLcyS6/jPbS344M?=
 =?us-ascii?Q?yhcD9ry/ME8Jc6quzz8I26YDvWQNMmOVaioSg9QmNVQOc3FnusV28aFcZdQK?=
 =?us-ascii?Q?xNHGHkSEzg8zVeEyVwyaAcIJZrOKkB0ZL0u8hQ/sQaEywV5mf4z+TneUe5Jo?=
 =?us-ascii?Q?vkKUTn94mvvbbnFMu069oKQVxySDHtX7bgVp2mRcxJRIVHni6WJhOBsQNIm0?=
 =?us-ascii?Q?YpJx4/UxUi2+0X0pilwUyoJED7l/v+i5mpS/mn7eTNybP+NV/X18uBVLniMs?=
 =?us-ascii?Q?aZI6n9JFLDSI84hTrfolNHE0qiKPntSoNlxMQ+ZZFIQcI05LaSPNhJIwWKdr?=
 =?us-ascii?Q?uB6IJzLXHbD+96PbmJUTn9OSY08hCvxZ/yXGRyWyezFL6ElY7q1fBJG0XobV?=
 =?us-ascii?Q?QDqRvPI2OycmoEwOlBWzz6z+2QsSWzzYTwKnmkaYbWuECA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A73CC9E09CEDA4CA13916ECCEEBD568@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fb39b637-d25a-428a-01ed-08daecd02f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 14:46:51.3055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
BRCM4355 chip which is also found in Apple hardware. However this commit
causes conflicts in the firmware naming between Apple hardware, which
supports OTP and other non-Apple hardwares. So, this patch makes these
Apple chips use their own firmware table so as to avoid possible conflicts
like these in the future.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ae57a9a3a..ad7a780cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -92,10 +92,13 @@ static const struct brcmf_firmware_mapping brcmf_pcie_f=
wnames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
-	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID =
3 */
 	BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
 };
=20
+static const struct brcmf_firmware_mapping brcmf_pcie_otp_fwnames[] =3D {
+	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID =
3 */
+};
+
 #define BRCMF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
=20
 #define BRCMF_PCIE_REG_MAP_SIZE			(32 * 1024)
@@ -2165,10 +2168,16 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_=
info *devinfo)
 		{ ".clm_blob", devinfo->clm_name },
 	};
=20
-	fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev,
-				       brcmf_pcie_fwnames,
-				       ARRAY_SIZE(brcmf_pcie_fwnames),
-				       fwnames, ARRAY_SIZE(fwnames));
+	if (devinfo->otp.valid)
+		fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev=
,
+					       brcmf_pcie_otp_fwnames,
+					       ARRAY_SIZE(brcmf_pcie_otp_fwnames),
+					       fwnames, ARRAY_SIZE(fwnames));
+	else
+		fwreq =3D brcmf_fw_alloc_request(devinfo->ci->chip, devinfo->ci->chiprev=
,
+					       brcmf_pcie_fwnames,
+					       ARRAY_SIZE(brcmf_pcie_fwnames),
+					       fwnames, ARRAY_SIZE(fwnames));
 	if (!fwreq)
 		return NULL;
=20
--=20
2.34.1


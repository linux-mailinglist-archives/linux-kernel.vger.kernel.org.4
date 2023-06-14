Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBBB72F224
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjFNBpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjFNBps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:45:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774410D5;
        Tue, 13 Jun 2023 18:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js7uxcInKBkry0qDrR7b8j+k47kCwhI4k0E7NPATgzBOt+602QSjBiHIU4QPC676D5eXyT+0G9Eru0q9s4VWI4G1tm5N0btcCc4GFNagpHDmYIAQkJqzXLcU7ZUK3XMOi17vHN2adalKovPvQShzUnIoYQDiHNr2WyoaPr1RbBpBXaNgM7lLTbbf6YqOyPc+ZuNzbX26mh/x+a0sneiQotapzxvqnkAON8K2E49szRkyEZz3Rd30dAbtBAtsloas+UDQqZJSgQXoCFKZwbWW7EYVsbk4sLPN3fpOMog3WbsmGbDN7q5uo96JVGlZcxRxotGz0eK1k2LvDBRrepa/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p88SClkOuUU6gwdVBYf1OL7ML2SOeam4TPTj73sXjC8=;
 b=LJxjkvLyLJAo8MIpIPoDNl0qKn1VVK30VNsM2h/MHap482WLAaKmhhtVYr/kluSnNgJcq04W3Wqfr/4rN32I2vOUwlwMaVdAZ3j5rug8QOxPJfntYzOlERQ/JHEFCsbxAH8UvoP3RodrdLIXxBhW1DW6OVpWsXglWbeu6tivPOb8FE2zULp2y8LzgUKJXO9eft2P4MkB85EghPna7zT3r4Unxkw49xyBMYgdOzNDZA8wR9doLGImkDLYOam/P3sFRxhFjxIgEmnah1YBZpCN3W8f20PDy7/Q7WZ+QQB13RZMztwfaaV1sWmwKJsQ5RbKWx0NFkBmdw5t4wjyYqz93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p88SClkOuUU6gwdVBYf1OL7ML2SOeam4TPTj73sXjC8=;
 b=ULzmb0futPhEaJyJ6MuDix4bZSdSzYqGnBwDV3OPwp2JoVPqaLGbJWQcWqkBwgEgjEy6u4VwrVWYOorCgDwE/XX9cB/GD/CpFu0etuI4lvKhnO70NfV44v9RUrWMMM/dq5RZdNH+LplAOgpEdwFpokuzEt9Zz0WvnLlfBa4vNX8=
Received: from PH7PR16MB5010.namprd16.prod.outlook.com (2603:10b6:510:153::5)
 by CH3PR16MB5371.namprd16.prod.outlook.com (2603:10b6:610:164::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 01:45:43 +0000
Received: from PH7PR16MB5010.namprd16.prod.outlook.com
 ([fe80::97:81ad:e05d:5a20]) by PH7PR16MB5010.namprd16.prod.outlook.com
 ([fe80::97:81ad:e05d:5a20%3]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 01:45:43 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     Chevron Li <chevron_li@126.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Subject: RE: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Thread-Topic: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Thread-Index: AQHZmOI41cWOq07zAEuRFE2Sr5b3cK+JkbpQ
Date:   Wed, 14 Jun 2023 01:45:42 +0000
Message-ID: <PH7PR16MB50106EEA29A8564B2296F449EA5AA@PH7PR16MB5010.namprd16.prod.outlook.com>
References: <20230607014812.30104-1-chevron_li@126.com>
In-Reply-To: <20230607014812.30104-1-chevron_li@126.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB5010:EE_|CH3PR16MB5371:EE_
x-ms-office365-filtering-correlation-id: 49720f0a-b76d-4297-85d8-08db6c7910b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7IIQR9sjGxOQAuwBxDFBDSVvSVYhTMhFWMA6YkKYNJnbG1s9rQa2oBTMT3BqkBjMujoRvOAaps1Wd9lxvwHla0Dpd4s16S3T6MkynChEcuv+G2Hjz7CX4xOK3Qex9H9KeljUDqAJ97imptRpGQv5K2i2E+fBkNtNe3yagZGoAKFEyGvcaDmO52OYoA42aVKeXTOxlrh94hCvqmxdI/8f/rrzR8M0RVJV6Yzbc9xA/rst+Ys6sb5Louv5Pw0efQUc6lXGBgs+RnGBEQwfq/hFUfDH6P3Igl5krlZkbfbxp9OyyxKcbFjqqE3JcT33o2g0BfClowX5iUcUbuijWaknGG16pvJ887DWNjDHGdOOM1rGx7LtKVAw34VUXBnciXkRBNuXEUndNy/bO0mhmM8LRBU0PTH/H38u+z94oupT2Rx0L6mnbiOI7XjHNIjDpOSbVpZdICfZTb39Owdb/OfmCT54hzd6DPAUCbr0YfqayOKHEWcl/X8buWLuxqHU96hV+4zSX6pR5frCM78JMwSR0vN4qhBcoTon7ddku8AgBvWZATUJ573W+nHAsYDgGzOrN58B3v8qNHVjvBVMeaJPAnWgWe1dbY6cdD4qCnNZArpEIh1hyP4h5NeOqGNUhri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB5010.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39830400003)(451199021)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(316002)(107886003)(54906003)(478600001)(110136005)(4326008)(33656002)(86362001)(38070700005)(71200400001)(6506007)(26005)(9686003)(186003)(83380400001)(53546011)(2906002)(5660300002)(30864003)(8676002)(52536014)(8936002)(7696005)(55016003)(41300700001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+Fyqph14o+Q1usvR9nT9gxIzjrWaYWUYv4EnsTmZtZxuD9T/BdfYx+qvPjp?=
 =?us-ascii?Q?ktvEx+r5GLjEBwD8DeNwFMdalqCzslAxSF79/zuwa47o6qmpfSoYfHm29v68?=
 =?us-ascii?Q?Pb7WldOK5aZ9s4UwUCqxo2knIi6QbnKX7o1TAb2qF0MkqUm2JHuflQ3xYkOV?=
 =?us-ascii?Q?az/bDwgsP8DuGuN5PIrDNiyoXSMHa33LbJWSxMRdQOQBQfZbxMzJgfFBnZHz?=
 =?us-ascii?Q?1vAUj66Ba52cHFxAgRkqLN9jcDq5XbWP8ZgDb1u6w+u2NciIIdWWhf6epPIz?=
 =?us-ascii?Q?wvk88TfUi8hVutHTcdQ2bu0bksZPtnPQU20PlP7S2G2Y4Wbb1LWjVYtWhRpl?=
 =?us-ascii?Q?GtCgthoGAZixF8RARS6KZ8EjqzK+5gVYr9+CbqY00lSoBbubHuiT0p2bjWZR?=
 =?us-ascii?Q?gkaU36ltQ6g5qw5jXsCchp/sdlEJCT9iiQx79x8C3yB2RJW1iIgZMqOcX1vG?=
 =?us-ascii?Q?1NpCRgJGP6NLV0LyIB66nJASSIxWNlNbq3TnvLKf8g9tiYpwGLz1GjXJjOct?=
 =?us-ascii?Q?1pFRGibKHdwSeYc4/klZZLCwarWvLsNO3h0yXwuN4YxJh2Uuht58fhTIklIR?=
 =?us-ascii?Q?4SXwaOZL12+bPkWedcujuXBg6D7x/iNMdcX607PfAdhDEE3HDdlVdffcLm17?=
 =?us-ascii?Q?jHQ5+VywV6ic/RtBg59bKtdqkxdMtZh9ODWRiWyxZKLsA5X0V7wItA4YBRRd?=
 =?us-ascii?Q?6Qbkh2pA6o7Gnk2wseQ+LUEMQxeFT2kTrPSN37UAHJykbhTmUW7uDqIWXjK0?=
 =?us-ascii?Q?UZXp/Vunp7tCrRg97hdubfO1SdFcNLFxdioCl6bG5OFZI606Kys4iq9zrLj3?=
 =?us-ascii?Q?OnRSAe5qY8lkRvHAvpWR3e86cm1fWBXr60PqBjcZ9NQioQ4sq8pWHMsADe8q?=
 =?us-ascii?Q?NnjYQvWclo4DPe0XCYnZkbxuJqZRvwdBpt1ZgxyCdu6YTs6PmfYhgsuzSc5z?=
 =?us-ascii?Q?CSuH7wVhWuAfdaglhbYq97vm151ZsCUwWFjWmcsUM/HM2J5CngGIYeGU9AeE?=
 =?us-ascii?Q?tj0nR+o/j56x6uCXj9RW/z6B8jftDAtm6YjYUbcs5QrXIZtqzzoVymXDyUKV?=
 =?us-ascii?Q?/lY075WAu2UuYDqK5eZWz4qvhaa8kI+2KEkoIGb7I4jQA+2tZPDNdWU+3222?=
 =?us-ascii?Q?6+gaMv+GvgoaXbsPEL2/SlfEIPDeIdXBeKx95Hd3iow/A/rnedsM+ug7Xb2k?=
 =?us-ascii?Q?PfEKkYnJdbRe2DmykWVfcdSYyjr3O7SuBAFj0fIRpls/JgTGmk/N6WDIhB5f?=
 =?us-ascii?Q?T5bELK0/qZsrMbaVaI4R5FBVELUcNJVOd7f0+ARe5samQEzoilml81Cmv6e9?=
 =?us-ascii?Q?wA4xv7Dxpa6aTmzMaqpBesge1S6sMVjwRpbWo8WV95nLcaooXdrwTC1B5Nof?=
 =?us-ascii?Q?D7p20bkalTWzknh8K1napw/7V/kP0vHBtIsqxRZBvj7Emmy/nW+C+dkTB1J5?=
 =?us-ascii?Q?iXfBkAW0fNjDMcMfHDXU1q/PoyJfqKoJSu6LL/IcaaXYJvWBKG49PdXFU0HR?=
 =?us-ascii?Q?SXtvaG3X5VwSVlgghw5zm9EZ+7qW1ag2R/ES8VSP19EYLX0GC2XwuJ7toXSA?=
 =?us-ascii?Q?NPgPiKKPqSnbOLZbEMc3VBN8a301HXHA4gJ4KVxQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB5010.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49720f0a-b76d-4297-85d8-08db6c7910b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 01:45:42.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ra4v910B7cEyOKT/TFj0gfSPf7J48+uASFjur+ihNAmnxRuwDdf+NOiO3qlKWB5RdOl+qDU9Qvqb1F6G2oMI4KuJen1zYB5E5xb/d5VPUDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5371
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian/Ulf,

May I know the patch progress?
Look forward your response.

BR,
Chevron

-----Original Message-----
From: Chevron Li <chevron_li@126.com>=20
Sent: Wednesday, June 7, 2023 9:48
To: adrian.hunter@intel.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.=
org; linux-kernel@vger.kernel.org
Cc: Shaper Liu (WH) <shaper.liu@bayhubtech.com>; XiaoGuang Yu (WH) <xiaogua=
ng.yu@bayhubtech.com>; Shirley Her(SC) <shirley.her@bayhubtech.com>; Chevro=
n Li (WH) <chevron.li@bayhubtech.com>
Subject: [PATCH V1 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 sup=
port

From: Chevron Li <chevron.li@bayhubtech.com>

Add Bayhub new chip GG8 support for USHI function

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
1.Add GG8 chip IDs in sdhci-pci-core.c and sdhci-pci.h 2.Add GG8 chip initi=
alization flow at sdhci-pci-o2micro.c
---
 drivers/mmc/host/sdhci-pci-core.c    |   4 +
 drivers/mmc/host/sdhci-pci-o2micro.c | 154 ++++++++++++++++++++-------
 drivers/mmc/host/sdhci-pci.h         |   4 +
 3 files changed, 126 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c
index 01975d145200..1d14300691f4 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1898,6 +1898,10 @@ static const struct pci_device_id pci_ids[] =3D {
 	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9860, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9861, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9862, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9863, o2),
 	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
 	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
 	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 620f52ad9667..8243a63b3c81 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -36,6 +36,7 @@
 #define O2_SD_INF_MOD		0xF1
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_MISC_CTRL		0x1C0
+#define O2_SD_EXP_INT_REG	0x1E0
 #define O2_SD_PWR_FORCE_L0	0x0002
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
@@ -49,6 +50,9 @@
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
+#define O2_SD_PARA_SET_REG1 0x444
+#define O2_SD_VDDX_CTRL_REG 0x508
+#define O2_SD_GPIO_CTRL_REG1 0x510
 #define O2_SD_LED_ENABLE	BIT(6)
 #define O2_SD_FREG0_LEDOFF	BIT(13)
 #define O2_SD_SEL_DLL		BIT(16)
@@ -334,33 +338,45 @@ static int sdhci_o2_execute_tuning(struct mmc_host *m=
mc, u32 opcode)
 	scratch |=3D O2_SD_PWR_FORCE_L0;
 	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
=20
-	/* Stop clk */
-	reg_val =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	reg_val &=3D ~SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
-
-	if ((host->timing =3D=3D MMC_TIMING_MMC_HS200) ||
-		(host->timing =3D=3D MMC_TIMING_UHS_SDR104)) {
-		/* UnLock WP */
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-		scratch_8 &=3D 0x7f;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
-
-		/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
-		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_v=
al);
-		reg_val &=3D ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
-		reg_val |=3D (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
-		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_v=
al);
+	/* Update output phase */
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_O2_SDS0:
+	case PCI_DEVICE_ID_O2_SEABIRD0:
+	case PCI_DEVICE_ID_O2_SEABIRD1:
+	case PCI_DEVICE_ID_O2_SDS1:
+	case PCI_DEVICE_ID_O2_FUJIN2:
+		/* Stop clk */
+		reg_val =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		reg_val &=3D ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
+		if ((host->timing =3D=3D MMC_TIMING_MMC_HS200) ||
+			(host->timing =3D=3D MMC_TIMING_UHS_SDR104)) {
+			/* UnLock WP */
+			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+			scratch_8 &=3D 0x7f;
+			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+			/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
+			pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_=
val);
+			reg_val &=3D ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+			reg_val |=3D (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
+			pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH,=20
+reg_val);
+
+			/* Lock WP */
+			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+			scratch_8 |=3D 0x80;
+			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+		}
=20
-		/* Lock WP */
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-		scratch_8 |=3D 0x80;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+		/* Start clk */
+		reg_val =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		reg_val |=3D SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+		break;
+	default:
+		break;
 	}
-	/* Start clk */
-	reg_val =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	reg_val |=3D SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
=20
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host, @@ -563,6 +579=
,7 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned =
int clock)
 	u16 clk;
 	u8 scratch;
 	u32 scratch_32;
+	u32 dmdn_208m, dmdn_200m;
 	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
 	struct sdhci_pci_chip *chip =3D slot->chip;
=20
@@ -578,16 +595,27 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host =
*host, unsigned int clock)
 	scratch &=3D 0x7f;
 	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
=20
+	if ((chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_GG8_9860) ||
+		(chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_GG8_9861) ||
+		(chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_GG8_9862) ||
+		(chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_GG8_9863)) {
+		dmdn_208m =3D 0x2c500000;
+		dmdn_200m =3D 0x25200000;
+	} else {
+		dmdn_208m =3D 0x2c280000;
+		dmdn_200m =3D 0x25100000;
+	}
+
 	if ((host->timing =3D=3D MMC_TIMING_UHS_SDR104) && (clock =3D=3D 20000000=
0)) {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
=20
-		if ((scratch_32 & 0xFFFF0000) !=3D 0x2c280000)
-			o2_pci_set_baseclk(chip, 0x2c280000);
+		if ((scratch_32 & 0xFFFF0000) !=3D dmdn_208m)
+			o2_pci_set_baseclk(chip, dmdn_208m);
 	} else {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
=20
-		if ((scratch_32 & 0xFFFF0000) !=3D 0x25100000)
-			o2_pci_set_baseclk(chip, 0x25100000);
+		if ((scratch_32 & 0xFFFF0000) !=3D dmdn_200m)
+			o2_pci_set_baseclk(chip, dmdn_200m);
 	}
=20
 	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratc=
h_32); @@ -624,6 +652,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci=
_pci_slot *slot)
 	if (caps & SDHCI_CAN_DO_8BIT)
 		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
=20
+	host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_DDR50;
+
+	sdhci_pci_o2_enable_msi(chip, host);
+
+	host->mmc_host_ops.execute_tuning =3D sdhci_o2_execute_tuning;
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
@@ -634,10 +667,6 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_sl=
ot *slot)
 		if (reg & 0x1)
 			host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
=20
-		host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_DDR50;
-
-		sdhci_pci_o2_enable_msi(chip, host);
-
 		if (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret =3D pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
@@ -663,15 +692,21 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_s=
lot *slot)
 			host->quirks2 |=3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		}
=20
-		host->mmc_host_ops.execute_tuning =3D sdhci_o2_execute_tuning;
-
 		if (chip->pdev->device !=3D PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
 		reg =3D sdhci_readl(host, O2_SD_VENDOR_SETTING2);
 		reg |=3D (1 << 12);
 		sdhci_writel(host, reg, O2_SD_VENDOR_SETTING2);
-
+		break;
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
+		host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
+		host->mmc->caps |=3D MMC_CAP_HW_RESET;
+		host->quirks2 |=3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		slot->host->mmc_host_ops.get_cd =3D sdhci_o2_get_cd;
 		break;
 	default:
 		break;
@@ -684,6 +719,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *ch=
ip)  {
 	int ret;
 	u8 scratch;
+	u16 scratch16;
 	u32 scratch_32;
=20
 	switch (chip->pdev->device) {
@@ -885,6 +921,52 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *c=
hip)
 		scratch_32 |=3D 0x00180000;
 		pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL2, scratch_32);
 		pci_write_config_dword(chip->pdev, O2_SD_DETECT_SETTING, 1);
+		/* Lock WP */
+		ret =3D pci_read_config_byte(chip->pdev,
+					   O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |=3D 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
+		/* UnLock WP */
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch &=3D 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		/* Select mode switch source as software control */
+		pci_read_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &=3D 0xF8FF;
+		scratch16 |=3D BIT(9);
+		pci_write_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, scratch16);
+
+		/* set VDD1 supply source */
+		pci_read_config_word(chip->pdev,
+						O2_SD_VDDX_CTRL_REG, &scratch16);
+		scratch16 &=3D 0xFFE3;
+		scratch16 |=3D BIT(3);
+		pci_write_config_word(chip->pdev,
+						O2_SD_VDDX_CTRL_REG, scratch16);
+
+		/* Set host drive strength*/
+		scratch16 =3D 0x0025;
+		pci_write_config_word(chip->pdev,
+						O2_SD_PLL_SETTING, scratch16);
+
+		/* Set output delay*/
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scrat=
ch_32);
+		scratch_32 &=3D 0xFF0FFF00;
+		scratch_32 |=3D 0x00B0003B;
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH,=20
+scratch_32);
+
 		/* Lock WP */
 		ret =3D pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h in=
dex 3661a224fb04..d680a030f3bf 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -11,6 +11,10 @@
 #define PCI_DEVICE_ID_O2_FUJIN2		0x8520
 #define PCI_DEVICE_ID_O2_SEABIRD0	0x8620
 #define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
+#define PCI_DEVICE_ID_O2_GG8_9860	0x9860
+#define PCI_DEVICE_ID_O2_GG8_9861	0x9861
+#define PCI_DEVICE_ID_O2_GG8_9862	0x9862
+#define PCI_DEVICE_ID_O2_GG8_9863	0x9863
=20
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a

base-commit: 9e87b63ed37e202c77aa17d4112da6ae0c7c097c
--
2.25.1


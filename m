Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28872F223
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjFNBpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFNBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:45:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE81D10D8;
        Tue, 13 Jun 2023 18:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoVY3rLUHBAIPp2ZJWXak+RPeASpdr2w7SzM08MM33P9n5Ib/2llcYOY2q0cfQ6mfM5xshLtvnPXi5v9+S3VT9PsNC1hglxJhTSb+utlTA1fKD7QDUy64crscdMM9b8pOCqaLFcRAbz1K8vf+mPwD86OZi39TVO4Kdb39Q0Ob7313z/AMUsQ1xLqOpvBD8krdvhkymYplxUisx4F+fjNHtXsyuyH7BtO2eGwqVI7M043cOGqo+rvx7a062aZuekDsbowiGVjKvbowzfR2gNRnlyOpfmUy2RbVl+H0ARmU533zzVHVULdSdEIUc5DIkw3V5FlGOuGWtQurwGMpLyPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpKlicGx09PkixjnV1xXoeOWA4QqM7OHvet/FAVv8as=;
 b=WkytNtyy9GEGKiB2o7iR1crPYap/TFals3u0mjHgSUDhwJXfK8fnUjJ2jtB4pgtERZBGZBLCoJ7IiGxJF3uAurANtKQZu2+Y+Mo6IBio9+l1CJ8BYHzmSohyh2fUuBNST/LT3iLrhg1D7nz+HI3rDcGB80MNpgDA0Qf6pkMEeDk8s1Jm1RlaoXgXhMqy1IyxX5C39mAjbQM3lCIJlpHDRdUS9EaD7whZd3cQgwsX4jmomPi+zwh9ynR4ky6o4BtqowOvzdIhz4ecngYfBl/XEOWJlQO31KqLyv2YXPIEvl+2/DyuEvW89XpbKa8XcSJByrYIiE7Uw6VPgIzRlXg4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpKlicGx09PkixjnV1xXoeOWA4QqM7OHvet/FAVv8as=;
 b=eQ7IzawFsBkmeKCRoQj3yf8QGWuLDhWpOemEBnxLoVOB9/w84udBzNzvNh+BBKBcvf8oymcIMvCUR9bi47OZl2XWgVZLbZipW2DWH5bMQWMO2ZTl3vHIK6AgvGJmOv1bgvgXFh0idCVwGSejZpL/Trufvqut7nQg9/bu9RtirX8=
Received: from PH7PR16MB5010.namprd16.prod.outlook.com (2603:10b6:510:153::5)
 by CH3PR16MB5371.namprd16.prod.outlook.com (2603:10b6:610:164::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 01:45:41 +0000
Received: from PH7PR16MB5010.namprd16.prod.outlook.com
 ([fe80::97:81ad:e05d:5a20]) by PH7PR16MB5010.namprd16.prod.outlook.com
 ([fe80::97:81ad:e05d:5a20%3]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 01:45:40 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     Chevron Li <chevron_li@126.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Subject: RE: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Thread-Topic: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support
Thread-Index: AQHZmOI3qtW2kpQpJU2AwcuZlT56W6+JkK3A
Date:   Wed, 14 Jun 2023 01:45:40 +0000
Message-ID: <PH7PR16MB50105407A5CB76FCDE2FC261EA5AA@PH7PR16MB5010.namprd16.prod.outlook.com>
References: <20230607014812.30104-1-chevron_li@126.com>
 <20230607014812.30104-2-chevron_li@126.com>
In-Reply-To: <20230607014812.30104-2-chevron_li@126.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB5010:EE_|CH3PR16MB5371:EE_
x-ms-office365-filtering-correlation-id: d54f20d7-a890-4ff5-bdf7-08db6c790f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIi/fyV8helq8WQEVtf8EZlknkkuOJQlcHDnKMFylnkoiwNrtxFWfSb/XtYnnglkmRPmMrllfgZpuFzahbDDsCdIhRm0jowa5tLWbU6IZXebLc1AtJE0tZH0KksBo83aa6PR5o5E4yfrRwchxYDtTn1X5FAsiU/kXzAvyr0tUJrTWLnsGrkICsqOpEQLkalrWmXJCattiUMGkaUIMD6BTln22+hamGDrkBHnixsEsYnwQXz98V+Xw6oIL7+Cr9MB1vguEwyrhlrvHzEDm/Id+F1ht43KGoVrzlSHlXOxlr3aE86zmhdtboX7WQWRDQsPvHxp/gd/hHFIxzY7h3qggVS+D9c1EnBsVzoS+vsS6VxIyFzQoJIsnMRR1HT7Y7va+wCdLd3sOZsKEKwIEi4YvRmQMBWS0yocZZYcd2m8uFY9fJvfzPOjdL0+kGdpbKre55kk2iGdhN43CheUZ2pQO6UNtezTaP/CID8VU3ZQMPvvM5mQAun3MrTjVA2SNCQoxTr+LPLlIrAPOmB9grfWv40GXs5q2GFOFwsaDjaLobb4/MUlbPhTAKSVjUispxboiFe2qyPn6TrwcWKtZMeUgdw9M71DWfQQBNw3M6PU3Cezv3XBvzg8ZrdwS8Z5XPYk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB5010.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39830400003)(451199021)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(316002)(107886003)(54906003)(478600001)(110136005)(4326008)(33656002)(86362001)(38070700005)(71200400001)(6506007)(26005)(9686003)(186003)(83380400001)(53546011)(2906002)(5660300002)(8676002)(52536014)(8936002)(7696005)(55016003)(41300700001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BAzVJG+OtWaanjRUhiSgyS6UPDdJbBHbz4p9zf8hnwDg/nhsZEvm00uSCFWL?=
 =?us-ascii?Q?9sEa6qB0GdgsCXBtciyXrLuID7E/QOJnypEZ6FUau1aAa7go6ZYmTe6ukb7X?=
 =?us-ascii?Q?B4qCTqphHrrPgpu2x9GRNaNiWbX7byZPHwVGipBeRfnVCDJM87vchvlXIovn?=
 =?us-ascii?Q?weZ/bBFP/ndlHSySeOndFTl665CGQP4TjqXLJk7H4HM9aB44vQMHX3iki5Yv?=
 =?us-ascii?Q?euKyAoiJLMf3ixkOlcpCrRLumcpdGvO6f8WSSUQJNbQx6xw+DSJAftaa15/0?=
 =?us-ascii?Q?NyPXBUdCeWn6Yap2KZfjnleKBKaX271Levxqx6b5PWgrOICUoc7D4aBttWFL?=
 =?us-ascii?Q?yKp3GDz57xygoIuSjZAzAsB6BN1A571Q0Fqhl0wi0YKJIB69VnDWP53lGn3k?=
 =?us-ascii?Q?wgK4IgmSpcCdKSCi8FbWCOdFecK/ggdOcc6J/KDhvrSb42AUDbWAqwWr2skt?=
 =?us-ascii?Q?iDLn9NyUyd5hFp1dpAEZHebcIjl0DFDVPNBH/x5ueA4jQARdiju3zp1lpIft?=
 =?us-ascii?Q?p2f0wJtLnjpzU2at7K410roXI7sAVKztlQaRGHiaNOi5/ITrYgy3TG8C6xbY?=
 =?us-ascii?Q?Gj8A9FF0OIRR84LlgaYfKV4Iso4Kd4yc4l7Mq8BcJAuLVUOLXQR8w85stV2y?=
 =?us-ascii?Q?gYMGxCwA3xynah5/PqaunVud6hgTqFuJQQQB7LP5Xcxm6U1b5/o6J/J0DAXf?=
 =?us-ascii?Q?mzeaFe2y49aWYG513t0wuz0+xk3KddMjlKaniFbaHV4Q8O29pU8MlBDkZPy7?=
 =?us-ascii?Q?xigqd6HTRYj9w70sOS+r1f1CiP212eIl9AlPQJY7053dWw7JAs8uCHxPlzFn?=
 =?us-ascii?Q?o5pHisDLEaSfRMq2UFYly53uNOT/cwy9f8OptqXCDUfSgxXV9bStsImOuhNw?=
 =?us-ascii?Q?kU4LQWqyCUi1dmAfpozA+gYa/Xk4Rbxg5DhEsBcZO1xV/n1adnuiVfSkGpba?=
 =?us-ascii?Q?WVE8ZPHafKz3AClmtfXK73GMhxL5eTYn9xfieKH/BJm/cYtlRX33DE9z2615?=
 =?us-ascii?Q?4ZpWEIHhmSQvrIdF3sA4X6i1fSBaJqialZvasCC3WeaCsFClLHxeoKm1UFxm?=
 =?us-ascii?Q?06SmiEfBsnKllGhtakcR39JhNfr2r66d8mV+8L3TeJq4yZbVKiGb+XDoQBfO?=
 =?us-ascii?Q?sUUj3wj7LQMNJRq6wwL3RZzZ12siZAIMofPAAoIG570utGF22YeSRuuw9sx0?=
 =?us-ascii?Q?c8bARAhwez5lD9DkGKcaRglWTiWfa3uPZbxapE2cemZdV8JPeztnZfZxNM9+?=
 =?us-ascii?Q?jP/pNp9oCwQ+BUPFjoTUr0qbiZTLEXYgr01RUQTaUWNiujEApRfNG181WOlX?=
 =?us-ascii?Q?K49rSw/J6AtjL9lK4d3VcOuKGRuj6mEylnrRrzk4AcxARSEjOWqNMmSDtgT7?=
 =?us-ascii?Q?xpBhHqAgwztIaDwUgeam/LfEP5rE7AL6KnVgn7yi1mTQSWsgBbPPBig+UV3v?=
 =?us-ascii?Q?r5IbVYD4LaJTsrEv7iYCymPo1wpXojnoZdPLf75aKgFVZPAL1hTubQagyN9V?=
 =?us-ascii?Q?0A+c6zrf1kyDJ1HTqW2uK/gDuvNnaRFFflQvFdEEjjcTzaHmjTwu2ZLNdkpZ?=
 =?us-ascii?Q?9a/tPCCCVxiqt5venHz5cBBmqj3xDD3UzRaYYoi0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB5010.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54f20d7-a890-4ff5-bdf7-08db6c790f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 01:45:40.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sFC6Wmq3y/9qC6cGBdXToDK1sFJZYj7QPLPTe7LeNn9vReg5gAAKugI6hpGakybjI16kCxri7QsYmBePa+Drqaa2OBl5Iz95npWtYsCCLk=
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
Subject: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 sup=
port

From: Chevron Li <chevron.li@bayhubtech.com>

Add Bayhub new chip GG8 support for SD express card.
This patch depends on patch 1/2.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
1.Implement the SD express card callback routine.
2.Add SD express card support for Bayhub GG8 chip.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 61 +++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 8243a63b3c81..b2d8ddbb4095 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -21,6 +21,7 @@
  * O2Micro device registers
  */
=20
+#define O2_SD_PCIE_SWITCH	0x54
 #define O2_SD_MISC_REG5		0x64
 #define O2_SD_LD0_CTRL		0x68
 #define O2_SD_DEV_CTRL		0x88
@@ -631,6 +632,63 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *=
host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
=20
+static u8 sdhci_o2_sd_express_clkq_assert(struct sdhci_host *host) {
+	return sdhci_readb(host, O2_SD_EXP_INT_REG); }
+
+static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct=20
+mmc_ios *ios) {
+	struct sdhci_host *host =3D mmc_priv(mmc);
+	struct sdhci_pci_slot *slot =3D sdhci_priv(host);
+	struct sdhci_pci_chip *chip =3D slot->chip;
+	u8 scratch8 =3D 0;
+	u16 scratch16 =3D 0;
+	bool ret =3D false;
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+	/* Set VDD2 voltage*/
+	scratch8 =3D sdhci_readb(host, SDHCI_POWER_CONTROL);
+	scratch8 &=3D 0x0F;
+	if ((host->mmc->ios.timing =3D=3D MMC_TIMING_SD_EXP_1_2V) &&
+		(host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V)) {
+		scratch8 |=3D BIT(4) | BIT(7);
+	} else
+		scratch8 |=3D BIT(4) | BIT(5) | BIT(7);
+	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 &=3D 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	ret =3D readx_poll_timeout(sdhci_o2_sd_express_clkq_assert, host,
+		scratch8, !(scratch8 & BIT(0)), 1, 30000) =3D=3D 0 ? 0 : 1;
+
+	if (!ret) {
+		/* switch to PCIe mode */
+		scratch16 =3D sdhci_readw(host, O2_SD_PCIE_SWITCH);
+		scratch16 |=3D BIT(8);
+		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
+	} else {
+		/* keep mode as USHI */
+		pci_read_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &=3D ~BIT(11);
+		pci_write_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, scratch16);
+	}
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev,
+					O2_SD_LOCK_WP, &scratch8);
+	scratch8 |=3D 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	return ret;
+}
+
 static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)  {
 	struct sdhci_pci_chip *chip;
@@ -703,10 +761,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_s=
lot *slot)
 	case PCI_DEVICE_ID_O2_GG8_9861:
 	case PCI_DEVICE_ID_O2_GG8_9862:
 	case PCI_DEVICE_ID_O2_GG8_9863:
-		host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO;
+		host->mmc->caps2 |=3D MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP |=20
+MMC_CAP2_SD_EXP_1_2V;
 		host->mmc->caps |=3D MMC_CAP_HW_RESET;
 		host->quirks2 |=3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		slot->host->mmc_host_ops.get_cd =3D sdhci_o2_get_cd;
+		host->mmc_host_ops.init_sd_express =3D sdhci_pci_o2_init_sd_express;
 		break;
 	default:
 		break;
--
2.25.1


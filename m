Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B46567A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 07:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiL0G7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 01:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0G7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 01:59:51 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2100.outbound.protection.outlook.com [40.92.107.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0424A635A;
        Mon, 26 Dec 2022 22:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/bf/NXPHRruq87TTTMBr5BoeoEARRbRjMT3whKAy0NMPv87N2qzFJcvm9NezKzA9TazlAN8bW0aEPdryvCHMFuQzxAvZ3J3VuVpD7Eq+/U2xWs78fpTcw472QbnYVO9D75o8Jf/qzThhzRiURwqxf516c5kuwrU15HdgqLSuEJxvIAN5GRuaRx8qCcxEFeTBtWfvUptZMbvP8xHH3kIyCnwBYH8HmWvHM6g78HFYV21b9XpRnZuLbzeVxWmIIlDgM438frhMbhEylVDitYXuDR1h4PxtgdhYHQqnR8okJabGI3w+0OhYkwEThCTZ6s+rtIpfyMltMwuvqrb3gY6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yug2rSbUvERN4azCp5q+G4ljz3g48CMgCI7epOtZfnE=;
 b=j89+vUKAraqVfI3RhyRpT+7Ya/ok4GexcC5xRBZIZ48ctfEB8loDPLDYSVZT6S81+Oy4q0G3gjJVTEhJOfqzq2JBQJVypHQOab5eHnF7DW1mn6qjDRZ0F3ezgrTQqK4utn73peQtpXsrYS1x9b+ujTIt8oqKv2NrDBzwlOXTi/cMd89vbkP6eIEBwOiEedx/4/PfKLM7YQeDpW5iw7BQm2mKCel7SHBhFZ97FLL66I1PKLPxsColdjUwLFcJ1UNIICFfn8RFb5suJd/yhF17BDnSA5Rq7SvQXHDYp6qPPlXu8DrNQvNi7dqzrhAO3Zs+azr0n71aWYykI6jbNuEkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yug2rSbUvERN4azCp5q+G4ljz3g48CMgCI7epOtZfnE=;
 b=qgZgp0k4akEEFI4BiGxDxHx2nVpXRnYB3xlp0JVOYKEeDwZ9nAQFwax+8PUnXZZShUuk/U5k/3I5I2DSw0FCMm9v2usbbp0jcVDdHpfEqOxU1KJJluyBzTGj2AVnmbrjRKiWiRfqiNFfcWK7ILpXNiX6lnc0gg5J/VB8VP+RXKspxS/IFhP69cvioreP+ZD7KN2/Pgfd4Lq3+f9dUxn9BIlFbPQrelQuB9HC3Q1kcwXl0IUsRbnFCuOF4CNF6xXrnoJr94nT6pkWGESsBl3neFAonDHKHNxgeOHoHsVepYuJ6NfbAgcebb8ys83vjikPic+oWhOryhJzTdZ/cQ4rrQ==
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
 by PSAPR02MB5142.apcprd02.prod.outlook.com (2603:1096:301:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 06:59:47 +0000
Received: from SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::f2e:fde9:5455:39cd]) by SI2PR02MB4603.apcprd02.prod.outlook.com
 ([fe80::f2e:fde9:5455:39cd%3]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 06:59:46 +0000
From:   Gongwei Li <lifangpi@hotmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH V2] usb: Fix typo in comment
Date:   Tue, 27 Dec 2022 14:59:30 +0800
Message-ID: <SI2PR02MB4603F6E3B7E062EF76656956DDED9@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [O+Drychpu3acXKvToz0leG25sTI38CdQy4m3P6px1Jk=]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To SI2PR02MB4603.apcprd02.prod.outlook.com (2603:1096:4:10c::14)
X-Microsoft-Original-Message-ID: <20221227065930.15211-1-lifangpi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB4603:EE_|PSAPR02MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c80f76-cad4-4028-29ea-08dae7d7f09b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6gNiKBCFpKm1pCtqcb3EGq1G4zT16cOwuqKO5DKQPIilFKcwGruYTnPLv7cKYMOLj5B1Dn3VXUTPvzz28iW4Lpa3ql0ZpkG/Cw7LyQdjJ6Q71WZmVm4s7cp6v6P7RwGwQD5dGGzaCTt2vz10UJuBhE49ag0vLO0NaAK1XenB66WPgoGAXPamZ3PJl+9BEFJmThr2dyw084krTKhdQ2csg32pjt4f/zZ6kuUUqhHcOvOBBjQ12ylBBcss2dNOYKkBInD+qP3HLHsjGN+cNbQgIBwPa/V5UzjF230LGasCalv9oLGmPlgTD29H9gNM7RiyAuWrIQvFB8jqy90L//Vdf9GnN8AP8be3x6D7jM6wb/eiY38HfWWfmuJrvLNYu9Gzxez2k8xXkQu21fnTwC33a5VoxNKSmhvILlDI2lGXmqdxv24mlhzbIpDgAHWRc7GMVwTjaqYR9oL5hlupooxfdEBwoetUPMd7xzLVtZCVIoibg/Os4DERc0b712A1qtIdpgiftgnHoe2CjR9GzEMWUbRseUlwBi3sQGuj8OEIE1iZ70pSGoADA0Iff9AhqbxwfGCO7Zp5VJCEILkN+Dbt/ecjh5wD6qFgOntQoI6oIM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61yL6/wM6pTJk7kNlSQFAkRjRB9SG8qfC8mKZ6pl2L3h0HwJD24At2Rsq5vX?=
 =?us-ascii?Q?Gl7nVffMlmoq6g139F824xOjl9poYfPV0A+VNPOSTms7I6hXN3psWoNcyxBC?=
 =?us-ascii?Q?kyTe8VeV5zczSyRQqbQn0n0WczktbzDPAAHjHKQCEoHng3tUek5j3gF/tAJ0?=
 =?us-ascii?Q?gs4aVk4/QCO+v57eRMEe+WjSKNyrBN/uL1MH/gKgqYErsBoyzy7ZJ1NEcmir?=
 =?us-ascii?Q?1FEQ+XdEY6IJ3gjxtgklvevfFcJrAb31Xoh3A54PekIJHq4mCeGLfsTVWGnl?=
 =?us-ascii?Q?5i+Y+lNDNbAXLEiCrnstyqCVW4sAwpwwDcuS0wSmYhwnczJZUFFrdhh3e1Xm?=
 =?us-ascii?Q?whiuIMeRjlBqwc+ekLIfGeGFOb3ky/P5DUa0/7roHp9ru8dKj1ELdJW37o9v?=
 =?us-ascii?Q?KpPPea195dC0FZpXihJYlG9lqC5sx+1XpxYgNkXYaQTpCiY72poFHUgxHyAg?=
 =?us-ascii?Q?ExYwwJKk2Du10J3ePd/IaCiHbboyoeKG2sl0an/Si3wn+EBIj86aqAFaV+lM?=
 =?us-ascii?Q?GFvHtCVYBI+C9j6GhcweSS/pKRGLnTNM2xEMVFy2OmmVr+SCWWRKL1bgjKct?=
 =?us-ascii?Q?F+sYerpVSZA4SjSUEsjiL66LVJaeW+Om6dRLmXEKGueDqDlNtiHL6ghRoLNv?=
 =?us-ascii?Q?GZQcaB3xU8enO0Nty0tzU2Xt1aFhYKoZk9SKewea0rtZ8a95G0V3Z7wkOMgd?=
 =?us-ascii?Q?QTjUtg65osp2Snku7n+ZlDxHy4DIvM0BSaPm1UXFNFviZ4PdhEben4O78FOH?=
 =?us-ascii?Q?BXe5P7ivjPz2WFjE/jy1Qr751fIMJB9TczWVRKdtnunnDyQfHWtY/3YQ5qFX?=
 =?us-ascii?Q?ylm7O7o+gMmroCJrFyNMKui2pSHaL1kKKGeHzieOAyVrIGtP11f0lZBlUBoS?=
 =?us-ascii?Q?jQPenlKxRy8gv84+yw3s6cjY/V5+Ac4QY6MlAtz6fAuGHFzd39del6LO5CME?=
 =?us-ascii?Q?IG0VKlourb1cC0eKs3cJO6/GrylvP4t3F5TcccZNruJ9E9WZWR3/5PvYzbTy?=
 =?us-ascii?Q?RHZb0ksmtfe/3OyrsZaYi30zHMeIaNlVBz4L5WTFejwHukJvS9r4Dl/ZoUDC?=
 =?us-ascii?Q?6713H6yben+pf8DwXcDQdAJ5TNtSu76p6dPR8iK6HCuPJbd9QAGfkb92kTR5?=
 =?us-ascii?Q?AU4PcfqjQa/VGYENfpNNv5Uy/X9luQJgLJGbo/Lp1Z3LyJ5iAK8Ggp6kNjDA?=
 =?us-ascii?Q?sMa2nMVho6WWs/vqz7bAusgU7FAYxuMui6TKMbZPZUiX93wRwXgAg/j4GwI0?=
 =?us-ascii?Q?mbKWG+IP29gk9OHMuX8lM/Mg9Ns0gTbU0ZhFpgwt6g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c80f76-cad4-4028-29ea-08dae7d7f09b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB4603.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 06:59:46.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB5142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gongwei Li <ligongwei@kylinos.cn>

Spelling mistake in comment.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/usb/host/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b9714..ebc478def1d7 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1103,7 +1103,7 @@ void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev)
 	pci_read_config_dword(xhci_pdev, USB_INTEL_USB2PRM,
 			&ports_available);
 
-	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xCHI: 0x%x\n",
+	dev_dbg(&xhci_pdev->dev, "Configurable USB 2.0 ports to hand over to xHCI: 0x%x\n",
 			ports_available);
 
 	/* Write XUSB2PR, the xHC USB 2.0 Port Routing Register, to
-- 
2.25.1


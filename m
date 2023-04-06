Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD56D94EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjDFLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbjDFLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:25 -0400
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469A8A60;
        Thu,  6 Apr 2023 04:18:20 -0700 (PDT)
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3369uhLC020839;
        Thu, 6 Apr 2023 11:22:36 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2169.outbound.protection.outlook.com [104.47.74.169])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9xuk2dn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9M9F28CSxv+PXxO+7Txj2NqVoxflCMDEKm9M+L2ePyck3Q+KuOSEmU5VkMTg/DdIg760lzrnTtBuJruW1z3z4iMqAkhr9mNVguEm9ItV4hGN5eF7ZVzRS7APBNWouXCDPxbXH0WHfe2ajEZDskTxS7tEkiNkYb5tbd4HaK4hh964i1kkhFgmXTvs+oCZ2BQizFRPZWIEtlNhhQ5zezpDwrdkrdArdFiyP9YrlHvJDGnYNdo/g/IgAoZYv+3Md0odbdSuAFNv9TylLx8/safXBEVY67mUcEY0Hd37NYwTh6x6M0CFJdwoQ1YdDpb4IiXn22g3zZjKXSCMrt5Lzkvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNgMfObSbEuuUgbi1Ni4mJYWQu6gggg3NLnXyI6ZFjk=;
 b=DUCfRaRX+uhw3OJ/ipe5THlcFPGfFlInuYBzip0Z/PsE3+SqlyaNrip1rpUWlZxV+/Z33HV9d1wFQP7zYajhxgbzPOpVvfaXmJTfnJso0eqJGNxDRh63BDL71d+SwfAFSyvPJ0TZVJgI9IWxSAP23487ceu2Ji4GbYngn3fasfxTq1884ng0HTYSskfLyZ2tINMjldYgSUDJv7/mKNHnpljDAUEYHccqaah3vi73ZAXWtDha1I9t6bfpHgFjB6ZiQDQeeJ1d1XBxlHDzh7I3n53pDo2WLzH1qnm/Z4nY5WQcVa89gQsC6QWVgyOPAddPzz0gXu+vo9SPV9kOeszc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNgMfObSbEuuUgbi1Ni4mJYWQu6gggg3NLnXyI6ZFjk=;
 b=B4FoPY1F+agTtoV6rn1ixyfU5EqhlHSb3HmR4t829nbZnJvLS6ncOvqCqShIT+VacBsnI2JV6CTjd+Ilx7VTTmhVvmgdlZRqgloRRDWl3pQ+VIEgieAE62TpUVZ8e2RRku40lmIxp43I0vAyZJy+t6b8n4CvIOlcMb/H0KnKdR4=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:31 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:31 +0000
From:   Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
Subject: [PATCH 3/5] dt-bindings: reset: Add binding constants for BLZP1600
Thread-Topic: [PATCH 3/5] dt-bindings: reset: Add binding constants for
 BLZP1600
Thread-Index: AQHZaHGyTKunL+QcgEWJ4FlRrzhdAA==
Date:   Thu, 6 Apr 2023 10:22:31 +0000
Message-ID: <20230406102149.729726-4-nikolaos.pasaloukos@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 8d13af40-eb4d-498a-2363-08db3688d4d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlxpwdISxJa7s/fZfQ0nliGuQ2Kl747tIvHovZT3IuEUj58OIyONHTwnTYfia6acczRCXieeVINQO1paD8YMACU0jvPIZN2Fnwuxp64kCVvrRx7us7g9CC+ZMfHe0r+bsfMQ2zAQ9RnHDDnh8ccIPp1a3HtKP80JTvrYYBB27718K0QhZKUJca9VmVyfQ3sDomBxgRD4224Org4JyPtFVjf09CzwK+w4RxLHKYQPsH45S/dujbvnCNUwUHPjrhUARz6usBWpNTAO4HsUJClqe4WyFRfiWDabLUoGPGffrO6lzK04C7l9O/rPViT/1zg9eOyZkWVxM9LUNKEc8MP4Etu+XzxjpsZv21Irwmq0Cah6NVF91wZm4a0YY3bTSdkerUkdqoK/WZgvbDzcrR4P2B/blcWvopgx2UjeekbdZldMxwAaQrS9evWQNqSFsNrmk9il4JjMj2PimT9zxAlrfCf7UF6IKJq9NgGwPlEzRI2QaFF6uQdIvnTO4Meuz/Zbl/QEzwcBXzOAfbj9vn2nXSzH9rRc31AqHXICZjm3NsLCSEUql7lN2f0+KWTdrD7wX8ZiEzWS7xnG6VKzM9b/kkqAgZAvFA0z+4kHGlmjMiJsZLdc814ilM1C+7mfR6r1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(83380400001)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sQQHvKNiUkyHSvyT55srhwMao5yz0/jWJWnacW/a69lJdPQiK37CEUCgkJ?=
 =?iso-8859-1?Q?Ayvqc5QTw4veZPeitwzzeJaRepv2kHzrn28um3xNkw16hyAYoaPIAbuYck?=
 =?iso-8859-1?Q?iMISMmOgn7Dsy3b3SBxLHWtK0ilGQ/Yle6mnJLPjjeBnSCw6J2lvX0PQCo?=
 =?iso-8859-1?Q?KITZAu3i0Iv/FbJadKzHy8cm+8rCEXuJeFMWcpzroH78fdz7+I7UV5Sili?=
 =?iso-8859-1?Q?RyZTd+sYAR920BCc8dHtqqcaouNi242Fhc84EF33OMFd7tzyk0UtEyUwo5?=
 =?iso-8859-1?Q?WwNwuum2E8I+vCPCHv3p2XyH9p4ByvdVgHWocAExLDzJc1jn86W838exIh?=
 =?iso-8859-1?Q?nANLa/Kw+BV7sc69rv5Ua5upXW1lUgeVr6x6KDPf3gwQayI1dpH+54JDaX?=
 =?iso-8859-1?Q?E+7X1RSxPxk15ib9AHTRKPMDLEEIt+93t7ojox4917Wkprp1x5SMO5s9V1?=
 =?iso-8859-1?Q?iUvtWDNf/9FS2PflZYudZ5GkW4uwDRylDQh57apD51M14xBjZOi9HneP41?=
 =?iso-8859-1?Q?GuFkOlCUxsIMlUDzc/60BaAFPfco/NZ3r8YvwUF0jmk9+7aITIIS+u8GX5?=
 =?iso-8859-1?Q?15fJZp2Pch3fP7gxt5LRdgedH2te6efL+Ilvwl3XhGLHp+Kc858Z2ByCKG?=
 =?iso-8859-1?Q?k1ldFyN0z5WgvQ9qib2Pka6YakU6U1G5TkzRSxkhFO2Mu4WM/H3tiRcJkG?=
 =?iso-8859-1?Q?RC1Nu6uDeipnrlshPWNc3+JDhuWaVWfgT7UOY7hIXaQ1bDfVWTh1gae0oA?=
 =?iso-8859-1?Q?sxSgDQaMOnvp5aO/es7Zq7k8/d83xit2aInVd/+zP7b7Pf88DEZW71Dv0K?=
 =?iso-8859-1?Q?esiCV9PE5232x/CmRshv/swMdvOdnWFOvlmqnNIeAIlxWH/1a4+PWgS9YP?=
 =?iso-8859-1?Q?Xnrt1agqT3GsilWFk+1vv1HGDsH/br48UViLQ/dpkAfJxki4+e03PdMmn2?=
 =?iso-8859-1?Q?McI1E4Aw1PMPFGUspol6KGXKAKw11cffxmV4bfgBYkCrdZS8/XfreVUKmL?=
 =?iso-8859-1?Q?3+eXd34n7y/1/WPMvfrZ75+p2AWVwFND3cF9eh8dHShv5BwqGZQzRACM0y?=
 =?iso-8859-1?Q?1sIFZS1QkzSNrr8HoZrE2qJz1l+hh8PjXaWwTkto38HZ7LfM3aLqIAXGrZ?=
 =?iso-8859-1?Q?mtPCg4KVOP2yqiyFEf1fNUZ0RwJcZ93E+24L+WNW5ULu8XBDtoRCYACmcL?=
 =?iso-8859-1?Q?jFCJ9g2CUs6Z7U5+obZORZlKys9PC+3oPmV9z/WovN68q7z32A7zmILG2I?=
 =?iso-8859-1?Q?BBaUO0Xg9APt9CrGMxonJKDEdmSX//yqWUsOuHkhz8HhiDbetY3hvDhJT+?=
 =?iso-8859-1?Q?inQZIKu70vP/1sw6bHiu7tQV/KvtNTIvb4+IQnLnNS36EED/8EYKWOMf26?=
 =?iso-8859-1?Q?lh3Fv2Q9y6kTyZq5Gw4xizu2zMHnAyUZqaEJQgOMpuyCpnKbXUaKNcW0D4?=
 =?iso-8859-1?Q?NHtNDJMgsyU0AlaLWnxd0QtoD46ZZXs0FWVs+CoI4AQ9be9eQwSMs4mmiE?=
 =?iso-8859-1?Q?77f/ru9A445F6S5EyHcdFORjaykfkiBWfxxrYjYt/KahWSdIj6KDV2ehaa?=
 =?iso-8859-1?Q?TtTTinD+DsThvYo9PrTGDKB3rmKmA0jpXsVyeR8A8kFallnQX+Ei5VlP8X?=
 =?iso-8859-1?Q?YooJpwaKUn4URdKtXROCmgfNVNV4x2nbc1zogSR2l+2+MVCF/jM+/D6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d13af40-eb4d-498a-2363-08db3688d4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:31.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPdQQiEvMSppi6NK4DRuubBnuZnNPpPiUc6bpMOceYAtN1Km037YKLfVdFqcG9GRVME9xrNFveUw8MFdA2PLlbD1CnlX9fqaaIs8DcfzmKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-GUID: Te0GVovQxH24LbDuWRSc77x7_zVwtZoI
X-Proofpoint-ORIG-GUID: Te0GVovQxH24LbDuWRSc77x7_zVwtZoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=590
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060090
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMI reset IDs which are used on Blaize BLZP1600 SoC.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../dt-bindings/reset/blaize,blzp1600-reset.h | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/reset/blaize,blzp1600-reset.h

diff --git a/include/dt-bindings/reset/blaize,blzp1600-reset.h b/include/dt=
-bindings/reset/blaize,blzp1600-reset.h
new file mode 100644
index 000000000000..ff1de6b1bd5c
--- /dev/null
+++ b/include/dt-bindings/reset/blaize,blzp1600-reset.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022, Blaize, Inc.
+ */
+
+#ifndef DT_BINDING_RESET_BLZP1600_H
+#define DT_BINDING_RESET_BLZP1600_H
+
+#define BLZP1600_A53_C0_HARD_RST	0
+#define BLZP1600_A53_C0_SOFT_RST	1
+#define BLZP1600_A53_C1_HARD_RST	2
+#define BLZP1600_A53_C1_SOFT_RST	3
+#define BLZP1600_A53_L2_CACHE_RST	4
+#define BLZP1600_A53_DBG_RST		5
+#define BLZP1600_GIC_RST		6
+#define BLZP1600_CRYPTO_RST		7
+#define BLZP1600_GSP_RST		9
+#define BLZP1600_DRAM_A_SYS_RST		10
+#define BLZP1600_DRAM_A_DDRC_RST	11
+#define BLZP1600_DRAM_A_PRST		12
+#define BLZP1600_DRAM_A_ARST		13
+#define BLZP1600_DRAM_A_PHY_RST		14
+#define BLZP1600_DRAM_A_PWRON_RST	15
+#define BLZP1600_DRAM_A_PHY_PRST	16
+#define BLZP1600_DRAM_B_SYS_RST		17
+#define BLZP1600_DRAM_B_DDRC_RST	18
+#define BLZP1600_DRAM_B_PRST		19
+#define BLZP1600_DRAM_B_ARST		20
+#define BLZP1600_DRAM_B_PHY_RST		21
+#define BLZP1600_DRAM_B_PWRON_RST	22
+#define BLZP1600_DRAM_B_PHY_PRST	23
+#define BLZP1600_USB_RST		24
+#define BLZP1600_USB_PHY_RST		25
+#define BLZP1600_CAN0_RST		26
+#define BLZP1600_CAN1_RST		27
+#define BLZP1600_CAN2_RST		28
+#define BLZP1600_ETH_MAC_RST		29
+#define BLZP1600_SDIO0_RST		30
+#define BLZP1600_SDIO1_RST		31
+#define BLZP1600_SDIO2_RST		32
+#define BLZP1600_SD_CARD_RST		34
+#define BLZP1600_CSI0_CTRL_RST		35
+#define BLZP1600_CSI0_VDMA_RST		36
+#define BLZP1600_CSI1_CTRL_RST		37
+#define BLZP1600_CSI1_VDMA_RST		38
+#define BLZP1600_CSI2_CTRL_RST		39
+#define BLZP1600_CSI2_VDMA_RST		40
+#define BLZP1600_CSI3_CTRL_RST		41
+#define BLZP1600_CSI3_VDMA_RST		42
+#define BLZP1600_CSID_CTRL_RST		43
+#define BLZP1600_CSID_VDMA_RST		44
+#define BLZP1600_DSI_CTRL_RST		45
+#define BLZP1600_DSI_VDMA_RST		46
+#define BLZP1600_DMA_RST		49
+#define BLZP1600_QSPI_PRST		50
+#define BLZP1600_QSPI_RST		51
+#define BLZP1600_I2S_TX_RST		52
+#define BLZP1600_I2S_RX_RST		53
+#define BLZP1600_I2C0_RST		54
+#define BLZP1600_I2C1_RST		55
+#define BLZP1600_I2C2_RST		56
+#define BLZP1600_I2C3_RST		57
+#define BLZP1600_I2C4_RST		58
+#define BLZP1600_UART0_RST		59
+#define BLZP1600_UART1_RST		60
+#define BLZP1600_SPIS_PRST		61
+#define BLZP1600_SPIS_RST		62
+#define BLZP1600_TIMER_RST		63
+#define BLZP1600_TSENSOR_RST		64
+#define BLZP1600_VIDEO_E_RST		65
+#define BLZP1600_VIDEO_E_REORDER_RST	66
+#define BLZP1600_VIDEO_D_RST		68
+#define BLZP1600_VIDEO_D_REORDER_RST	69
+#define BLZP1600_VIDEO_D_L2_RST		70
+
+#endif
--=20
2.25.1


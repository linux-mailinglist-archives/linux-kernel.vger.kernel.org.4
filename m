Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B526D94EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjDFLS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjDFLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:18:25 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 04:18:21 PDT
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B58A64;
        Thu,  6 Apr 2023 04:18:20 -0700 (PDT)
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
        by mx08-0063e101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3369uhLD020839;
        Thu, 6 Apr 2023 11:22:37 +0100
Received: from ind01-max-obe.outbound.protection.outlook.com (mail-maxind01lp2169.outbound.protection.outlook.com [104.47.74.169])
        by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3pp9xuk2dn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:22:37 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNRmopubi3q3hMy4Fz5TRRj7a12m9o3wH6YS67usLigh+FV49LLhHWjoY7OoB1PKnnxpnzhOGPFH16Xxv7FxJt+gubNOcIpna/t/3Q8HJwB0kug1ObZ+xELjrQzQJkSFcKS5SicMRFzr0L4vv2GQu+UNDjurje0MIqciEEBaNe1PpV1660j9mgRZPXzj/bgTL9UlHgEnkA0g4hlArhiwHEhIHylzf8dPksHGya3gRjFf1K4189GoPa1r9l+PWwazA1ooWhBNCCyssQGM166GAL6VLmEWuXfnqCzioUjMG7YQYqVaRYwwLkh1IiOSMPsydJ0FfGODUoWYFac/LXiScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idEkOYXbiY81dr+/HxFR2VwJoQt1nwA5cm8b7imhnRc=;
 b=QAZiVaJ6DDOuaynGUyUg6/LqAnCK3zQNf1WQaP8jHmufjtVIYKR/Lp35+rlsY1lZfNY0pPLEILEoUjZxa7AMzEnN5rQiFWwaT5vepgqQRBoEPBDh9bDW+vUXec0HT0x2wvTb1HIXrjeCQVWgn709DLpCmd9MaMtIQOAYs9Mg4FHwmPbbGv2o2LUZT43UxkDVITsb9VAwve0++f3a/t0/UhNW7PT8w564/TbgLFHsGy5MOAlWPZBFH3A32u+8HwDSu27qkoBM0+W2awk4K0OI6DU7AxRVrI76iEgXXd8rZGEMEG7SLhc5vmrI9esgRkYiI3qYYVkuIkkfNQUniy6FQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idEkOYXbiY81dr+/HxFR2VwJoQt1nwA5cm8b7imhnRc=;
 b=VNZygLHMWo0T+gG73NOT/158F6fD+B2sj4qe2OlN4zg2X8IRp5mi6ntS/7TBPgz7LVgKckM53yIRVSTopO/oJnsgAlaqPBm/YkzoCZcYrUVC4tcNhT8pFjYzO8OlRM0MkpcFpkbRkca2znAWMBiZVNv34vUxjwk/uFZxvMdrZY0=
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:37::10)
 by PN3PR01MB7647.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:22:32 +0000
Received: from MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23]) by MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::527d:d71c:fe10:7e23%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 10:22:32 +0000
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
Subject: [PATCH 4/5] dt-bindings: clock: Add binding constants for BLZP1600
Thread-Topic: [PATCH 4/5] dt-bindings: clock: Add binding constants for
 BLZP1600
Thread-Index: AQHZaHGyF2fs0jiP9kqhgqQARXLnhQ==
Date:   Thu, 6 Apr 2023 10:22:32 +0000
Message-ID: <20230406102149.729726-5-nikolaos.pasaloukos@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6906:EE_|PN3PR01MB7647:EE_
x-ms-office365-filtering-correlation-id: 8a750ed9-66ec-420c-1fcf-08db3688d518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXKLS7N6LzXaFNGSuTRHS+m+hPJzWhT97/R0rdJtMHHbs8hYmkGf7qGWbY6LIfrYHztt+XZ/fMs/rBjsJTbBGwfzEcwtIj2i2CJ4Nz1C52mNV+XTZX9tDwpoXOguheATxsaORWZjamYeMjiVo8wwgjqlJHZ2i7H2bxvAnmOYpoXF9x3IasImIFg8wb8BRu1eVS3vX+g+Yl1MI3wzbN/IG2nvMLktX3h6kNIonYNm5z5F+3RCNVT3sDLzXdBHRs+vDuKBEOKHbJxBT+fIcBY5KkHgzvdZQhurwIxhBMxMfyMcewlt58F5658OWuPfisjysRFw93fKyV3TAPmUMCdormAXKE+Y6Y7cQ1OsuMf5LyjjlVUSDiaJlHzt0BoFTcZOFOyDY0OYhDI17TEpKcCk4Kl/5yo1oxQgt6n2gE+PIwl9haJr7oxTAKMy3T2oFibX0L55/t3PmEYnz1h/gytPWgbj4ODlloU/38sree349kR0cbXcoR/kuYVWlmaa09cZ//K1uMt1GxxgOnoJjCNmxY/eVn2psdXl8yptGzkd9dDS6gt3HoPB24iKFB1VtkAiZ0SLCs2ugfRVPYO3Du+LhfclNIR01I6h6YyZDIZYIRPr0f8Z3QXjnOEndZN+UwoZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39840400004)(366004)(451199021)(6486002)(4326008)(91956017)(110136005)(54906003)(66446008)(64756008)(76116006)(66946007)(66556008)(316002)(8676002)(36756003)(66476007)(122000001)(6506007)(83380400001)(6512007)(107886003)(2616005)(186003)(26005)(1076003)(38100700002)(5660300002)(41300700001)(71200400001)(478600001)(8936002)(38070700005)(86362001)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bqrpNjqr2UqeD/VjDzI1HKAJ97clh3JyUqpfINkrrYeXWGjdRYyOOwLc4U?=
 =?iso-8859-1?Q?N9uJ+beaPLHQjwJqAy0fHdVXcHhXwQGdn9uMzhQ/4qWWvqR5/xhAC5BFvo?=
 =?iso-8859-1?Q?GEkkOxnJxxtP/ni4Q8ZWrQPksBWxZk8DbTI9IxyN4ptOrAkYt3gJH0ydrI?=
 =?iso-8859-1?Q?fGVJpaYiBWEUBs/dzh/r9HgRJvvhH4uWhem8jwPPXsehW3LXx9+FL0DDGp?=
 =?iso-8859-1?Q?zws5FzDXDXAsaoH3NDNPHOsL/rSVOLRyrs3aSWV6AvpLFK+PmszcUkIf2E?=
 =?iso-8859-1?Q?yhkeFPKm4mwpKAKcnE5Vi/C9HNS/mSjrYs/5FlmQFjQ0pW37hrgqf8ncs8?=
 =?iso-8859-1?Q?2dVYNj8AvkH0aQ35DTnhiMasz8BfAjJ88pbXpY01cu36hGMUeI2VIcKnmQ?=
 =?iso-8859-1?Q?YFI+aflMh9tUMe8nLT7+Lhin5ogQIH2BDB7o3FFz0wsFhCZon8yVSpDUH3?=
 =?iso-8859-1?Q?t8JPQHDQ6G/K0ZnbrI2oyNSb6dwJ3UI/2lmH0UWaqdn5QJJrCoCGB33qNt?=
 =?iso-8859-1?Q?dc0lfbngGr9D29Ebmu9xQfEsL7l4q8GTDYOvOwJoZ+09hiwkIdVrkE/iUN?=
 =?iso-8859-1?Q?0dEv7v84UnRI9kqFskjjCkM6Jo2UoJTidfAYQhN74iL+1mhIDa62T0NRPn?=
 =?iso-8859-1?Q?aN0cmGnA0hvRFaJARgN76DlO2/+0zlh9DyE2ktTemeV/1GR74lx27UhITh?=
 =?iso-8859-1?Q?IY4ccDzBVpr4JCaCrbnX0P06VHhFnEyH/+JyoziBYvIU1QN423D+KOMVOJ?=
 =?iso-8859-1?Q?vrieIL4u177gR7zazmwetDW9Wvmc1WB219XYXkgpKBl99Fe9RrVSgzaHTL?=
 =?iso-8859-1?Q?e4OkDt3KDn50zHJlF0drM5gBTrEV5rZMUoneAAc/slqGzhTr3NfHXaTOkM?=
 =?iso-8859-1?Q?9UTp5gK1fnnGMmlqX/IMfgNwlc0rLHVS4txX+HUm0pitcqjMUzAN4jlaDi?=
 =?iso-8859-1?Q?o949h5k7s5k2pcQUN5mr9gWE95gpB3HlJZ9bPUC9WCLwpn38pz/k2ICJia?=
 =?iso-8859-1?Q?h5Ho8Dg/7mahxf69kiD8wYWCzPn2X3Z9V71W8FJFCE1XuSwWnz4TBiwesf?=
 =?iso-8859-1?Q?tq/Qvrq6DWBedB1PmlqUzx99Ch3IUj2OV0wrleGeP6v8EiRMU+/c9zWdGT?=
 =?iso-8859-1?Q?VmzfnRkUl1CGtLLQ8/btHXIi6WjdA/GguBVWcCFxqd+O1aUOz2+jkEyU8v?=
 =?iso-8859-1?Q?nwGz3unsjICk9unE7KscbfVln6hmm+UHoMSVVpjiQIkrE0EPQAqEGHpeMp?=
 =?iso-8859-1?Q?p2neKWg2dIvtuT/vZyMtKTvTauTYsxjUuplAyeknVJL40TvLGRA3xKCaqG?=
 =?iso-8859-1?Q?3kuVmPreV4PepVtTYsk8zgPht92e08tpUVsGB+7xXMBz+p8D4RrG1zytqi?=
 =?iso-8859-1?Q?hoAlvzydAL42BJE6hD86Z/szcsbmiPgfZyMHqcaX159oIa5lLtEucp23F/?=
 =?iso-8859-1?Q?FER/GWj8EBAnDnBfUpwZiZaLrr0vl1LtZkgY5Fz0wgAwJ0wRXmIf9XQ8/1?=
 =?iso-8859-1?Q?MoF627TacI6BS35f5BievWV3JYseCoJw8BTY7kOmxA13mbj+rwRnV5NWn0?=
 =?iso-8859-1?Q?cwotjkHEivX4Ycxc3aESgQhbBWZZT01uA56w2R+zJ3DbxuswucGSpRq99d?=
 =?iso-8859-1?Q?xJ0d82rNDPv3t3LpAZBpdO3udb8fvIRxss0DJagmCyYaE/tUP5elJ/hA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6906.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a750ed9-66ec-420c-1fcf-08db3688d518
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:22:32.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6C8JoGuESsBjxJSbgjlG2wd4L6D6dg9CqwOKb8LGQko+0gD+1hUHP8WfNoGR3fLDLPbeVa5BRiXdzM98hfXltDQTmLYcXCNO51a5IagxWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7647
X-Proofpoint-GUID: awd5GC-PXAyb7lZbwY5ls0IKOdfI-6gM
X-Proofpoint-ORIG-GUID: awd5GC-PXAyb7lZbwY5ls0IKOdfI-6gM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=566
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

Add SCMI clock IDs which are used on Blaize BLZP1600 SoC.

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../dt-bindings/clock/blaize,blzp1600-clk.h   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h

diff --git a/include/dt-bindings/clock/blaize,blzp1600-clk.h b/include/dt-b=
indings/clock/blaize,blzp1600-clk.h
new file mode 100644
index 000000000000..bcc8ff513b28
--- /dev/null
+++ b/include/dt-bindings/clock/blaize,blzp1600-clk.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022, Blaize, Inc.
+ */
+
+#ifndef DT_BINDING_CLK_BLZP1600_H
+#define DT_BINDING_CLK_BLZP1600_H
+
+/* Simple clock-gates */
+#define BLZP1600_CPU_CLK	0
+#define BLZP1600_CRYPTO_CLK	7
+#define BLZP1600_GSP_CLK	9
+#define BLZP1600_USB_CLK	24
+#define BLZP1600_USB_PHY_CLK	25
+#define BLZP1600_CAN0_CLK	26
+#define BLZP1600_CAN1_CLK	27
+#define BLZP1600_CAN2_CLK	28
+#define BLZP1600_ETH_MAC_CLK	29
+#define BLZP1600_SDIO0_CLK	30
+#define BLZP1600_SDIO1_CLK	31
+#define BLZP1600_SDIO2_CLK	32
+#define BLZP1600_SD_CARD_CLK	34
+#define BLZP1600_CSI0_CTRL_CLK	35
+#define BLZP1600_CSI0_VDMA_CLK	36
+#define BLZP1600_CSI1_CTRL_CLK	37
+#define BLZP1600_CSI1_VDMA_CLK	38
+#define BLZP1600_CSI2_CTRL_CLK	39
+#define BLZP1600_CSI2_VDMA_CLK	40
+#define BLZP1600_CSI3_CTRL_CLK	41
+#define BLZP1600_CSI3_VDMA_CLK	42
+#define BLZP1600_CSID_CTRL_CLK	43
+#define BLZP1600_CSID_VDMA_CLK	44
+#define BLZP1600_DSI_CTRL_CLK	45
+#define BLZP1600_DSI_VDMA_CLK	46
+#define BLZP1600_I2S_CODEC_CLK	48
+#define BLZP1600_DMA_CLK	49
+#define BLZP1600_QSPI_PCLK	50
+#define BLZP1600_QSPI_CLK	51
+#define BLZP1600_I2S_TX_CLK	52
+#define BLZP1600_I2S_RX_CLK	53
+#define BLZP1600_I2C0_CLK	54
+#define BLZP1600_I2C1_CLK	55
+#define BLZP1600_I2C2_CLK	56
+#define BLZP1600_I2C3_CLK	57
+#define BLZP1600_I2C4_CLK	58
+#define BLZP1600_UART0_CLK	59
+#define BLZP1600_UART1_CLK	60
+#define BLZP1600_SPIS_PCLK	61
+#define BLZP1600_SPIS_CLK	62
+#define BLZP1600_TSENSOR_CLK	64
+#define BLZP1600_VIDEO_E_CLK	65
+#define BLZP1600_VIDEO_D_CLK	68
+/* Special clock-gates */
+#define BLZP1600_NIC_CLK	69
+#define BLZP1600_NIC_HALF_CLK	70
+#define BLZP1600_ETH_MAC_M_CLK	71
+#define BLZP1600_I2S_MASTER_CLK	72
+/* Clock sources */
+#define BLZP1600_SRC_XTAL_CLK	100
+#define BLZP1600_SRC_PLL0_CLK	101
+#define BLZP1600_SRC_PLL1_CLK	102
+#define BLZP1600_SRC_PLL2_CLK	103
+#define BLZP1600_SRC_I2S_CLK	104
+#define BLZP1600_SRC_CSID_CLK	105
+#define BLZP1600_SRC_DSI_CLK	106
+
+#endif
--=20
2.25.1


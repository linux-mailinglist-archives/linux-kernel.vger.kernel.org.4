Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B35734EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjFSJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:02:23 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D598;
        Mon, 19 Jun 2023 02:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axh3Lr7Yo3TmhmjPX5/uQ9sX7xr0Et60SpuJUwA2AOPqpq8joAGhJFVdsHebYlDPvg/pWMIAME7CWFXwJycpAhDQviT1Lj9pP+PV8XbJUnhEqRr/+eYJxmK8j1A9aDO04xk0qJGvqBWloaXZB5oSN3U5Dkyi3Tght8Xsg1k+ckj7CMjSXCVjiiyh1Ia6IOAE67U9Bytsq9XDJWoxlHO4JS14o02vC4n37BbsNyBz3S5FMfXpSAf3HvFzE5VDev8XhM7/2JZLdMI5l7+ySD0//BtRsZCadMHjwq9daEewQNTFpFFEyt039bAkW65mvkgyP+SDtOm7bT3zCUiwhAj+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=ZnF41rjoRdyluXPTZRT9leDDnjh0gqcRL7EcTn9g+x8eNm1g5Wb/OxiOOkxcUrfX2I+iclRHhggQY7qlsIrKpE1QZE/iBUNDKNgE967IpCpLSuG1xvnIKfLsbG46spDvqvC+C0yDKk3pZjcOIpUxhHS/Getzy8ql7kat1Y3XiXtnD7/jXfx+7KQeyYZCYROEBDrvZbHlrO8BTkMyZbkCm7++FnKQs40ilmVdQevlb9VWHOZdeMDrj7f37VbJYidqGk6Q/w7hyt9+ri5QPBdpplFxRyNwiaXw5uMqrBxquOe9fdWVvoZtCuPcu1bBgVi9XbNzvR55C1t/mUFULXTrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=P1lVek7jG0Cs/fdL2FyDrhqkA8azyNXRwx0t1BFhCgopT7BBy2tCBIL9TdFwvbQccOk+5B/FzrwXB68EMPcJOhkN3EgDzVMP3VmHRsR4gvolAGDIpSb5ygtFtJ+C/dx9hdIz2qdVAfnh3qvMrZF692h1AObEhAKZvtQMjq4n5h0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:02:17 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:02:17 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 1/4] arm64: dts: lx2160a: describe the SerDes block #2
Date:   Mon, 19 Jun 2023 12:00:23 +0300
Message-Id: <20230619090026.22713-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230619090026.22713-1-josua@solid-run.com>
References: <20230619090026.22713-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: c9da835e-347b-40bf-91cb-08db70a3e1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0bNn0vGDOLIyjyvjIft6Qgxg3VrU7gwQA+n8p21DJYr5Mwnom9BdvLt1kuXOBQ+NxQbEI6C2jwwrURpQtB3gqoZZGDpOcxuRh7v7I4EX/0kruC0JriDGJjFqZ9k6I5wpkA3PXljo0G+z636cQbObnbbEFSoV4O4av7qfxniWv9x8wJYsVtIZDl8oN+L+HdoS2nnpgbfN+4avPu7KsqSxJZZWlfaUnIDkWzRaA49lJAg/hozwSfmqnJhlm9b6gTJx79ZLAOXw+z5EFSOwpNPF2yIZra38v5dS8d6nGBefPIUGHHvNqU9bmobOUoQS1CIIeR54tRQktYzfkQjyp9lVJwx5vY5FTYkHD8XhzcyUVVEuHbmRp6iatr5LyKuzS5KiwTUUrBgOLNZ52r5LueevrzziHjrTzyaKQ/+OGhsjTBCtl/YZ3POzAMJchOwZrOCLUEn673FLRgtnIItyM/FaG2ccgdP4TzcOYmJLVcUrppBsi4EOCHDQb8F3QWbeW9877zWdzkw+AfePnC4AWmMBIDi8/sdGNehcuv2nwYklHibxqzlYlhcsRsif45qOl26WNIvgtlSyG2YcFhjA/2Xvdd3Ow+L3t2ZWMKYPaH6oADAch1Gq6UegAVY77B5fcbK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(52116002)(6666004)(5660300002)(86362001)(4744005)(2906002)(36756003)(4326008)(54906003)(8936002)(8676002)(41300700001)(66556008)(66476007)(66946007)(316002)(83380400001)(2616005)(38350700002)(38100700002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uUulzcef83176QkJmX3IAJ1cZ1kcbAyn0RJS3iwRjjP9rZLSBhbzYmu474BO?=
 =?us-ascii?Q?a6r0IpvZTh99Ea7To/v1azgxhrEtb34kjlwgO+Xf7OeZlYXYrHrqwAjnvmqe?=
 =?us-ascii?Q?NrHRF8UhhfpNXuLXQyP7Bd+DXcM3zQzN4VVrEHrSz5xOMZORAhwhg9zYqtQl?=
 =?us-ascii?Q?CX8/QazbbjduUo/hp625/2E91DkHQoz68T2vrfVfNAvj8hfIc9i5f1MNeCan?=
 =?us-ascii?Q?oJEnotl1Hdd3Ic2UOEWw1mTWBqfpKV6A7nScgEL3QrQcQcqwqtcTU1q0kVra?=
 =?us-ascii?Q?AlJGsbUSC1UYM32YlriIAGUEBcNCcF6kCDgHdY04CRaNd1lq8xQaZuz3+XOi?=
 =?us-ascii?Q?E3ZpHNqEjN1Ugeue/ZfoyJshRqF2v6QoqXK3JZPYZ35Ks2DJvlT1fDSziOQI?=
 =?us-ascii?Q?KGUrKm/i2Q2rOFwclGDL+jAlC6Uqpmq4+C1R/xaAu7oaWZGEWXqu5JEDeIQy?=
 =?us-ascii?Q?sYld5n75LB+JV41vF+unTEE8XhAGnaefn6nBC95MeJlLDRJSk8RdGhZBDFZN?=
 =?us-ascii?Q?fw8B28R0H3kvTgAi8W5YFi56qwIy3nvo9rcMdK7BhQc4UXVFfRRfyOQWpgvM?=
 =?us-ascii?Q?aGgTrgSI0ST+kLWFaFqSxxBO3/jYGP6Hntwt8rL52UVl16E+2gFiY1iVLxgY?=
 =?us-ascii?Q?HZCfGnXoG2lcA3WtjBdvks4qyOzxgOYHlHVvKfy2Vyi+J6upiT9IB2E3TUq+?=
 =?us-ascii?Q?dVU5L105/lQ3vp7aCOSSJn5L2UOTQpT1+r1LdwU1chItSXXAODXLq7JT1J1U?=
 =?us-ascii?Q?JsQ4vRjQrjtS283fCi0ZjTDNjJMeqgIc8PS4RmtWOsFiOXzqUjTLkoYfn3YC?=
 =?us-ascii?Q?C3f11BL4gTD0O7heCk1ZqfcGeNHlkdwxb1pehqh8dGe+3Y2Yuuxuaccr78iJ?=
 =?us-ascii?Q?DInyA0a6E/BGy7DQJ9EwPfzN0rWdm5+LYC/zzyPBTw0HB2D9leDGzn1J0Nvz?=
 =?us-ascii?Q?zR7mvoyLiJvm1DxCGYVfQXe10U72ImDIWHV6Ev1UGJvrnX13xfNKODqGHRBu?=
 =?us-ascii?Q?J/aBh7ngmJP6Re+dUWcaaLh63e5pzW9SNL9NPVOgpmq1ZHj9QvaGmCc+Lq/v?=
 =?us-ascii?Q?Al1HRILTJaP05pmzCdVOq+DFdrdXxAThL70kSQXzU6ZfGkOvrTIAwp/F9npI?=
 =?us-ascii?Q?R4fS3WI0yTAlUZI9+lUSM82+y9hbnuH+OtmwSMEia8i3oe/mnXj88FowqxnV?=
 =?us-ascii?Q?uLoWB1Z5TGAma+Lq/y5hOmuWwzlP/u6DIOhPS1MGKMwlu8i6YUGmA3Ax9Lkc?=
 =?us-ascii?Q?ZI45Q2X/y9EzlH4v6i4iwY97TIFV/60Urt7ISrkU6f6y2SavrdsMTzLsVA7B?=
 =?us-ascii?Q?GwZADKUSISj9J02wRJPMRNMajcUuwr/P4/Vlynt+9DCfGTMfdpbUgtwybT9T?=
 =?us-ascii?Q?lsnyBrx+gMDeCjprKmcR9u85EwwqlvjJOWhp/G0rROL4lCEttTQXzwfA9A0v?=
 =?us-ascii?Q?cXZoantjM8Kd5VcKpDarm0Aiu5qtXWvF/Pp3PaJvdikaTNDCLcfXKJrh6PU3?=
 =?us-ascii?Q?2Yjdpi35CsWh/BouqbD+pLUl+E0KFw54QIF/XIAiGlANNS7YcFBlKOE3zS3I?=
 =?us-ascii?Q?6KmqhJIgjw2XhWtMAftrk9vbA/SKf87LIbfj+W8J?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9da835e-347b-40bf-91cb-08db70a3e1f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:02:17.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XNh4SuhF+niMhb8SQ04/H+PMGuO6M5rQ5qUAAG3gNSciUfZW8Uk/MbmM79R3XjL/0t4ltew3SsyE99cKhGP/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the LX2160A second SerDes block.
It is functionally identical to the first one already added in:

3cbe93a "arch: arm64: dts: lx2160a: describe the SerDes block #1"

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index ea6a94b57aeb..2e68c05181dd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -626,6 +626,12 @@ serdes_1: phy@1ea0000 {
 			#phy-cells = <1>;
 		};
 
+		serdes_2: phy@1eb0000 {
+			compatible = "fsl,lynx-28g";
+			reg = <0x0 0x1eb0000 0x0 0x1e30>;
+			#phy-cells = <1>;
+		};
+
 		crypto: crypto@8000000 {
 			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
 			fsl,sec-era = <10>;
-- 
2.35.3


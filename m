Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076B9734161
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFQNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjFQNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:40:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D8B5;
        Sat, 17 Jun 2023 06:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXJniutfSS06bfBs//MiDqryFAQrlYmjhR/OVtumQFmdiFd8XuztCHGx3s0cRl3ylnzyA/TpC8v6Dpo5EyuGbCh4itnSGhfhzQJ1qmGgs8/sQqrLpHfryVGuUnzSKrsRHP6ycmyZ9XP5yJWb+Dm/z/Ndap4C1IxTIPpQfXvUI2t8tpX/HkR/DKmjQfiduRo9HcPcfvUPLDIdkISNYT96WprGAFobqaWbtpvWR7tY8F5HkbozmvALObEcbn/J9SMX239QeEhaoNUnugzJqXuTRFQ5q0Z+KhXcVE9+JXnfzN0Ih3heizQTHvkJCixUdRKlVvM0st958DtNW8ibLj4qMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6HlT5oupH7XTyMxEYEHtquV4GsGI1J09d14g9e/wsw=;
 b=fzjaxMBrPG9p2F8+0RbUZUyfxzMLwTJ1tINty4ByEyzOSzCn0NrGfWIArMd7Ar4A4PSwZTkVvOpmTp2sIicIi3Tmel315ctc78Kk3/RKuSRjIg4hQDQR1gvFvW4flXI2osjAkcgVcroBKWXrjpM+ExY1dgsNh5SE6MEv9SR+403kS2WNYCYLVSwn/ismO1ZQr4FoUdpDsyp14wfqnV1CfUePe0gxMm5ZKh91cl/OWcDTQCQkq+YbQDPBfV7wBiZzFY4FuEZ8Xu0RELmuNnrVvUTDDq3u381iC2d0UPpje0ttvjfPaJzNH+n5fiqyli+COEPYRKfJ/OAjEqVY3Pontw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6HlT5oupH7XTyMxEYEHtquV4GsGI1J09d14g9e/wsw=;
 b=kRZKqWVRh4d5dw0u1vYBP7x6qKLRw1eqPP66mfl3AOg2nknaimt3JXlbSS4+2QC1kvmjeLc01G3Dj5Hi7Qvj5GyPIN6eIlvFbrxiTvJNNu4xH6XOs9gextwAHbFqmWB/NEWdesv+vQnXNX2+v9qUTQIjdIyLhAnrm1rWO4jrFRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.33; Sat, 17 Jun
 2023 13:40:30 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 13:40:30 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 2/4] dt-bindings: net: dpaa2 mac: add phys property
Date:   Sat, 17 Jun 2023 16:40:07 +0300
Message-Id: <20230617134009.23042-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230617134009.23042-1-josua@solid-run.com>
References: <20230617134009.23042-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc65822-55de-435c-90d7-08db6f386ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KbnPU00JXf59YnrMYI1NLPp/8UVd1JubX8T9yCnm2c3cfvauQdctSvQux6C7L+P72H4ibtkAN6ZJGcnrbmlsLd1xZ1W4dZ/ZAj3VRbgBhDXvemYR1g52zaNHgPv87BZ8LZL6HVD1WvpVic4zeTIHjTbgtzFPBCiVJUE8j2BHLCLlCtttHbxrWlZ/zQsfUYhkCvhWOuSI7hXiSleIzpLqIVh9AOctTkXY9VzYOekjPt7YQsHFoY4MdYShjghspQpSijm5vewgqhoFjZiAZtcB6/nq4IGLvZY/IpEXSmRSvjelcHxZ6k0Tny8rKN3YPJRNrgIKIF8iwDi4DTitOZ8Y6/xtckLrBmr1UASj8Mkbmx2fL/NadKxaU4OtFWH9OjWEaQDKVrhj6YjBSAfh5By6It3Iyt1+DbVQ+0iuJgnnZY16WnfY93LwPjIflU0S9Ehfa02jLGNQZJJbzZA9/l5p5NBjGn/m18aqiN1aPsGhxKdEBRgxl1OHLWyOUzBnlIR24Y19atB2DnIYwyg02zUcznR3E5mG4hfyeCtRAx5q7CB2Xh/Dgq6L4EhkjmvJDa0iOmumSomS4INJei2JnrAzKKB1kwtc2bxvzMTtpo+zIqPvboK0hWxM10XW4BBXtdL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(6486002)(6506007)(1076003)(26005)(186003)(2616005)(6512007)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(52116002)(66556008)(66476007)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udLMvobI7iDgPdnD2o+K9bycowapB+WZn3JvECQM/o6KkCtBgd2TdAg4hqas?=
 =?us-ascii?Q?Gpn/18EC6YoTsKquDNiZgz05k+vSBgKtu/psJbXxUqszN0mMd3i6h35uNxBD?=
 =?us-ascii?Q?XHNo7OTN6vWVmF2FaECU8Sz0rLHhh+weQjM8prprQRZBwEFYLGP2c8yX3AyO?=
 =?us-ascii?Q?ZIxLXwX9RkC9LqQa20CGQu094glCmN1R8Ng9AmaX1iP1ak57ZrQEiDf/jQs6?=
 =?us-ascii?Q?lX7ZSZDFZrF2aN0jqj1my1EZplE55K5x8y2mXYH/HW33G8BTc0ibGSg/cAr3?=
 =?us-ascii?Q?MYQQOMTbOJyNAM5KKnbKz0DPDUbKjCvYQE9bWavFDo2zkY3fzah2erJtrMlG?=
 =?us-ascii?Q?MCXhAb75qX+dAyPyu6lwCqhT10VswbXu5ZA/fOFhMEvKwZQpUjJovE63qs3U?=
 =?us-ascii?Q?nasgEDz1YFeSM7NW82iZ4x2NNPv3BIAqlLtCXNsH2xZ1aqcGAFqP4QrfUOCn?=
 =?us-ascii?Q?gn+oHLoBcjX3Me5pgIYpYzSPHC2Uh0SJ0uXF0cffW/U+iC29fraqBDSUF5Mu?=
 =?us-ascii?Q?J83JRtPG/+6ljiYMTMBhkflNeHg1QqtWMUVHRUUDiQY0KtRuCDlj8kun54Kg?=
 =?us-ascii?Q?paLisJN5cypyc2kyemm8qurbX8bO3/oSQnmTEUZn5lKTp6LmoOSXdYSNRk1p?=
 =?us-ascii?Q?elhM2rGz9Gu6QYbu6p8OZOIdHVmAzvudhmFFl2cpWSSt2OPt55KxAVopjBQX?=
 =?us-ascii?Q?RWjUH3zm58JNGSlJp7GYemOna/bz7cTV4Soji7pDcjv3cVsf7nn+ZjuBNQXI?=
 =?us-ascii?Q?Yzzi9qAft1NgLcHziCSpeJh7xcJqEwO11/HQv4mwdDmE7vqxweoIDOZgyKIZ?=
 =?us-ascii?Q?ulvFPHlw1WlVmZbWB5+/3SFjaO4CP6z6Xn7xtB0gNj5+vsLQPpdNbY2u6Dzg?=
 =?us-ascii?Q?eWFO4bHbyR+RZlbtop9fY8dJHTPccbInC4D6Rrvu0O6QRTiu2rfqNdU9vMWG?=
 =?us-ascii?Q?uQLLBcqmoRKp5Z/YrHUZYZMoRvO6a63e62x0bHAlCYLuBpaALTwsgIYyShjC?=
 =?us-ascii?Q?LxFJipN0kLyZCBpBTfA6NqxfrAJZfz6UuhFxtEdusGxJYsuWKk975R54a+lO?=
 =?us-ascii?Q?+PzH/f8vlnO+y9XCRT6A4lGbzKVcYAZM4nwvm+JIkm3mAD/AGWb1MVOJ0J8Q?=
 =?us-ascii?Q?YLTSseURaxXh/g/DRzyyKbGK4DlqkLITpZ5T/fHQxl05MnIs8u+uCuqF48o0?=
 =?us-ascii?Q?x0QBUZ0OCbzL8N6EtN1ERV8fTZfnpP4khAvLCf5ZmjhUdyeUzD8Ukcu/6OBH?=
 =?us-ascii?Q?+fbuEa9exf0s4xC9q4njEkQMsy1stU9roWlOWzbZmhhkN0OZTEX3c+ix9mti?=
 =?us-ascii?Q?fW6p1NdiG4W4XAbYq4jnyDFTXvKtA3yzvQFqPLFvKYLnvfflujU2vRMhAFBy?=
 =?us-ascii?Q?yxxilDOubClPDEbx1X/KHAmMFY8L34+SeRmepWBGw8RCY+Lj0LJLyllrNiCc?=
 =?us-ascii?Q?RFDs+NwPuUeMOT+Fq35vTLaXj7BK9PuwI3l3UHzBmwpRTrhrIW0fmCKM9HNI?=
 =?us-ascii?Q?JtrCbw4UP/CyhVO6RJQtPCQOHeZk4U0V7RXsHEd2Xj7igK57ArG9uYUc9YPt?=
 =?us-ascii?Q?qpb275Vl/gLEWjL61mvvu+xgcxTdvWdqMPoFLLpw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc65822-55de-435c-90d7-08db6f386ad4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:40:30.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nIwrLUNce8Snx7pVjUIsNRQEmg/hNZalVfGcrQBVgtCnpTqjpYclgnV8hokc4iCIrrRcks/RGwQv4+ax3AxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpaa2 mac supports runtime configuration of network protocols on a
generic phy object specified via the "phys" property.
It is currently used with the SerDes28G driver to switch SerDes
protocol between SGMII and USXGMII at runtime.

Support was introduced with:
f978fe8 "dpaa2-mac: configure the SerDes phy on a protocol change"

Add bindings description for the missing "phys" property, to fix dtc_chk
errors present in various layerscape based dts:

'phys' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V1 -> V2: this patch is newly added to patch-set

 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e..a40c7a84af2a 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -24,6 +24,10 @@ properties:
     maxItems: 1
     description: The DPMAC number
 
+  phys:
+    maxItems: 1
+    description: Generic PHY for SerDes runtime configuration.
+
   phy-handle: true
 
   phy-connection-type: true
-- 
2.35.3


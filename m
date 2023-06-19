Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68760734F00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjFSJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFSJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:02:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F0E9B;
        Mon, 19 Jun 2023 02:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSlShRMIqkTLsFLsSnE1lYp0JHIcI2u/NY7wTLnQPS40/6SgAAnU5WzGPqAPhWmu/IAudJnBSfcRURhvJ6N9dzQPinwhx8QBfM+sxexhsRUePdLqo5WlD6KEFbhikewSNov2wT8v+da53EDFT/9QU1NNO/oL0HMtHCsRGGhgI45wyGi/BTmRv8G9KHb1FkwbKQxbvDJVGypnokvYtLov2K0CyAVrjetxzqtNzQbRs/zgXj1cces7oUl1sgYaWwj6rKCg2MR1X599JnNoFYZ1Vb1mVqRW9J93TOc4IHfqNsMWIVobIqZ4iuH/a8NAu9nZcs86Ey9cMbYr+UBCcUPaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=WNWWN3TbGtxRzYRE1mNfBx+3RjAXlm2QYibMiBJKYt0t93Rx25uOHsBJZ2caIIBKolKTMN0rbTLd/k4u2xmSycMGoYTccyxrRhusQN2J/NH8XhO0NjdgBZtNBeoXz81p6muLbhh4MPvll6HnQjb6Q/OldNLeTkJmR80/mZSPUaM9PX703Y9dzUDpqzzmFTZpjdwvqC6gmXF3V6AkpMrD4iIO/vm5iRMhO7kJbku5aIyvf/0K33IdQy+CJPEzG6IUv2sZF5XxHodUWsNAjfXUWmKeuigsTVuJLNp9RLuxEDwgaYtlt9d42YGlgL+9quBfCGsJKdo9ZhrEENMZZzQXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0B3b/ucyjOAYWlQFGDQjlTeWZr8CxeOTg0uej/vw2o=;
 b=hdtCxKOGrX+un8Swpa1xG46YzMmxCyhmwT/mwAzfJjKwgLOIIx3qjNC7rHkzMClHY2VN58JTKTi5TBlHD08W0Db6FbLGE8f2sUcJdQzuBMqiNsgEueQ/PP6JsW2m2b1ADowT3CkbTPPcnEIUBwe53kPJ7X6lk1/j5B84pqDnnEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:02:18 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:02:18 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 2/4] dt-bindings: net: dpaa2 mac: add phys property
Date:   Mon, 19 Jun 2023 12:00:24 +0300
Message-Id: <20230619090026.22713-3-josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3228910-e0fd-4feb-244c-08db70a3e26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGHUpDpp9WIjFZi+MuWZYP0PI2yw8x4Eh1La1Fye03YzPfnRWqW8YynqQkpETPTglrBtBAxvN+d93YdfB+4+mM2CBVthOXrumBR3z9fGnVlV1sYA7pykW+Vel/q/o0X3rN3nl0JMm/SfEw3hi8yYowJ5RbDEFan8b7pQvjjy+mvFpKiURRYUoDVC7lYafadB38k+4S73WKa83Yl9hBFXYQTolarAvoxW2kqe7fzyKsgO5xOTXcK3kebIfcjWtZHGmTanlqAtwb//64pY8UCm3T/OtuogjuZFXc90pAhyUY+QcXhkXE5Vlw7l3Psv1I4HXjUq75oXIAL6SGe7NV2NgOuBEo1QSim3AHLl6p1eIR9tJmG9x/ZZTSpjiyNj39vvA9L+KhHIYb6yias4MOCboo3qoyKcrBohO9bt2Ubwf3FPebi295/oiQS2nIGQs6K/1a0Tt+TUMiOTo2Qafe3nbFn/6PUkgfluxY+ggKL+45Vc/7LbZauJ+8Ocffg4/x5F3MFZkzqy568v3STeJQ5JMwET+ivtvr+l12NkbqRxvKLK30tMVTL/t6EEM102bmOR1wxQnFvKsV1+70YoMX38iH1QcH5k09Pi2RTed/eF8GsVj+Ye+bhoIC+WxbJhIDsW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(52116002)(6666004)(7416002)(5660300002)(86362001)(2906002)(36756003)(4326008)(54906003)(8936002)(8676002)(41300700001)(66556008)(66476007)(66946007)(316002)(2616005)(38350700002)(38100700002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wleUaY1husHqEcRzkDO2hfTt8GRDwtJloDFeFcegis/LVtgJ8RkItZNIlEw7?=
 =?us-ascii?Q?vT4P1dKKhKNo/HgiUM6nHz0Hqy8TOXYPdzlcvh5eGaAkmDhKm4twX8Hps/Bm?=
 =?us-ascii?Q?ayUyGyhgACuWNd4PfEtW29Op0sFgBcVBRZMXRhAuvsRa60MHv0qfXOeEYEIF?=
 =?us-ascii?Q?DEKjAuwIJONRAGVmEEfFDbXMw2fnJHndoipYCxTdfM0JWEwdb1VvGWBSojhE?=
 =?us-ascii?Q?qeesbD10Mqoc4tQ9a136WQ/sHYssmqHg6HLnHlSCa7oNtLis+KrI1JW+OwP4?=
 =?us-ascii?Q?GlmHZaT2Pmt2zvGFkOnaaLWl9AhnDGTxPb+iJ+GePH7gE3/kH50MXsSGbrpB?=
 =?us-ascii?Q?McNGIT+KIWpBjZDaeDdcC3tK/rz5cTnTgcysub+n5UDRFmTkUljK04AB/DND?=
 =?us-ascii?Q?42yn3UBSXHuE1Jth4SDX7vSIK+KrAot6dLTV7z5PEj3wCK/83VJo6rqvcX1F?=
 =?us-ascii?Q?9EecBEqqGMIINzN3/ZHecd9sA86lptmzzu/Q1KCWPEPPEwV36AQbgRJk9OdC?=
 =?us-ascii?Q?rj282AiwNqmIDLJMHjXsvyXtv2OSC5DqygRqyzWdcau1C0BzZqy676hobCRi?=
 =?us-ascii?Q?1nyG2hxmJfDzBPUmnML3DenGkDIGaJxSYQT0uUBT004VMdY/LAo2+3hV92fi?=
 =?us-ascii?Q?PhjKssfm50p8JAGjHKoML8+q/FZcrgPsj9lyGTgaAO+grpc+SLHF093sDqIX?=
 =?us-ascii?Q?42IMZMgCqRR720qPqToAHI6AHTzaYhOndhwzuzIN9qkzVc0ijCA6Qp58wImu?=
 =?us-ascii?Q?yZu+xVbR948my7ZqEN1G0653yma5MvVM4ILDMwY/DqLjcXpAHSEERrB/LcCl?=
 =?us-ascii?Q?05sdPz18vtL/9Gg3npjzKA7AMr6IBTXeOD+Xje2T6aA+Up1ilOAiUAJLYRzH?=
 =?us-ascii?Q?Jv9XlAFHb8itABbcJdQPR9Ri3+oCgKx35jGlwueMzY9T3JfGWm/pmqCUUZmr?=
 =?us-ascii?Q?+mAxJ02zNgKwJ5EW/izfAy3bAYb+wwqwXA3UVB4HD5/ADTxKY0hMMvRg4H7k?=
 =?us-ascii?Q?YlM+Dg7Bc2PhsAK7+KoSGMWELU8edww0WsA4ehABiqOJgLUzMSKGXv1fEB/m?=
 =?us-ascii?Q?6aLj74yjBRAOSB/ct7E82xiLI9kJvWxqiLPwnNPQqJKhLIMuhVjVHWL5YVgT?=
 =?us-ascii?Q?GhEU+YuBNnqoIc6AxiDw39eJuAn9QfNrTF2NlokZKmWglgcg8cnFZYpn5vEM?=
 =?us-ascii?Q?FJgDDkGS7dqkrOLI3aGECFWJZ7g1RTUAaAR1RHhto1fwGVGfNUEfZ996JZPz?=
 =?us-ascii?Q?Hsl0Tws4dLShvGtpW3bnAL1Qv7lfCvZJTWDJDZFkMI/u1zk5L/yHIBwRJi85?=
 =?us-ascii?Q?y6CTWXWPuZuDusux0wao2LXYAectjPL5+RfMOtdlVlHtqhiuSKgykpUkwriS?=
 =?us-ascii?Q?mzGoIixX7l4ebkPtUq4g4OYAN0UWZgIngwg70IcC3IMnGj8nbEapFTsFb1cZ?=
 =?us-ascii?Q?j8ahU0kbqdXRrH6d87Lmbul7yF6CJMY3xDVl6HzTS0o8+o4C8NqKPYRSD244?=
 =?us-ascii?Q?Kzeq+WRHKR33JmYC0iwch5Y203ZIH3ilzkY3E+j1BXL2JRpU90UpVS3K3hQs?=
 =?us-ascii?Q?PvFPpD7Mk86tuY5+50OiLjuMREgoKMDcCPgeEn4z?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3228910-e0fd-4feb-244c-08db70a3e26a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:02:18.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H0b7Afrwx/ff5K/DAEsodJRHO3ea/kiJRwPXLDtUockG5uyLN1Cb39h9sAM7y7SjsxLJwRlrF9Zqy7jx6abcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


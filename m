Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CD732F72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbjFPLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFPLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:08:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A32948;
        Fri, 16 Jun 2023 04:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euJiIVk5SnngfBQHjivSo+Gk3JhbXEccfsnHfvxG9iJlViq9QYPlp+MeTqDedVZ5tbl4aDnUZpqduUpV+xxVhMQaT+loErcVkJtMdbN6L5UN6CIOb6z5IDS3J9ThEXzd0sSQMxmRYINfQv2oMmB0+/nfZUaR5jFGwfVCj2P3Bypw28MDYxVVsexuO2Vo02uQv+FG/+ImmE02aaR3DylUyQ+sLkE6xEFihEoYgZEZJlsMFwO6b66vGDf7S2lfbc/gZBjwmh1CigYEllXGZkN6+yC1RQmUQ7BM2Ozp8K4qWjz+ZVOVOxQ1prwWG6VgVBkBSI/16o/RC3yGPsVRMmkoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t47WWa2ezz2lA1SJ80f3MQm2LMmcMiPJPujm7bz6m74=;
 b=TRO/rpWMnajgYWLv0aJQa8GR0kQupB9NRChzarX2IYFpPMo7TKuCuLrTWFiDphRu3oc2DEkkKVuaHZ2yiui9b1dm9ZoYgnxntS929o2UfCBDMwRAdqN2ePSgAV3OsFnZCf+XOg3it1v7dSdcEqr8m5KxlLhFV8QN2g157EG+vpurphntl7UT8PIZwpcQU3pNknpikyw46+gj0I05JBgqu70+tuXBr48VvfgIUILG+Baa1/WDS9mCg07FHS76vWWq1ncZ+Gom+TT54qLrBl6GiNCHmMisKzxnaVKEacKxVtsdEBuuVntB7ApEc2/VXp7WHTdFK4rftAX0qMsaqhOLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t47WWa2ezz2lA1SJ80f3MQm2LMmcMiPJPujm7bz6m74=;
 b=XYOFJnyiBG01eWez+wolqdpDcb9s+ox8gaoWRfHws3SpC8EcPXANk6ZxcJPuEvTgCrTtJbXrVAqJnNwEkDCM1xdX6WIhj5zGn8UztXjDE7RH/h4ZLF+Ut4qQd8AsJA1lBvv0HySQL/HkBqJE1NDvhqAAGzSpwpLlIN0D/knaE0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:06:32 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:06:32 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
Date:   Fri, 16 Jun 2023 14:06:09 +0300
Message-Id: <20230616110610.32173-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616110610.32173-1-josua@solid-run.com>
References: <20230616110610.32173-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: f1659656-371b-4349-b681-08db6e59be54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAYmMLZuEwdKVju7glCmzgtMloYpZjsY1Vng8ftvsjlmY7+jj4H5+N2YPmy+7xWa6DUV236K4CWEv6H3wT7kC8hIo4av001bBZfzPlkBymfj092AzwGt0VIsmB07bSmfcc4HyoXNw4nqScb6H4jkEyAw8lPF4/Io/psP2DhaafnzZhL6zqpZPwwJK2idlxOO5xSrubBY8/jIUVFixrV5+IW+jX30xORRPbHFMxgA0zGCCHWhtxaeEpBDpa00a/rjrhWSezAUpC6YBOYnuHcyAC3IXgznBFdot73O6HEkoN7Vug3otBpmSY/HiUZAI1FEUBTBAmvoCe0Rt1kjwB/zjCMC4dCUOG0bhTg212AhRhFnANcpBQEBFwO+fjOh5opRJuuBrNDHewR503d3UQcuU6/jm8AHI376XbaMshObExTjz12tnaOpoRAuOprj/HgAY6/CTLkuSbnF4UIAEkc/jhCLJVbNRVaFqEMiLA8iPl+s+4UrYDy/yff3jZJkuzH1aObT9/yjrI4R85MC3D8GvuNv7z2LF1kymlfvYu9AYa+zRJ6Y7fuJ40A9ENBQWMoWMtw43TBHenuByXVydDAEjmLR3Dr12DgH18ETq7nl3FlXtPoVIlol59vHyvNIncXa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(136003)(376002)(346002)(396003)(451199021)(478600001)(86362001)(52116002)(6486002)(6666004)(316002)(41300700001)(38100700002)(38350700002)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(4744005)(2906002)(5660300002)(186003)(54906003)(6512007)(26005)(6506007)(1076003)(2616005)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H0U5hKKdrD5XBq7fe6p7zBw8WqsM4SjWigGokKDBw39Rguq0u80vglXO0Max?=
 =?us-ascii?Q?waUcpuT6tAii5s0KTns+nkr9fTWOWp3LXM8Nb3hAoGkj5UVRdvxlI2504zGD?=
 =?us-ascii?Q?8lpoPGyXvRUMJNMwelp/mJViSXLDgJ+JgfOC+JqP5wKhqRsZKeGrz6/4+emm?=
 =?us-ascii?Q?VcXci1MNhw70KRW8+c/uvO3Myx5CcHZMjCpB7TV3KAOWowyFV/ZlGxPQ5rti?=
 =?us-ascii?Q?MwM3PFaP+B5/1au609HESgBDeTuED8KWEOKCus7CWmSTgGBzqRP0OUgsuzg/?=
 =?us-ascii?Q?drcEeDK4e9Gc0rPoav5fwDjsk3PkWYAoCnnKrw1ra0oblo/eCBklawrWDibl?=
 =?us-ascii?Q?ZqF9q1Gr5VJX98lOiu7gQ7148ULsvoaewU+MMbR0iQ4d9LgNZbh8uygxa94x?=
 =?us-ascii?Q?v0HdEAmXdJ3tqa7S5Z1soZcGZkjr7p7FdjR7h0m4cpAkA+4boSqI4lexeE49?=
 =?us-ascii?Q?/nOGQyIpEcFjufKPBjixvNl/76LYs8CkB5gTByBvPQNom5lqCABS+QQoXo7l?=
 =?us-ascii?Q?DAub2KQHdjHQrCVghEv1c0sUcoRJ2jT+2INuMn6I1INMGdYa51xVM8lq3d4k?=
 =?us-ascii?Q?5WzPKskghhiZ59fN0V3zjNPlwMmCWsg7sJoS79f38dB3DAk1OFFtHCH8ZCLS?=
 =?us-ascii?Q?oF9uhyCkdVpjglxG1zpdZ6OKhhziNgwzzeu59yc/LULufrlRF7ETUQp1dk5l?=
 =?us-ascii?Q?dQEEDMSrUAYXd1ZEfMx+kQpELT4ttC6e62q5EjBGARFpyAQF+WNaLavhGtNz?=
 =?us-ascii?Q?wHZvAirvXrarCHdEZ3e/TODPph9WvzEGcgg6tGceHWH4r5CQVUIIqxhM8rM9?=
 =?us-ascii?Q?xEkEP8u1SVv0o6uGd5YdR27lvmR5TCAkw35QfFqt5ZhC5tgIJuTUyDhIa6j4?=
 =?us-ascii?Q?sn5KOWBlGb9NPkEPp9PbWS7OYukqQhQcUJmeK39rJXpWCHbaDl56FVw+7Ws1?=
 =?us-ascii?Q?LaMsg3VENoi5cLGG+P+I5McT+3SBAkpnsuRVUwWeXGfXNTVdZj4JkEU5Bi+L?=
 =?us-ascii?Q?sHR0y5FM6eiOgk7+6+gxU4/c+UQ7LBI754jiNcFRe49IwT/kA9sIkdTb3HRM?=
 =?us-ascii?Q?k3yQ7MJwubmLUlTHgYUG4T8Q6VwbhiIqkOWF6Sy03wpL+3G3J3Wvi83XAUAV?=
 =?us-ascii?Q?6aGMzSPw97Az4DTFytrp5UCCtAlmqaXihR/p+kiMcDZbNTgX5gk3Ue1y7MxU?=
 =?us-ascii?Q?1Hagr5dfdMLT8A+yFbRBPUyruXFDiD3LpVe4plX0Pn3pdGHR3m1L6lZ6HtK8?=
 =?us-ascii?Q?ksdjQ7nMte63cnr5R+U/CBJN6zyAtTDCfoI/xzLvpFTWrDz1FGPeUw0Q7OTx?=
 =?us-ascii?Q?Bsg0+srmbpq2sSAGovIqQFbyuEgh87iyXNnI3jXo2Lxgxb7c3qtdaIyhiZTV?=
 =?us-ascii?Q?1P97SKbXOj1axsf6ZcIhJoh0hwvnD9wmXi7ZBGZShDy5TH3o94V0t4Px+i81?=
 =?us-ascii?Q?jlvgxHJhyCfGN/HtDPCFYRjNoG4BLRin9DInUiYy9ov2Y8tIFhZlSfyN50Zw?=
 =?us-ascii?Q?DUkE1DmoiOcViuFX5l3FgQrzw4I8bHDizHoUEbLHBnFfLTd4yBQUKvDjeXIJ?=
 =?us-ascii?Q?cegXmbfwJoEJcNenmt8+6asW+mXQSxUdxoR93pzw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1659656-371b-4349-b681-08db6e59be54
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:06:32.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoNQ7un3lI5PN/RInTXRTPpVPh5bjnyier+SzJVBB9QHuezkpVF7Ir62O8l5WSUF1OQN5Aj0gks4pVawlKdiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible for SolidRun LX2162A SoM and Clearfog board.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 15d411084065..438a4ece8157 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1373,9 +1373,11 @@ properties:
       - description: SolidRun LX2160A based Boards
         items:
           - enum:
+              - solidrun,clearfog
               - solidrun,clearfog-cx
               - solidrun,honeycomb
           - const: solidrun,lx2160a-cex7
+          - const: solidrun,lx2162a-som
           - const: fsl,lx2160a
 
       - description: S32G2 based Boards
-- 
2.35.3


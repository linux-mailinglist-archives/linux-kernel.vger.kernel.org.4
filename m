Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3E73D585
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFZB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:26:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1100E0;
        Sun, 25 Jun 2023 18:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKdPYAj0bou0+2cKc2AUhIFtErLsLQDUGW+XMboXJB4Xh1aq9dFh+DvRMxpAaLdg9yAYCpdnEHE8Zwt37NaQF1yDvb+nNpIN0E34c5YUnmeBFPnqzCipLt3+Ecj4D06vpBeuRq0nrNtiPujLgVeVzqE0lRPQMdGi45qHIOyYsR09fjH3CaMBC+qjGnxWYWdBB9q8u7dIPSfr+fcQOOdBchjN2X58pKhGzakHO79dhM1linstKY6ncLuO9wGCJA9MhhGFlGheVMMTWKIuvhVqNol47DF5TJ3c6J7OBq3FyI2Vlu9j24nwrimNMNvOQaFvP0sgV+atu3BzAs03vVRRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL9d3oeuRK5FDbYf69nqdsZJrps0QgAPqPCaoyeOgOI=;
 b=EY0tED+8ZCug/TOZ86ctzV9QN9YvK5xOm6p046j8FQNKZxBDbRQpdvIq+k1ebYP8tDaTfjbA2Fe9t+5eFbGDv+bmkimRsQd36qkQ8Q9JcZ2ydiM+rZ1KyeelLJcZkpLdYqDyasLsTwS0Ym3LAMgzMKIpndH5yGGn9oYNY0tk/4ABQiPYPg5nOntEmXMJxbSGnnyOkHeVhukFfnVW9NOYWUCPIoeFjcEvTXYsrFj6DGhESegpcclMRBYkrvME8331Qjds1uYZ8GxgSW2ULjgivlghlRVAv3W1HuN64tpGeBEASlKOXuygjiwstH2zgcSYriLOLZyPUJLHj1Ig3x1WVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL9d3oeuRK5FDbYf69nqdsZJrps0QgAPqPCaoyeOgOI=;
 b=J4Gck7aFUtrf/GUCXAjYLK77xGWgOf5S5b2Juhex4RMkCT4BxYq9QRSf6mI9QU5GJEW4mP04mr3ZTpwaSg2pzy7wBoHe8JhJx2i93uPvJd84i2o+p56CC2Vbuz45n93NvPmzBkgDeMRiY3z7bT/HKiBKaWZA4Hp16iJQe5pl6RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 01:26:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 01:26:22 +0000
Message-ID: <e6829927-d172-abff-f5f0-799a27d14c13@oss.nxp.com>
Date:   Mon, 26 Jun 2023 09:26:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/9] arm64: dts: imx8ulp-evk: add caam jr
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Varun Sethi <v.sethi@nxp.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230616174050.644880-1-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9fb5e3-2a94-4597-f1e1-08db75e459c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZewRPj435Fx62/ZgPAV+QhT8yiMJ2Fe1yF8Il16rYD4pd9cR2xuHz5BbKf+SKcnhFFbS2y/c4h8dholVrX1XvGMLit5SFcTs4NZkHn8hsNaOka5A6oll22gQ3vV531geuwbj/Bz7BIDK1FmFPRXFQVFIXHO13DXKujU5jmJzGY6YTAhVAQ9cfXZqF/LUp38j66OcQIq7yFpcuAibjzgLoRz8azHbaTEkk0coy4f/dEIYL1mATgpsH7xvoDCH/Ldp3KyyCqRyJh6AufdxbY0FiDjlfyIBu2mCuHjq0mtnw1KTA/QtsBOweVMg6kmSndC/qmXlQo4qIkx+Msy65hdQuEs3dsZjR1n9PeFrCZOcIpQE8uCHPNnWK5EcBfmkOb2CAAtZvVrSf11Uzbgn20qbH4MoX2302twl6kdf8hLzolJ0pkJViVl1PGkSr1VL+WUPpRalOKMgYIbn0/U1ce9fV00cZg047e84jiIaydAOULppEaOv63C8y4j6sGmoEbM6M97T0T9hostlw8ro9TcZRal69pdZ2K/r+Bcl0q/nD8sBmH/uD906A7q38eQkY5roO29XCNw0aEHY+3qXk5RxiiNqEu+mA+o7CZftqKCL1qccHgKp2x4BhKLJdU05T32QCFhobqvnDb1p1ihl2czfxkBloui+UZhntmWP6d71jotlQM3s0eCSJ2cglsaUrJF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(921005)(38100700002)(83380400001)(31696002)(31686004)(86362001)(478600001)(2616005)(6486002)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(53546011)(26005)(4326008)(6506007)(6512007)(186003)(2906002)(44832011)(7416002)(5660300002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdoRmFaYnRreXlBOE42NGhJaHZkQ2lJK012eDR2Z2pTV29vL2o2eGdGTXJT?=
 =?utf-8?B?aWlIQi9reDRDRzNiRXo2ODdIYnp1TGtSc1pXbWh0TEhubkp1NnVjMktPR0hi?=
 =?utf-8?B?cWhzZzFkNkx6WmJJQStLTjN6d1FnRVdiNXpBR3BBU0t4djdXZUVxcW82US9J?=
 =?utf-8?B?T3h4RWFWN1pxTzhteGd4a29XMitqZUVSdGtOblZnNVF5a053TnJyd2Z1YU43?=
 =?utf-8?B?ZjlwVTNncmt6RDhvYzB5MDgxZ1YvVkRqTS95TWxXOWxnb2tRTDlSQjJsNjdG?=
 =?utf-8?B?NVU4bGNsVlBzNTJtY2poK1phbW9vN2gzWjN0V0VaSGp2MXdRZmNnV0xQbndX?=
 =?utf-8?B?YVdUejZTQXUxWXltTi9iTWhyVCs2N0lVTUtpeko0NkJRQ1dVWjlyL3VreEJ3?=
 =?utf-8?B?WndxbjdhWFVYU3lKeTJHcWFCUEV6R3pRYklsOVpTaXJsbFdvTUVEcENkVFlC?=
 =?utf-8?B?ZkRscFkxeklEZHNJeFBEY3F1eEg4RnliMks0RDcvMXRCRUN1NkZsYVNDMER0?=
 =?utf-8?B?d0hlTFVyWDI1anRQUnIrOGF1OEVSQjVyQmc1ejVZZnl3T1FvYWZjU1dJVTMz?=
 =?utf-8?B?MzRWTlhqNEMzM2orUCtFOGJwSUFhM0ZCQmlaRmtVOWt6QnN6ZE1JWVNzMDlC?=
 =?utf-8?B?RThWb2JYTnVUeGdFZ2J3TEZaWG42SWQyMWFxV1M5WmdpZFBXSjlFd2FSQk5z?=
 =?utf-8?B?S2E3WUgzVllvSkNlcGtkenN6ZGJuRjFES2w4VlNKUkg3OUI0K3ZZcjhtcFV6?=
 =?utf-8?B?SlppQ1I5MzZ4dExCOEtSbWs4ZUJhWCtWUzREeENlQWpsbGE3NFk4L3ltd3VU?=
 =?utf-8?B?czVUT2pHTW0rcWtraHUwb3RqNi8vT215RDZ4SVVUTTR1NG9teUR1OVJzd3Zr?=
 =?utf-8?B?WWpqVThBVTZxV3FPSWsxNTFsc0VzdHJXdEFabXNNRVFDaElFeVNma0ZPa2ZR?=
 =?utf-8?B?UHNXRitVWkV1M2F2aFk3UlZJWjV1eU1Kb2RpbW5XQVRBQTNyeXRlaXpUVlFx?=
 =?utf-8?B?MnUrRDlQYkpDQ2VBK29wc0VIT240NldrZ2phODRXZTl5QjBHcTJxQThyejR5?=
 =?utf-8?B?TFNUMGJYWjBiaVlRdlFKR0FMWTRacE9hcVdUZ2FwZkE3ODdoaFlHYmZUVmdN?=
 =?utf-8?B?blJMNVRpTm9US1hkM1BVOEJWQ09LTjhMVFYrK2NWU0I0QkNkQzQ0MDc1SWZa?=
 =?utf-8?B?TXVBdEpnLzNqcll5ODBKOE9ENlpQOERjRytJUmhZRGFmU1phVDJwSUNmYlpa?=
 =?utf-8?B?M244aHZZMUV6L3JQYmVJOHN5V2Y0U1l6bU4rczlxTkpFUSt4RWRrTkVhTzlJ?=
 =?utf-8?B?dFlOc2owcHNCRHF6VktNd2pEVVdLZy90VUFLRHJIcm5LRy9hVVE2cXdhdUVH?=
 =?utf-8?B?TmdMV3pSbGMwUzNveDVBWW9LVk1PMjRqd3RlNzNBSTZzT3BubDFvNlNMWHhM?=
 =?utf-8?B?eEtxVlJ4dG1WUWNnK1MyQXB6MVkwc082Nk5XYlB2TmVjOHdDK0tkaWVkbXBl?=
 =?utf-8?B?VmwzV0ZhOHBDL3M5RmsvcE9pbWc1MVhoZURDT1M5WjNlcStFa2JlYkJaVjAy?=
 =?utf-8?B?QW0wRFNTVEVKWWZ6dFI2MmU4UXhNNVB6Y1V4YU40R1dZVnRYRzhGNXdYdlRj?=
 =?utf-8?B?dUVlcTFDMmlCekhzcXcrMGZjV1JzWGhLaGowQjB6MWk5TDhmUUpWQ2JOdE1r?=
 =?utf-8?B?MUNlbUZsMHhVcDJ5ZmFrcnNyNWVIOGQ0TUc0TXFuMXE3QmIvQkl1ejl3TVp0?=
 =?utf-8?B?NVVGcVpZYlo1b3BrWW5nNmwyZm1lbU5HclRDeTI4NUw4a1VyeUR1QWhYczFX?=
 =?utf-8?B?ZzlTOC9reFczWHdvTnM3S3NVZVZZcE4yc1JXNjRKNXVRaFQ4MjNySUpHS1E5?=
 =?utf-8?B?L1RZbkdVNVVPRE11cU1INFNpRXpBY2d4TTZwT3g3Q01jdjJSdzFCRUFlN0Z6?=
 =?utf-8?B?c3lNalFGMjdoVHVwTnA1RUZNUklGLzVDSVl5QXFzek1mVGdmQW93MFh5MThV?=
 =?utf-8?B?bnUvRENOOEVxMUVvclVnT3M0N2dnMEN0UFdFR0N0Qk1aR1NReGtiNkV2SnJk?=
 =?utf-8?B?K29TcGZiZlNSSWtwMGxJWVQ1ZGJObTJUQUZ0R2QrSnlnSjVtZVpsNm9NdDB3?=
 =?utf-8?Q?VsEeqjW+AWvkB1H6GmSaSrgCr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9fb5e3-2a94-4597-f1e1-08db75e459c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 01:26:22.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Ml/6mw7KUJlVjzLpwTPkJ2e6NbV50Jb3FBLhC/14yTZitdZ9bibeFHzVCCkBc3AGn9cZUXYI9U53QRCWIjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a single patch? or this belongs to a patchset?

Regards,
Peng.

On 6/17/2023 1:40 AM, Pankaj Gupta wrote:
> 
> 
> Add crypto node in device tree for:
> - CAAM job-ring
> 
> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 32193a43ff49..ce8de81cac9a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -207,6 +207,38 @@ pcc3: clock-controller@292d0000 {
>                                  #reset-cells = <1>;
>                          };
> 
> +                       crypto: crypto@292e0000 {
> +                               compatible = "fsl,sec-v4.0";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               reg = <0x292e0000 0x10000>;
> +                               ranges = <0 0x292e0000 0x10000>;
> +
> +                               sec_jr0: jr@1000 {
> +                                       compatible = "fsl,sec-v4.0-job-ring";
> +                                       reg = <0x1000 0x1000>;
> +                                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +                               };
> +
> +                               sec_jr1: jr@2000 {
> +                                       compatible = "fsl,sec-v4.0-job-ring";
> +                                       reg = <0x2000 0x1000>;
> +                                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +                               };
> +
> +                               sec_jr2: jr@3000 {
> +                                       compatible = "fsl,sec-v4.0-job-ring";
> +                                       reg = <0x3000 0x1000>;
> +                                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +                               };
> +
> +                               sec_jr3: jr@4000 {
> +                                       compatible = "fsl,sec-v4.0-job-ring";
> +                                       reg = <0x4000 0x1000>;
> +                                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +                               };
> +                       };
> +
>                          tpm5: tpm@29340000 {
>                                  compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
>                                  reg = <0x29340000 0x1000>;
> --
> 2.34.1
> 

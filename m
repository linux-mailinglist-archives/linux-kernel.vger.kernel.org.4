Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE76717CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjARJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjARJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:23:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435E5D935;
        Wed, 18 Jan 2023 00:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gve4jQokwL6NqbhY6+qszOOfNooW330Ip08iMRhXyYRBjnKfTsANjfDXwLc+020Tf3iHep862jpmNw+VXmDKWFvqkLf/1QfdDYB6WyTWq2K8wStaLQJZ7P66lXAc40BNYpe/mb+7Jd/4fyQcvTtlkz5riAbDxtsv5rxnwebf0qx14KAA3wlEZg2llVOz8wBtRh+aVldSEXkFtWqUmZr5GNnPv2rdDiM/iKhumNJ1e6aODl22w+sw02ONEY8dREPBSRuLS+ismbOF7GWTgrS5JhNa6AQXoNSzLCzxSBk99FkWNpsJ+49ERZ88XkDndKWeuUCzP6JK2u3zpa11kITNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P67fM+3IT0mP2fIH4QBwi7G4K7wsVydaUNg/zhECgkw=;
 b=lYVRPvmJ79+1rVnyCMaqpqpZr8bGLd6/ziIrBQS1lq2xNed9sch06VQhGnQdtUk4YN84GR5PeTnbROV5jRexa5SsnXR8+kqBZKMtWGfyKbPNi5H6q75lGX80biUmyeyjk5zRxCy9s08hQi+QQhIkllq2x6f1IGklbOnsf37J4YdvqLG349RQUSkdY84/LOI46aisKG3iTqE3Idvf7JYR5KccukS1YZrGDaORyDj0h6FMrGtyncjHELXqjBwRPid9pQtqJDDOC4YrDcd88OAWhcERzFW7/jXNKPRpF+UwZob+EDZrjp2tN0qKcwuG/LdmMnLEfzZAyEVrbrPx8y9LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P67fM+3IT0mP2fIH4QBwi7G4K7wsVydaUNg/zhECgkw=;
 b=WTyolefO/JFqtgWKknjLaiLy5JXXgxmaBoejETtxC7KsJVA9Nf6P9d7DQ516Bq+rAOaYn9O4yYwbfRZqeAMXIDxcKRGikwnASvstjQWbbuxuSDKG+vNTGq8FzSx7/YXIyqERDEAFYiBDSmcrbofqL3H2VVdIvO3QZMrjBXr1vKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9474.eurprd04.prod.outlook.com (2603:10a6:10:368::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Wed, 18 Jan
 2023 08:48:04 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%3]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 08:48:04 +0000
Message-ID: <60f8f656cf466b8fbd8dfe93177119cfa4839b72.camel@nxp.com>
Subject: Re: [PATCH v4 05/17] arm64: dts: imx8qm: add pwm_lvds0/1 support
From:   Liu Ying <victor.liu@nxp.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>
Date:   Wed, 18 Jan 2023 16:47:18 +0800
In-Reply-To: <20230118072656.18845-6-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-6-marcel@ziswiler.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 939029d5-bf18-4792-5e96-08daf930b551
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jkVeyIpKOFxA06x24TK6xrNLGVJfCeMqeZ5fz6hgyFbuXqhAtHo1yTSt/smLixorKxHZPCRPI5eOzIKcnvd0Z9NvG+JHXOxHq7WE75sPVJ8qUh+jz4Ypvtv0DNny6eVzt4wMO07ziPJrlh0r4aaDAxofF79s1NrwG+PpjlKJ5kGgcqSPvz2UDipK1spTN64n9p9lcnnbKU2LXtkqTKUCteKvl32CszIBNVHGhI9hMBHH6JzJb7UImp7iGUomtZCtBVEnDp/INKbFS6fpl7ROS+pzA8tKKK/ohHdLUgPH5FWnTy+C2pC5a6ZxWByi0Mz3cLHKjMCZlfghEJJ54bqhovgtJ+34y2paECpxlo7eUfFCGECoffpTi7yuJTu9Xz/n5Dfjv7406krE9jSdeLnjKH4CCZViXcHmjsDm5LqdRpmDhFXFz6yGTpMEEGuYgSvSbbZx+MwYbk6RVRa/ZxtZYH2gL1bOxAFGN9LUWu0JkkpWSBbPSyYKnmHI3zIRvLSUTPSzdZBq26notB2JPQf6nfJW6oUI0OuDVYS1kUbypc2qJ03zTENor8uCN77iqD4Rf3KKYpXzyImNuXbhvVmSCaKTMZ10aXecvgZgAwf3C26tPDo9JBqFLKsLuvSQ9/k6WqxT/rdyeCWrjDtHOx3Dx7y7z+07ZS1Hta4ZitkDGJEkFE17cXP/j7Hbaya4Mv/hYGEeMRzr/hcL4mKXWiaKJzYC823gE5C5faydAzdNOVJvApvUFMf8T2dPR6na39nb3r7whVVqqDn2grND5bAEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(52116002)(478600001)(6486002)(83380400001)(6512007)(2616005)(966005)(8676002)(38100700002)(38350700002)(6506007)(26005)(316002)(6666004)(186003)(54906003)(66556008)(66946007)(2906002)(4326008)(8936002)(41300700001)(5660300002)(7416002)(66476007)(36756003)(86362001)(99106002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdVb3pYOWdQbEF5TGxaN25wS0tvYVFmZS9wL2N4UXNZY2wvb1o4VzVWWG9Q?=
 =?utf-8?B?SW9xWGUxVVB6M3hCeS9JbmVraWRWTHdoRTNzYWsvQ0x6ODludFhhcXJpM2x4?=
 =?utf-8?B?eEpQclUvVGNBbUttdmRTMXdCUC9kQW9Nc2V4bWhaeVk4dmRHcFROQzduQ1Zn?=
 =?utf-8?B?TlFNN2xEMDgyby9HNEFVUXY5TnpkMzVzNzFzaStDYmNTVDRWSmd2ckExeUxi?=
 =?utf-8?B?S3dYclN5MitPSlNtVE14ZWE5dlVnWDdzSEtneEJwZTVERVBnN3dXU2hrc0Vs?=
 =?utf-8?B?NjZ0M0krMU9ZTUI1NjBhWG9XSVRWdFVEWFRPY3dySFRIU1p3RGZDd1Y4SVl5?=
 =?utf-8?B?WCtLbUVxOXYwWTdrRjQxRENjK25LdkY0R2R1ZXNOWHQ0RkpWT09DNU9Kemp0?=
 =?utf-8?B?ckoxN1pJRzhUS2lMSFA1OUJpT2JPY0hQai9VcXIwNjFGWXNQekNBeS83QnFp?=
 =?utf-8?B?enY1TmZEL2tvRTJHZU9FSHVoTlhNMDVObGtDSmhLUEpReWVIRldtV24wY2hl?=
 =?utf-8?B?SHZLaWZrUEIwdlYyaHJWK1hodDk1WDFEVHZVR3pHSHNLeTZKMlBqMFFoaTlv?=
 =?utf-8?B?cmtVdUNpT2hGWC91WVdtZUlaU2g2bnBqQVZGWUplcXhlYW8zSmk1Rkh4a1Vs?=
 =?utf-8?B?c08zSVhlN0c5Q3c1ZUtEdGt0MnJUZjltNjd2NlNHS2xySHZSTnAxZjBKaDAw?=
 =?utf-8?B?eVpIenRQZHNyYlVWdEk5M2FsNG9ReURacWdIZzhkTmFBL3dqa1VHakhsTStS?=
 =?utf-8?B?U0hVZ3ZBb0VnYnhCNTBqNGJnNkhhMjFBeHJ0WFF1U3FRdVk5NXdNU1NzODQx?=
 =?utf-8?B?OEgrM1ZKaGxMWFNTMlpaZXg1YlRib3ZwbjBqVGcvY1VrdWNjbjJSd1oweStn?=
 =?utf-8?B?bWUxdEdubmpBdDg1RmZMUnJ2MnBqNEtSVkw2NDYwWlI2Mmo0Q3FHL2dncVhE?=
 =?utf-8?B?b3k3RlVqdWV6K0pyZDh3VVc2bUNtS0lPei9rek9NWUJHRlpBSzRYZ28yL3dW?=
 =?utf-8?B?c1BtVDF2eDdXL1JDNlhTbXo3VHdvWVFsM0o4cjhvc1J5T3QyaVJteEp2akNT?=
 =?utf-8?B?LzVMNXowQ1ZsekxmN3FzQlFIdGxsTG91Z1k5NTZhZlRNKy9TNlFPZVczdE1i?=
 =?utf-8?B?OUo3cGQ4cDV6OFNtVnU4ZWw5U2JmY3JVc2QvRFZFOUMxN0JzSzJ6SHBLOHky?=
 =?utf-8?B?cnVIMlE1UFZ1WCtrYlFIRzVsdEY1aXVSbTdzVDBiMlprbUtQTHh0V0NjQm9s?=
 =?utf-8?B?TlQyTVhjWUlhZHA5K09Oak1vY3MxN0RVc3JMR21vamlXclNjd3pUTmtHSGc3?=
 =?utf-8?B?YWwzNUdmQjNUODRqUWcyTG5peDR4L1V1L01qYnRNUDF3MzVDdHRNYStORnlv?=
 =?utf-8?B?ZldwVVhacm1oVDE1RlR4KzIwUzNzT25rVVZ0VFl6YndaMTgvc3Z1OTlndXZO?=
 =?utf-8?B?QW1jMzFjMU10a1FBbjQwaXVvTWU3TEpnMm0wTExOZFlYWGswRWVjS2F6eHJu?=
 =?utf-8?B?aWF0MHFvb0pNa1NGeGRYak9IVk91M2lxTGlwem02NzRCLzNNYmNPcWthSUNq?=
 =?utf-8?B?OXJVZDBUemh2R2FUSXN2bW1YMFFUVkZhUnJHOUlodktuMVhiQzlHTTE3Slls?=
 =?utf-8?B?eVpWK0ZQZFpKK2JaYXRLRUNUaW5VcEkxQytGT09sajJCYTM5RnQzMUQ3dmpz?=
 =?utf-8?B?VTdGU2NwNURDZ1I5RnBDRDJtTmVFcTRRSG5NVit2MFpXRHI4ZDcrZ05TWkM4?=
 =?utf-8?B?WTdzQ2Qwa0J4c295OWtxNzFqcVZtWS9BdUJudThtTVFxTHdrMTRNR2FYYmFQ?=
 =?utf-8?B?cFhTMURKNWlYaWtYU1VjUERYTW55dGkrdHNJRTdMVzRXcGZYWERRQzJCUTBL?=
 =?utf-8?B?QWUzZ2NHY3diM0RyZXhTU0RwL2FzNmovUTdtUy83RDlXd0xuSEFwbTVQV2hv?=
 =?utf-8?B?VUkzbStwWGdyQnBETWlnczNqdXk1Ly9Wcll1dXg0ZnNUNVdkbEVkWWxwV0Rq?=
 =?utf-8?B?NXVhMXhxTXFEcWROMnF6ZVBzRkhJeG1PMDg2cHRaZVBnTVBXL1N2ZWFubjA1?=
 =?utf-8?B?UzlCM0o4NGxYVXR0cWFRRTF4YWlWUEh6d0h2K3c0MVhleHNWSkxZYkQ4RTRq?=
 =?utf-8?Q?mmb9TlVVqR4xDoeyrg6QgZh4i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939029d5-bf18-4792-5e96-08daf930b551
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 08:48:04.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgypjg15b7/K0anUZaLydaZG0hN8yBJyv5VgJ6Vaa1W+srrGOUuB/7LRBltoPuolOKNnBzD48BiAPJg0lFwZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Wed, 2023-01-18 at 08:26 +0100, Marcel Ziswiler wrote:
> From: Liu Ying <victor.liu@nxp.com>
> 
> This patch adds pwm_lvds0/1 support together with a
> i.MX 8QM LVDS subsystem device tree.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - New patch combining the following downstream patches limitted to
> LVDS
>   PWM functionality for now:
>   commit 036c6b28a186 ("arm64: imx8qm.dtsi: Add LVDS0/1 subsystems
> support")
>   commit c3d29611d9d4 ("arm64: imx8qm-ss-lvds.dtsi: Add pwm_lvds0/1
> support")
>   commit baf1b0f22f8a ("LF-882-1 arm64: imx8qm-ss-lvds.dtsi: Separate
> ipg clock for lvds0/1 subsystems")

Sorry, I don't think the downstream patches are doing things correct.
The biggest problem is that the lvds related devices should be child
devices of display subsystem pixel link MSI bus device(See below
comments).

I have local patches to add some lvds related devices which haven't
been submitted.

> 
>  .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    | 83
> +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  1 +
>  2 files changed, 84 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> new file mode 100644
> index 000000000000..4b940fc3c890
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +/ {
> +	lvds1_subsys: bus@56240000 {
> +		compatible = "simple-bus";

In my local patches, there is no 'lvds{0,1}_subsys'. Instead, lvds
related devices are child devices of 'dc{0,1}_pl_msi_bus' buses,
something like this:

In imx8qm-ss-dc.dtsi:
&dc0_subsys {
        dc0_pl_msi_bus: bus@56200000 {
                compatible = "fsl,imx8qm-display-pixel-link-msi-bus",
"simple-pm-bus";
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x56200000 0x20000>;
                interrupt-parent = <&dc0_irqsteer>;
                interrupts = <320>;
                ranges;
                clocks = <&dc0_disp_ctrl_link_mst0_lpcg
IMX_LPCG_CLK_4>,
                         <&dc0_disp_ctrl_link_mst0_lpcg
IMX_LPCG_CLK_4>;
                clock-names = "msi", "ahb";
                power-domains = <&pd IMX_SC_R_DC_0>;
                status = "disabled";
        };
};

In imx8qm-ss-lvds.dtsi:
&dc0_pl_msi_bus {
        lvds0_irqsteer: interrupt-controller@56240000 {
                compatible = "fsl,imx-irqsteer";
                ...
        };

        lvds0_csr: bus@56241000 {
                compatible = "fsl,imx8qm-lvds-csr", "syscon", "simple-
pm-bus";
		...
	};

	lvds0_pwm_lpcg: clock-controller@5624300c {
                compatible = "fsl,imx8qm-lpcg", "fsl,imx8qxp-lpcg";
		...
	};

	lvds0_pwm: pwm@56244000 {
                compatible = "fsl,imx8qm-pwm", "fsl,imx27-pwm";
		...
	};
};

The below patch is needed to use clocks for pixel link MSI bus as a
simple-pm-bus.


https://lore.kernel.org/lkml/20221226031417.1056745-1-victor.liu@nxp.com/t/

"fsl,imx8qm-lvds-csr" needs to be added into simple_pm_bus_of_match[]
in simple-pm-bus.c.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x56240000 0x0 0x56240000 0x10000>;
> +
> +		lvds0_ipg_clk: clock-lvds-ipg {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +			clock-output-names = "lvds0_ipg_clk";
> +		};
> +
> +		lvds0_pwm_lpcg: clock-controller@5624300c {
> +			compatible = "fsl,imx8qm-lpcg";

Should list "fsl,imx8qxp-lpcg" as one item as well, since imx8qxp-
lpcg.yaml mentions it.

> +			reg = <0x5624300c 0x4>;
> +			#clock-cells = <1>;
> +			clocks = <&clk IMX_SC_R_LVDS_0_PWM_0
> IMX_SC_PM_CLK_PER>,
> +				 <&lvds0_ipg_clk>;
> +			clock-indices = <IMX_LPCG_CLK_0>,
> <IMX_LPCG_CLK_4>;
> +			clock-output-names = "lvds0_pwm_lpcg_clk",
> +					     "lvds0_pwm_lpcg_ipg_clk";
> +			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
> +		};
> +
> +		pwm_lvds0: pwm@56244000 {
> +			compatible = "fsl,imx27-pwm";

Need to document "fsl,imx8qm-pwm" in imx-pwm.yaml and list it in the
compatible sting here.

> +			reg = <0x56244000 0x1000>;
> +			clocks = <&lvds0_pwm_lpcg 0>,
> +				 <&lvds0_pwm_lpcg 1>;

In my local patches, I set the clocks property as:
                clocks = <&lvds0_pwm_lpcg IMX_LPCG_CLK_0>,
                         <&lvds0_pwm_lpcg IMX_LPCG_CLK_4>;

I'm not sure if it is correct now.

> +			clock-names = "per", "ipg";
> +			assigned-clocks = <&clk IMX_SC_R_LVDS_0_PWM_0
> IMX_SC_PM_CLK_PER>;
> +			assigned-clock-rates = <24000000>;
> +			#pwm-cells = <2>;
> +			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
> +			status = "disabled";

In my local patches, this node has the below interrupt related
properties:
                interrupt-parent = <&lvds0_irqsteer>;
                interrupts = <12>;

> +		};
> +	};
> +
> +	lvds2_subsys: bus@57240000 {

Above comments apply for 'lvds2_subsys' similarly.

[...]

Regards,
Liu Ying



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031C6259EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiKKL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiKKL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:58:59 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91645A1D;
        Fri, 11 Nov 2022 03:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LShDTN+eU5aakB0oxG1F2UABVYnun/NgSMTJFpNzRrraVuf97noGn2qN9Q7VJECSq37B4APeSBLiQCnQpNmqPPwvLycZ/ICAYZ+yUbn+oj4ZNvTC1nBqVvIiNxd0TBtPsPi1/LKPQynhmP5To6WUdwWgoseunG7tpChBW9MGvKeC5BgyXvrEYtM79S4rQCE2DsIjMOrgpLzyJPMO4ViVoCaPAHJ88ll7jxtyLXMwsVpbH4DRNygIkn2k0Tva8R5OjhMPr9l5xuXPSZVNxSGECCs2DiR+6N+ENLEqjS0ct1aOwofyOb0YbyeG2DXzkQtB75QerF3i8ojeRPWRgDBq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFUauZq1VokH0R4eU74z2zOi2AsxHPClNAg/3exCaAk=;
 b=GeaAl6u5oB28X8tAiP+6w1zvIFGH0UA5D1SDSmxGukaUsnv1tSxkZHimmnfbn1/eOHZnRnsOGiFTqpvSYn/32EGDrIos6a9QNdb75yugoI0UOTowSdzCQ9MD8MFvUOoocMpMMjXT1AhMc04wgq7BP0HRdq6FLKkxQSARP/rD2GaD03tPMSJ3DTXT/kKEFkbxXCI+G09hZYbVDoBygzu97q7zdCtPEx6F6E/5RsWAaeh5sMyTQVLhX/mD6zybVZ/hwcTYXfggtMTI4nfPzzs4c2SWT4scOlksgFPA/AZXq/q80QcsdECXtHvkNntd3p4qtd5s/RPv1/FFX8CHC95TvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFUauZq1VokH0R4eU74z2zOi2AsxHPClNAg/3exCaAk=;
 b=uWXKIS7zLQOno1GlLzgyMhb8aZ/rDHZ7+XexkQACqpg8kOZX0yREGhOpzvmz5NfI/JDK5ED7CJghvcBNQ/fUTkEZb15UgDJRj+J0vzlh7KNUltWuX9vu5/RX9AEY6tCZt+tFbrkewa3VJ92++JxJT/7gZsEn7tReTPYZ1EWYAK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB7386.eurprd08.prod.outlook.com (2603:10a6:102:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 11:58:55 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5813.011; Fri, 11 Nov 2022
 11:58:55 +0000
Message-ID: <42fd2eda-f25c-44c6-1f1c-80653b04bdd1@wolfvision.net>
Date:   Fri, 11 Nov 2022 12:58:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linux-next-v1 3/3] arm64: dts: rockchip: Fix ethernet reset node
 Rock 3A sbc
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111094238.1640-1-linux.amoon@gmail.com>
 <20221111094238.1640-3-linux.amoon@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20221111094238.1640-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0006.eurprd08.prod.outlook.com
 (2603:10a6:803:104::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2080f7d4-aff5-4061-610a-08dac3dc1bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5OOzjKLc0NEl2zJ4PMIa4TdKY9vv9+IIZf5bY3EPmJ8RnE/TeyAuXybK++78361sJ17vJqrOLSBCNcvyebEd0XNTVJRbGumL+n7m3mIfauChkpQrwT74oinLbam3MmiHTN9ip/SRTlSFjWuWfqwaADhk7ET1pRaSxivAJ/F0gtUUkQlmyiXNLH2q/9IAiesiCAtDpmfRMVRgFsYX12JCsSZ1ruwmbSkWG3AnYXovhJuXSKYn3m7b9FWoP58P+KAxKajxwKtO0v6SWY8FNiVeLQtxhXVL+FthuEwxXPAxhuApaKA0Z9o7DfblHWq3GJrC+KiP8aiZXpNohgPMcyOiAfmLwyVjYgrYiCmQz/riBfBEUt7sV97kzucudFdKRR7bNBPiOqFm9Heam9OtGYNk3Qt/6jtgeZA0AvyisimccVqkZ73RqutldGLDtd3Jnm2AJuW1yZ1fb8gy5+eXRp65dWOrR8Ekk2PM9Uwto/+2BFUFwY6qLP6Z50yK4N5sELSwAeNy3VGTcXK/nkLpwRj5hdA7rRfH9SLnltwDYinw18WH6T9J/ozjVQwN+wL0+SRAvcuAj7ZQGi8R06UGnMtNN3ebo1bF+EYd7T9NyCnz0jcuh3xQpK32nXEBBkBO7GerDRbryXTsutvu9ZrSmm4ZbNCuMHxD1tAbI4HMcHszw5M4hByEx2XdRM+bNunrC22bAuDd72Lle3fRTHODSs8Jn1xIr8tsD1EoE5fIKdndqAu4ItRKOCWhkeVZkgUVypbyfEPmdDdWvocYUhmr5PxTiD0sesfaUCoZ95FQZ+H1QFhC0DSGmD7fu7wR2jV2fJG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(396003)(346002)(366004)(136003)(376002)(451199015)(31686004)(36756003)(86362001)(31696002)(38100700002)(38350700002)(5660300002)(8936002)(44832011)(2906002)(2616005)(6512007)(110136005)(186003)(83380400001)(26005)(316002)(66476007)(41300700001)(66556008)(8676002)(66946007)(4326008)(52116002)(6486002)(6666004)(53546011)(36916002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05WTm9DNWVINDcvazdLcDZXUjllODlsS2h1cEtYSUdMakg3YWZYbEh3TFBC?=
 =?utf-8?B?WS9nYVRwclRTSnJ3K0NrNUlYS3Z6dFZsUTZDdFpTVHFuS21NVE55dzk4ZW5l?=
 =?utf-8?B?L29HaEdxWDM3TjFOeGJseXQ5TGZSYkhON1M0d0Z4aGFOVCt6YTBCaTdZalVL?=
 =?utf-8?B?MGxPWVJRdEZlU3pIOEVxVHUyK01tY3RZZFFINDB5NGVKVnJFMGo1MHVHTFNn?=
 =?utf-8?B?R09PRjU5bjNrNzhiNGk4ZmdiUEJPUzF6ZmtocDhBRkpCcHVhNHU0Q2RDT2du?=
 =?utf-8?B?RzZYOUVXYUlRdlRMVzlqa2V5ZHdTeVdlNU5aQ0YySXBtcHhNY3dDblJDRXFK?=
 =?utf-8?B?aVAyRVhGallXb2pPQlV0UktvMnkvMDVtNEh0Z0x5cGxWc25BaGxLa3I3Nmtu?=
 =?utf-8?B?bmZjSW9hODJKYVBORGRCNHhPQVlvL0l6R280OWUzb2JoN2NYUWI1ZXErQ0s5?=
 =?utf-8?B?TDBLYW5CV25Tb0UyWW15SDNMNWgrdmNZd0htVW5UWGlsYzRabXU0UDhKNHZV?=
 =?utf-8?B?SkQxaWRBeW9GcndWWktlRVVXTjI5ZEtLeEg3QUJZVlpjSUhFM3krbWduKzRs?=
 =?utf-8?B?NHUvbGZxcW0xcWRhcHhmRnhra0FxNFFtbHdWbGh1NzBscUV3NENWdVgwM3h6?=
 =?utf-8?B?U1c3WGN1MGZrb0hIRGxOMlVVMzU3a3ZEbUJNaU4wbVFTalRZQWY1NG5qUE04?=
 =?utf-8?B?OUdtZE4xdWNyZWtYTFRQN2R5L0cwTGFHWHpVaWNCWWZyZ1Q4SFZNTjVmdnpz?=
 =?utf-8?B?TTFFYi8vaHdFSmswSXJWRU5xSjA5YktYcG1SN1d5bWRUblFYWmxPbi8xQ0xz?=
 =?utf-8?B?OEVFNEFyVm4rY3lIOGJyT29ZVUZTbGE1WUNlb3p6R1Bsb2Z6VUVWaWFQTkxV?=
 =?utf-8?B?a3dXTmJDaVFiOVZwWUZiNk1nMEZhZmFkWmc5V1pxekU1UFJ3TEY1QWxpTkZF?=
 =?utf-8?B?a3dFMHhObDZXL3lCcGh5QkNQSE9uVXBQWXVERHh6cEluam5QWEhUcDlPZTgy?=
 =?utf-8?B?czhrcmtkb0E0ZlV6a2p6dGFjYjNKbE11WTV4ZlVuYTZkNUluL2FkL0ZFdnlo?=
 =?utf-8?B?RitXZFdKL04rU2ZXOUQrMDZFR3pBaEVrc3hzN3RvVHNiYVZ2RU5mcDJYbjJk?=
 =?utf-8?B?ZlhoVUp5QitlY3ZQSFUxS2ZGZkFDM3k2d2g1aXVVKzNQWllZNG81dmZXR0tF?=
 =?utf-8?B?OUhXSFo4TTFGNm5nSm9EUUU4Nmhmc0RIVXdtbHpsblF4RVdjb09EbUxKVWc4?=
 =?utf-8?B?cWxZTTJzN1FGemQxZk45V21WWEtpYmhBMnZYOFF3bzVMK0lCdm5qdDUrWjFO?=
 =?utf-8?B?Z05neUxnRXlSOXRNYzdYQjFzaUxHVCtOTEJBNFpPUW9nTGM4aXpuQW1JN0x6?=
 =?utf-8?B?M20wbEMrVUNkTU9kckJsUkdnNHBIOHVvWlNRMEpDWEdvLzhCSFlHcUFMdlBK?=
 =?utf-8?B?bTdIZkVUdUNDdjRpc3NvbVlyeGhPUEx1bkt4cEpPK1I0NExlNXl5dlMyZzFQ?=
 =?utf-8?B?MWMvekJTSW1oYSt5enFjU25MWU81MjgxSzlNMFRQek5GUDd1RG1SMWFIWUt6?=
 =?utf-8?B?bjNpd01kcXpLYm92dUVKV0JicmNUNndoMnFiZlVsYlcwLy9rWndnRkwzdDJz?=
 =?utf-8?B?N0ZpTnhhbTdJV3hyRW1xcUdpbGFFL3I4UXdJNGZTT3RiRWlNeDJiNFQ2Qlhp?=
 =?utf-8?B?S0pJaXdaTDkzSGx6VXF1anZEalgyNFg3UzVLem5vdTBlRGd3emlUNmNUek5B?=
 =?utf-8?B?ZVU4TWt1b2piVHVBWVdSNnF5T1Jka2xrT3ZnL1VIQ1BHS0d0WWNDSUV2T0Qw?=
 =?utf-8?B?NnhYQmxkanc5R2NNbDl6cmdVUE03a2taT3VISXYwT2g2VlA3bjNHZ2ZaU043?=
 =?utf-8?B?c09YbVBQaTIvUk40ZTdWM0VsaEJhSHArV05yb3hpY2UzcmxKWXo2ekdxQ1NV?=
 =?utf-8?B?Z1FJTUw3eWxQSVNhbFRSUTFSSDJYZjlEUGFHdDdFTFl5QURYSElZSnREZWda?=
 =?utf-8?B?bXgrOGZiOFRiUytnU0xWaW1VUW1keUdkUnpSaXJzRndMMVMxTzdqYklGUnRz?=
 =?utf-8?B?dm9rS0NRYUpNc0J6RTNuNGhpVTdMaWJwbW0xSUFPaHB1c1BmVGhQK1BCMkVj?=
 =?utf-8?B?VFRqYXZwZlJFYm84TmhjYXc3SXJwWnU1TmZQRUN6clJTN2NIQW1LOFNodGhW?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2080f7d4-aff5-4061-610a-08dac3dc1bf0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 11:58:55.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YyTurMZeRdYptQu/JUGdBzBdX+E88fw5vcWzyawh6qUmzqYgjEzjqAoCGCdmV4611hIXhaLiWLKQngCqZFu88Xz6NT73QQJtLme8jeBjgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 11/11/22 10:42, Anand Moon wrote:
> Add support for snps,reset-gpio reset ethernet gpio pins and
> drop the mdio reset code.

But why? Is it preferred that the MAC driver performs the reset? Or what
does this change fix?

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index 16fff1ada195..9172cf60b867 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -258,6 +258,11 @@ &gmac1 {
>  	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>  	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
>  	clock_in_out = "input";
> +	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;
> +	phy-supply = <&vcc_3v3>;
>  	phy-handle = <&rgmii_phy1>;
>  	phy-mode = "rgmii";
>  	pinctrl-names = "default";
> @@ -267,6 +272,9 @@ &gmac1m1_rx_bus2
>  		     &gmac1m1_rgmii_clk
>  		     &gmac1m1_clkinout
>  		     &gmac1m1_rgmii_bus>;
> +
> +	tx_delay = <0x4f>;
> +	rx_delay = <0x26>;

Ah, here they are. I would say these delays should be added in patch 1/3
along a comment why the rgmii-id approach does not work.

>  	status = "okay";
>  };
>  
> @@ -583,11 +591,6 @@ &mdio1 {
>  	rgmii_phy1: ethernet-phy@0 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
>  		reg = <0x0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&eth_phy_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
> @@ -625,12 +628,6 @@ vcc_mipi_en: vcc_mipi_en {
>  		};
>  	};
>  
> -	ethernet {
> -		eth_phy_rst: eth_phy_rst {
> -			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};

I would assume the pinctrl is still required no matter whether the MAC
driver or the PHY driver asserts the GPIO reset.

Best regards,
Michael

> -
>  	hym8563 {
>  		hym8563_int: hym8563-int {
>  			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;

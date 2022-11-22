Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D8A6340F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiKVQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKVQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:10:32 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5335E7341E;
        Tue, 22 Nov 2022 08:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miyYrl3YTbmNaNkMLURyPATqZ3tl+I9e0a9eqSeP2m2qt2fD+UbqkYVZFeSzXy6M0k8tMZ+Vfcs5Rax+Qpa/en3jwmkO7GKFX6xnNXG9SPIOHcOFAw+aPIusimPLMjok/HLSB6KJ9oaLB17PQlbkt9Hvxuk7FNb1X8HXzEjcoNxBkTLp5AK4gcKTFhUCVqU5ZQ+loAkmV3d+StuUtEh5gF0zEO/PEV7KlzTD3vX8N6AphHL7WxGOk5UB0aPDTGJ4kMWsNlktUTB4L+1TXtfjPP+xceoCMUmUVTyTYuR/SfN/Ffbq3qHvfTnvHA/j/EvAQwiZG1oZZNAlANalMJSq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtLxjwnsGlW4Bup8Vd+goy7Q3opsa9pIiv32HXkBRXQ=;
 b=gzEWwqbNePUVOn0Ye4NrvURgmkGy2H8HEp7EOhR9+iFFvAv6+W9Lum4m50vm/buVAYa32g4SWWqZcxRUFLlKpJ3sA7SlNlYPE2MsQRNcWSLKCH1StgBigJCylwz0DKj0JyrEa5b3riiCOl4SKBQNg6Ay92/BRUyczgqeXLHC3CAQtF8BDShRFL37ABuYi4T7NCkV8aVLspZqF1O6T4iK1Jqto46wK1GO9fVRnL+sb8YxukZaKc8RD6RqWkxQ1yhz8wdIZDd+9QFINCBKvSPyoK0ENdIWoPeGU5CAfBgnSut5RsO3egWhmddWpLB+F/es8F/lFDtZT6xinuoH64GeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtLxjwnsGlW4Bup8Vd+goy7Q3opsa9pIiv32HXkBRXQ=;
 b=l1zRjJhC9r+1rYrO14xMeWfmbtZ68BN7gL9Sdq+UJS1J/Kn6ZitIbZO0TYD+/JAEH7ZvZ2aLXPHVmc6VqINILyngaBoj/sv5doUH1BUsdq490C7NkxRVBEoFeQAUpAhtyjB5CZRnXG4reP5k940XViZ4ou4ImM6gfXR3qRZTiF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAXPR08MB7647.eurprd08.prod.outlook.com (2603:10a6:102:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 22 Nov
 2022 16:10:28 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%3]) with mapi id 15.20.5857.017; Tue, 22 Nov 2022
 16:10:28 +0000
Message-ID: <19f1a4fb-42b2-580d-3736-e0e1d0cfe7fb@wolfvision.net>
Date:   Tue, 22 Nov 2022 17:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linux-next-v2 4/5] arm64: dts: rockchip: Add support of
 interrupt to ethernet node on Rock 3A SBC
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116200150.4657-1-linux.amoon@gmail.com>
 <20221116200150.4657-5-linux.amoon@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221116200150.4657-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAXPR08MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 75470a20-fe04-49e7-a63d-08dacca4124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGiTzQoMyjlrcs59G3XYN5Q8whHF7uNaf0JYuePmkbL2diRSq+trAAFnNhEpCgSv8jvuZZ6hvmQaPGEmFHRDcRnKp9CL0pnB/1oD67zmiyhLVEkkdnfd19h3UFF5E1EJRqfIk5cvWDBouGT2sjKOMgO3KTXiwk3IOI2azqc8d5HQjHAqqkwj87Z4ASwt4Qy+vBtVh4iCbSCjVBQEpDHLjsXDokVezV9MvFXfOFpQNunyddab2skFoJKKGsDi7pUoSmGHo+rpDT29Kgj9jdB6MAqMqDFSwBvZqcHhoVIu2BGy5aViJlRxmUEsvZ5tWGQxxrwwJ2fQ56DlW25L0wKeBwJ7cW4dcfGYW8ykAjaczQ5kguc0OEl9nicLPkT1v0cZGNKIxycnHH6Sx8rOr+jxhw2pg1Td2sH9ufKg9GM28BJ6zD/0vTNcVhFnE47eMSaVwJE5xl09NRlXbLk8yRQOgqee3nup9ATil8YDvhuk0M6oV5qYjC5GpqqY15TRbkcwGPIGqXZujR3zwh18S6uJClUDUBthf8XO4i7/2X5D9k+/kFCVfYIo4C0HfnkWryWvg95dcc8zR3ZVvL/eUg2/lHWQGD8gdTR9hp9nWJzPpN8w6rNdC9h1MHTwhEzQPf3n/3rePlGQsdxbhmIqpI0QhigpWhKQH0Ku0icQeEVvTzKnCcPjW6Ok2XMgRFRMb2BvtP8dm12YQcZ1TdmzXGIMsOJY3ME5BKz4/EfnUKIC280=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39850400004)(366004)(396003)(451199015)(31686004)(36756003)(8676002)(86362001)(31696002)(2906002)(7416002)(4326008)(83380400001)(38100700002)(478600001)(8936002)(66946007)(316002)(186003)(110136005)(6486002)(66556008)(2616005)(5660300002)(6506007)(44832011)(54906003)(66476007)(41300700001)(53546011)(52116002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEwyOWxCbzNNbE0zNUNvNUFBKzlsMm12b0taTC90dGdMNkY2YzZoSGV3Qk1n?=
 =?utf-8?B?TFQ0ZkxvTnl6V1ZoSFBIQ25XTlFhamNrekFuMFk5elVWQVV1SkRqNFlhdTVS?=
 =?utf-8?B?MUQ0cVRUZUR3Q2lVQjlLMHg1ZXJzcDlKK0pvb2dxYlZJMCtna0pSRnlqMkZY?=
 =?utf-8?B?S3A0VU5PYlo2czBPdGtaNzRHRGNSQ1h2VGp1Tk9STG83aEp0SVFiclBsNEhj?=
 =?utf-8?B?SlF0VnY3NUpVcWV6emRlSGhsUVpRSWgraFFES2VMa3JJcVZjRmtidmQ2YXhD?=
 =?utf-8?B?RUV6dXExTmZQdWttWEVLeCtxY1pJZFJ6bi9aSGZtN2MxRStoMGtPSEpMUHVx?=
 =?utf-8?B?U1NIWjZFZUZjOFpWOFV3SGxFZlFIUGJhbUVSdFVPdHkzMVZhM2JIWG1MbVla?=
 =?utf-8?B?RHUvdGtVTFduRkZOeXhoTkRjVU5iU1NGa3o1VmR5Sjh1Sy85bTJUNWJXR3Zm?=
 =?utf-8?B?UEw5QnQ0U011OXFEWlpmTWxmWlM0WDlqaHp3blE0S1lhUnlqL2Q1ajFkOGlU?=
 =?utf-8?B?VmtRMU1ESTJQdTRKekpPYmhwV1ZjS1NpYzdxc1ZzV2NNM2o3NUluMlFWQzg4?=
 =?utf-8?B?bDBseHpYY2pxbGxObVJBNXFJaW1DUnE0UzJGcTREaWNsWnhSWEtqNjR3b0d0?=
 =?utf-8?B?QU56bXExb2hyQWI4Qm9vZGFHZEx2RWxZOFRQV25DSUNUNktmQ2FXUVFnTXNl?=
 =?utf-8?B?TWpTZzdXM2ErWmoxaHc0VEdyR1RGR1pJNi8wbnBCMzNNQWYrdUV2VVROTnNr?=
 =?utf-8?B?djVXZEhSb1pSV0ZnWG4wSndFZ0ZwVzFnWFZGM0hhTmNaWFlFZE84VW5ObUVH?=
 =?utf-8?B?Qi9yNEFDWG9teHc4VHNyR0Rsc1R0NmFvbDBZZGtCYmhGMnhiekNBODVZRjUz?=
 =?utf-8?B?WnNBdTNhckVzY3F0RWFQR0ZDTkRBaElCbmxrUEpHYkxIRkNRYTVWcHZ6ZFZy?=
 =?utf-8?B?ZDFmYUU0TEJHMUtUQy93REJ6cFdSNGlGUlZQazYrdE9EYnpod3ZWemg0Sm45?=
 =?utf-8?B?YTZXM2Q1dVVqS203Rk9CL2lqbWx0TUY2Um4xaVdKWmdOK2NlZk9MOUp0NzZT?=
 =?utf-8?B?Q2pYdmdPc29wWFlET0FMYk9iSDRJaHF3d0RWTWkxSEV1clBGbUI2bllESWZh?=
 =?utf-8?B?NUwwNWtObThtTTUxQzdKd1JIdnNNWUp4enJScXcxd21mUy9CVHA0RzNFUzBO?=
 =?utf-8?B?T29ZeHRxTEFoanhnQ3BRRm9SSkt6SExvM2Nwd2RibXk3Y3ZPSnJCZzlVZ0N1?=
 =?utf-8?B?QUQxVUpIbzUrcEZZSnVtNThLUHNaeStmb1AxWm5sNmxVOUN0b3ZuTEpVdEp3?=
 =?utf-8?B?MXhBRm9zWlg5S2czYllUVlFXaU52TkorVnJFWEVBYURheVg2V2VOTFEzbFkr?=
 =?utf-8?B?WmVLZWRwcGM0SFFWVis0RDMzajZQNnJ4M2g5bmNLZlV5TDhjQXI5TkdTYWQw?=
 =?utf-8?B?SjF3NWlGUmhXcEs5enNuSXJmdEtka1FPaWtveStoc0lPMG1tYWcvQ3pGZkl0?=
 =?utf-8?B?bFN0ck1KeTFhV0E4VVZKWUJlTjZYN1dZTnNzZUJNd01WVXBOS1JQUlJPajVI?=
 =?utf-8?B?d1pDQUZmZE9nWUdKbWFDemEzSWFybk5vcUFZK1hLQTBncDBHK0RiVVRMdldk?=
 =?utf-8?B?Yll0LzZOcllPWTNOZ3VTcTVvQy91MU56SWN3VUw1YUNsOTZNYUhrU1VqU2Q0?=
 =?utf-8?B?dndEUGdtSmdsZTI4emZIMTJBQkR3cGo3VFlHNTVhaFh1c2R1a2xuTkdqWmVa?=
 =?utf-8?B?SEFXa2JwdjFNMEtHV2ZabjdSOGJBRytLdGwvdElnb1BpN2RIVEo1VzQ5ditx?=
 =?utf-8?B?bURJWVJiV2VZV2hhdHJJRXhxSWNHTEJnS3pybllTa2pOdHdIeEZKSXF2UUFu?=
 =?utf-8?B?TnY3M0p2eWtnUGFwRnlWalJNdU5yTE01SWVlK3R0MkRUdGpNdUlWVGxERi80?=
 =?utf-8?B?R1p2Z2d6UzEyZUNvMmhTRngyWWVMRW52eTVycW1zeVpsWHZ4Z3NraG03SzZl?=
 =?utf-8?B?T004UUNjd0QwZkNQRmZvSlpvUy9HMnpNWHBtVUFxajgyK1FNWXZyOHQxQlpV?=
 =?utf-8?B?NGVPQm5vRE9uZnNUTnVqMmF5UlJyMkNOcWxEb1VacVNScmdwMDRGbitqbzZS?=
 =?utf-8?B?cURsRHpYVzFPblNoQnpIaHNkWE04SzQ2bk5OL1I2MmVmS090SUt4RWlOc2kx?=
 =?utf-8?B?OHNZeVVlUGhSL3dRdXgvZ0UveU8zQmxveHdvaDBoNlhyYlIwWWNNcExKeHZm?=
 =?utf-8?B?NGRPRmViNlFmM1FscXdzcGRZZERnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 75470a20-fe04-49e7-a63d-08dacca4124b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:10:28.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe9DeEc1JkYwUjLJ1FAzZucsCsWbTOBAAUL2g7XI4r3zr02h7TSx40zvkKeOUIKxf1Yzm8x0JaXcdYjGK2XyuRYi2IU4t4+i9fltZ4NtmMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7647
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

On 11/16/22 21:01, Anand Moon wrote:
> As per the shematic gmac1 support gpio interrupt controller 

Typo "shematic" -> "schematic"

> GMAC1_INT/PMEB_GPIO3_A7 add the support for this.

Maybe split the commit message into two proper sentences.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: new patch added
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index 5378254c57ca..9f84a23a8789 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -588,10 +588,14 @@ rgmii_phy1: ethernet-phy@0 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
>  		reg = <0x0>;
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&eth_phy_rst>;
> +		pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
>  		reset-assert-us = <20000>;
>  		reset-deassert-us = <100000>;
>  		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +		interrupt-parent = <&gpio3>;
> +		/* GMAC1_INT/PMEB_GPIO3_A7 */

This comment is pretty superfluous.

> +		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> +		#interrupt-cells = <1>;

I am not an expert here, but I believe #interrupt-cells = <1>; means
that the phy provides an array of interrupts. Are you sure this is
correct? I find it strange that the phy driver consumes one interrupt
and provides N interrupts?!

>  	};
>  };
>  
> @@ -630,6 +634,10 @@ vcc_mipi_en: vcc_mipi_en {
>  	};
>  
>  	ethernet {
> +		eth_phy_int: eth-phy-int {
> +			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;

Interrupt is active low and you pull down the line here? There is a pull
up resistor on sheet 11 of the schematic, so this does not seem right at
all.

Best regards,
Michael

> +		};
> +
>  		eth_phy_rst: eth_phy_rst {
>  			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};

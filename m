Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B6633B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiKVLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiKVLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:22:27 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA0391F5;
        Tue, 22 Nov 2022 03:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHV2RJPkGVhfBjtn5Jk8iCq6xBxRFwVIsVNTLMg4h/1qlXwiETrSYyJHLXdqbt6ALFJxz5P60klujdhOC3O6/BL5D183q7jBtRVX69kxukY5vWWClSBql5ZraTD9Wu7xgBDJkGWKqhB/rvkLvsiB9qROesNqGl5+J2bQ2jakjA6I6n2FgYD6h3mwSWKTtGeN/cA7v0ZeOf5DSCjhrTiFRavSfe4/L0P15OoqooW9IXDjyxkeidMHTUM9PmsXJg6lzRxgHQ9YxXnj01tctd9TQ4Xj7vddPdGxcxZrl0Vtl5eu1j9uAtfpueiRxvX/nTUMQgwO+qdFDQA1U1bP4tIbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB3vcHbePwkhnoUcT0k99/AaYtyKq3n7JKNb8osmLCA=;
 b=SfOTsWJUAW2QgQ+LHn4+vy57dskRRaoKNFYFNPy/r8MpTD23lzbfO8WEkcry7o4EnhFkiWlqVa8NPLyEYpqX6r3ZCRZbTM+MN00eBykXhmRtM2urYJv4Al9xiy+BX63mc07NoIPr2/EwxAsu+w1/1eECUa/YSnqlbgLt8UQKIjVzY+7XYr2BBU2233a5dtK8EWfiLFm3Mse4/bO1LTu60HVPZK5FcVjfbfHcMCXiyNVNeghdTVVHe+1PQ0qR3RvD9bgM6Q+Ye1rewZIqGVhZ1tZ71w9QZwYRdSUq80q9dtXZwDNso4hmaYPROuZSoeewm4ng2vzErekmdi2qBwYaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB3vcHbePwkhnoUcT0k99/AaYtyKq3n7JKNb8osmLCA=;
 b=C2HgQm9iMjoAHfA6HySNziPwKI8iM6r1Bi0L5oepckeZwEdHj980Wg+xTKgrNZshGbS2wcjsImpvxrsk1eFeUT6GTk9E2GTzx63XkFkYEkrMMcJLw7eoAH1pZnOpG4MTNxmzTqmt4JP66H9ECfNkfEl+PX8s9x3oJV+4hHrzvjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9691.eurprd08.prod.outlook.com (2603:10a6:20b:605::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Tue, 22 Nov
 2022 11:18:37 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%3]) with mapi id 15.20.5857.017; Tue, 22 Nov 2022
 11:18:37 +0000
Message-ID: <3e4e601b-e7f8-e9df-0ec5-4f4b629d9c0c@wolfvision.net>
Date:   Tue, 22 Nov 2022 12:18:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linux-next-v2 2/5] arm64: dts: rockchip: Add support of external
 clock to ethernet node on Rock 3A SBC
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116200150.4657-1-linux.amoon@gmail.com>
 <20221116200150.4657-3-linux.amoon@gmail.com>
Content-Language: en-US
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221116200150.4657-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: bc207329-ae31-4782-761c-08dacc7b4d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hU8KGh4vFpsV4vttrCUhFu40T19bpNBjoYHiRXAO5lKY8j9D8vf/T0E4bp+lnQx6qVYnpalqdWND1XqFRJFYIpZJexDZ7ZR9UjGgYER1Cxf1AVLC5+BiyocJwwgp3pK6DUlu1dFvKU8pcX3PSQJRe5HznTNQFriLL25n22ufdfwhGGEQLV5W8sVxMdzfetFJHUIgS3Dcrr76h2ppHYeTg4v596HduNQBDElYzoRA1JOlynjJQqY7nCLMkIk6Cslmzv1MoL4ACDCwQPxbQSrhQDMaKbylA1yvWETq5Emf0QqbR0oOc6vKtdIf52w+hm14hifg2l0UAOi7dEKI2QVMQG83/0r8ITKKk5eTgQMGMHkFkb273NYiEY8m1LwQFOjlUk5IPwHrOexM2RfSf6bDkI+Vh1d3cEE4aB0QV2Ej8BAlTvV+nw5d0uvX6CQ/uhBVGKYdrW9NML/ssCJxkksihX3oH9dxyDp7pPSfFoUGxmHxnjP0i4dCMsqPmxu4jWeYQ0XsUmRa6+74H9Hiw1jYw8sK0vT4nSPMq8P6FGpfkGaM+ivoOd9zIh2zt5Zs6W7BpzzhaY8z7sWpVMNkQiNMRfDc7AGh1crgnqo0WyimdK/XOmlXAa8J2bUJNDIUAtI4x0/sJhl+kJGe1IBSmTjAfP9Sq1/RvrYZ/OvFdtf9pTBmUoAXIPHBBwuZjTaGzN32z1e5wagw2qWMw4JMbslHxRgmtGAW+4kmf67OuJY2Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(136003)(346002)(366004)(376002)(396003)(451199015)(54906003)(86362001)(8676002)(4326008)(31696002)(38100700002)(7416002)(8936002)(83380400001)(2906002)(44832011)(66476007)(66946007)(5660300002)(66556008)(41300700001)(6512007)(52116002)(6506007)(53546011)(2616005)(186003)(316002)(478600001)(110136005)(6486002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2w2N3VHSFEwK0wyVVdtOTJnbTFYN0NMc3hXTjhIcTNiNURiNG42NUJha29L?=
 =?utf-8?B?RGUrTVZaTHhYVkYvYUc1R3VUT25nRjU1dGFnWTdmemxQZURqTVB0QVdWcmtL?=
 =?utf-8?B?ZW1XRm00TGEvWjZLNW1lLzNyUnIzSlBwOHVMTnZ1WDdKaTEyR0hldzBlcmdI?=
 =?utf-8?B?aXJPT2p6czZCYVQrd01nVE1DbVIzZ0czOUY3YmlEOWZBS21RN29OWGpyVnBs?=
 =?utf-8?B?eFBvSEJLb1pNcEpTUHp0d2xBMWREZ3diZThjVGRtWDB6VVl1bXVFYTd2M0lF?=
 =?utf-8?B?TDJFVENmeXd6d1ErbTVlVkFwbzlVUVIyMEFJY3pWT2tIMGtNZUdTN3ZpcEdP?=
 =?utf-8?B?a2F4ckNOdUVmQnB0WG9iUXFqNEhzblFPTW1ZblBkQjdTUUMwUnRQdHFsM0cv?=
 =?utf-8?B?RVl2N1dvQ2lGMGhTVFVRT0YzMCtxdDZWV2VmbzVBYkhQQXFwZ21pQWVBdm5R?=
 =?utf-8?B?Yy9KWW9aMDFDamhwelZNTmJuUVVuQk5vV1RtdURzY0FWUUlFN2JOYWlkOTBu?=
 =?utf-8?B?MjIzQytDOUczUHFTOXFySk1CYVREYkRWZ3NpNGZ4V1FranJRV1BjdXJoUVJC?=
 =?utf-8?B?RmpHdjFOUmp3aGVYamg2dnNIUjVodDZQQzdNMkw1Qk9wQ1FTUzErb3QyL2RP?=
 =?utf-8?B?bFl6dm9LTE16TTJWKzA0Y2R6NHJjZFRGUmRPVkRyN3RhclFxbHM4aVhTeVJB?=
 =?utf-8?B?NnY5dkNxeHVCQ0xqRXBqNHhIaU5MRUxHbVdFNzdUZWxmOVFPbFRRNDFPM2tI?=
 =?utf-8?B?WFovM1hsekphb1lhTFk3dTlmZ1FzbFgzWE5FQ0Z2SHpEYWxzLzQ4MlY4ZUlV?=
 =?utf-8?B?b2tOK1JpVnJZQ2Z2eVBoRjZEeGcvK3hWSGE0UHhrK2N0RE1tNThKSVJsem80?=
 =?utf-8?B?OEpMWlBCS2NPaDdIbkJLcEhlM0xTaU5aU3RRSFRKdU1OTUR6NldNanZwVUdQ?=
 =?utf-8?B?c0FVM1NhZnhnYlVOUys0Rmx2UGFrRGo3ZWYzOTl4T1hYSWhmOVhYZ1h5Y0FU?=
 =?utf-8?B?ZWg3QllrNHozejZ1aUx0YzNXbkY0YnJGNis4dWhrd0JGQVpEUlRINFZBMlM3?=
 =?utf-8?B?MUczVnJoNm0vOGdhRHdBNWFkM0hCMlJxZEErYWtjVjNtQnBLK0VkdkVpOFdF?=
 =?utf-8?B?bnJITFZBTTAyWjV2SDc3QVhTWVEwK1FLUU1mc2RVdFcxc0xiUWNiTTVKZUtR?=
 =?utf-8?B?U1dNTVBDVi9NMEFiMUNoOXlPTTEraXFpQzBRaWhaK2N3YWJ1ZUZmNXhOMUFQ?=
 =?utf-8?B?NGhUUGlQYm5iY2JFcXp2TDdkcEl1ejZ5Y01kRlQ5ck9ydmNjSkJveWlobkh3?=
 =?utf-8?B?cTZlbDNJWTFJd1ZxRXhjNjErQzhac0FWVGdnd2I3MVhJM0tpUzVDQmF4NzNX?=
 =?utf-8?B?WjRxemtrcVdadUNDR1ZRODJPRUVkcWt3S01VL1l1MFArNlV5ODZnVzJxYmR4?=
 =?utf-8?B?dk1Hdnk3S2hqQ2phWkI5WVU3OW53OGpaTlNOZ1gySFpaaHRlUlk4cEhhOHBU?=
 =?utf-8?B?by9hbE9qblh6T2ZiM04yT0RLQXhkS3FxOE5KQ05hNFVmb21mV1BLam94dWNY?=
 =?utf-8?B?TW5DUUF4dDgvUmNKcGVIUnUvUEUydDQ5Tmg1ZmRqcjAwcmg4ZmJ6YThseFRt?=
 =?utf-8?B?cUU3UzJBREZvRnlDU0VCcDNmckNxTXl0ZnlBMEZzWSt5SUk3aEFCNHp5YmhM?=
 =?utf-8?B?Z2RkRUJGRm94b2ZQU29YTkorSDN3V3RaaXZiU29kRitZVUlibUhqZUVjVkFt?=
 =?utf-8?B?Um5uMlVGakdoTnZHVlFMZ2d5UEhqbTZKZExwd3dSMUJhRmN6NExWSC9uZzRz?=
 =?utf-8?B?UWFMcnY1SjFwaWlFN0M3WWtMdFl6a1pDUVUyTS83eTdzNjR3NVRIMGhMMVI4?=
 =?utf-8?B?aVlHbnYzUW5WaDBmUVpuR3M1bUl4bGorTjg5T2NnYWdYSUV0NTlZd0h4MGlQ?=
 =?utf-8?B?VXV6anBrQmFrVGk3TTk4ckkzdWs0NjBlZWdMYmV6REZObzVwYVZHaUlhc3pr?=
 =?utf-8?B?SFJVSmRjM2J6ay9jTDJ5OElGb1lsNzc2UEhzOEs5dytnZVRpVEVyUjRJRU8v?=
 =?utf-8?B?V1AxRXpUaVBMSC9ZcFJ1ekNvMlk0UVlVVW1TWmZHVTIzMC9IbzQyallSZmsw?=
 =?utf-8?B?N3R1NG91d3BJdURVMU9uVEh3MnplTDE5YTBEb1U2TC9sVDhwOWt6RG4vQSth?=
 =?utf-8?B?RzBEMzJXcnBjYVhFZmVoTnBJKzBXVjhnZ0p3K0dwazEzVk9VL3JQU0JicklY?=
 =?utf-8?B?MWlrV0ZFVEZXS2J1eDhFL3dLYWlBPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc207329-ae31-4782-761c-08dacc7b4d28
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 11:18:37.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mydUPAHt/1KiMtdfLLF+m+Hmlju446gAHYH/hpWxcLDYONANx3rWZFzfC5mV62bxw9UhzOslIuSDLiJ6kSBah/Ylmq+af65VchwWPnDQTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9691
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
> Add support of external clock gmac1_clkin which is used as input clock
> to ethernet node.

Indeed this operating mode is defined in the schematics, thanks for the fix.

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

Best regards,
Michael

> ---
> V2: None
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index e1c75532dcee..b848282ea005 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>  
> +	gmac1_clkin: external-gmac1-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "gmac1_clkin";
> +		#clock-cells = <0>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -249,9 +256,8 @@ &cpu3 {
>  
>  &gmac1 {
>  	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> -	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> -	assigned-clock-rates = <0>, <125000000>;
> -	clock_in_out = "output";
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
> +	clock_in_out = "input";
>  	phy-handle = <&rgmii_phy1>;
>  	phy-mode = "rgmii";
>  	pinctrl-names = "default";
> @@ -259,6 +265,7 @@ &gmac1 {
>  		     &gmac1m1_tx_bus2
>  		     &gmac1m1_rx_bus2
>  		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_clkinout
>  		     &gmac1m1_rgmii_bus>;
>  
>  	tx_delay = <0x4f>;

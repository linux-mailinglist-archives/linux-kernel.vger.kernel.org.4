Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B926259DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiKKLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKKLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:52:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761F27910;
        Fri, 11 Nov 2022 03:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW5U5UlpDfAkleYvE/n9n5Hv+IcQN328dzACNZomCj5XSDtm4UWpj6lpuKbIfPzFtywIxOb458/N0NNY0eEYVEzGbxU8zeibQmokyk89QTnclBIj9IYWys5SSYRLUoK+4snNE9XYUoQR1z9sdMOugMt+fwTkBsGozN2gV6CHqN7bG8K23lBwbyFtt7WpbI/1sMobGio5jusTGS87FQMtmge/bCMysmtzeNPho7Hx0IQgqcYWqJdRM5R0VStNLbT/y/iaMyOrlMieV5J6AEZD8haC1IhqFug57PpWDc6Ek1Mz1qsy6QrrOIP9wvQBqcr7Y3t2AUjw8IJDuw8dCsQCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVuLejCbATu1qCMW7V/G2iROu8Mqd6/0L97iRtPPcws=;
 b=By2V6jI/Ahw8vMVs+aTQW1b9vaj0quC8HNsS9eeimLKVKck1VEE1XYXwNfpmQZGOcF0mWck8LhoTyvBWUO3p8ggZ4bIot83otP3iP9l+oit1UkMJsYhBL0qVMLAFF0XsiBrijbGj5gONyC1Jp+CmBsXXw7OLGGo58CH/vfNVWR6FCeYE5EI6I+AmhkPZcXUNojKGQrdFwRek9+zd5uLppx518bEDTSNsRTSYG8mNJShOjXCjlwH6IqLDg9Me+q/bSU+8Z2vVuJAksA6OoHwIhN796Q2u7MZZVjbKb3QIh5nlDDJMImxrcumuf3x0oESYsX8pJhAZyId5g2yrye3CvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVuLejCbATu1qCMW7V/G2iROu8Mqd6/0L97iRtPPcws=;
 b=MjddFzj7w42rNA3Sy7xy8N2T2zO+ziz/5n6kLTW8YRRP4eRLdcNmIph//WB9b78+PsneFnOxT5QDUJ+I7qu2dCLqNDgfJ6IDfyO+UPDRdMWS5Vvw4LoXDgSFWXlxF9NbiK1UtrFPSWe2BRX47JjazBY7k2Hh44FkRfhOUbpWozI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB9657.eurprd08.prod.outlook.com (2603:10a6:10:454::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 11:52:28 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5813.011; Fri, 11 Nov 2022
 11:52:28 +0000
Message-ID: <69885e9d-d26a-4a93-8484-c19d7ed23121@wolfvision.net>
Date:   Fri, 11 Nov 2022 12:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linux-next-v1 1/3] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A sbc
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111094238.1640-1-linux.amoon@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20221111094238.1640-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0196.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe81a1c-083b-44ec-1f6f-08dac3db3480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+gytL7sdaF80b+u7JSluYkobhEw1YrrLQGxWGUpMnjsBEmAkwnDzFkCe1FA77JwqoDSJ3nRx+XXgt99uy24l4FfwxSxs2wVeq3hbpr+5VopQnlmxkvp0mTkI3BTuhBZvqMDDzuztR6k4bWwXRMlFB48O7RXsPb4Q9TuKDwSiYlPmGk6Mnu/NgUfLkjKbrHQdTRLF6wVm7mZ6/OgOGMp9o2cxiE7Y4159L68VRFo6kqDX8MpSr+et4szA0tMBiw14OUVMdUmKd4WHgDe6mxqejGd8t3BvbgmkGGxOPFpl/mpDIF6v1L5OYd3NDGzvlxLNaD4n0QQtIrfwBjbN/Fa01rAFheHq7yCuPHP1iFqoE2K/JGc0RJS9PFPi2gC5MofAilDZYkC5+OMq9rlp5Lh7HOfC9nvX9/1S1jA1VQDXupugtVdfUwsb3HOzhCkJpPIJ6/7cE3KZcZ+ZFhFI3u0IYj7Bv6OmZaKkB6Wm++f38Ts+dFUf5Z8H9qrbBXgj2n5k9zZ9k+rcfFotwVgekvSxzQogzOdmcXPi6MpRdXMCjHrwRruhyezwCkityiB4MA4D4TG52MFCg6d0lb/rsC0HUmAXl97c1E7cBZxdGo3Ipb+oBF0EkNp8y2O25qlNaZS1wF3Yt1HYLFPYg9Bl8anlwwcl6RP3XWEb/+gapiODb83G9zZPqsDdAgF4rbheHsCVMsBQv4f6bLuk6f1QtaHaThGzi3IhMbdmxU0pe1HGSJ6Lxa1B6TE5MetvftzV8UbH335HlTaX4pPe3oeYhXqVjX0DwoIe4TA0ohV2RF9RWl0sfOVOaxAWweB09yRPcQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39850400004)(136003)(451199015)(478600001)(36756003)(31686004)(36916002)(2616005)(6486002)(8676002)(6666004)(110136005)(26005)(31696002)(53546011)(6506007)(52116002)(86362001)(6512007)(66476007)(66946007)(2906002)(83380400001)(316002)(8936002)(66556008)(41300700001)(4326008)(44832011)(38100700002)(38350700002)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mms2c1ljdkljcmVuelB0V3cyUjgzd0VQb1JWUFcrZE14QmlJTFJ0Y3hkVmlZ?=
 =?utf-8?B?bUVoZzlvdEtqNE5qVDVTVzNkbWdXQThONlhpbnZDdjMvbjlOLzVVOEhzL1BM?=
 =?utf-8?B?ZTQ4dVBKT0V1cEEyaWJVZHJNT2Y2cjIvMW9tYTVmQW5Xa3FRbDFuQlhvbzBv?=
 =?utf-8?B?eXJhWkE5Q29BT3dRK3o3VE9reTVjRHJQaEFLNytKbWpMRytVdVFtVDZCTDdM?=
 =?utf-8?B?ZGZkdFpzTDRtU09PK21IS01FNy9rWEpYQUhsZUkzelY4U2trS3g2Y1lQUnlC?=
 =?utf-8?B?SHF3TjFpcWdEVDJnM1U2U3FxNXNXRm1BbWxnUDZFUTF6ekNzelFzenU2MC9J?=
 =?utf-8?B?WitLdVZpU1hUdlJ0eTgvRGZIdTRiTGdGb0pKVHRGQjIzVVdleHhuQTd4R3Bt?=
 =?utf-8?B?YVRFeUpBVUxVYXFyRXYrK3NKVWZnNTArRVJ6NGpjU3p4VlQzelhWbHU3SXFD?=
 =?utf-8?B?K3E2bFBnZGE2Y004NG56OWtNKzJrWVp3ckR2L2FaaVphdXllRVhScGJzZHFT?=
 =?utf-8?B?WCs4TTAxaVBvRUNHR0ZDUDQ3ZWI4R0QwZkljSDc4KzJDQmkvdFQwNDJGbzBD?=
 =?utf-8?B?TmRRT3Q3aUJCSnhSajJ6aTVyUlpPM0hxUUdUd3R3OHYyRjlTbysvVlhEM1Bi?=
 =?utf-8?B?dnhRcjhDVlhQc2kvR3Z2R0JjSElQOWd3U2hIYWMzY1ZRN3VOeXhTQlhkQ0xJ?=
 =?utf-8?B?Q0ozL2NqMWhHeEt0MkJwVU42MzdsQTFFdCszN1g1S0dnNllCNXNuNUM1OWMw?=
 =?utf-8?B?UjFTVTZQY1ZqWXpZZnM5cTk4NXAvMXZla2MyejF1SDIyV1dNczdMUTIvMlYr?=
 =?utf-8?B?THVzUjYzcnpRSWlHR0ZidmVjZVdhT2tuSThYcTkwcTRWZi8rNmhCMnhoVCtp?=
 =?utf-8?B?ZXFaOEpqbkpaVHJ5Z0NVTWZUMnRDQzRLTkM4RVNjUVN3ZmlxWTBjekZEa2lv?=
 =?utf-8?B?QW51M0Z6cGdUd3FyVk9iaUhMMVYxSVk0WW9NMHlGdEFxd3YxZHg0UHBuMGlx?=
 =?utf-8?B?cDdwdGJNZWUrU3VsbEs0TDAzQ1l5YWdNN0RDTitwVndtSkY3cmduRWpYRDFH?=
 =?utf-8?B?T0Zienk1NkM5TlgvWmVIZEk0aGw4cVcwcjZtTW1adTd4YnNJZHAzVFNhUk1D?=
 =?utf-8?B?YjBSZEpZUVZYS1lZSk00enlvWE91Nk9vRHg4d1FHZzJJVWxGOGVmSllQUHBV?=
 =?utf-8?B?T0FreEJJTVF6SmcvWHdWLy9takczaDlFaHVNcE0yWGhHTzFvOHdtZVJyMW5Z?=
 =?utf-8?B?VzJnTWJnU29NQkVOaHdUa0pWVTVZODNCWTk3YWNCb1VEM2tnWFdtRjZYbTNF?=
 =?utf-8?B?T1o3WXZNN2RMV1B5RmozMjVkdVdrbk8zTmtwSnRPME14VzlXU0xUcmpnODhU?=
 =?utf-8?B?UVUyM3ZoSTJBejQ3alZlTzN0VnFDRUlyWGJuUHNHVEZ2bVMzQ0RJSlhNZWg1?=
 =?utf-8?B?U1kzMWl6d0dRNkpwVy94R1cySm9FV2NmRHd1QStQSmpFQzNWenRDcTFtNjZm?=
 =?utf-8?B?TStYMVJlY0V0REUxMmxUd0JrQUt4K0tZN2h1SElPVUlBWGFmMjdtWk5Oamxi?=
 =?utf-8?B?T3V2WUxaNWR1cVpYalprNXpCVitNZEFvM2NPZU5MeU9FZ0tXT2I2YTcyeXhN?=
 =?utf-8?B?UFZHSHVDa3pMc2VrV1ExSGx5OFNJVndEVUlMemtUMG5xY1IrQ0o3S3Z2MW9M?=
 =?utf-8?B?SVRmWG42dWY4NTFIRlpUNHUvYzYxMkZ0SFRzaHo5R2d2aThqMVVPNFdrZmdk?=
 =?utf-8?B?SHovK0hmSVdKRU5VSy82bk1ZK3NrdUVubWhvN01CMkRVZXc2V1VQS0Q1Tm9H?=
 =?utf-8?B?c1dRNkZiK3d5Vk0zalU0NGxQQ3lpcWdXSEVrbDk3ck42eXJzN0Q0SmdWTVpX?=
 =?utf-8?B?S2FORjJ3SklBTjNpcU9aejlpeUVZZTByOWlLL2w2bWVGaVZlRGF5Znd5c1hr?=
 =?utf-8?B?TXVYcmRRQnp0cGR2ZW1MdzdKbzdzSnJHdjQwUHh1bUFldWlCZUt6eXNMRnFE?=
 =?utf-8?B?bmIyZVYwNEk4N2ZKRHJqUEhJWGFWWGxFYXdlNEt2c01FTmIvbFRQcmZmZGMv?=
 =?utf-8?B?LytVdkprd0JaaUM4dklBbkgzYUE5cVA5NkVuN1VLSUV2NVFNSjdzN0NOWTh3?=
 =?utf-8?B?ZGpEbTkyMG5nNk9EeHZXRTRRUEV1TDYwcmgrNUtUaTNFdnBPd3gzYXlTNlZp?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe81a1c-083b-44ec-1f6f-08dac3db3480
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 11:52:28.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wWl2Fo5bnwRMHJ5t0sISBZKAMLMB0hnhUJICm2/FxLLUlcUyxgzItUj1xwatS+4uBXVQxZ/LK2qTCUHvAsLi1gvH6T/rpLUiZcol4Ue3vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9657
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
> On rk356x ethernet phy support reduced media independent interface (RMII)
> and reduced gigabit media independent interface (RGMII).
> So set the phy mode to rgmii.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index ea74ba32fbbd..72e410e3aca8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -253,7 +253,7 @@ &gmac1 {
>  	assigned-clock-rates = <0>, <125000000>;
>  	clock_in_out = "output";
>  	phy-handle = <&rgmii_phy1>;
> -	phy-mode = "rgmii-id";
> +	phy-mode = "rgmii";

What are you trying to fix here? If it ain't broken, don't fix it. I
would assume if you switch from rgmii-id to rgmii you need to adjust the
rx/tx-delays, otherwise this change does not make sense to me. Feel free
to point out what I am missing, though.

Best regards,
Michael

>  	pinctrl-names = "default";
>  	pinctrl-0 = <&gmac1m1_miim
>  		     &gmac1m1_tx_bus2

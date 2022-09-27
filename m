Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7C5EB9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiI0FmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiI0FmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:42:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868A85A80;
        Mon, 26 Sep 2022 22:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A16EzXoeEUaUputWzmYgGVi/ZjLm/AO1plOm1Jpu+U28FosejhoQBB8eIgJEhql/ZkpFbWHZK1E2HJWJfFFanih2LGU4o7tsFj1bIKR0XqaQQ7MyBWNQjSCl5XCmYWLZZZkhRUIkV5sks+h6lDqjobIhMSxaCcEfKlTclujeNe9EnjFS048dZBsKOJK+UhMU/tVNpnqv6CQlnVPl11m7IDkDxEEJg3hQJq+39PGLeFXVvHWbwTClp9jBzlJxJLvWIzunM0eSxUyEZ7K0+XST3kbNgH8uhdFPcr9QqpBS4ZeuRuZ2ILh1ouFGc6gzbZiTOPwdsFI737roW5cdTt+peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+SeRhHPIVYNiF0rT3sB/vJbw4z0MF1y6sXdkhhp3BY=;
 b=IzuTAxI4T3UGHBCs8UMandlR01RsKUvyPEeG4VqknccBhb2TwRQRfUmvcnBxomHZeJxO2touIsBblnsDUA3snShHYU5LbYRHa0YD72AMeDD6aXy1FKyJGhgu52uD3JesUOll2zrr+so4Anaxk2QF8tZZ4HEV4HEG5SA/JvPEqKRBwz/MgUGxMKyqYKvwbW7ghJtB1GEWmshuVFF0y897WjhixHo5EFOxmJbYED8b00XS5jZhgDSCbI0j3oYQmLujBkPJwvO7TzwlGFG9oVsjBohCmzT+Ocaz4CV8rhc/fyK/gr1CzpAOzqHIy8X4Q+ktqmzKxoU1/YK1K1lFElWXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+SeRhHPIVYNiF0rT3sB/vJbw4z0MF1y6sXdkhhp3BY=;
 b=YhGw7NLo8RM4achMvMW77dJPAwbkJYXJV0yodwucwZGBrhityuwpk1u1hMnBZQpptIqUvgDSN8euBmhErvUfBp9975hBbuWFoyiybWTrg21sCc3DvLVmxTMD4b3H/F/CrJG+uAODfDb2mA5AaKsUZv3/MBLPxNPyOHxEfpTWU6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAVPR08MB9187.eurprd08.prod.outlook.com (2603:10a6:102:30b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Tue, 27 Sep
 2022 05:42:05 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::30bd:5198:8936:b796]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::30bd:5198:8936:b796%9]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 05:42:05 +0000
Message-ID: <f54aa330-3f19-b415-e62e-7edc0d1f0f3f@wolfvision.net>
Date:   Tue, 27 Sep 2022 07:42:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add regulator suffix to rock-3a
Content-Language: en-US
To:     Chukun Pan <amadeus@jmu.edu.cn>, linux.amoon@gmail.com
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
References: <20220926061420.1248-1-linux.amoon@gmail.com>
 <20220926180102.37614-1-amadeus@jmu.edu.cn>
 <20220926180102.37614-2-amadeus@jmu.edu.cn>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220926180102.37614-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAVPR08MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 08031253-4ede-4ce2-a64a-08daa04b0251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyol0KOYhHzh35UFyJhP+eG+xKt9M7DcpPRNO5sqmASWsBCG7i0OvkY1Smox84PGymUXdgDg1sAhgNeIe2CIoBuAzMV7KVpcDBu6n7zPIetI6h1g/ibS71Nqkj0X/AHa16eXY4vm9qQHE6erGIv+R04avjgZOPjiB517rwl6nlqo8a/GOTEubptiT2MH4qlVcpGqOzkqDRyLIrBxQUCp18eQdUW7MQUqeLyNfpMzFTzJrNX531pa0CxXecP0WSGQn/PcZVTQjdolqmI7aqI1yySn76fw8yPjEoiD+ujiftbH1/EnwAmKcx1BX9uyD4dr1Ud/w4Bup4Uxe4KwlJHVrsXk7ku46lLE2Y4gf2g0e5RABtdz/KG8W3nmLbPGv+BXA+l+vVad3y1ybXXCVCa2x9B2TNARGLeKL+x3R0IdVWDbRoBAIL+8PsQprUUEAGr/nyM6g0qsLgdF5o9k9LPcCB1bNiG+0OAzsM3c2eMJOPPsN+2hw3feovTVDijrEL/lTls05EBRIAEuq1X7vzMFZ2Ilpx7cJjVm/8fH1zjvYJMFe3G1UaPZIC/O6S+S4Hf1A5UuJ5yG3OFDKEW+ofhfnrbSJ4+iw8GVklWNo/ampCK0qsDBAXLPi83O+FPPKamzPKwvjEy/5HUg97YrvQsN5B5Vivox+XMWzOsvLLzYz1097Ue3pCm+wYHgz+BhHqdor1tPyOJwRaGpnZQnf9u9p6O2Gv/6tlQBkx95jP0fKlggOiMlM4cOFxW52F7WZ05SGoVsUYxNgZFwjHqwBOUQI2wQD+v1i33w58Rmv+zj1U0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(451199015)(6512007)(6506007)(44832011)(6666004)(66476007)(478600001)(53546011)(52116002)(38100700002)(8936002)(8676002)(41300700001)(5660300002)(66946007)(66556008)(4326008)(36756003)(186003)(31696002)(2616005)(83380400001)(86362001)(6486002)(2906002)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVTZXJGUitaQ2dSTGVlMHdkMUdpRERUQklzVm5kdjEzTkpadlo0WCtEc094?=
 =?utf-8?B?OE0yRCt4M2h6aHhuL25Qclh4dmFPOTNrUXFrOXJTR3JZUU40VmVSVTMrd3Jx?=
 =?utf-8?B?VHRiYlc4NG1SVnNNc2dhdlV1bVI3eWxKOHJDL1JyRUlDODNsS3NBa1JXamtR?=
 =?utf-8?B?VnJlOS92VllIcWdKak9BRVkwZGs4bVRtcFRZR0NacDZaVEYzeG1wamdTYVVR?=
 =?utf-8?B?NmlKMVZEMVlGYmVVTmZFZ3ZrVEJaV3JGZGthRHhDL3dGZjZhbk9pU2dnTVdz?=
 =?utf-8?B?L21SdjA0M214SHpYbmtvM0dJc05QS2t1aFJNMEQ2aEExN0JZZldxWHlCcmlK?=
 =?utf-8?B?eEVRWnF3dUJ1MDNzdjRTaUVvQi9QT2tYZkJJakFiNWhhL2VrN3kxWGtZTlJo?=
 =?utf-8?B?dml3ZmNnblJSalR1WmdtOVZFS1l1MklWWTdEYnJUV1BVb3JwUkh2VWpZY3gw?=
 =?utf-8?B?WHh6bFRZVFg2RVZNSmx3eElKLzcyYkloWVBGNzhvTjFZSGdoM1JiazFjait6?=
 =?utf-8?B?b1RGQ0dJTkFiajRvRGhlWEdwTXJhNTdONDVzUW1RSDExM2pWL0YyYUhlVnNm?=
 =?utf-8?B?QW5pSC9KbjEwWHJqQnE1L3ZVUFUxMTBsdHVEbURncXdqOGFoTGRReklETWFL?=
 =?utf-8?B?aUwzQVRqYlczZndVSlBqL1lnczhSOHNJbVBYV3BqVUFBMzArUlhWY05ESlZH?=
 =?utf-8?B?WHBLK0wyZFR6ZGVvQ2kxNXVtOUhzcnQzMitscHpSVFZJZXNsOU9aTGhtVmdx?=
 =?utf-8?B?bG9nZFNmbTNnd3Jib1k2ZVpWYmhaUUpVa3Awb1pscTE5ZWFqRS9qNHp0L05z?=
 =?utf-8?B?QWxSNS84a2xwcmJXQkQvb3lyTVpFbjNnYWo3TG5SME9JL2ZwdEVlUkQzUHdX?=
 =?utf-8?B?clhacThJcWZjdU5yZTBnMUFOU0d1Y0JpNnpnNEdYYW93ekk3VzRldzFXWTlX?=
 =?utf-8?B?M0pYRE9VNWQwMVhkQjgzRzY1MTllTkV0bVNwVURDZEFHWHE0M3ViWFlvMHZq?=
 =?utf-8?B?V0Q2YUpVSFRiaGJPNHorUDhBTEZaWWRSeTMrbm1WbzRKRW40S2RnSXRveENS?=
 =?utf-8?B?L3RHOFVaQ0V5T3EyeHorTmlpNjYwcEIvK0lhR0lEQm95dXE5cXNzdXJCYW5J?=
 =?utf-8?B?Wjl6YW9MYWdTa0VBZWJlYlM1dWVMaTBNRk5rOSswMzlNZ0NXWUdSNThNYzBn?=
 =?utf-8?B?Mnd1akhoTHBYVGF0ZjJIUmpjcFVERW84bkp6VEpPTjZZNlRRK1NBZEJ0bU9h?=
 =?utf-8?B?TDF3b1JYQU9nOTVGVEhlVGlRbGlieFc4UFM3bDFZVm55VVZxd29vcjQ5Rm1C?=
 =?utf-8?B?cWRVT3FWajRBV2dObmhYUHI3NW4zUUNmbk9iT3dvcFhhSEhIcW9IWDhNdnYr?=
 =?utf-8?B?eXd4ZFlNMDdyK1ZrSmxvOFFZYjg5cnZIVnBabWptMW1JRlJYZDllb0poN1RY?=
 =?utf-8?B?dk1GdWVwUzZuUTZwZDgyS0ZmOGtBdE9aNlM1VHZIZjR4QXF5cWdQVkxETEN5?=
 =?utf-8?B?bWU0RCtURTUwdWpQMTdMaGZMakVLc1Mxc295YWt3bVJRQTIwWXBWcmlwbHFt?=
 =?utf-8?B?UXUxOVRpR2pCT1VoRGdHVlVURXVibmE0MFI5YzhDN3hyY083VklmQ2VtVkEz?=
 =?utf-8?B?NEZURHJvYUg2dnM3dGpXYVM3OFFiaWxGVEJvc0I2WWlWNGVNK2hYTFI3bFcr?=
 =?utf-8?B?YUZ1MUFtNHJQeXRWeXl4S091OE8rUXJDWVJiRjlrS1luSlgrMlNzMVZvRVdh?=
 =?utf-8?B?YVBDQy9IYWRxR3BVQmZhQVhGVDZLemRScjRCZGROaHpVak42dm5rN2U0TVN2?=
 =?utf-8?B?ZHJmZVNob084OEFXNWo4QTdmMkRTMTNOSjduc3FwOXlwR2NmanJtQ054ZUYx?=
 =?utf-8?B?WlU2ZmlKN2ZYWUc4T09VUXVPeHA2VEJRdXlXZk1ZelBaSFdEMzBQV1c5ZS9V?=
 =?utf-8?B?UHhMWk9kWDd2YmZDZkd5M3VQNnVpblBvbmJVcEN2NGJtaTAyUUpsanpJd3Iy?=
 =?utf-8?B?MFZKSFQvVEE0dWRERnZKS3MxeDBpenhZdEpJdzhHVVI3eW4wWjNjY1JVT3A4?=
 =?utf-8?B?SEQ2aiszMVpmdEo3NU11QkJCRmZCQ3c1SFllYVpWVUw3L3llOXZJZXZEenNn?=
 =?utf-8?B?L212d04xcHdaNTJwTkpBRVFrRUxGLzI1d2FrZjhHUXUzQjRUTlRtc29MSjJQ?=
 =?utf-8?B?Slh4YnZuclVmY1lZV3dZdTRvaFEvcVVGY2ZBMnQ4ZGg4TDlEWEY3M05XeG95?=
 =?utf-8?B?NVRONHdjeXR5ZGFGSHQ3NFdRaGFRPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08031253-4ede-4ce2-a64a-08daa04b0251
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 05:42:04.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1qaSPSxm6ibdq9xTODQPMP0EnDjmxnZZFfIcWIygChbeO+Udc7JgqFW0RooNOU+ySjlPP1031yuQ5aTYazeBX6uPNfrgRFv57cyplnQdkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9187
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chukun,

On 9/26/22 20:01, Chukun Pan wrote:
> Add -regulator suffix to regulator names on Radxa ROCK3 Model A
> board. This makes the naming more consistent.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Acked-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index fb87a168fe96..8adf672709e8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -60,7 +60,7 @@ simple-audio-card,codec {
>  		};
>  	};
>  
> -	vcc12v_dcin: vcc12v-dcin {
> +	vcc12v_dcin: vcc12v-dcin-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
>  		regulator-always-on;
> @@ -79,7 +79,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
>  		vin-supply = <&vcc5v0_sys>;
>  	};
>  
> -	vcc3v3_sys: vcc3v3-sys {
> +	vcc3v3_sys: vcc3v3-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc3v3_sys";
>  		regulator-always-on;
> @@ -89,7 +89,7 @@ vcc3v3_sys: vcc3v3-sys {
>  		vin-supply = <&vcc12v_dcin>;
>  	};
>  
> -	vcc5v0_sys: vcc5v0-sys {
> +	vcc5v0_sys: vcc5v0-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_sys";
>  		regulator-always-on;
> @@ -99,7 +99,7 @@ vcc5v0_sys: vcc5v0-sys {
>  		vin-supply = <&vcc12v_dcin>;
>  	};
>  
> -	vcc5v0_usb: vcc5v0-usb {
> +	vcc5v0_usb: vcc5v0-usb-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_usb";
>  		regulator-always-on;
> @@ -109,7 +109,7 @@ vcc5v0_usb: vcc5v0-usb {
>  		vin-supply = <&vcc12v_dcin>;
>  	};
>  
> -	vcc5v0_usb_host: vcc5v0-usb-host {
> +	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
>  		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> @@ -144,7 +144,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
>  		vin-supply = <&vcc5v0_usb>;
>  	};
>  
> -	vcc_cam: vcc-cam {
> +	vcc_cam: vcc-cam-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
>  		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
> @@ -160,7 +160,7 @@ regulator-state-mem {
>  		};
>  	};
>  
> -	vcc_mipi: vcc-mipi {
> +	vcc_mipi: vcc-mipi-regulator {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
>  		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B6C721146
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjFCQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:42:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DAD8;
        Sat,  3 Jun 2023 09:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZdMqfvCm/udP46G6e1dIFV9tVrX2YYxEL9TkH8Ihwx9lSsC77BsY5bQNxS0Oon1cN9+F4TP6tYuWQoUUeKkoVREVZqydtlFL9gT15RGKb3AfKfUImqqloKuRP+TFR9D7i+Gs+WYBGIsQn7UdF1hu+ZFK5ZJNWc2WcK4o8XIXK+iX4ifO4N3inGKuvTpNwxswLORVfhB5FWVpoRjRSTJFJsndYLnoIYx242ylWCY9As5+kaodTTzdsYixELdfKDVhNkb3FWnrmTgQsUZOYsvpCGQLxCTr5PIRUw6wr0qb9epbRFGqAj5PhJqccbNIrO9PLXYSIj541I5+eVfwluH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Z7Jt0TApbmYqnSbHULkUhNK7GG1epwvmoVWLwiOMk=;
 b=Q0uqFYZUzaaD3jqreA1dpmQsOoEZbEdSc5XIfEotXEKTDkCU6IGMgAoSFDKR/6GDLJYSS7elmWd+STwkruweW3XL1YEcyc7n0M3r68BhPaHCD/Lwy/nr+Uj5+tR33A5nn+MOiPyXDwsMR7MwCe1vhvV45H2ABEOkdja3XCz36WxJkCrl+/JpLd79nVegBP/WXaqBbJwc7viDO2BBkMTT3NSN3qVo4SBdAUoZSM74g7arwVW6apOE1HRymAAxcQ4JuJJ/gF82uNiYxZuPZ7Ea8xLn8LeVVi2tV564qPYVcP/ky3nw3BSJO43/cFb7i54I/1UIN0TBQyOnxWhafQggiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Z7Jt0TApbmYqnSbHULkUhNK7GG1epwvmoVWLwiOMk=;
 b=xULdJU9CvUHcOf5Tco9qFzYSgM+huLak/Fsk/duNJ+3L95uqucNe9DNaWP9RvbSOjXuEGlLIv282oE5MoeLDqZ8CezIa9W+BeMoCnWXphCCg/KytwOjDjwMDexrTD6ZuVEplLNXVYWxmeY97khlaUQbYOcVmIMsnA9VYmxlXpuEouf0HMsA6vFm6wDJUgdd7WPsSvs1pe76WoJN95B8MLS9/Ib66gUxu3SfCahUCSzI4U4f5B+ZXCrw/wH0T/valiG0+mdteN2J2ctfuxsMU5Jk5QBCz+164qi71bBemL5+t5EIxJHdrTZg6XM0TOlF5c+sxb7RtzMXKSugFe3tRuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 16:41:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.028; Sat, 3 Jun 2023
 16:41:58 +0000
Message-ID: <12c60b4a-6c1b-ce99-6828-8ab3854bb415@siemens.com>
Date:   Sat, 3 Jun 2023 18:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/12] arm64: dts: ti: k3-am65-iot*: Fixup reference to
 phandles array
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-11-nm@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230601152636.858553-11-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3821:EE_
X-MS-Office365-Filtering-Correlation-Id: 82999f08-5173-43bb-05fc-08db6451727e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFyf2d+u2wkxcnDAU6rzQDGAftQ64TbzXe6jSV/sLomMyFud8MpuzZ9MsTFXSvd63u+HDluBt2n7qYkd55MJvLnf0O/ujSc1LCp+8B4Fs2oo3lUkYp3JKKaCQQFoye5L2xRWGEvxpbWtlyREJG541vSTsMGiGt/5BDypikVpsg/wMDEiPcRrW1RCGvBcjEwVbpNuHk573Fy14JlHS/vkykDN63wEtkVMP1BidLzLbhSLiRBOKMYmKxc4AeXtFPQ6TMP4fZ6yzD9qKcFmfcDmAn2pG5u0oMddGs9GQy0JwNedKNB/wpvZNC00dzKRH+MSmkLd6djnRssynvOAzL35LXQqT5orJmNGaLfVmRe45DURg8o2M3QBvcKdasdQsNtZdAXEEZhtPWZeKsCOV1oI6/Brm7yA8mw099wRPDOe5C9/qFCfsbvS6DQIQ0tuEudNwI50LbQnjFD4Pqxco+Dp3MGhCrzwL51z/+tx8cbhezWvzcHV+nmodyIMfnqklIWaVjoyXidOStAVYNr9Tr1ltoqmq8otsYNGzqyFi3O5gZwvvlar5w8IFsxuDOJRa1yybgAmVQou1nVj+hyOKvjT4uE7ZJ7X3pJDYaIR1lUlJDCii889gz0ahaC30atjqmyg2wltwdJYtFXqEFADsFHQaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(44832011)(7416002)(8936002)(5660300002)(8676002)(2906002)(316002)(41300700001)(66556008)(4326008)(66476007)(66946007)(110136005)(6486002)(54906003)(6666004)(53546011)(6506007)(6512007)(26005)(186003)(36756003)(2616005)(31686004)(83380400001)(478600001)(82960400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGZrNnRaa2pCMFlqbGh3U0hoU01EOGxTYVp1SUFvS1BPTmRKWURXdGtVcFNn?=
 =?utf-8?B?RjFDQllSU3paUEl2eEQ5U2xvSW1mRVNaZlZZME40bmVDZEQrd0hJYXF1YmFD?=
 =?utf-8?B?UDhVRGwvRytuVm93RVJobE5NNlphOHVia3JiVkVvNzB6akROT3NRQkM4b01I?=
 =?utf-8?B?aDZDSUloa25wcVI4UEpXWHZ5RThZUG85VlBRV2pmSUh6OEFEeHRiMEZZbWg1?=
 =?utf-8?B?MWh2UlB3YjExUTJiS2ZPV1V4SG92ME0yczNVQUs3Q21udzV2R3lJelFhbHV0?=
 =?utf-8?B?cWdFcWJacU9kREFFcFRjOGNvaGJEYXJuenR5dUZ1WmlFTVZXQ09kRjdsbXJh?=
 =?utf-8?B?b1hMYjlpd0xiVE9sOXpmd3hOYndoYWFyWW9TV2p1cHA2M2xhL3pEYWFuNEZZ?=
 =?utf-8?B?S1hRS1JuRnp0UENjSFFlM29QUDhoeGl2TWVxaElxRTQ4VnhCenpGUWRxQ3Yy?=
 =?utf-8?B?UmJ0amxFMnQrSzA3K3JLRXNzK2wyRlRxdzByUGZVMzdtaDExZFE5VDg1bHRw?=
 =?utf-8?B?QXU1cGEvaFp1eFIyYkU2ZkMzLys0VzN5SmNIM3kwbkdlYXBqWlFLZEI4UHlM?=
 =?utf-8?B?TytmRkExSU5tT2liU2FCTXR5Zk1zZ1haYkNpekZYSFFxOEJPcS9CVC9JV29i?=
 =?utf-8?B?Nmw1V1BQSUpxcjlDVzV1NjRuRmtPcFNIaTlxSklmbUdzTVppclZzT2FXMUlw?=
 =?utf-8?B?TWJ2TmZiNWh0ZkZoUjZjZmRqN1VQR3cvK2JBN0FpOUhQdFkvM2UzT2ZNaEs3?=
 =?utf-8?B?ZnJJeTR6YXhaandFY2hVVjVNM2lmK08xZWloZEdIVnRUZGswVmdIMVhnQVBp?=
 =?utf-8?B?aFdoR1ZXZWcyOU8vK2FOVFA0R09qWDRBNVBZT1kzaTQ4R2NMTyt0NFdiMTZU?=
 =?utf-8?B?WjFQbTNmRGE0djVvYmVhRGpxbHhHN2w0RzBObWF1K3MzU3o4RW1uOWRnL2FT?=
 =?utf-8?B?S3lMZUJlYTdhdTJrNndLaWhSeU5LcXljeC80SVcwZFFqVFN2M0l1RVlBYUhT?=
 =?utf-8?B?ZVoxWjZUcGNTRjlLeXVLMXpSeElqeEVwQ3hnNG80YzBJdzlEcmhWS3ZEUlg0?=
 =?utf-8?B?Wllxa0ZrYTVzdHN6YjE1N3hjaW4zZXVwNm5LQUxsa25xbk9XTjNwdmhZc3lG?=
 =?utf-8?B?YXh2VmhpenFYcmJMc3hNdUZ0aVgzdHk4TnY4VWJiempTTjdUUnlNNmxBSEtr?=
 =?utf-8?B?alp6L2krRDc4dTNKVUp3dEVSWDY2ZDVHYzBQSzQzaEkxV293cWJrMXVBaHcr?=
 =?utf-8?B?ai90MDNjZkRRa0tYRWhzcTNiRS9ieVlhaHBZRDUyelIvaW5kQ0RNUnExZnlh?=
 =?utf-8?B?NTJHTG44eEVEYXhUSFNJcGh4VWpCZGQyeDFlTmVUbXljbEZvbWNIclFqY0Jz?=
 =?utf-8?B?eno3NGQ3SUMzRDJSeDhyVWZiTDhaR0ZtdUlGV2I3eFpoQlJOaHB2aExObjFO?=
 =?utf-8?B?bHRNWlFLSkVJOUdFWnpSQXFzd2ZUMy9wMXZrU3BEWEIvazZiejJWaFdOSVJB?=
 =?utf-8?B?MTNGMlpQSzY1dyttMmV4cy9zalRVRkhydU8xQWV3T3YzZk1CWGxnNkZFVElX?=
 =?utf-8?B?REQ1ZWhiR3RlN2x2dXQwcmhwUUZVZzI4RENodlpVazNEcmFhWWRRalhMTUw1?=
 =?utf-8?B?Rzk3WGZnUU9sbG9OZGk0YUF2aXJLUTVCRXNXeFNkS0dCMGVUNzVkejI0a2dy?=
 =?utf-8?B?OGV5RngvVWM3T1VrUzRpdTZPZkhDRHpTZHBzVkVKTVIxd29uOTlQVkNGdlNF?=
 =?utf-8?B?MmYxSkUyQXhSeXl1Nzl1Mk5kMmNiK3YvS2M0TWdES01kVjU0RlhtMWF6bmhk?=
 =?utf-8?B?UFN2OXNnZ1d3dGhPSmduSmgvNjhMY2ZCMmVOWWJoMXVEd1dBQUpEbXB3Z3Ji?=
 =?utf-8?B?ejN0WWlmOWZ3V3BqdXIrTU5ZYmdnSVZ2VStDMmFqNmZ2NUhrT2x0VHlPRDZY?=
 =?utf-8?B?YmJtQ2pFa3JsWVhjV2I3bGpDNnR5SDJ0TDU0UUM5cDlIdFV4TmtLKzRFQzV3?=
 =?utf-8?B?QWJTaUJKYmYwSGdzOVBTWEVuY2pEcmxsMkFaU0FFUnMrS2RPQTRPejFlcWsr?=
 =?utf-8?B?ZUJsUWNwaWNNcVcyTitGQXVQbkl2Wk9wR3NyVFRpWDRremdtMlBseDFUVDlo?=
 =?utf-8?Q?oNhS1COrc05NbnKkqajWT37K/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82999f08-5173-43bb-05fc-08db6451727e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 16:41:58.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqV4G8pHZkJo0yQjX6JBK2TmLp2bbNrpc6lU/97WIDbJkCh/9ITHEdTbbCoZ+sEFU7yqSGVPxh4J+0tW65Lz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3821
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 17:26, Nishanth Menon wrote:
> When referring to array of phandles, using <> to separate the array
> entries is better notation as it makes potential errors with phandle and
> cell arguments easier to catch. Fix the outliers to be consistent with
> the rest of the usage.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi    | 17 ++++++++---------
>  .../dts/ti/k3-am6548-iot2050-advanced-m2.dts   | 18 ++++++++----------
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 6b052a0ecfa1..bbbb5c169ccc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -384,13 +384,12 @@ &main_gpio0 {
>  
>  &wkup_gpio0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <
> -		&arduino_io_d2_to_d3_pins_default
> -		&arduino_i2c_aio_switch_pins_default
> -		&arduino_io_oe_pins_default
> -		&push_button_pins_default
> -		&db9_com_mode_pins_default
> -	>;
> +	pinctrl-0 =
> +		<&arduino_io_d2_to_d3_pins_default>,
> +		<&arduino_i2c_aio_switch_pins_default>,
> +		<&arduino_io_oe_pins_default>,
> +		<&push_button_pins_default>,
> +		<&db9_com_mode_pins_default>;
>  	gpio-line-names =
>  		/* 0..9 */
>  		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
> @@ -711,11 +710,11 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
>  &mcu_r5fss0_core0 {
>  	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
>  			<&mcu_r5fss0_core0_memory_region>;
> -	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
> +	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
>  };
>  
>  &mcu_r5fss0_core1 {
>  	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
>  			<&mcu_r5fss0_core1_memory_region>;
> -	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
> +	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> index d5e41bdc89c3..1fc93e0b3c9b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
> @@ -66,20 +66,18 @@ AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
>  
>  &main_gpio0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <
> -		&main_m2_pcie_mux_control
> -		&arduino_io_d4_to_d9_pins_default
> -	>;
> +	pinctrl-0 =
> +		<&main_m2_pcie_mux_control>,
> +		<&arduino_io_d4_to_d9_pins_default>;
>  };
>  
>  &main_gpio1 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <
> -		&main_m2_enable_pins_default
> -		&main_pmx0_m2_config_pins_default
> -		&main_pmx1_m2_config_pins_default
> -		&cp2102n_reset_pin_default
> -	>;
> +	pinctrl-0 =
> +		<&main_m2_enable_pins_default>,
> +		<&main_pmx0_m2_config_pins_default>,
> +		<&main_pmx1_m2_config_pins_default>,
> +		<&cp2102n_reset_pin_default>;
>  };
>  
>  /*

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


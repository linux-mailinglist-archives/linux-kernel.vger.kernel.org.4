Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B3742166
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjF2Hux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:50:53 -0400
Received: from mail-tyzapc01on2127.outbound.protection.outlook.com ([40.107.117.127]:35187
        "EHLO APC01-TYZ-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232297AbjF2Hto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOP5xKjmH3jd1sMuzzqsJP0+W8IX1lBv1aHEBVCdrLGW8Oy2d87kze6lZhEtMl/EjX8UTJAojiO/kvpGOO21Vn3AHHcBndfSoM6gyYT2bhhLxNuSBmlxm7vZMKknQZ7Bc51Y+EKvooJvOETkkBElH/RT+1WDeMI1GeIjCttYme+K94jfOP7vt1jOihuMDjqcZCbbYHjpMxG15H3vydsuPGv3eSRCH5xERSAWgBpNHTbjjz8Hy8JIaB0lGLUHJgOBQ18c/hRiuv1MXm/8isey7uncbgCCMRlIMcGwTc1fhlT7sfZGZH33IaY8pZ0WEK/BSo4MBs6J+bW/q3NbPlLioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/W2pbIOQTMKAoxK84Mwh/sLlNSeF+DbF1pOlFJKizw=;
 b=EUiRDZ8Tx8GJpkgl107zKVV2Xoiqt2MiIRyvtqsyE7rV/g7DbDy8kE9M9X+On+arqiq7yRKUhN5y+jr8H8uR+Rrz5f+5FT6vd8+7skYw8MlGcMFS4Cch9GlgbFuUFW58kAKGEPMaiMBSbZ18rHq8JulFL1GgHM6hhlutGnGmx8oA/PYBSMgLv7vONPY5F0FKuuN2t/gIeht/17UjNZb1kP1S17dmjg/gF2QZWgG4I+PVKYWgydsgYvzwm1AgLF40k2qXokd9tAPPLGrPloT22ZpppEqB7+/i77499Nz4hCDUqLr+pNu+k5JmO/a/+dwKA+6UnB2f22ya+QH+2FfJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/W2pbIOQTMKAoxK84Mwh/sLlNSeF+DbF1pOlFJKizw=;
 b=lLa/DE73sY1ZyJB34CTsGBuZ9+7fxQddfpjP7EhFJSh+hbYsrq9IAhMXOk7meT8kWlCMDEHBAaz9AQnyQvmQrudx48+dMSjGGDL27VNczsm/vAEz33EuaP7OeSf89Q2selkocC41AahwOuYErJ+M3ekzCKv72I7h6/MNRuIh5WjsY92KV+uWRvPRwN/rHD+Tmmb3vgh4VHqEkhPqnMRSckIl67nO+aFwYIf1w9aHevT/2CYFpJ0Hj4MkVivrunc15mwFR5TlhHtbgBKpNeRLzNf8NE0V68vAACuimoV130GcA4DPiF01u4PTLXhE+LWt9pglLGBBDsrOwnhOO3oiOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYUPR03MB7231.apcprd03.prod.outlook.com (2603:1096:400:357::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 07:48:50 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 07:48:50 +0000
Message-ID: <c99fbf55-74a1-beb6-613a-268e48cac84a@amlogic.com>
Date:   Thu, 29 Jun 2023 15:48:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add
 initial device-tree
Content-Language: en-US
To:     tanure@linux.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230627091007.190958-1-tanure@linux.com>
 <20230627091007.190958-5-tanure@linux.com>
 <fd7e60d1-b99a-a425-42c9-db85236ba71e@amlogic.com>
 <CAJX_Q+1q1nbE3HxA_xG5f6vwRBfvzcfBnXiFnEfsU7KuBkTHWA@mail.gmail.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAJX_Q+1q1nbE3HxA_xG5f6vwRBfvzcfBnXiFnEfsU7KuBkTHWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYUPR03MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: bb65e2d6-e636-48d9-7181-08db78754713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuR2mrVyERHB1anOxttbEH4enMqM0dEbFdeBFxMKaqWJQJx31beqRyZt1cCJrNnJpnXsaHhEJ1C6obvKx94TX/RgMkSPb9ViV5RJsqPb4780J9UczlJM+jOPM+BTlR8pztry49TZiEXi++278k/rBJwpObhxe6GXHujs4rHZA6g29pCTkn9z3Rb93kVm5BTAW4OCJuT80Pq35noIdntwXGxUnXqb8EashPzL/qcFvydBJDwZiWV8N0allefL8/tgVc0AikBnQ7TQzrQTW8kkQC6ydojfnH3RD2CpjB3jpCqSw6m4z66v16FR3tfG0u5JkIA0EroDVrqGUeelkrp+aOUI9T7xyyiYB8DaRWggiS2BwH0Af8jfqiX14eF4Lkd6SpaXQW0yoIpke0TUz02W4o/adKcIgI6DWUGv1+cMZCRN48ZvNdOyA/+3aBuBu3W3rpC1RHw4TUeFq0rCcyGa01aw9i+XCTuWq6+aETRI6UKampR7Zaf3ii5ZdKz96JQ17XkBD14pkcru8zFARwEQKZGAqupevTGBgkxWcnkFmXqjamcMw32FQM/VHP0lWirn2rVOuwKrBmxNc18e6vmlw0bTQq0fj7hzT0c8uQNVo1TmrH+a2BNBMrQB+lW1CgItAE7GrxLCn7d7qrfMRnO11Ej7rjJ6HWsucce8g6+mjG+VjHJqVHck+vFbrzUJD8MNIrUv5dsvVOCYcGOxl5yRtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(451199021)(31686004)(7416002)(66946007)(316002)(44832011)(66476007)(6916009)(66556008)(478600001)(4326008)(36756003)(8936002)(8676002)(5660300002)(86362001)(31696002)(2906002)(54906003)(41300700001)(6486002)(53546011)(6506007)(6512007)(6666004)(186003)(83380400001)(38100700002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0s0R3gxOXRrTlJmaXJpOG5uNE9aRUZqQXRyazVybFl4RDA1d1k5czFqeEpX?=
 =?utf-8?B?MjYxRUp1WU95dUxUekxyVWNSVlQ4UC9vaHlGQW5ObGJUZUc0ZDRJUnhnOHd0?=
 =?utf-8?B?R0RHRGwwZ1FCV1liSXRXYS95cllsYkI4bXE5QmZ3Q1JPVCtEdVlrZmY3TnZy?=
 =?utf-8?B?bHhZTjZVanhkRHVmc200cFdoQjZodUJYQlI2Um5nS0RuV2l1bWtQbnNLUDlU?=
 =?utf-8?B?VU5oZjFrRTgwd3BKM2hVRm1SZE1aaGtSZEpUWkVWcHhhSzVQMGJFS3FOcVBN?=
 =?utf-8?B?YWRiZEwwc1p3V2pyNzllN25kY1ZvNXBoQTFxRkEyQ3dNZlMwYi80ZmFoQUpv?=
 =?utf-8?B?UWJqY05RUU82RS9KMUVOTTREV2NOYVJBRnJ1UXVycU4zOVB1MjFBQUt0eHBY?=
 =?utf-8?B?NUp0dmRFcU5hQVphSks3QWd4M0pkdlJSVU5xM3g3aTZKQjZzVndxTmJDNXVn?=
 =?utf-8?B?bHROUWowZnlkV2xabVE5U0RYMjVpZ2ZWVDMxRDJ5Y1pBM1pLRFB2NGdTU0Y1?=
 =?utf-8?B?YUdnbXJwb2t4QVJvdlhhcHpRWkw0aEdaend1M3Z5L2NoV2FuYWxLem1HRkEw?=
 =?utf-8?B?NTh1WlVPdXB1WFd6MFBpVCtjTkkyTURPbjZsRk1aY3ZQa2NRUnNvVjJNZFln?=
 =?utf-8?B?aHJKdG9UUnZERUlIL1N0K0tvZWZKa1o4TUtWQWFFNnlTK3IzbTlFNWZVR255?=
 =?utf-8?B?bkE1anFJcFdkWWp0UnZNWnJRN1QreUNIVkZIcGpUd05VMmFtN284dFJBSFJG?=
 =?utf-8?B?YlRuNUEvU2FUVjF2aDI2dUFKZ1JJQ3hZbFVKZHV1ZFpEYVNDTHQrZlpmOHJm?=
 =?utf-8?B?MXVqMFBnSnhURTBub3BDYzBJL1VDNENheURhTXVkdFdIN1dydW12QUlmQWI1?=
 =?utf-8?B?OFhnditXYkI3cG9FWisrUGlQM2tsdUNjSlM1b09GYktsMEt1TlUzM0ZEYUtY?=
 =?utf-8?B?YzJydUp5SGlZUW1LZTBsNkFoTk5UY29lZzM4T3hqSTlHWG91aDUwcVBISkhz?=
 =?utf-8?B?a3JLSHpDaDlRWmVJZDJiWnZHcSt2Y0JHOGZ2MHRmQlJFWWtvdVBENWZZdi9a?=
 =?utf-8?B?SDB1SHRIOGF5WGRJVHFudVB4Y2NyMVAxZ0c3bE50MkRpUFlJOGRlL0svQlk4?=
 =?utf-8?B?NS80SjVtK0lwZWFyQjhJYmZGd1pKRkQzVzhOMG9TdHpFQ0VIRkRBU3ZYQlU1?=
 =?utf-8?B?MDVDM2Erb2hiNkR6dTkwSkFZRzFOemI5aTFQMXZKcXRKaFFMTU1tc1F0eWRn?=
 =?utf-8?B?Nzc5MkptZ3dwbFFobWVtdmpMUzducFEranpnOHIvS1N2bFRRNFlPM0JiQUkw?=
 =?utf-8?B?TXZXMFBNS0FmT1g1QlVKZnNtZ1hpQkY5dXhpNlZNZHYwV1hWTkZnU0dESFBv?=
 =?utf-8?B?QkhjcWY0OUk3WUVCWU5kenNpdUYvRzdITmYrWHJuaVh2L3Z2bzZqWEZ4SEFv?=
 =?utf-8?B?NjJaNWFsTklmN3ovQmR6TnUrZjBNWTcrakFaeWQ5RjYwOWc2V0NIbEJ4ZWNY?=
 =?utf-8?B?d0tZckp6MTlEallBSjZvcURBd1l6ZnlqV0RRZWxZUEVEbExxVFVsNXVYbE8v?=
 =?utf-8?B?NTRqV2pPQ0xBK0VYSmV5TEJMWS9tSThDVjcxZnRPblNZbksvTWdib3VmL0dj?=
 =?utf-8?B?enh6Z0kycytuWGVaNVRPb1d4dGQza1RmVUdZcGViWTNrMG12OWQ1VkFGZTFH?=
 =?utf-8?B?VkxHK3c5RXR4dmsraEtZTkRKd0lKeHVsQ0ZzSUN6cTYremlIZ3c5OXFCaWo2?=
 =?utf-8?B?cjQrcElqK0xBNlV6SEl1RkEvZk8vWTNpMW5LZ3NKMmdFSjNpVENENlNHc1l5?=
 =?utf-8?B?aGVIRVJNcXJ0NWdkUHBHWHA1VWliencyN3QwWjdIeU1TamptNU91cWFaWWZj?=
 =?utf-8?B?YSs5MkVpa28vVzJKQ0tWb3kxSXhrb1pOWFFCRmYzNGY1dU8ydmx5RVRkVFhQ?=
 =?utf-8?B?YnMvN2dVZk5ocDhydnR1VWowZVRmbENaaGJCVFV1eGpFYi90eCtsRCtLSVZQ?=
 =?utf-8?B?dTY4S3FzQy9kN3V3YWJycDhIRHJ4NmlEclpTVEcwQUNRRWZWVHlSalZTS0lw?=
 =?utf-8?B?UlBTd0JEV1M2Q0JiT21hdGJ1T2tuSkpNVXJqSnE3dWJSNmlpaHI1b1RxNmFR?=
 =?utf-8?B?VUFRMk1KK3M3Tyt4M1Z5amprOFlpZVRZRkgwcWNYRU9FL09SWm5EanNFRmRL?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb65e2d6-e636-48d9-7181-08db78754713
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 07:48:50.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k9LmOVlA3JObmd8HWduT5YRBQxqslkUVr/7WY6t7CVBTxjH0T9XiAIE2KGK4uzRDcTCRHy4ebYRfRLQltIBsId5euVWeNRvzR/QzF1bPXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/29 15:10, Lucas Tanure wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Jun 27, 2023 at 10:21 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>>
>>
>> On 2023/6/27 17:10, Lucas Tanure wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
>>> family, on a board with the same form factor as the VIM3 models.
>>>
>>> - 8GB LPDDR4X 2016MHz
>>> - 32GB eMMC 5.1 storage
>>> - 32MB SPI flash
>>> - 10/100/1000 Base-T Ethernet
>>> - AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
>>> - HDMI 2.1 video
>>> - HDMI Input
>>> - 1x USB 2.0 + 1x USB 3.0 ports
>>> - 1x USB-C (power) with USB 2.0 OTG
>>> - 3x LED's (1x red, 1x blue, 1x white)
>>> - 3x buttons (power, function, reset)
>>> - M2 socket with PCIe, USB, ADC & I2C
>>> - 40pin GPIO Header
>>> - 1x micro SD card slot
>>>
>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>> ---
>>>    arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>>>    .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  52 ++++++
>>>    arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 158 ++++++++++++++++++
>>>    3 files changed, 211 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>>>    create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index cd1c5b04890a..166fec1e4229 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -1,4 +1,5 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
>>>    dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
>>>    dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>>>    dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>>> new file mode 100644
>>> index 000000000000..5d7fb86a9738
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
>>> @@ -0,0 +1,52 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2022 Wesion, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "amlogic-t7.dtsi"
>>> +
>>> +/ {
>>> +       model = "Khadas vim4";
>>> +       compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
>>> +
>>> +       aliases {
>>> +               serial0 = &uart_A;
>>> +       };
>>> +
>>> +       memory@0 {
>>> +               device_type = "memory";
>>> +               reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
>>> +       };
>>> +
>>> +       reserved-memory {
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               ranges;
>>> +
>>> +               /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
>>> +               secmon_reserved: secmon@5000000 {
>>> +                       reg = <0x0 0x05000000 0x0 0x300000>;
>>> +                       no-map;
>>> +               };
>>> +
>>> +               /* 32 MiB reserved for ARM Trusted Firmware (BL32) */
>>> +               secmon_reserved_bl32: secmon@5300000 {
>>> +                       reg = <0x0 0x05300000 0x0 0x2000000>;
>>> +                       no-map;
>>> +               };
>>> +       };
>>> +
>>> +       xtal: xtal-clk {
>>> +               compatible = "fixed-clock";
>>> +               clock-frequency = <24000000>;
>>> +               clock-output-names = "xtal";
>>> +               #clock-cells = <0>;
>>> +       };
>>> +
>>> +};
>>> +
>>> +&uart_A {
>>> +       status = "okay";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>> new file mode 100644
>>> index 000000000000..6f3971b4df99
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
>>> @@ -0,0 +1,158 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +/ {
>>> +       interrupt-parent = <&gic>;
>>> +       #address-cells = <2>;
>>> +       #size-cells = <2>;
>>> +
>>> +       cpus {
>>> +               #address-cells = <0x2>;
>>> +               #size-cells = <0x0>;
>>> +
>>> +               cpu-map {
>>> +                       cluster0 {
>>> +                               core0 {
>>> +                                       cpu = <&cpu100>;
>>> +                               };
>>> +                               core1 {
>>> +                                       cpu = <&cpu101>;
>>> +                               };
>>> +                               core2 {
>>> +                                       cpu = <&cpu102>;
>>> +                               };
>>> +                               core3 {
>>> +                                       cpu = <&cpu103>;
>>> +                               };
>>> +                       };
>>> +
>>> +                       cluster1 {
>>> +                               core0 {
>>> +                                       cpu = <&cpu0>;
>>> +                               };
>>> +                               core1 {
>>> +                                       cpu = <&cpu1>;
>>> +                               };
>>> +                               core2 {
>>> +                                       cpu = <&cpu2>;
>>> +                               };
>>> +                               core3 {
>>> +                                       cpu = <&cpu3>;
>>> +                               };
>>> +                       };
>>> +               };
>>> +
>>> +               cpu100: cpu@100 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a53";
>>> +                       reg = <0x0 0x100>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu101: cpu@101{
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a53";
>>> +                       reg = <0x0 0x101>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu102: cpu@102 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a53";
>>> +                       reg = <0x0 0x102>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu103: cpu@103 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a53";
>>> +                       reg = <0x0 0x103>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu0: cpu@0 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a73";
>>> +                       reg = <0x0 0x0>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu1: cpu@1 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a73";
>>> +                       reg = <0x0 0x1>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu2: cpu@2 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a73";
>>> +                       reg = <0x0 0x2>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +
>>> +               cpu3: cpu@3 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "arm,cortex-a73";
>>> +                       reg = <0x0 0x3>;
>>> +                       enable-method = "psci";
>>> +               };
>>> +       };
>>> +
>>> +       timer {
>>> +               compatible = "arm,armv8-timer";
>>> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +       };
>> cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
>>> +
>>> +       psci {
>>> +               compatible = "arm,psci-1.0";
>>> +               method = "smc";
>>> +       };
>>> +
>>> +       sm: secure-monitor {
>>> +               compatible = "amlogic,meson-gxbb-sm";
>>> +       };
>>> +
>>> +       soc {
>>> +               compatible = "simple-bus";
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               ranges;
>>> +
>>> +               gic: interrupt-controller@fff01000 {
>>> +                       compatible = "arm,gic-400";
>>> +                       #interrupt-cells = <3>;
>>> +                       #address-cells = <0>;
>>> +                       interrupt-controller;
>>> +                       reg = <0x0 0xfff01000 0 0x1000>,
>>> +                             <0x0 0xfff02000 0 0x0100>;
>>> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> cpu number is 8, not 4, need use GIC_CPU_MASK_SIMPLE(8)
> OK
> 
>>> +               };
>>> +
>>> +               apb4: bus@fe000000 {
>>> +                       compatible = "simple-bus";
>>> +                       reg = <0x0 0xfe000000 0x0 0x480000>;
>>> +                       #address-cells = <2>;
>>> +                       #size-cells = <2>;
>>> +                       ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>> +
>>> +                       uart_A: serial@78000 {
>> use lowercase, "uart_a"
> 
> OK
>>> +                               compatible = "amlogic,t7-uart",
>>> +                                            "amlogic,meson-s4-uart";
>>> +                               reg = <0x0 0x78000 0x0 0x18>;
>>> +                               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>>> +                               status = "disabled";
>>> +                               clocks = <&xtal>, <&xtal>, <&xtal>
>> "xtal" why defined in  amlogic-t7-a311d2-khadas-vim4.dts files
> 
> The 24MHz clock is a crystal in VIm4 schematic, so its something the
> board did to provide that clock.
> Other boards using a311d2 could provide that clock in a different way.
> Or are you saying that this clock is mandatory at boot time, and all
> boards using this chip will have the same crystal?
> 

The board must use crystal, different boards maybe use different
frequency. DTSI file be included by other DTS or DTSI files.
It is strange that DTSI file reference DTS file's  property .
The property "xtal" can  be defined in DTSI file, DTS file can Change 
the "frequency" if necessary, like other property.

>>> +                               clock-names = "xtal", "pclk", "baud";
>>> +                       };
>>> +               };
>>> +
>>> +       };
>>> +};
>>> --
>>> 2.41.0
>>>

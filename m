Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D932742126
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjF2Hir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:38:47 -0400
Received: from mail-sgaapc01on2124.outbound.protection.outlook.com ([40.107.215.124]:38848
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232403AbjF2HhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:37:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa9fscREPK8W3I0ONeGc/Xcc0FjFUp7Pt5NylH1eD5FFfvHCHzKeVcIQiYH2QdrP+CPs7gdG/dhEj6YhIRzIjQuxMZPet7JqyXJWOBG6xPJwrE4pxtCp6dgwEotzGMUuxRQInveZopz6euaG63D79R2nh2bt7uw1B2kNjByj5iHHhfhMPUsakGDl8D9zUAVECG+haKwEeN17jBtUrCaM2Xry3xm+DnvUtNP4JtfWF1M+m0IczfdXKjtqMZHvTF1K0XE1Q2JoX5fRrrR4KmB4CqPlL0L+c3nQa6pjkz5cECiupwPbl0c8HwWvZx9+PpNWLZod4HkdZRcIG2+iS8Nlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUc8AlZQJWuCcK9tWQdI3hEIDrmwuMhGyYmDGN9V9QQ=;
 b=DJ+phGvJWmdW/3iTgaunkvvl6BaWrJ3cWsGD7KMbLKd+uEfTaxsPp4NxyjxH282+n+6om4owPC4O75gI+5NBk36JeEcS2eVagRoQRq+XQuj1uOISQ0zmQUe2ExgQC8lwiqOuBblVvWWH52mwUl9+lWc0Ly9DZnDmlFoXAOGyxwCt1rmVdMCRXgJ7eYwOaWyTLpDFZ/YWT6lF7WB4B/qWoh5DLOcRkYemHPtp1T5L7kUTgcBKqaaL0u5I9UJqp3ksDlPYwPrtLto/8QRF1KQniR5XdfTWHn2X2VBJaHTD5c7xHnatp4jTAS4AecAL3hcGntbSdf2MYkmG2LD0QZOW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUc8AlZQJWuCcK9tWQdI3hEIDrmwuMhGyYmDGN9V9QQ=;
 b=IxEbPljj36NQW1RO7QN2LZZnGBu9+6/cSFS1nZoATqLW9CJLz6D+TGiG7DqK4Gko/Y8dWq5OAIYU+YpSwfoNdr3FYxmnRlyl3+0aINMnLj+IUV0PRTJJKv8lb35WlvJ9VGso3mccTfC+DuO8h6U0YDRvISapq0GTjEuGMgv9SPSs5flb4ktWcXm0sINrOSzE+uXnIxnX5nsXcirss1gkaLgIrJ9hlfmcE5RTcmAKBSKTM+EXE34KhrLrqXcenDnMt9F7xth2JEsfhLtDihVmFs5WtMHZClwnEnUZKugRbJE8BATRXigtvSQwVIjultXPdDeGqBPIXWwtFST7RQhpYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PSAPR03MB5384.apcprd03.prod.outlook.com (2603:1096:301:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 07:36:09 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 07:36:08 +0000
Message-ID: <0dd16ca1-9377-30e4-3f5f-3ce96d9db1c6@amlogic.com>
Date:   Thu, 29 Jun 2023 15:36:03 +0800
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
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PSAPR03MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0b43dd-e92e-429f-a96a-08db78738100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rfTeVdkIrdWH04JAT+4XM0Np8CZkv59drF/r5kYCC4RJmHDzWc6N5TWdxI7D9+qUoU0NjZdE7TUx2AV/2++9dI3n7NiAb/bRHSyzvMAhcKhG3fqvn/fsRbuyu++RcVuNtCKbiZ9Rsi1PUvEF0Rin21AphbtCoqY0FmnG3J/O+p7dBcjZTOa5kIiXqbGcPcSN6Q9a/xXCkJjOseLQkJXxWDZoPJ+rM4tWBPY6xKMRAUpzxnIb6AnRacSklPGISrz4m7D+Cx3ZWkWAk0TInWtQB9nlOarAZTO0BY8i2YuKPyzylwFo4LhxSF1I9+hUHmYSjwWTGFNakP2n0xBPSHBgKEnQQYLmHV+7tnkUtvZ91lWqQ5K7Yc32jJm1r54RBRudWVYOxo0Ro3Cq7O0KWHaFZ/tLTmhSgvDJL/3RloMT5efJb4kAPBHBf4gMfrtMqN8+XswCGpGj3JSrevcHcKldCR0X0qmnW6/i/xIDbSm+oaVvLQ1ORySYWKKCGfbJt/vUxI8r7f3r28TouGZQiSn2RNpg/5XQkYOu+JTQF23vOYmm3WUVyccIQl3qpN0TU73jLhnpB6S98dh/IFjRKB4+CjN5MhMywtFydAuBg6m3mwIwaTYiGIRbzJSGCdxgX0NPVtSIKISPzMqpjxLn4050/ANL5vcdJk9GGAVyGJ+z51QyoV1uIMjvdhYJC3rxq3OwecCiK9lI3g5ZCnS3Kx2/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(451199021)(31686004)(26005)(53546011)(36756003)(6916009)(44832011)(5660300002)(7416002)(8936002)(66946007)(66556008)(4326008)(66476007)(41300700001)(86362001)(31696002)(316002)(38100700002)(8676002)(6486002)(186003)(478600001)(6506007)(6512007)(54906003)(2906002)(83380400001)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2F4akcweHphcnV5b1FCaE84TlNoS0JFOVFNWnl1OWthSjZKTzg3TmpSenpQ?=
 =?utf-8?B?NzByeG13STZDZ1FWamNrYndENXZpcVM2R1hhK29XV09MN0x5SFM1c2tMQlRY?=
 =?utf-8?B?em1ZVENBMkdjTVJyMGFkckw3b3prZi9leFk0UTBtTlY4ZURITCtzU1Freitk?=
 =?utf-8?B?TS9pRFFTM2trOGVoSnR6QnpxR1pVUlMrTEMzNDA0d1J0YVlsQTZPWGQ1bG1w?=
 =?utf-8?B?WDl6RlphSE04c25NcHU4ZjFqQnJDM0E2bW9RSnpmOExaRmZvZFBYMXNONzBM?=
 =?utf-8?B?cXcxREtjUnJLQ05IL0cxdVRmVndPSnN4TVdHRnQzZyttaTZkclZkaXNaYXlj?=
 =?utf-8?B?WU5aTjhSMzVvRmsvcmthY1VPa2FXZjlrWjByV0pzTmFjMmw4VlplbFd1MlRy?=
 =?utf-8?B?Q2dlU2I0SnNQWFQ5YWkvclpLc2ZsUGdoaFZUbWplMmgvNUZ1d2NEUERGZlJM?=
 =?utf-8?B?NXVGNC9SS2RLZEhOaTlhTnE2STNzNHZXampwUTNTS1R6SG8yaisvYVphdTVK?=
 =?utf-8?B?L3Nqd055WUdpcG16QkJvNi92eVZHeFJBQ081enRhd0cvWk9PcVlxMCt2bjFo?=
 =?utf-8?B?VnFPSkpoUGN3cnd1aWUxK3RNWlh4eU1MTTZLbTR6M1lDdjJ1U3NTRGRZbmox?=
 =?utf-8?B?cGtDS3huTFRseUpLTzRVWjhOWVpDd3gzbjZRV1lBKzdJVkxPaDRaUkd3bUxM?=
 =?utf-8?B?NVdjY1M5RnhnVnh5d2hnekhuZlYvQ3ByQ2FCUTFUTHdXZWp2OTQ3bGc0S1VB?=
 =?utf-8?B?VFVVUTVSSENGc01SWW90M2k2eFljTzdnZTlhT3VQWU9IM0d1bXR0MlpOa1l1?=
 =?utf-8?B?alpHZXVZWnRLTHE1QUdmVDF0bEhocGxPNzVVN1ZvWUtPVzgzY0VPMGZWUDQw?=
 =?utf-8?B?OEJMZldsd2tsYlhnOU1lZ29Cckh5T2NQNFF1empBb3I4NW4vbTJGYVlCalZK?=
 =?utf-8?B?dkVzank1OG1hZ0VxZUhVeE4xZ2NQRHNBK21JNE1aYk9kc3NuTHpBK2plQzJQ?=
 =?utf-8?B?RkdsTzhKTGd6VU9ET0IrK0gvSXQ2Zm1GM2I0WmxKZURsaUtLWXVVUE8yUFZN?=
 =?utf-8?B?d2VZSWpST09Rb2hZYVRLZlBacGlyRFRGWUhtK2IvOCtwaFE4NEJTNHNzcW5h?=
 =?utf-8?B?eTlORVhJSlF2NWhqVjR0Z0xxQ1I2ampFUVd3c1pJZmZlZm9KTE92a2gxTlRE?=
 =?utf-8?B?Z0ZYRisvVFFNYjFUMUtGbjlyTTY0Z0VPWlVJeEdYcXZ4cGs1UnlVZm1ZU0FZ?=
 =?utf-8?B?MlZQeXFrcWU4dVR1bEk4UWsrRzcrNlRxcTN0dkZocWdBeExIUmc2TVhiKzBH?=
 =?utf-8?B?dld1RUthbHlPNkJ0aXVaL3hLSHg5cjlkN05jOVBmbWtMRENYd3NiWE5iNlRQ?=
 =?utf-8?B?aVAwK2xrYVZIZXFVSmttUmk0R0RONVBlZjdlb0doWGJpeHhYMXNXUTRhTHds?=
 =?utf-8?B?VVlJM2ZBb3N1WlM0MVdTaWpmeWtOTUNPT3Jpbi9MaExzb0RKcnJyMTkydngz?=
 =?utf-8?B?RDZKbDloZnRzQ1hEVWN5NUZabU5YaUQvd2tFdUY5L1pVa3Mxbmh6SEVic3Bp?=
 =?utf-8?B?VnVEMzY5bXNqakphd1BDUjdEbzZRM3pGVXhOUVVabzhxdTI2K1ZXVVR0OUZC?=
 =?utf-8?B?L1dSbUtWNlZNUmh4M3pKQXFYZWh4SUMxdHZRcWEwU1lycjEwM3ppR3YyNTFE?=
 =?utf-8?B?dlBOV2syaFJwZDgrdDBtRU0wNXA5ZDhEL2ZUWDZoeGF4LzFSNTVvU0xyMlg2?=
 =?utf-8?B?a05Ta1Y1MEk4NlFzSUNKd0JHZlA3alQ3T0Q2ODgxY0xFN3AwMGlCVExESXpL?=
 =?utf-8?B?cCtQd1YxTHprNllISVlSdVF3NDdNbmtZUGk3NmlRK0J0RVBsZ25DYW4remYx?=
 =?utf-8?B?MGlVN0xvZEpEbzBUMGpybUhYUU9NWkRoUHdNQ0drRWRJNmR4UU1ZeFVtZjBm?=
 =?utf-8?B?UDUwSld5eEI4S3VhN1NSMWI5Wll0L2ZIUGN5RWpWZTk2UXdiVEJhdmVTNHB0?=
 =?utf-8?B?aEdIZEYwSVhzQTZiZGwvZnFENm43ZWtIRVd5bHJmL2wrN1VYVStiT1BQcnQr?=
 =?utf-8?B?Mm9PdklrdzQrR3REMGt0UE5mT0xYU09hTHE1R1YwaDM4ZTBsbjl0MTZiZXdQ?=
 =?utf-8?B?THdQL0Z4dlptSWVMZVVXQXZjMGhVbE8zakVmWU5HMzlnNUxRRGFwL3RYVjE2?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0b43dd-e92e-429f-a96a-08db78738100
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 07:36:08.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCFcY7S08kbE5/kHVxmkv3DXYJTW5bQ7HWAzizQE4dkmQrJ1/Hg7VDfWg0wD/MDu7aDp/Kcgyn/+0VGU1xjvGSGXDlyyPWHP3xAMb/j4aXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5384
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
> boards using this chip will have the same crystal?The board must use crystal, different boards maybe use different 
frequency. DTSI file be included by other DTS or DTSI files.
It is strange that DTSI file reference DTS file's  property .
The property "xtal" can  be defined in DTSI file, DTS file can Change 
the "frequency" if necessary, like other property.
> 
>>> +                               clock-names = "xtal", "pclk", "baud";
>>> +                       };
>>> +               };
>>> +
>>> +       };
>>> +};
>>> --
>>> 2.41.0
>>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79574672A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGDCKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDCKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:10:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF0E59;
        Mon,  3 Jul 2023 19:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwATscuqMuIbF6LvXNUZwjphY/Ivu7RuOdeKemSm5rCXKzm3Y8WaiuhrrsP/gUhS2ffAV1piRl3CtOtiZryImV/zLAEpbmXHfJcl/yPx3C/bjvQ5GWZvZRVzn3JAuVgIqhAULV6xzGhmpGTDoxsoSQP9Bxid2+OadwEdd7dRZ2mbQYMXmvsHInM6o5emE86cMCdAVL5V/+2Ec8xsuNOUE9YrX51ZTwmxv4uWcKB7WNeIpkesU1v3PctQAFbtt7rUzlHlWrbQwoxrktCROUzuyud3wsgNpAht4y8OQRSxf9AAOgvGclJwjVa65Sjj97jLNHGSjnODhTdNwBQJqhO+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGApEb4F+KdWzd5bUvff8VKWVM5Wd9pOa9PmtRhBTu4=;
 b=lcaFSwWm1CrlH80gpSZSEy8zC6Dqg52f6XcGNEFrfUr5XBBt2UETjLOr0NaafSHRGgzh0PUrX1+yQpUaTVIfHrrvMuoba/E+WUIA/fmrxngGQenluzoQJQFZCY6WIHZXw92ckKj/p1tPdp4ROv8ZwqSCUL5ep1nYAlG5iT8RHoWlohrUrwsHX9ki4kVDkKxcFKpcvfE8fjfjiICPkJEb8H2BBAaIOu1OBQueTI16HaAHiq/8maOMgddjzSHGJoP3XbdSsQlCrsRsGOYDVioV5rVJVPw9n0ref9Dkrpdi8Bl7jVAAcJcou5caC/FC21kiX6aSy3TZlafFAKw0QtbpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGApEb4F+KdWzd5bUvff8VKWVM5Wd9pOa9PmtRhBTu4=;
 b=KcbtfidQbP+DUHvNH23KTljnzM6LPOmRYkP/YUgkdDaiUFIMUoEamOIzHQA6t8Orsr8elzmdpvZCjfnuhgmiDXdp9InB3dcnw0VTQCum3e++NkgcSKIqOZKs5KoEEyMf8Fs2ZW/k1a8pw+gKNmgqTpZkPqBYWuNip7W9J6Wjld6zShsZdfq8z7yapgkLyenwTtNSH/RFL2q4Y/afcX1KZ1SkSSFceD/B6WoCOWqTV4Iq0YPe25iEa64UG/Gh5veTFDy4WD47llc+gW78EG0wwigxG5UEQJXvP+h7UoXhxpnYByEvI/GOZTEC38xgVUCf5h9BFbfOzvKVob7YL8eezg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB5863.apcprd03.prod.outlook.com (2603:1096:820:80::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:10:07 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::c478:28ff:9d91:61f5%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:10:07 +0000
Message-ID: <4ac15ef9-8b75-c429-5de0-9739f971061d@amlogic.com>
Date:   Tue, 4 Jul 2023 10:09:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic C3 power domains
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-2-xianwei.zhao@amlogic.com>
 <d1cfb1fb-d347-16d8-4446-dddcf8200638@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <d1cfb1fb-d347-16d8-4446-dddcf8200638@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efbdf13-ace5-4df5-924b-08db7c33c8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ/sCd34XqzgKeqHVC56P0YnMsoIIfBh90sH1AGMIoNRX9GiymLNrBQbYNLfdiJsi1Q0tZ1fY/HP9A6FhyApQc96m/xWSi40mmgKGuUTqTDxlgl9cNktINDUXMstvzS7nzOO3s10TNbPo0irUofaolwldaQlTNbMcuhaJw1pcjad2WGL4cc8VnV6Lk2g5qyZS7xPj9TWFQfYevDYHFJCoXCRi6UVNHVX5jCuV06RSPiiBZyg+0UWQDWUe1Lm+YB9zk0EzofoeKIEKV6enE0ra5CvHGMPhiCmhDvmXnxip/wNdqaYRg6Z5FW4eUCE3/e32+IONEsolOTz+OUB0fx4iSz1MzUQxGPlA0eSPo5Dl6TS53lullOySDsTk7qFNKTjFhlLuP39Tr3RfM9UVYRwk7BfEitamP0vq65FS6dvJhDRTf8eQzGAxngaLzXWUBwnDnLMCSuFXF3anez+kSihUhTcSrR0+u3oSjWiOGc5M8sOzNRpcLeGqLIuyzBNn7jC9lold9k10vPIwVQNF6Bb3Drfhr+WDPABJZB+MJY2UqzYzvrA4GbN9wrnyzy9H1PQpPWbHCP4nij3cg5yV48zrPsUPOLUhpyFyy4Y2Vuj2NTanfikghTMtuEkC8ZjWWIJ7VylZh5DgQnGlGf8lhi7a3+gni5JsPKPfHL4D3lXe0aehxke6tamqsvWgwcQRwRya61ZBIbL1BXRGkKRZY9axA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(451199021)(316002)(41300700001)(6512007)(6486002)(83380400001)(53546011)(26005)(31686004)(6506007)(2616005)(186003)(478600001)(6666004)(54906003)(38100700002)(44832011)(66946007)(66476007)(66556008)(4326008)(5660300002)(7416002)(86362001)(31696002)(36756003)(8676002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUw4NWlWRGFudGR5UmFZa2ZRZ0ZQR1U3VWxtbXBVaFZueFRsL21ObDFKUTY5?=
 =?utf-8?B?dENqNG5zeW1oYm9lTUdLY1NnMnlZMitqR2JxK0lLdUIydUd0R05Rcm9yb044?=
 =?utf-8?B?bHcxZC9RRXp2K2tSa1VTYXY0dGpQZ3ZUemhIMjFRNzAra3NzaGtPQ2dMblk4?=
 =?utf-8?B?eDM1MVlyNHJQUjZZbUEyMEdJOVB4dXhsblZaQzliakVCb2kwb0tzZTV0WFph?=
 =?utf-8?B?bWkwQjdLTnZrZHF0N2w4Vk9leFdvdFFOcXJrSHpiQWpQbW5tNmxjcFp3bFRS?=
 =?utf-8?B?L3FwRkRTbEUvSXJUR0EyN21SUERyUlc3NXdRRE5vMFBXd3c2VmN4MGFuUHEw?=
 =?utf-8?B?NlVjVndWL2F2TTNsc1BmNWU3cWF5eks3TWlPSXZUbCtIbkFwUjRXNFg3bGZD?=
 =?utf-8?B?ZlpTRjdaUVpseEI4bUtMVWc3YXd1M2pwbTB4R2tOUWNERUVkU1lVcE85NUNL?=
 =?utf-8?B?cVFxZC9Mbmo2cDZSaTZPZkdsSHJCSmNsQ3o3R1NIWjBSKzU2dGF1QVpjZGg0?=
 =?utf-8?B?RUVpdDB0QTJMZHd6alRpZk4yTmYxb0dMaS9tRStCTTZnSFBJbHhXQmVFaVhB?=
 =?utf-8?B?Mmd5aVBZSlQwQzdNUElhdEYvWUhoUktVQ2VYQ2E5b1VUWmRXUEptMFlQU2Q5?=
 =?utf-8?B?Rm5ML3c3Z2l5OTVsS0JTTm9wWnNVNGcyLzRmOTlsc1FwYytZN2pmSmtIWUhx?=
 =?utf-8?B?T3g3RUd1ejI1cGpuQndObTdKMjZTR0l3MHJsL1lkcGpVbWloTmI3QkJBNlBT?=
 =?utf-8?B?Y0VPV0lWakJQNXhRWm5MUzFFOWNXcmxYbTZxZ1hWRzhQMDNLc3RQczdkUjBG?=
 =?utf-8?B?eHV1YW42SEd3dzhqcjduajFKMXh5anZDVHdSWjllK3RtREdUMEp4QkU0b2hR?=
 =?utf-8?B?cUlPMnF0TnRhOEVVUi9VTnUwZW0ycmtMRWpjSXdDSW8vcUdHUTQ3Ymdmb0t4?=
 =?utf-8?B?RTRSRHQzVUlrQWtsZDlMM2lsNTZDZlpnZmNwR2NPeXZGd2QyNWNjQmUyNzlJ?=
 =?utf-8?B?NVA0eTcyc0U3Qm9yVVBTU2ZlRGhuUWtqYlRxR1Bab2ZaSFlhZm5VSHZzeTlj?=
 =?utf-8?B?aEtWUHhXWU03VDVVdWZaWTkwQnhKSXhzR3pRUnNheUlpZmFDZHhQM29FVjJi?=
 =?utf-8?B?b2hreW93VU1Ya2phWXExWVhzK2Y2azhIdmpLYThEYTIwdncyeHByWkNPOFJs?=
 =?utf-8?B?TzcrdXZxL0UvcGU2Y1R3SzZBWkRRRk9LWnVPYXRPUnUvR3p4NlM0STlIQ1Q2?=
 =?utf-8?B?NmthUGFqV0pnNnJwYnVHUDRNVnBPSFc1bkwwLzdKRXBNcGxPUGl6d1lTakNM?=
 =?utf-8?B?UkNjZXVvRHVSUURsZlhwQU1XVzNWUmhCdndZcVcwdVN4ZFRaYjJvWE5STU8z?=
 =?utf-8?B?a0RCVlMzcXp5bEthYkNHakI4VEV4bGwwSEdUVXN6Sk1FL3BFQThVM0ZiNXNF?=
 =?utf-8?B?ZUxxc3R2TlJNVnJxR1BuckFvNFpTVmlSQmpMbnRKMFRSa2ZSc2xad0lnanU3?=
 =?utf-8?B?R0NzSjQydnZQclp4VjZmK01iYk1LYjZDVktoZWJXR0Y5SmRhY3NKVURqUGRR?=
 =?utf-8?B?NEEzdHptaE5kcjJ2RGhyYVRlRG1xeWJWNHVSaHIwNEhINW0zN0d3MmRIamRB?=
 =?utf-8?B?eVVQd3B0WkVWcmZOS2JyVUpockZpOUZQMnJHZjk4Y0d1RS95TGxRN0htdVVR?=
 =?utf-8?B?SjE1V2dqTldIR3owS3VwNzZ5T2U0QUh1ZllPb0tRaXZUS2d5QWthMWg0M250?=
 =?utf-8?B?MVdxRDg0Nkh4THNNSFFHMjkwZldnMm9GbVNySy9Db3ZwV1FRY1NJZkhjU1J5?=
 =?utf-8?B?ZEcwOU1DRHRNYlY2cko2TE5TK1lRT0IvL2JHSG9lQWl0SlFjZWRiSWxwMUpo?=
 =?utf-8?B?Z0liQkdBL3cvNVRyK1NlNGE3ZHArcW9jQ1pBRU9jNjNNam9EQjJUWnQ5MFd2?=
 =?utf-8?B?RVVhbFI0eGxQMHN4NCtpWEZmd3psbFhKQ05kYlJaZXBpdCt6eTZUMU5hK1lz?=
 =?utf-8?B?Tmd0RytueElSTEszbkJhQng2YnV5MmJwNVQvQjNWcFQwQWx0eW82VE9sYzUw?=
 =?utf-8?B?V2x5RnJuMFltQ0RZbk1DcS81OGt3dnI2RkIzbXRpZSt3RExlRngwOHJrVHdV?=
 =?utf-8?B?KzYraUZBUmdTZ0xmMnprbmxGc1lCbUFJaXU0dmQ2WkJKTFI5N2ZYNUVsVWJi?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efbdf13-ace5-4df5-924b-08db7c33c8dc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:10:06.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1Zm/wj9Zcmi1mjj/RRFWvE2NawT9xGWinnFKdx2rtJ3iqRe3XQsGbdl+3089dBOHfHcxwLbm5kJncB6ysKvc1967Y3QwcmqQ3WFdODvXnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5863
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof,
    Thanks for your reply.

On 2023/7/3 21:12, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 03/07/2023 11:31, =Xianwei Zhao wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add devicetree binding document and related header file for Amlogic C3 secure power domains.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
>>   include/dt-bindings/power/amlogic-c3-power.h  | 26 +++++++++++++++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>   create mode 100644 include/dt-bindings/power/amlogic-c3-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> index eab21bb2050a..d80bbedfe3aa 100644
>> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> @@ -12,7 +12,7 @@ maintainers:
>>     - Jianxin Pan <jianxin.pan@amlogic.com>
>>
>>   description: |+
>> -  Secure Power Domains used in Meson A1/C1/S4 SoCs, and should be the child node
>> +  Secure Power Domains used in Meson A1/C1/S4 & C3 SoCs, and should be the child node
>>     of secure-monitor.
>>
>>   properties:
>> @@ -20,6 +20,7 @@ properties:
>>       enum:
>>         - amlogic,meson-a1-pwrc
>>         - amlogic,meson-s4-pwrc
>> +      - amlogic,c3-pwrc
>>
>>     "#power-domain-cells":
>>       const: 1
>> diff --git a/include/dt-bindings/power/amlogic-c3-power.h b/include/dt-bindings/power/amlogic-c3-power.h
>> new file mode 100644
>> index 000000000000..3403e7c0b49d
>> --- /dev/null
>> +++ b/include/dt-bindings/power/amlogic-c3-power.h
> 
> Filename matching compatibles, please.
Will do.
> 
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>> +/*
>> + * Copyright (c) 2023 Amlogic, Inc.
>> + * Author: hongyu chen1 <hongyu.chen1@amlogic.com>
>> + */
>> +#ifndef _DT_BINDINGS_AMLOGIC_C3_POWER_H
>> +#define _DT_BINDINGS_AMLOGIC_C3_POWER_H
>> +
>> +#define PWRC_C3_NNA_ID                               0
>> +#define PWRC_C3_AUDIO_ID                     1
>> +#define PWRC_C3_RESV_SEC_ID                  2
>> +#define PWRC_C3_SDIOA_ID                     3
>> +#define PWRC_C3_EMMC_ID                              4
>> +#define PWRC_C3_USB_COMB_ID                  5
>> +#define PWRC_C3_SDCARD_ID                    6
>> +#define PWRC_C3_ETH_ID                               7
>> +#define PWRC_C3_RESV0_ID                     8
>> +#define PWRC_C3_GE2D_ID                              9
>> +#define PWRC_C3_CVE_ID                               10
>> +#define PWRC_C3_GDC_WRAP_ID                  11
>> +#define PWRC_C3_ISP_TOP_ID                   12
>> +#define PWRC_C3_MIPI_ISP_WRAP_ID             13
>> +#define PWRC_C3_VCODEC_ID                    14
>> +
>> +#endif
>> +
> 
> No need for stray blank line.
Will do.
> 
> Best regards,
> Krzysztof
> 

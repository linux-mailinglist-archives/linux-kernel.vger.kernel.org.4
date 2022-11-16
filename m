Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0662C9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiKPUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiKPUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:12:03 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF9663E0;
        Wed, 16 Nov 2022 12:12:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEkd9om7MNc6tXXKmQJc7WKBK5SnCrgvE0E3FK3WOxzDbx8Q2Sz/hBvxgmnsSeoIc0dizt7HRhHx6H8HPGWli0iTEraYGsy8QZa6rfzrM59OAsA5VHpkVdeDoR5No+OBbJaOn3aNK3BV7cUazAXdayUlZxy3N/dtntJckVLoinQX8yBLKLKc2FurPIxAjakxKRBBX8ohmJPt7AzDjdokBy+wcsbCY5rCfIuViJ8CEjDiEBGzPILXxwr6dlX4NaMQZVryGgwvGQac4Ik64YbS7rprIKpgS6RsbAZXWN3ieT+JflLQnzQJGR8xR+DgBZjs3ccgBcb7YgtzjAmXNPL8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9YQLN1+lgzDqrbL8nYsvundqkklG4eFEt0/Vbpu5xA=;
 b=aTEpbsEL5Q8pds61xLnKBZpSDeSSIeQZBANVN9y9lNulypudcTO7DPGTGraRFqdwJWEVkGXshlVs5Vpsyhpj+KOwoBhwTFCtqqMF1szuBkXEkHArXPSJ5Ux8exBmSO0ysGeDZbCcwzuSS4gAYVuBuPx9GFmXCh9TOnT3f0dfRMa2kanf01ehQ3daQOnguDPl/aVS4jNANmX9g9ahUATUsOFn9XjOzv5EYs1w2tKmBt7LC3YjKMU/+Q0v4Ngcq9yDnCpwV8KQ+56sGvogiud0QeQotedDJZNyDQx1GxwAQMQFR/M9FAoZ4zL2GiaQdDcEtn0D06F/YjUG4bKd3StroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9YQLN1+lgzDqrbL8nYsvundqkklG4eFEt0/Vbpu5xA=;
 b=XuwebUPazbunLLYRWCk+46hmFrKsCp1WToZIIBQdZUULYh9cu3u8REmJYexbytUu3zrELvsa51sAwx2Cs5W2aUPgwc4Q2ZObyferAJkyx7jX+bD9C9bRzdRl3rsgtOFhPqGtKXaZ4OlwCSZIUbfm2+413nkxDpDSlbfgnDkdGO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSBPR01MB3894.jpnprd01.prod.outlook.com (2603:1096:604:46::23)
 by TYWPR01MB8574.jpnprd01.prod.outlook.com (2603:1096:400:170::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 20:11:59 +0000
Received: from OSBPR01MB3894.jpnprd01.prod.outlook.com
 ([fe80::9a71:4e29:fdb4:b73b]) by OSBPR01MB3894.jpnprd01.prod.outlook.com
 ([fe80::9a71:4e29:fdb4:b73b%6]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 20:11:57 +0000
Message-ID: <9231404a-85b2-9a9f-f040-f97615bf8ec0@renesas.com>
Date:   Wed, 16 Nov 2022 13:11:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com>
 <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
Content-Language: en-US
From:   Alex Helms <alexander.helms.jy@renesas.com>
In-Reply-To: <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To OSBPR01MB3894.jpnprd01.prod.outlook.com
 (2603:1096:604:46::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB3894:EE_|TYWPR01MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 599f08cd-57aa-4330-f615-08dac80ecfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9t8/8lwEoeHYTOq1mAklcwZUFhOK+itoBoIO5UzoNAv5W37g3+iEa3M0yUDOyluvHlODCjSuqjrxfzjKi54LvABjFto61sv//Ts8ZRLceCQCAPmr+dHJpSAeePdah2pcHDGzmPst1fcWuk+sYBTEYDSblbRTpJ57BmIVk+n72xNNLlLeNxdf6c7ymfdSQZ5o/a2p3VoDSFPHc05zAuQ8dY+H0/egKUXZ3pvDImpO9Yk7N89Bwn0EgN7cbeUQgqYHunxEqhffzeDnhgjpCop47+dryYFDwV+PlZU2v+9jZ9lAp64av5NlUVcjm2ajdTI0u3tTOF672ZKOddkUrw7lGA+FJZvH9w7TpDqvGMDZuN0jMtM/jW5Eca8nPiaAvlMhNfdpwE0uq3uR1smEm3GM4SQSZPvrk8jXCKEIByL97Rm+2XBEsLWWk5xtCaQNnNEER258MZbVJGJtmnrqY4euiJ5jDvAEYUnH7TzMjXLSOr5EiUNRsx/V26E/csbh0TCmnjh1569AkP15/U8Cpa1864d8etwMZKMOlp7wH0IxF/V7laeBEmWaxMpgh8HJeGo4yRYhbzqp2/x6K8gLMMSFGfdh6Vqlg3Ct0B8xUfw2oqeR/KJj3zib1DIFBxamcYPLFD2BxpD29KnKzHsppy/sDUCey3JjUg+vxXzZ3KYYWWK4mhQ49c0mlIMX6SYNYgX9YxG6Qu3+TCAS8t8LJftWdiVgcGZIZarzAHfgRJm6AWv0jy53gqufAhRkOI7tHUifu1GWrljIX5JtlcJ1Wt+ttW+ITCopD4dTD4Io424+izg+BcUhE5kDyubikyHr8swE4LUaKDCl7RNySxeLqpQPhY9m4QtcJ1qG2alULBZK9jPx3d757gCeW4ApL/EMABTjeEDWUZ0UY2nhQZIhSMsGzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3894.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(53546011)(52116002)(2616005)(186003)(26005)(38350700002)(6512007)(83380400001)(38100700002)(5660300002)(2906002)(6486002)(966005)(45080400002)(6666004)(478600001)(8936002)(4326008)(8676002)(41300700001)(66556008)(316002)(66946007)(66476007)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1XS3BvK01BMFlBSG14eXpCaUNBQTRmMDZFWjJaN1NrRFlVSzdXckVyaEF3?=
 =?utf-8?B?ZHRzVlNBVGV0WUVlWDZHUUYwK1ptNk01MzUyVlNYQ1E4V1pqazc5elVCWTFn?=
 =?utf-8?B?YzhDMGp2VXh5b1JhQ0d5bCsyTE5mMFFoMk8rWU45WXlOOHFzQ3FpcmtoNkxL?=
 =?utf-8?B?Y2d0U2VtSWNwOW5yQWd3TytzT2dCN2IyOERMdFh1TzN2eHdHNWk5NFZXMXlP?=
 =?utf-8?B?YjNDdTBoRUFFaHRxK1dMYU9ZblZZbDZpVkVRZmprbWFiemsyYnIxQVlxeDZG?=
 =?utf-8?B?aWdpWjdrTHRBaW4ySWhueTZOYmh6LytNdldBYnl5VkJGTENtQktDRW1XMFFz?=
 =?utf-8?B?R3d5dnlWQjEwR0NJMm9Zdlk4ekJyalZqU1dUSWF6VGJxKzhZbXFnVDFFbjdN?=
 =?utf-8?B?OXYzTzd3U2kxUnJVaWEwSHl1b2lJRWUrSGFkcEt1N01HSWoxTWF6Nk12RjVF?=
 =?utf-8?B?NmFHSGhUNUlKUVg3WkRyZDBhK1JPMHp6SG16Rk5xLzQ2L2dmUFVSc0xqaUlB?=
 =?utf-8?B?QnNKQUFaMFpjZk5RclRPbllYaDJLTDNuNE9pV0hIZTF0elFIeDlERHYvMVB3?=
 =?utf-8?B?T1N1cDZ5SW02TERyYjFsNjk4WmE3T1BaMUdkOUdxOTdJRDVYTDVaN2dWVlhw?=
 =?utf-8?B?V3g5WUwrM0dDV0FYZGpTaitsczRzZ3Rjb25CYnp0WjdBNHRHR3dBVlVMcWZ5?=
 =?utf-8?B?eFdPV09QOHdCKzRsUS9HQVA2SWRXbU4raU1sVUdnODVXamZDRm9qM0lEMmJy?=
 =?utf-8?B?QmFZVzJQZmhOeElYckcyZm9RQmxFZ1pScWZLM2tIVU8rQzJIMUdXbVlPV1kz?=
 =?utf-8?B?cThucWtUNFBwaERwbGU2a0lvUFJMU2tVNTJYejdYUERPQ0VMYXNxa3ptbEpW?=
 =?utf-8?B?Y2x4NjNiajdMVWtndlVBVkhmOGhSZmxhZ3IwekRMbDl3cTd4cy9ma0dBOVVn?=
 =?utf-8?B?MlQrOTVqN3pUL0R5MVptcjNoTWNsRTE4cXk0VFE0VE51bUFJSUIvek56cnh6?=
 =?utf-8?B?eVhScW5qYVBkeEpoaEd4RWIzOFV5L3RzMTBiSmtidlRZdE9CTkIyT1R4WnBZ?=
 =?utf-8?B?QjlpYUtHSVFKQnBZZ3BLR1dQeEpSZDlWMjZFNThsMGtWRkZacmQ1ZUQ0UFNJ?=
 =?utf-8?B?WU5Sdzh1c1pBVWxyL0FQanBDNzFqWTJmM1QyL0gzOXhpSjFLbHlXdGhmNXk0?=
 =?utf-8?B?aXFvM3EwWWZuTHc1cnVCR2xCbTYwdjd1aldqYWRyT1JNamhHdXNlcnFKQTA3?=
 =?utf-8?B?dlVvUFFiN21USjUvMnh6YmljTS9QeHdtZ2FObmgzMmJSSXBtMjFIdGhCV1Zt?=
 =?utf-8?B?ZE90Vmh1ZktUODVtU1hxZ0E1OHYvSnQyVjE3dmlRN1JaWFFhYk16Z01WN09x?=
 =?utf-8?B?K01BL3hvblZsR1ZhdjFCZm5Na2NPOG5Lbk52dlJDQlpnUmdrVHIrOUo0Nm9j?=
 =?utf-8?B?akVJNmtIZGNtRnd2NFE4V0s4WlR6Q3dIbkRKS3c3YnI2S05pSlh3V2hZVjZT?=
 =?utf-8?B?ZDFIcnIvZ2tyK2duVE5HZmlSVEtqditCOE8wamdReHVGSDAvRTFkOW1vVXFX?=
 =?utf-8?B?cjBBc3BQenNteFlUZFJtVnprOTdTYlB1R3MxUUlvR0hCNnY3L3lRTUcya3lj?=
 =?utf-8?B?ZXJFSVF1M2FrSldsVTJ5RkhraWt3Y0U1L1NMWFlZR0p0eXhJZEVXTmJZdUhw?=
 =?utf-8?B?NU1zNHRLM0dJVXh2NXpwNlIwaGJmQzdWa1BCU3laUDE5QnRYZGh2VDFBbmxX?=
 =?utf-8?B?dlJENTlXUTljQmhscFJ5eVd6MWgyNjJ4N1ZLbmN5ZEhOM3FUMnpmanQwVU5v?=
 =?utf-8?B?Q1RldGVGODVENG1MUUJ3UUliOGxkeTB5b0hubUdUeWoxeGQwRjZPZmlCQlRI?=
 =?utf-8?B?aTRwRXEzZVJ5MzMxZ3pUMGlSVjNUYmFSVjd6bHR2T2txSXkzM1luVjJIZHBB?=
 =?utf-8?B?QlJodnhyQVF5WkJVSnd4d2tySis1U1g4c3N5SGw2d0RtQVc5amJmcEhBei92?=
 =?utf-8?B?MEdqc3lSeHYwTHQ5cGFEV3g2YWQ0WENGSVFWUG1IRk0yNzdNUmRGdHYzVHFv?=
 =?utf-8?B?bGZBMmsxYmMrSWxKZk5CdGFpMno5RUhkaTlRdlA3bnhmNkpFd2NrM3VTNGJh?=
 =?utf-8?B?RndodUxmckRhekNXakxLOEQrd1R5a0pHNi9qMjlrTVBsbWpha2ZhV0xlcU5z?=
 =?utf-8?Q?TYb/0oJUo0Og8rdm9JQe9xQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599f08cd-57aa-4330-f615-08dac80ecfbe
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3894.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:11:57.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awGIrYYBzV2kmgoojklv7BhuUHi8l1g0xbbiMshV/FMtCfCwUuGJkXiSWXxpLx/yQydk2T/XR3xovAF2Njh9fhtUOhv9W9ksC0E3nemaI8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2022 1:20 AM, Krzysztof Kozlowski wrote:
> On 15/11/2022 20:26, Alex Helms wrote:
>> Add dt bindings for the Renesas PhiClock clock generator.
>>
> 
> Subject: drop second, redundant "bindings"
> 
>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>> ---
>>  .../bindings/clock/renesas,phiclock.yaml      | 81 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
>> new file mode 100644
>> index 000000000..2b36534d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
> 
> Filename based on compatible.
> 

As Geert mentioned in the other thread, this is a family of products but
the others cannot be added now.

>> @@ -0,0 +1,81 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Frenesas%2Cphiclock.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C9c13a32848f3434e217108dac7ab69f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041836281252737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=J6kNqua%2FJf0c8HczRM8gU8%2Fm%2BhX6gSF2fqnf2n3wSbI%3D&amp;reserved=0
>> +$schema: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C9c13a32848f3434e217108dac7ab69f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041836281252737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ofZbC2sBnTpJR3KKzPVqhsFy28r4JjbJpaVGSuHKx38%3D&amp;reserved=0
>> +
>> +title: Renesas PhiClock Clock Generator Device Tree Bindings
> 
> Drop "Device Tree Bindings"
> 
>> +
>> +maintainers:
>> +  - Alex Helms <alexander.helms.jy@renesas.com>
>> +
>> +description: |
>> +  The Renesas PhiClock is a programmable I2C clock generator that provides
>> +  1 reference output and 2 clock outputs.
>> +
>> +  The driver supports spread spectrum but only if all configurations use the
> 
> Driver as in Linux driver? Drop entire paragraph. Bindings are about
> hardware, not driver.
> 
>> +  same spread spectrum parameters. If your configuration uses spread spectrum,
>> +  you must include renesas,ss-amount-percent, renesas,ss-modulation-hz, and
>> +  renesas,ss-direction in the device tree.
>> +
>> +properties:
> 
> compatible goes always first. Start your schema from example-schema.yaml.
> 
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xin-clkin
> 
> Just "xin" or entirely drop.

The pin name on the datasheet is "xin-clkin" and as the name implies it
can be a crystal or clock input. If the name were different it could be
confusing.

> 
>> +
>> +  clocks:
>> +    const: 1
>> +
>> +  compatible:
>> +    enum:
>> +      - renesas,9fgv1006
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  renesas,ss-amount-percent:
>> +    description: Spread spectrum absolute amount as hundredths of a percent, e.g. 150 is 1.50%.
> 
> What? If this is percent then it cannot be hundreds of percent. Percent
> is percent. Use appropriate units.
> https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-units.yaml&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C9c13a32848f3434e217108dac7ab69f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041836281252737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=6MULpJhPyyjWSo1SvPCrz6KidE1VEtiiNYk1O5wS1vI%3D&amp;reserved=0
> 

Values like 0.5% or 2.5% must be representable which is why this
property is an integer of hundredths of percent. How else would you
represent a non-integer percent?

>> +    minimum: 0
>> +    maximum: 500
>> +
>> +  renesas,ss-modulation-hz:
>> +    description: Spread spectrum modulation rate in Hz
>> +    minimum: 30000
>> +    maximum: 63000
>> +
>> +  renesas,ss-direction:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Spread spectrum direction
>> +    enum: [ down, center ]
>> +
>> +required:
>> +  - clock-names
>> +  - '#clock-cells'
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ref25: ref25m {
>> +      compatible = "fixed-clock";
>> +      #clock-cells = <0>;
>> +      clock-frequency = <25000000>;
>> +    };
> 
> Drop, it's obvious, isn't it?
> 

I disagree, this may be obvious to someone familiar with how clocks in
the device tree works but not long ago it was entirely new to me and
examples like these in the dt schemas were very helpful in getting the
device up and running. There are several other bindings that define
external crystals and reference clocks in this way.

>> +
> 
> Best regards,
> Krzysztof
> 

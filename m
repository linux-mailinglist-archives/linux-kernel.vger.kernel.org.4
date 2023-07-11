Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E074F00A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjGKNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGKNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:22:39 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0818D;
        Tue, 11 Jul 2023 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689081759;
  x=1720617759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejwo9Q+sc9ZHhgDLJslkmrhLigR8fRXmA+QLUxKhE+A=;
  b=NfM4ik7/2x1vdwpKDv4JRp+BBFHqNyZgtCVZMDAE6lpt5hYTiMmhsU9H
   I3ZbuxUw2sfcVZiu784LrKsqvwXwp9dar52r3RZCqUQrTwpdxQbFxDzh9
   5io3xdU1K6pT+94jKRmYLAsmgYgtxbUX+1qPup+1vc7d/YfjXS9tP7jH6
   XQcXDexLizV6cWDgpG5vd+DjaurFTXV7+Pfw2/b0Rzg39rUEdQHtiCygI
   6S5Eyc+dfo0amkTO2DYDkW6UAIdgZ7WUQ28pmjCWk2TvT7CQLBJMHqPbp
   s720J7+fYUO58J8gNS4Jtk+1f8kqhzD7SnFWSQCXOe+X+e4OvpiodnhwR
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XenU1oa15BGFloUdq1qqhxFkHx96sbyoTONgBbsTv5CYiBNoB0yHvKq+BYQMH/JVSFnaucBSoiNhE4BNVZXAoAhT6VWl4/gYvOyK4lcM+uetPH8Q4bVisLhL0goI+QT+q7bPTyC8JQeTDbhBDRtEtnj3kvk9qQRSLAtjo/LHMskqadgghsKPsxYTg+bPj6PxFnPqDoD6Ef39TjcJCW+uUJg2Miy3F0q0JKx+2SEcYWV9FZacLDmCyPrRWrCijKl/4fa2sAX8t2405h0kM3jTnWgPvpuGpO5+r8pFGPrWSI4xdk2NysUx+SfOd27jp1LSeZNfzhTw+uE4ZqySARDS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejwo9Q+sc9ZHhgDLJslkmrhLigR8fRXmA+QLUxKhE+A=;
 b=VL15HAt+FZgdWQTn12iDJR0DhtgN8wzSMiWZl6zy13TxsphYJTiRKpA5LUoDyGbfGYFYXn+IFtRAE5/69op3a0V1W3phOcaB7TtkxdxZvY8CsE7zsuGY7A+ixjK3BYUxwX6QX1a//pOJD7hKmpSLMpQ7DI4mde8+UuSf6IovMMC1aNFedEVCk+e5FDgMYy8++KF+nUK+d/m9mLUmPZVcQIfggZvzpXx8hyXUfR9QA/XcMkb5oR8sgqsuhDJXT0oEk7Ki9gCWMe6EhQgWq4p0pd9PNVdFMLMqBIsV9HOU11A6OVqjE0800Vxs8AYwfDTKXqskLC6DLbZ8d4nuTFOhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejwo9Q+sc9ZHhgDLJslkmrhLigR8fRXmA+QLUxKhE+A=;
 b=LizKXUXP+ll+qBql6k334//eH+pQYJJUNGHez1CWWxHE1n0Pqw/Wtpr2pBbV34upmN1gVbyUJfpIlVJxA+kstkRq1gFN329wkhENjhrwkJLvSBnzn8zTGcioHM19A9BB5tvBlIDOsrb44mSsfms0N2ABBy3s5y+GbZiSJre48/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <3b02a7f4-4598-93cd-757d-27bbfdae5182@axis.com>
Date:   Tue, 11 Jul 2023 15:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>
References: <20230627065316.1065911-1-jiriv@axis.com>
 <20230627065316.1065911-2-jiriv@axis.com>
 <20230629151635.GA3003066-robh@kernel.org>
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <20230629151635.GA3003066-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::23) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|DB9PR02MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: c59689e3-6cfb-455a-8e1f-08db8211e293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x32Mvaf/wODn772Ilb9ItNFusUcX2A9G4Bl39gXgGFI4+JWCPoPIq/dU1Qa0/es34ubxjoDdyVQjBH+87TkUdpUIO+z3UrRgL98b2CEPGjsNjjk7GrQ6/LKntu98nlft1e5pUpPrCmkD2eOEMGrTTJVT7gL2/cSZqrCrlhs8fdL9zguCRYwaoAm1gcpXafpr6WVcFK1fiwfIZw9BRoaNSi2F+Y/3WETRAi2JRS/mG1oI2bm+bhikjCKaMheMOZnmBZpEr9CCGMNSzzmv5roWAuoY9zRWzTyAo6AkaZPEgFnrC2OfKBrQxca4Ln85lf4BglLhz0Bos04v04U1KgHSvoGd4XqSuPTOFy3Kjunq+Bi2vBPQ9H2X63ukz3o7/uyD/+MzFxD4Nko1l3qAnK+z48Lo0gh8h3+DuhK5tdSADRFc/68OKb5mzXfRM6IGCeVVKJBk5vqCqJxArdegharQSzJxDw2swiE0eKfIgVSC3Lrj6TmfAs5oZvj/7+hrx0vBS9NOXr2RnZBhEGuwUXNN8ciDdim6FuejleTBRTa9nOVS96nizDXU9yL1ckxUj02mLt5qARuJWdCwvqtxRQqZ+xK+aE6QAwNMcbso4D9oC8TYxieUrAjqu1t/qqzbHypwNZjfQbRV4eOq0kWNNv9oPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(478600001)(31696002)(186003)(6506007)(26005)(5660300002)(8676002)(8936002)(53546011)(41300700001)(38100700002)(66556008)(66476007)(4326008)(6916009)(66946007)(2906002)(83380400001)(31686004)(36756003)(2616005)(6486002)(42882007)(316002)(6512007)(83170400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhyYkJNeU5rT2lkbHExQnBhd2REdk9QdlYxVTAyWWtTUkN6c01KNFArcFhn?=
 =?utf-8?B?QUF0c0ZsdW5iNGZSZ0FKV1BtR2xxSXpZcm5CYzlER3ZtdkVFa1J6dWZOQzYv?=
 =?utf-8?B?V0tWeHlkRnIxMVRhNVY1SlRiejF6cnJZVitHRFlOVFRNWVdndTVsTG5JUWhB?=
 =?utf-8?B?QUlBMnppR3B2VWZuR2RXRkZjV2NxdTVXT2luOEVXUVhZbjhnWEhNR3IveFd3?=
 =?utf-8?B?djZvNTJ0TE84cTF6SmYwMThjb1Jma3RxakdDNDBNSU1vaHh6VEVMREQwclZ0?=
 =?utf-8?B?cVVzQXMyTVRQcHg5NCtHT0lDMnZnTnV0THZsN0RBczhjVWdBTW5zSUhKT1lY?=
 =?utf-8?B?ZElkWDAxczRKSkpaRGhvQzM2Ry9zOWlDYXVVYkZ4NWQrVWZiYzFCOE80ZDd3?=
 =?utf-8?B?MnVEVmVOM3Q5cGZJMmk3ak0zLys4THpCQ3RFbS9SZGFmZnVuNUM5QzZpVE5G?=
 =?utf-8?B?U0ZRWlROUTJXNkw1bUIvRzBNejBTZkZBanFwVzVGSXJiU3RsM0ZuL0ZNUndk?=
 =?utf-8?B?NXJMNVZCMWNFbTlHaEc2YkVXNjZqMUJRWmNjem5SM1hQcUhhaUpjeFlma3VO?=
 =?utf-8?B?NW9IeENab3BQMGY1dEFqYi9pdUJQcWROMGZSVmhKYjBMeUZmWXVYTXhSU0Fa?=
 =?utf-8?B?VTNLWWZBZExOQlBOd1hzN1Zva1ZpVU8zRGFvMGhJNXZiUXRiTFkybGU5anpt?=
 =?utf-8?B?RjVBOGwrRkxpYTFFdWd5cmN1UlY2YmN0QlphbHBEU2lLZUF6ZnlUUGtwQTVu?=
 =?utf-8?B?QjdwOXdWV01zV0JuejRyUWZ1QUdmS2FSdHhwUkNJQnZtaGd5T1VsRTIzVktm?=
 =?utf-8?B?VHhHZ09sYzNGZmFjWVFZenJwUXI2TEtCU0xsSEM1bG5BYkZ6OGlkdmJ3bnVn?=
 =?utf-8?B?MDJSbWNrV3FLSFc0bzlKSzJSc2NoRDdEREtXN0krWE04RUF3aGwrK04vMXhN?=
 =?utf-8?B?cnM2aWlscEd6SWpQT05lYStaSFExK0lIblEvTFRYRmR4aTZnbnJWY3pHUzQ1?=
 =?utf-8?B?K0ZzenZSdlhydWRQODhrcUdwWGFqMVYvU1lRelEwZUViRzNRcm4xcytNV2pL?=
 =?utf-8?B?OEFJUHRPZFoyVGN4WFdWbEY2Y2grZHFLQjNjVTE1V2E0LzRLZjREM0REL1k0?=
 =?utf-8?B?bjN1bE92VHgrMTUraU83dWJOeWVFZ1F5eUk2T0R6dUJ0WlZhUmNnSWx3cXlY?=
 =?utf-8?B?ZGF6dXJEOThla1l3ZDVSY1J3L2YrYUxqdXp4N1ViQkxxQ1hGcmJaa0E1OGhr?=
 =?utf-8?B?MExTbVd6MVRHV3RRUCtOVXRFT29jYS90WVY4VksvQUVSU3JVd0NGWURNdnpI?=
 =?utf-8?B?R2xuWVhVRHlzZlNBdU55d2tCM3hGRjB2ejFhNHFtb1NVOGIrWDBxWUdSMVNH?=
 =?utf-8?B?UCtCM1dweWdybnQ2c3ZoSTY1cGV1UUtQdDJZZzJNZXVQSVJ3R1hadFZqV0lX?=
 =?utf-8?B?cGNRT1JCdWR0TGJrb2NGZU9Kb3ZFeGNXazd1V2w2ZHZLa3RLMjRlYlhWcGFJ?=
 =?utf-8?B?KzVNbGs3NEpTeUxDNDZqejBGRE5SOUFVaXJmV2pmdnp3SHRjbTRVbldKeC9v?=
 =?utf-8?B?c3MwbDBCbGFZSUhjazJYQlNQWTdMMUV3UXRiZW16dUhQMU5MK3VMUG9lT3BV?=
 =?utf-8?B?dCszZ3dIZXpSbXJEMzBJSUlEdW9TNkozcTdHY2xOU1dIM2JzUHkwbWVkMzBy?=
 =?utf-8?B?UVBoZnJMWlQrYmtUeHdDQi93UW5lTmdSVFJzcEJqTW5XZ3ZqcGVTNTVnd0Q1?=
 =?utf-8?B?dU1GYzhMS250TE1UUldaUURKbXE4UFAxVUROdXRXNTQvZ2NsWTc4b3BQOGJ4?=
 =?utf-8?B?K3p0KzRTUWQ2a2VXaXpvT1l1LzNiVGdYdU90SVJJUE51MUh6akhpc0pXZE04?=
 =?utf-8?B?dGN0emxCQlJablg2dXRqbUhSc2ZDV1gzdnQ0UXJodWZFRzRZOHlTOEpDdmJr?=
 =?utf-8?B?TFF6ZmpZZTNFTzFaalR0a2dBTDdLakszekZyTjFHRjhMc0tTUTJrQ2lwR21H?=
 =?utf-8?B?aGtFSlFUSk1FYnk4ZGQ2WDFXM2FJeVB3ZUpUQkdzRFRjYUNCNC9leDQ1T2lt?=
 =?utf-8?B?eEVmM1hXT240NHh5NnFUSFdjZHBIeDB6eFpIVjNKTFFmNllvVzlMOXp1UERv?=
 =?utf-8?Q?wAc/PhbZs2xMWXof4ez4MUDjk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c59689e3-6cfb-455a-8e1f-08db8211e293
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:22:33.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 890UrzNc65REw6bBX+b5YjeSEivSPCwnB82AAvRuLZAfXfVRLX4VVyEwWLMEMNGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 17:16, Rob Herring wrote:
> On Tue, Jun 27, 2023 at 08:53:15AM +0200, Jiri Valek - 2N wrote:
>> Add support for advanced sensitivity settings and signal guard feature.
>>
>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
>> ---
>>  .../bindings/input/microchip,cap11xx.yaml     | 77 +++++++++++++++++--
>>  1 file changed, 72 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> index 5fa625b5c5fb..b69dac1fba0e 100644
>> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
>> @@ -45,13 +45,13 @@ properties:
>>        Enables the Linux input system's autorepeat feature on the input device.
>>  
>>    linux,keycodes:
>> -    minItems: 6
>> -    maxItems: 6
>> +    minItems: 3
>> +    maxItems: 8
>>      description: |
>>        Specifies an array of numeric keycode values to
>>        be used for the channels. If this property is
>>        omitted, KEY_A, KEY_B, etc are used as defaults.
>> -      The array must have exactly six entries.
>> +      The number of entries must correspond to the number of channels.
> 
> This change seems unrelated? Or maybe advanced sensitivity means more 
> channels? If so, explain this in the commit msg.

This driver is already used for more CAPxxxx types.
The smallest have only 3 inputs and the biggest one have 8 inputs.
So keycode definition array length can be from 3 to 8 items long.

> 
>>  
>>    microchip,sensor-gain:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>> @@ -70,6 +70,55 @@ properties:
>>        open drain. This property allows using the active
>>        high push-pull output.
>>  
>> +  microchip,sensitivity-delta-sense:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 32
>> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
>> +    description:
>> +      Optional parameter. Controls the sensitivity multiplier of a touch detection.
>> +      At the more sensitive settings, touches are detected for a smaller delta
>> +      capacitance corresponding to a “lighter” touch.
>> +
>> +  microchip,signal-guard:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 0
>> +      maximum: 1
>> +    description: |
>> +      Optional parameter supported only for CAP129x.
>> +      0 - off
>> +      1 - on
>> +      The signal guard isolates the signal from virtual grounds.
>> +      If enabled then the behavior of the channel is changed to signal guard.
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,input-treshold:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 0
>> +      maximum: 127
>> +    description:
>> +      Optional parameter. Specifies the delta threshold that is used to
>> +      determine if a touch has been detected.
>> +      The number of entries must correspond to the number of channels.
>> +
>> +  microchip,calib-sensitivity:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 3
>> +    maxItems: 8
>> +    items:
>> +      minimum: 1
>> +      maximum: 4
>> +    description:
>> +      Optional parameter supported only for CAP129x. Specifies an array of
>> +      numeric values that controls the gain used by the calibration routine to
>> +      enable sensor inputs to be more sensitive for proximity detection.
>> +      The number of entries must correspond to the number of channels.
>> +
>>  patternProperties:
>>    "^led@[0-7]$":
>>      type: object
>> @@ -98,10 +147,23 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> -              - microchip,cap1106
>> +              - microchip,cap1188
>>      then:
>>        patternProperties:
>> -        "^led@[0-7]$": false
>> +        "^led@[0-7]$": true
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - microchip,cap1293
>> +              - microchip,cap1298
>> +
>> +    then:
>> +      properties:
>> +        microchip,signal-guard: true
>> +        microchip,calib-sensitivity: true
> 
> This 'if' doesn't do anything. These properties are already allowed. You 
> need an if for the cases they aren't allowed.

Oh, thanks for the explanation. I will fix it.

> 
>>  
>>  required:
>>    - compatible
>> @@ -122,6 +184,11 @@ examples:
>>          reg = <0x28>;
>>          autorepeat;
>>          microchip,sensor-gain = <2>;
>> +        microchip,sensitivity-delta-sense = <16>;
>> +
>> +        microchip,signal-guard = <0>, <0>, <0>, <0>, <0>, <0>;
>> +        microchip,input-treshold = <21>, <18>, <46>, <46>, <46>, <21>;
>> +        microchip,calib-sensitivity = <1>, <2>, <2>, <1>, <1>, <2>;
>>  
>>          linux,keycodes = <103>,	/* KEY_UP */
>>                           <106>,	/* KEY_RIGHT */
>> -- 
>> 2.25.1
>>

BR
Jiri


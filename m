Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5362CA83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKPUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKPUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:18:04 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18D66CBB;
        Wed, 16 Nov 2022 12:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2dORXcBr1vXz+w5lYFvZT0UgLuJwZjrnJYte308Eu4GgzvWEMfwE4aj8rtf7eYPeC0c8ClMkFp0SNpg/pCy5p8va2tA+4AFp7yXBQvzyaThZKF2NCbmpsy+SXNsLuqC3qM4WkgEDlKWx0STBHtA2xiULk+TFwk0REUFgZ9H9JoGMA65pkRRWoVuYtXVMhsU1qj7svGoADikztxNSyPUa0UiU99kTgp+pI3SKB2URrX61tq17SWVY8+2N4p1bw1WHBeS6VeVgPrfgeaEMEx7eAMCag506qON+sdn2JykAYEJe6HuDAd905PQM7zieITJei+MhhR2QgKOvJV+P2oq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk/UYORosnuVxH/rnWZVbeVoKn6tqpN5zaxJMembokI=;
 b=Cv9C1ljEU/n9EK+c1UJOjC2s7Z5XZnrgOFpni/Mr3K5qJiFV4MD5M7Z2dgesqGfSGtyyhfURx465zAHuDIXlmfKqtOWzTRTx84RJWyMvJn6s7Q1miPUh3NZuZkA98neVjuadbpeTHGv54p1egsNrJJygiv8Odr1fuLoI6KBim0QhksXP+a3zaI9eKAjRjmRTjcQ9/uLeYrccQ+Jd5B4hRlXFbhxUJtDOLmGCO2M+wVJS1Ui91yJm8T23/Fw7sgC7MJn/+0yfJxTjm/nrDitzKxVPxViLo6WBZqgDIeToX9jLLRHIPKxPB8I86hpqIdCEz+hJAN5LA2fjSPSJrhF/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk/UYORosnuVxH/rnWZVbeVoKn6tqpN5zaxJMembokI=;
 b=FGuYH9cabDTD/6mPcQ23i4vc8gVOwbUA4I/pFzd6rJDha7jT8ySTWr+lT1A2qBjaUQ11LKWdPVvd+uOF07qA1kZq0zO7GxAZLyADVIuQJhGiu6qzL/RFARSrlf1JvXNd1fomo0bPCmo1sBOrdIs+jw8TVeNqlEyO0CpR+Nfmedo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSBPR01MB3894.jpnprd01.prod.outlook.com (2603:1096:604:46::23)
 by OS3PR01MB9721.jpnprd01.prod.outlook.com (2603:1096:604:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Wed, 16 Nov
 2022 20:17:59 +0000
Received: from OSBPR01MB3894.jpnprd01.prod.outlook.com
 ([fe80::9a71:4e29:fdb4:b73b]) by OSBPR01MB3894.jpnprd01.prod.outlook.com
 ([fe80::9a71:4e29:fdb4:b73b%6]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 20:17:59 +0000
Message-ID: <abc55598-8833-c4b2-aadc-c4e589aa775a@renesas.com>
Date:   Wed, 16 Nov 2022 13:17:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
References: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
 <20221115233749.10161-2-alexander.helms.jy@renesas.com>
 <83492f7f-1217-69aa-8b38-ec1f08995832@linaro.org>
From:   Alex Helms <alexander.helms.jy@renesas.com>
In-Reply-To: <83492f7f-1217-69aa-8b38-ec1f08995832@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To OSBPR01MB3894.jpnprd01.prod.outlook.com
 (2603:1096:604:46::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB3894:EE_|OS3PR01MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd256b1-bb8a-4c45-2772-08dac80fa814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZMofXAYOjDVnBwBlyDN2LsB9TitCUK2acgfu2FJ4NE3wP/VqUCQ2YKBGchwao/nHqbgsbPQq3mtNwr1vJaDrCeDx6DXGcIOA3kVHk9RMUhZ2y0nrHW4icQfS79+UdAUOiBYX+cI3fbx772hd4oGe3RsRu5MVlstpbrxmaHs/yL4xRN66yC15U8DBQXesj0TqNxC2YDXiSsYRAMa7EJ/FdZzKn+6R2zw9lESIs0AOO7foMsHqhzu8pWPR3U9iF8OI/KbnJv/DFM6nvCt6zJgHil9Z8hJU6W8RlmXfCcGJV027Ws5J81gVH1MpNV7lQCkuJXNgEi657Yu3SeWMLXF1H+VB76lwPu3SlLnh9TeprrFE1uyYTNFCbTG72F33U1YhpGu6Gg5fr9NH60fuuyZGwDnAAusCQPcU7IiU3oEyadrmkmUWIr9tiMTNs1cnAYjChT1Z3htFztWq+nyKJHkgZy7e9hzV9kPvBWo0aN33vzNdnfNLFE9+Q1hID6KJymR/fJ4oe5uWvRRYIWOPhMKb3f2k8g/Dtm9Do1kW+5997qdOfEPrJbWn9PeZtWYJWWQa+geS4Yq7soKQB4+TfBmNamZ438OCNThGnJ1whKtD20N/qxUJGSXXHrGtsbqBIJ/8JJLAk9JKviL4j5nOqUPun2FFXM6D0hXK81AuNwZz65VYMFHyj30XYQd9YVa1E6MRWTIOIF0jksIjTdJ02nY6Wrbx2bUI+lWJMfDDz9LmB0fOgu6/rqSm6S8P4+7pPyqgWFpcK5hTxBunT2n4pWFE3QyLUoQaFblFsgrvI6OeWkrdmiQ8+q5Ox5RWsMFcETBQDZEti00zjB3ocZU/oGsNTZaLQs0aj7l+QYcgc5/vnjqJQAojk5DxSv0ROJTWHyZ9/35fH4KPj3DWy5QdXWptQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3894.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(6506007)(6512007)(26005)(53546011)(52116002)(2616005)(186003)(38100700002)(83380400001)(38350700002)(5660300002)(2906002)(966005)(6486002)(45080400002)(6666004)(478600001)(4326008)(8936002)(8676002)(41300700001)(66476007)(66556008)(316002)(66946007)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZRU1BVY1AzVFZmL3lVV29oUGQxVGpUNHJTcUdURmZzT1JESElEZDloZDNX?=
 =?utf-8?B?VXlSVmMrRWJXa3RRMlFCRkttRUdoV08yTTRQd3RxZXdlNXU5QnkxOXNja1VV?=
 =?utf-8?B?T0F3QlpvNzhzMVdVZ0xqa0hwT1dmMkFHeEVpZ3RtRHBQdUpGR2pOZkk3T01R?=
 =?utf-8?B?UXhrWjdmekFQeHJsd3RLUGVucjd4enlSU2pOL3J1VERsUThTcDVCQnNBTHpk?=
 =?utf-8?B?eUNLdnM3bWxaZ1Z3anY4TGFlMnUzNDdzTExtL2lTUkx1dWY1aHV1a2tncjg2?=
 =?utf-8?B?WTJ3RytEYXRyeVlyMnpVLzRoS1ZvbHoxTllsUkpCSmdTWkhzYXpUdi9rL2Yr?=
 =?utf-8?B?RXpyOVZkdlpQQTZRaUVKajRFc3ZhdklNdk9RblhGNGZLOHBrT1JEcUJEL28r?=
 =?utf-8?B?OENOWkpFYysvaDZpaWhSQTliRVBzNk44dVBYeVFxUjhRU0k0citqOE5vZVV1?=
 =?utf-8?B?OWNkT1JrUXEwZFArdUpzU01zTU5OSVhtVnNFMmFVdUpMamp6OUhzNXJYQ0dJ?=
 =?utf-8?B?N3M1SUdYQ2IrWGVpalhQazRjMEpKelFSSGRVSEtibmpHZXREeU1VRmcvYU5K?=
 =?utf-8?B?YkNXVUhsQVNBTGRMYVlYeFNWZDl4MktKNTNlUGQyWWRZL2ZZOHF6K1hDZTBk?=
 =?utf-8?B?MmpVU3dWUHFUV3M3d0tXYU9za3dnb2lLemNOME85cUxZTEVtcVJ3TkFSWWxp?=
 =?utf-8?B?YnVSQUhRZmJKY3pCTS8yVTIxQW53NDNkVzFZdHBsMVFUQ1RmdFVFK0d5OUpm?=
 =?utf-8?B?VHNwK2RLZ253OTkyQld4RVN2S045MGhKSytydmFuZjdKdHBnZXFrcUE5VG5X?=
 =?utf-8?B?YmtvVWNDY3FsK3ltSythalNCd0Rjc3Q2TjlqL1prbzhwRUVLV3RRNXgyLzlB?=
 =?utf-8?B?QmJJSWh5dGJ4NVI4Yy9RMnRUeTN2S3ZlR1JOUmpWRUxkWFJGK011Y1FyY25K?=
 =?utf-8?B?MDlOR0VZSnpYV243ZGo4bVh0OVc5Z1RzZGZjRVFlL1BCTUU0MWNob3Fqbkcr?=
 =?utf-8?B?RnZ5WTJpUkIreWhkckRrdng0NEltTnI1RlN1NUMxSDdRMm9JK2w4RkN2Mit6?=
 =?utf-8?B?ejkveUxVamdZaThiaGVJNEVWTVl5dGlkQ0xOOUh2TUc3ZnJUSWN6L0R1Z1p6?=
 =?utf-8?B?VFIxcW5pZG0zdmpLU2YvK2YwaTNuSzdaRGVQdzNkVWo5NXVCeVRkbmtEODZq?=
 =?utf-8?B?dGxXOStrZE11QWw2NUkrNUxlaFFFSFM4NUpSQU1VUnBpY1JXU093cW03Z3ho?=
 =?utf-8?B?U0dyZm93SmpUdkk5TjZ4VEtJNlZ3dldGVG9QcW5OY1pvY2h6YTJVeVVYdllr?=
 =?utf-8?B?Vll0U2RVTS84QURmaVZEMkNSY3NuUG9zWm8vbzJtL2lUajY0Z3hBVU1hRkR6?=
 =?utf-8?B?YjZvT2FvbWVlQVpSMFFvbHNOczhrRk0vVnFKUStFa09QU0xjcldYVmN2aTl0?=
 =?utf-8?B?Uit4b1hTeHVVQ2VHQllqUUdyUjdmU2JlQU82Y3RDdnBZQ3JGYVdQVTZPVmdl?=
 =?utf-8?B?c3I2d08zSld1eUZ4L054UHI2QzJ4MHhyME1pOHJMelVCR0NveVRJMkk1citz?=
 =?utf-8?B?dURmb0xBUGdPTmNsSjNuWXJrc3pYY1FUNFd6SG5sck5qWE1ralExWnVsOWpv?=
 =?utf-8?B?QzBYNFVFcU5HME1HbW9uOEx6cnIvMm53RFdhWGRFQnBoMUtzVDBZQWlOT2hF?=
 =?utf-8?B?OFhxTm9aR1VBTEpRTEtubUFyNzBTUHdFOSsySW9xRVBGM0VYUUhhd2R3alc2?=
 =?utf-8?B?aEZOZ0c3NWpXK0JLWnhSNXVpaFFjdWYydW5HZHJvU3UvRXVaUUZSZnd0aUJp?=
 =?utf-8?B?dHdZUlNwaUdmRDZXSjdGZnBSa1krZEVoOTF2K2JOcVd1K2ZEMHhmSHd3RnZU?=
 =?utf-8?B?ZmtVNGVBU205WHFCV0dOQmhGdlFONUhFUEl4U0MvdlR1Y1BBNjh2cFRzNGJX?=
 =?utf-8?B?UGJaM1pDRjhZVXprQ2lYYWI0dDQ1amFBWkp1TmFnMEM5eC9FTEFRdVl6aFRt?=
 =?utf-8?B?dHlucEhKaENEZC9xV2xMWTlrbWNkR29OZHJ1cFNjaUVxR1dBZXNPaXpVa0th?=
 =?utf-8?B?SnFudFFIK3JITkg0NHNWTDRFRExmSEdtK0RXWVJaWDdNcEhTcTd0ejNHbGlh?=
 =?utf-8?B?Qmk0c2o0N3ZDeVlxaDFhcG1zd3Y5Y3R6NXIrZTNpUnU4ak92OXRiK3oxQzJC?=
 =?utf-8?Q?0VAQKgHMkTcBXAzAyZqfkaE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd256b1-bb8a-4c45-2772-08dac80fa814
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3894.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:17:59.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSEVlOGOGGRiYLbJx4xrjG6NceQkqth1aqxW4TX23b+USVI6dnz7XOBu3fekbOM9PMWf+SD43zIaZuVokAOoYR/LI7pxfjEr5PeAH68u+lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2022 1:50 AM, Krzysztof Kozlowski wrote:
> On 16/11/2022 00:37, Alex Helms wrote:
>> Add dt bindings for the Renesas ProXO oscillator.
>>
>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>> ---
>>  .../bindings/clock/renesas,proxo.yaml         | 51 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> new file mode 100644
>> index 000000000..ff960196d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Frenesas%2Cproxo.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C248dc84dbca44a4013d408dac7af9cf1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041854305996374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iGbtWJLjV%2FM%2Fps0lPk7f40bMzX8qdt8VZBtH9J4LdOw%3D&amp;reserved=0
>> +$schema: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C248dc84dbca44a4013d408dac7af9cf1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041854305996374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zYh4aHuw6G6A35rXBD7FTKeFrC7Hfcxag60ghkKUaGA%3D&amp;reserved=0
>> +
>> +title: Renesas ProXO Oscillator Device Tree Bindings
> 
> Same comments as for your other patch. All the same...
> 
>> +
>> +maintainers:
>> +  - Alex Helms <alexander.helms.jy@renesas.com>
>> +
>> +description:
>> +  Renesas ProXO is a family of programmable ultra-low phase noise
>> +  quartz-based oscillators.
>> +
>> +properties:
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  compatible:
>> +    enum:
>> +      - renesas,proxo-xp
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clock-output-names:
>> +    maxItems: 1
>> +
>> +  renesas,crystal-frequency-hz:
>> +    description: Internal crystal frequency, default is 50000000 (50MHz)
> 
> If it is internal, then it is fixed, right? Embedded in the chip, always
> the same. Why do you need to specify it?
> 

Yes, it is embedded in the package but there are different values
depending on what chip is ordered and therefore must be specified for
some configurations.

I'm also not sure what you mean by me ignoring Rob's comment. I
explained my case for calling it "crystal-frequency-hz" and moved
forward. I can call it "clock-frequency" if you want but I find that
more confusing. Yes it is a built-in name in the schema but it seems to
be used in a variety of ways. Some devices use it as a crystal input,
but most seem to use it as the desired output frequency of the device
which is not how it is used here. Therefore I chose a more clear name
that better reflects what it is doing.

> 
> Best regards,
> Krzysztof
> 

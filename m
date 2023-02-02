Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21C6879F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjBBKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjBBKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:18:02 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2135.outbound.protection.outlook.com [40.107.8.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95376A8;
        Thu,  2 Feb 2023 02:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVArhtm+blIlI6cnTQHBOwU7cUlva9gROAQcMwYsTP4KhJb4yR8MCloAms/eFezKyr/L01z+DGUI2AhlA7jfWFSLG8Oi7w45s6pIhlXFKdQptDMo+jNitZwwg675w/SK8ugnUWEmLE9MSD4SVq30hFlmNSwfFxJQWnVuuSO6XhjP81cV0FbQkun7a+7t88pTwh3smTPpPH6aMs/U7xF8cyTNvgp45TuYu6+TdVplaVzUdY3sYrEdI7khlyEMhDVxWSqyk8dbeoTvd+p0LG3Kgw184R+n+Oq1E0KpFm6dIYtbsO8EEDabFGrHw92MNdJucCTrG/CmOqyd6pfvYksJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaIqzXBR1jtWLP55SYLYPBxi+3/PUFPSmoXwohbyuFM=;
 b=oaO6kgkvjPOhCSK+3yFXY2Z4kj580CYA/dw348lTiVNBCB6suIl3mQOK78e5FRMm7qfIFbL7zAQgXYWw0yT/cx7ychd7Is8hNmn0SNb4W+twxP/RV6N5vZXFJx6eSTtIgxntvHIYAafVLdxQCHRUvQTC4LzDVT8U7h8ACWNKaD5RQoO+853fjosUW/MABcsNkfwvbxYXQLlk6sRL7VAfzdkVVQaQko8MIrqp3UC3XB7iRm+1RyWB43belq10H83rW+soLE8/5rdm9uYpL82ByXLWjgAtJlKkb1bUqmXTMxr3zHy+E1DU6EByCDbivll5GlRuXrsFIcTcA/4OVKXAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaIqzXBR1jtWLP55SYLYPBxi+3/PUFPSmoXwohbyuFM=;
 b=lGlkpTjINlOYX0aS7EdWP+CxOlpL7/JcYqlpcHGua2UFNAhTySWQJiiEuUNmL97sg5o7TJbjWtC1kdsiJKPEyCjcUXFaEHwQtIRiftnTgWiup+huiaFZgvUcKKffxPXKMuUQjHFrTY5EoPdMx954VV5YZvsdqep6/UmGRooBUFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB6545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 10:17:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 10:17:57 +0000
Message-ID: <e017f5e2-3bd5-152b-4429-6369af3e92b5@kontron.de>
Date:   Thu, 2 Feb 2023 11:17:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] dt-bindings: rtc: Move RV3028 to separate binding
 file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder@fris.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20230201143431.863784-1-frieder@fris.de>
 <20230201143431.863784-2-frieder@fris.de>
 <50b797aa-adfe-b3d8-79db-c3ee2cb72f6a@linaro.org>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <50b797aa-adfe-b3d8-79db-c3ee2cb72f6a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b7ebf9-e7a3-4177-f546-08db0506c14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWKGfgcksQypxHzM6BmpUHKQBoAViN8Wv8Jmkh2U9VoS+LnlSiOoUL3rA3QZzComtAd0USnT0KAzcX9mxTHUGFNFYs5J252MYSYbr6fVMuDbq7Kn5VbfHEgMmbFocLNhVXhaXs5mDA2AJC6Qk0COaITGupTwWZ7HusjPdOa7KK+Sr6PMzlDSDWJZUAuDn1EMq6hlSl99rVscpX3V0lZzegC1v/xk1ZgrHALCChQEPYb811M2hESgphwYWhPV9DOliZbaULISqs8rBoqbayfdFDi9hlKzxFPT/KjaJar5VhSF/GhFwz3o7EfkATBEQDHx6wIPjaYbO6CrPU47zJcTz2hnk1Kg3pBqrqRk5YgbmXhuhIWNbGCcMTRM2XpGRReSf/6+FQdQWvVw9BmFiph1H7a+GqsZ31qvh/K4m3TOECDLmPRCij+OC+3Z9kQFV9q0p2yQ52PLX2se0ByNYfcHFlCyzLCmcCDgyb0FHCmdiDCN8/EYq3k076Xdr5uCSKQnDVdyohaZQHbkw8rqpa5lrMQmcCDFpaJqzPfVHrM8RxuKp+ZfLAGMUGS3btOd6ntbklZ6oszqRQc1XYJW1x35pypCsuS3KAeb3HXL9gJ30KRf0dva0zNkQRUMLe5lJvRXuCewtWVJijCcEdddaB6YobkDY5QBVeiPuLS3pwDsxyTItV6xMRRlEjnxiifm+kZjwunHz6Vk16QNUIb2R4w1cIsiabMJQnyue8OoJg9bIS3+SSGB/saCWLrlQfR6ptciZ8Al7Rd1tR4WWp34yD87cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(186003)(44832011)(83380400001)(53546011)(6512007)(36756003)(38100700002)(7416002)(5660300002)(6506007)(2906002)(6486002)(45080400002)(966005)(31686004)(2616005)(66556008)(31696002)(8676002)(478600001)(66476007)(4326008)(66946007)(110136005)(86362001)(316002)(54906003)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJHdDZEendmTTJiM2ttUjY3VW5rUmFmOS94M1F6WkJDMnNnR1dNU2VacmZh?=
 =?utf-8?B?dFpqLzA4aUl5RnhEemdLNjlyL0crZHgrdTJYeU40VzNMbzFrZm9xSStaeVpE?=
 =?utf-8?B?UWR6Q0VsaW8vZFdyMVVMMU4xd21jbGJDcmd1ZnJoc0dCOXRiTGFidTNxTmNy?=
 =?utf-8?B?NlFYUy90Rm9Db1JVVlhJdm0xOTZxSHl0NVhzaG1wcVVKVmZEMVl4M0ZCeTlw?=
 =?utf-8?B?NndLcW5TYUl4dTFZaWtkSjMvMVM3R2FjYldKZG02ZzNibWtzMjZzbk1rYm1o?=
 =?utf-8?B?Mm5ZOWtEQUc0OTVKZE90S0U2cmg2ZHQ4YjFzazhJVG0vNld3aWlXZFIreVhM?=
 =?utf-8?B?TzY2UFdwd0NlYWo4YlZRaFFUUXZSNFE4dHNpRjRVV0pPVUFGSnUraDBUVUda?=
 =?utf-8?B?TXcxOTFGNEptUTJaQnpKK2p0YUJ6ZUREK3hUU3VqVFRXMnRSYzhJbmZnQWFC?=
 =?utf-8?B?YW1qb21Edi93c2tNalpBdmlkUHkzS1FmZWM1eTRrcjlob041UjgzaXBUb2NV?=
 =?utf-8?B?cjhHYzRBbnpDS2hVWGJRbWxSWURES3ptU3pkb0t3NnUyUTZyVkx1Y2pBYWJo?=
 =?utf-8?B?TVJjSjVxQUdXbUx0WG0zZjYxRVc0OCtuZzRLVGRVNExRZW96Mzlrbk9RZnN0?=
 =?utf-8?B?a2JYcGhENHVJRCtnbitZSjFPUDQ3MmVxYWMvSzdMU1NKWXlMVjRLeDVJRXJW?=
 =?utf-8?B?b055NCtHNFZsRmZ0dkJQNXF0cnpHK05VZERLcHZ3Mm1vSnMxWGhIM0xvazNj?=
 =?utf-8?B?WExnNTdxUStqVTZwSUUxVkJHVFZmWVVzVDJyMlJGb2s3Y3RLOUU4NS9rQmhh?=
 =?utf-8?B?WGkzSFMydUIzT3BLcG5NY3RjbTBLbVA4dG9lMFgxYU5DN0dvQnJobVY0bkY0?=
 =?utf-8?B?ZHNENXMzOUdLM0Q2K2ZtRk5ybFJFWFhZSGxBaThrbXhYZDRseDJoR3M0cVJK?=
 =?utf-8?B?UEtmTThGaCsvNVJUZmxEMU5xZGhaajRlRlVId3JjVUdNL1FmUTVWZGZZRzQy?=
 =?utf-8?B?T2ZOS3p3NzhTT2JleFRnYm81U0tZd0hOTjl6QnhiNTI5d1NrZmQ4NGVIVnBH?=
 =?utf-8?B?Ykp2S2VxU0tVWTNiZHM1Z0FGZHR2NTAyNFU4SGRSR1VpZURiVEVxc0EzSnor?=
 =?utf-8?B?VThLSUNoWWJxM21tNGRIV080USsvZHNjSlJwTDVXelA5WUdwSUtzUll3Z05J?=
 =?utf-8?B?MHd3aHY2N1VUWDVDcGpSajA3eHRBSjQ5Y3d6MitGSnFJVHZPaTNpM3JHTzBI?=
 =?utf-8?B?RU1Sd1EvdHBSTTgvMWhmOWlNbUN4R040QkJWL0F1SkxEc2p5eFQ4SVhUT2xN?=
 =?utf-8?B?dExtWlJpcGFFcEdNZTdzMmluQUJHVmFqYVdBTmR0VFNVamJiK2NzNjdSWk5l?=
 =?utf-8?B?QkFqcnpITk5GUDdCZm5JanNmSXE0ZUkyZ0pQU3lQeXNJczFpNFVubTVzcllW?=
 =?utf-8?B?aEJoUXNWZVVXdU9aWkZhV0o5S25Lem1FMkl2QkxSRzR5Tk9tR1B0SFFzQSt1?=
 =?utf-8?B?b3Rsdnk0OUg0SGR3RlFGbGJxQnNwWjh6RlBhWmxVaDB0OEdvVHhhV1FObW5i?=
 =?utf-8?B?WDJ6ZllvS01mL1pnM3cvcjBXeXRBR1FVSUFNS1N3OGlhSHRQNmNHd0ZhTkZJ?=
 =?utf-8?B?MW85ODNRMm9qVUFtc2gwYUNSN1ZsNGFKWmtzTWNIWktucmVEbUQrSU51eUhD?=
 =?utf-8?B?blcyeDFTbzNFbnRTY0JDOUUwL0pqVFU4YzVqbUdxcG14UWlFcWx0QitjQ0Fw?=
 =?utf-8?B?K2RjZjQrTzJraFBPak51dWFyanFzb0tWbG5lU2t0QUNTbUd5NlBKWU44clVm?=
 =?utf-8?B?c3FOZC85dTJhYVlwTE9ZRUpqNmZlWUxjaWxOZGlrbFlYMFFrQkNncjJsUG42?=
 =?utf-8?B?c2dWdHM1SkhtZmpveEd3ZXpZWGk4SDlLTlhpTFR3ZnMyamM3MDcrenByNjd0?=
 =?utf-8?B?NWxaRnJTckZxYWwwRzBCSmN4RTdpMjg3enNCdW5VVjJBVEN5U0I1VGdxSEJk?=
 =?utf-8?B?dlA5eUgyb0JXRmQ2QjdrTENVZ0pVL3VQVi9qNmozZjRSL0U0T2FNL01PRGg0?=
 =?utf-8?B?d2plam5IdHcwVEhNWDZ5K3ROZGd3NFl1bWZFb05nUmdJeHcxSTJQSVZnc0FM?=
 =?utf-8?B?WkZ4ZzdyTGVUR2I4SUJqMVBzZnRjYytBdW9iU3grUWN0anlUTnd6L2pHNU9D?=
 =?utf-8?Q?ACootHVtwPu00LpMkwJTAxKsLxgcWMnorVn3XCkqRmAj?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b7ebf9-e7a3-4177-f546-08db0506c14c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 10:17:57.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JGq1x8VD7XIvca1k8Yrn5NsZiYyRXEli+wKFlrtspqguiAhv3+A2QDNSLCY0E0C21V3idpgWhXXtARi0bMyFWX4PVC031OZfFGJTZ+cIdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6545
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.23 10:10, Krzysztof Kozlowski wrote:
> On 01/02/2023 15:34, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The RV3028 driver uses properties that are not covered by the
>> trivial-rtc bindings. Use custom bindings for it.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  .../bindings/rtc/microcrystal,rv3028.yaml     | 56 +++++++++++++++++++
>>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>>  2 files changed, 56 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
>> new file mode 100644
>> index 000000000000..4667ba86fd0c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: https://eur04.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Frtc%2Fmicrocrystal%2Crv3028.yaml%23&data=05%7C01%7Cfrieder.schrempf%40kontron.de%7Ca99c626bce484657aee508db04fd470f%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C638109258107205830%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=z8nsgRaxC3AcIoXteA7Xj7EpCKrA%2FkRPyrYeS1fig8I%3D&reserved=0
>> +$schema: https://eur04.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=05%7C01%7Cfrieder.schrempf%40kontron.de%7Ca99c626bce484657aee508db04fd470f%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C638109258107205830%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=1RPGw%2FEf7UUNrJZPAHDw7BHnuroLg1oVR4xLq2%2FgIHU%3D&reserved=0
>> +
>> +title: Microchip RV-3028 RTC
>> +
>> +allOf:
>> +  - $ref: "rtc.yaml#"
> 
> Drop quotes
> 
>> +
>> +maintainers:
>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: microcrystal,rv3028
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  start-year: true
> 
> This should be dropped as well and then...
> 
>> +
>> +  trickle-resistor-ohms:
>> +    enum:
>> +      - 3000
>> +      - 5000
>> +      - 9000
>> +      - 15000
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
> 
> ...switch to unevaluatedProperties: false
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rtc@51 {
> 
> Rob's pointed missing testing.
> 
> But more important - please rebase your patches on current tree. Looks
> like all the changes are already done...

Oops, I need to remember to check patchwork/linux-next. Thanks anyway!

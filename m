Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EA62E127
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiKQQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiKQQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:12:42 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452A2195;
        Thu, 17 Nov 2022 08:12:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvQYvoqbFO+a2kpgp6opfbCuoaCVRMHd+azKTfOXylpTJJYyDjE3r5Q/XPBKpFdJHrtZKcld3GUl9fD+HnruRKr6/OVZAJHcSQrEZXEdMCznC0PNQYEvPlIn8xihlG05vMag5HqmraAQSHrdLqNCYijXK5eMi+mRRCXsUjq+SGwa5/ONGw1SUMOr0odxSQbVqh4+otAXqCoHHhYJYsBRyfCXFn2E5j5IfuL/1/TQRfXUNgwGNeUOR/DVPkzCHWzbiUnStevs5GgnxImU+1BGwA5I7BbkJWmvXNSMf7TGCYLQjziQWAVCnrDX7/sZz5awPGe6b14IMqJTgzj24JCbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad5gBEb2ImvEZAozZVOhV11pTTRfCKg+iuQ4rgChCzs=;
 b=T2PZYmuQQdNF/sKw8Hn7ZqZPA5hTqmaraIxmZ3QOrHyBZPiv29AfX0jcX87JJ1z+naNwBtKHMbB1AJy0CxA8CWy56NCVo+XQRJYtxECU8KjdA8IsEz2yydco9pLwJBo2eTakXOIqxO6lSHK1mWBO84ejZjRrvotSWI2Ul9HGnswLScUnmHK8tJIiDTYce9PsoLsyALMzwzwBcYH5pJ3bjzsVchZLFgpvW7PJHCXsD4BFRU4qigrFLHTSv8yG5s4PIFc/oqkzRuIUtW8RoYJ4/7cqVXCZGFDo/vDEBtXwATCiQAPiWHjyDyC694lc0pUh/tf2MinX45PEMW41T3h0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad5gBEb2ImvEZAozZVOhV11pTTRfCKg+iuQ4rgChCzs=;
 b=eQF2orar5v+1Q/JW2X/QifE1quhGIZtHDNIQ88T4oKqz5g20uuMEG5p/o16jVaNSim/AbYFSgrUyv1x1TSXY/5NuHcG/GQmgROGX8QdU+fxCwZ5E6G5jo+EQb2NqsJ7GVp96MKsfF60AUdWfTHDoKkSgV3PMOsKzRvBih6GC1So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS2PR08MB9641.eurprd08.prod.outlook.com (2603:10a6:20b:60a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 17 Nov
 2022 16:12:38 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5834.009; Thu, 17 Nov 2022
 16:12:38 +0000
Message-ID: <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
Date:   Thu, 17 Nov 2022 17:12:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
 <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
 <20221115174355.00004a01@Huawei.com>
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20221115174355.00004a01@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:803:14::27) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS2PR08MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2b5613-be17-471c-e955-08dac8b68b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPaXnEHFsklLjIjVe8L2TwnJ0PmiRRw6kCnVw/OigoVdFSyQc7zj1oE+4DmCPGwBFjoM2FxFcyv6l6yNcQBzZtmB2q1eoV851PByOABxLly18Lkqo6t5HIpK69T8Ls9b8wi0UUOEJle/fv1nTi+bdm0EBNQJdAZdDvpGuxR1BAkzR02MH5xHrFOND7T/pEWaRInCMp9SJwrMZPVOFoIDkLm0lSSSICxytV4tFK2YY1XN9QTJE+HamH31GEMxlibmGVGJp7YbwoZmtG9lIe616KLkC83ZfX8k+TUT4vAKAlo3IVJYmzlJoy3CCn/twCqvAe/4ky9PajfvRw2tHTfBnB09teIjxQ8eBR5CkQgxIwf2QUc9NiQ2X41h1ECGZWU0B54lvM49nQ9ARWaPGC6WPauv5d9pa08JN1jMR4p1kiUMQmiwQmi0gvNGyztCxmrud5zfzk7J7+lVnVMvj7nI82wJZR+ceaS8yBBoGG9RSThPdhMHwCeVU1WRdP71bV8sm4IbNxKegMEegi+qj1guvqHOsT2RtQbF86RHv8Pmub6pIBiOkSwpeWffx8Rxc04U5qHReXIN6q6wDSAKOrlHLJ3ngZstCD8VvlNX2TaIqY4aD//ZDDRix7WWVp2I27oEu2c8cm8irT4U4y37ibKuRIRLs5e7uj+D96jYQQLruoE8P6yX376gLMH+sfhmAoDT2QNumonwEkAY9SPhrGHaRMNgKpEegHUeTXu9/nbv+wMJ5DCp9GzGX7l+hO5GFBUtP1J15XXXlErDbbfTA1rTLHgFTI/5PnC66C9OHGoaFmfkrGhZVnqCub7rvpxij5CD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39850400004)(366004)(376002)(396003)(451199015)(478600001)(45080400002)(6666004)(36916002)(31686004)(52116002)(6486002)(966005)(66946007)(8676002)(4326008)(6512007)(66476007)(66556008)(41300700001)(26005)(2906002)(7416002)(2616005)(44832011)(186003)(8936002)(5660300002)(107886003)(86362001)(31696002)(38100700002)(316002)(38350700002)(6506007)(54906003)(6916009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJkU0NmZWVtekJnZG9vTnBwSFUzQ2R3SVBwVjlnRHpRaGU5cDRPU0tLUHhN?=
 =?utf-8?B?Mzc2YjdqTUJ2aDI0QTlSalp3WnEveEZYcW5lVE5MVGNFeVFlSEd2TEtxdWI4?=
 =?utf-8?B?RmpmQ2kyVkMrN0g3NEI2SUtxRVBTQjJDbUFnVGFpL082a25GUkhqd0g1Z2hj?=
 =?utf-8?B?SmRiRjBkWktHbnI2SkR2R0NQUXNIRElWbms4Z3h1M3NWU2UxclYwVHVyNUYr?=
 =?utf-8?B?emNXNUY3N3ZaalJSL2RxZnNQNno4Ujhuc0JpRnJ4eHh5Z1NsQ3lxeWpWTXlB?=
 =?utf-8?B?WndtNUhFTXhrakZvL1gvQzhmMjBURnFqejAwVVNlS0p2QitxbW4zOXRiSVRS?=
 =?utf-8?B?d1VjL29SYzliSTNWRVYyUkpZTE5KcjhkM1p6RzRZZWJsZFJMd0l1dDRiSkZ0?=
 =?utf-8?B?NHpOOGdxQlNSZk9CQkVscEhqTEtCTGozeHdJZW5oSTZZakQ5aWZ3ZC9JSnA5?=
 =?utf-8?B?V2VPK0w5M2xnZ1JvQkxweHUvM2s0cVoyNVR0elFYS0hwWWJlUHBRQUNNSjYv?=
 =?utf-8?B?UHF6ZHVCT1Z0cHU5QXplcVBsS08zVldXbHhVa2FlYVUxbWVCTGFoYUdxSlBX?=
 =?utf-8?B?UVlkenFqTUJGVmhvRTNtMzNCK25XYkYxSkFOT2VtTkYrV042THBMMXYxMS9R?=
 =?utf-8?B?NnRPcmFDc25Wc05GbTU4RTJGN0JVVFN1bVRZWVIvcXJxZjdHbFVadWtDcExW?=
 =?utf-8?B?YTNFVVk2QUpjUmRBUjkyaWlSc0M1a1M1RGtGdE5CNm53RzdQNTM4ZGdRYzlk?=
 =?utf-8?B?dUh2eitrK3JpOGFlS1BzUUdINzZtRXlzTnlDcXNmRWFhc3ZJMWFUaXlGRGpw?=
 =?utf-8?B?WlI2Q0Z4UmFnR0RVWUZiR2lSY0I2cUVwYVB6NmpGWlBpakFDNlZjOEp3K1pQ?=
 =?utf-8?B?L2ZRYW5ETXJnbTVpamV1OTFtR3Z2ZkVlcDltMFJyd0hKYmxyb3ZIay9JaGtw?=
 =?utf-8?B?bTJPM1ZmMWxWTm9TRXVjQkxLVVo4STBuMDZ0b1BreGM5cWQwTGlRemcvaElh?=
 =?utf-8?B?Rjdicjczc2RiWGd5K2NOckxEQ2dTQm9pUStJTlY1Zk1BR3VnSjRGaytBWFp5?=
 =?utf-8?B?K0crSXQ2bFRHWlRPWDNDajhBcEhGUGZtN2s4Mlhxem1OU0M4ZnJVV1hlVW5E?=
 =?utf-8?B?eUtNZ0Z4SW5peVo3YUZpZFdpbXM4U3pXTGp0YUUxRXZRVjJ3T0ZJVkNtcktv?=
 =?utf-8?B?TnRTMkYrbFBZSFlkNmZ6TCt6NlZvcFdlUkZYakUzTFlSTmNEbCt1R2dXOUtU?=
 =?utf-8?B?OE9wYmp0WWp4emxydXd6Y29WUTVHcmo4d0ZITFd2R0F1WFBlV0ZrdnJKVlNQ?=
 =?utf-8?B?SE1tNGpVenJ4NkUvSUN6YkV3SHoxL1pqMW5hQUViWGFZQXc5MUlzTzBHRlVr?=
 =?utf-8?B?cmF6WWNMUFpaaGpiclhPM0VFS0VtWUVVWVM0dkZ3TUdyaWpYY1Rla1pnS2dV?=
 =?utf-8?B?MjUxb3piWWUzeW41TFU5eFRPclFhMTV0alBCV1lWamU0YUgyQ1B0QXBIOU05?=
 =?utf-8?B?SWpONHNKT2FhdHpYOWRYNmtNZndzUkpBYnhXUk05b2RISmY4Y2NMRm9STXU2?=
 =?utf-8?B?SmxMSUx3WEowK2g4NllLMFRKOUxpdHJySUNTSndqcVBMOVBWdjRsUjNjR2Y1?=
 =?utf-8?B?WjE1c2ltZ3MzV2NwRDNhNDU1WGJ6Szh4UE1HaEI4YzBuT2twaTVBdW5VaGNX?=
 =?utf-8?B?ZU9LYWV4Z3k5YnBGVU5SNkVxZFNtMTg3RTdHbDhXWlp5em54UmNPTVdZdnZW?=
 =?utf-8?B?YUJqaUdxTTFGajkxbEthRVFUY2lQaVUrcUZWOTdHSlI0STBJaE03QUMrR0s5?=
 =?utf-8?B?RitYRlh5Y1ppZ0VMNnNVb0d0MzFqNENFbHJ5UlRNRUtiZ1BWVDhTNmdsNjFN?=
 =?utf-8?B?TmxkM3RiMmZ0eVA0VHJTM1hQN2ZxRGlhSUwvYURPZ0FXREIzam9RQ0ozbjNN?=
 =?utf-8?B?Sk1CUEFNaElQVUQveW5KVGIzNldJWDB4dmZXWjJPZVZmTWs3OXR6bklVNUZ6?=
 =?utf-8?B?YUVEYVNnT2tXQUVIS3c3RDM1c3RqakxWT0JDYUpTK1RiK1lZL1dkd0Jldktv?=
 =?utf-8?B?SUovOG1rTEgzc2VSTWFXOHhxekJRQnBDa0xhSVBPZ1lybWdkZmExWkJPRCtI?=
 =?utf-8?B?bTFZLzlaR3o4VU4wOEtJRlQ2RTkra1l5UzU2M0hnVDZxQnFobWJjTEtpSEpQ?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2b5613-be17-471c-e955-08dac8b68b8e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 16:12:37.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayrQo8X4fHcOrA6rFpiLZ+LwCs/VRaLy3Hv87H0PvLEA3XfmhxIgf1YXbLzuxveuPe4/Hw/cuM7f3UbV6ILgW6q2szjqBiUy3yj6UqCXECs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15.11.2022 um 18:43 schrieb Jonathan Cameron:
> On Tue, 15 Nov 2022 08:37:17 +0100
> Gerald Loacker <gerald.loacker@wolfvision.net> wrote:
> 
>> Add bindings documentation file for TI TMAG5273.
>>
>> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
>> ---
>>  .../iio/magnetometer/ti,tmag5273.yaml         | 72 +++++++++++++++++++
>>  MAINTAINERS                                   |  6 ++
>>  2 files changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
>> new file mode 100644
>> index 000000000000..2f5b0a4d2f40
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://eur04.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fiio%2Fmagnetometer%2Fti%2Ctmag5273.yaml%23&amp;data=05%7C01%7Cgerald.loacker%40wolfvision.net%7C9788e9788f344fcff9b808dac730f926%7Ce94ec9da9183471e83b351baa8eb804f%7C1%7C0%7C638041310400330990%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nczO1QC74gD6eGXAkm%2B6LRrc7fyEsr62r%2B3aoW%2Bcfu4%3D&amp;reserved=0
>> +$schema: https://eur04.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cgerald.loacker%40wolfvision.net%7C9788e9788f344fcff9b808dac730f926%7Ce94ec9da9183471e83b351baa8eb804f%7C1%7C0%7C638041310400330990%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=raKUiSntfhvdSSnqiR1Wm%2Fqr9cI3XEu5HCprqvISlLE%3D&amp;reserved=0
>> +
>> +title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
>> +
>> +maintainers:
>> +  - Gerald Loacker <gerald.loacker@wolfvision.net>
>> +
>> +description:
>> +  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
>> +  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
>> +  The device has an integrated temperature sensor available. The TMAG5273
>> +  can be configured through the I2C interface to enable any combination of
>> +  magnetic axes and temperature measurements. An integrated angle calculation
>> +  engine (CORDIC) provides full 360° angular position information for both
>> +  on-axis and off-axis angle measurement topologies. The angle calculation is
>> +  performed using two user-selected magnetic axes.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: '^magnetometer@[0-9a-f]+$'
> 
> What Krzysztof said on this ;)
> 
>> +
>> +  compatible:
>> +    const: ti,tmag5273
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#io-channel-cells":
>> +    const: 1
>> +
>> +  ti,angle-enable:
>> +    description:
>> +      Enables angle measurement in the selected plane.
>> +      0 = OFF
>> +      1 = X-Y (default)
>> +      2 = Y-Z
>> +      3 = X-Z
> 
> This feels like something we should be configuring at runtime rather that
> DT, or is it driven by board design or similar?
> 

We use this sensor for a zoom wheel application, there is an EVM from TI
for this as well. So this is for setting the mounting position of the wheel.

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 3
>> +
>> +  vcc-supply:
>> +    description:
>> +      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
>> +      typically 3.3 V.
>> +
> 
> The dt binding should attempt to describe the hardware, not what we happen
> to support in the driver so far. So I'd expect to also see an interrupt.
> That way if someone ships a dts file today, and we enable it sometime in the
> future they will be ready for it.
>

Is it fine to add just the description without example then? The
interrupt has many options such as low active or low pulse.

>> +required:
>> +  - compatible
>> +  - reg
>> +  - vcc-supply
> 
> Ah. This is presumably as side effect of having the driver set the voltage.
> Normally we only need to 'require' a supply if we need to read it's voltage
> (for scaling on ADCs and similar). That's not the case here so I wouldn't
> expect to see it.
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c-0 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        magnetometer@35 {
>> +            compatible = "ti,tmag5273";
>> +            reg = <0x35>;
>> +            #io-channel-cells = <1>;
>> +            ti,angle-enable = <3>;
>> +            vcc-supply = <&vcc3v3>;
>> +        };
>> +    };
>> +...
> 
> 

Thanks for the review,
Gerald

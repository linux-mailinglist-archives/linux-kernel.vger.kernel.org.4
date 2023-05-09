Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7E6FC8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjEIOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjEIOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:20:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A930D6;
        Tue,  9 May 2023 07:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nobpo8+tNchjRUJ3Ec0jqEj8JfkPO/1//53VboU8GevAUJL2ytr1P9hP7Mjw3/i66eOBPvnLCMcbYlYTGXd44FwLcztAd83ImHB2YTyF7B3HrPs83ofQLT7woMCAFgktew7HAVzTCG74s4YJcO6VHqVR5QQBjRFQdAgDmNKE3OTvFNEHMYInI2AQ/f9abj9H3tJPP3LyvaL+yJo5aSQn/f57af32kVBZAjcJ5DiyCOJy8NaQ/I50t8VqHZJjROkVMDVJNsqbLj+55pBSR95S/RlBY/eVx8uKhUseb4xb0DOrzLwFmPO8VFn22psaUWVdjERTBmvMSZsuhMyC8nfluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDyrVSAQLyyeKL8iaML1gzPwmGtVPrgQ3QZk/2z7his=;
 b=lylCUJYp6XeTpjW3syuXHEXZqikLXxD4b4t5s31tojkSRT8Pf5tvqxwq+pVBPYVCCsmL9BSWeESvR48DEEK9ufcR/BHaB5HNapRK8JGjocCIGHmmq/Lmbs+aFGgDFHSHr4FrGRXOXuU/qbBqw/3E866xIYpAg4xSqn/Lzu00kmJWM+jtWGXLR5MLdIxWw/nglaDkA7RqNfHdiNR1+vXvNAU4lg/m9Ow7RmPBwejtsPs7ZjEqaDppNDUiBKbxGOY4c7zprRPBuEXCaLya67YaDjAq3nWtr6kdehJ8DCBEow/nnKH3yVsbR+1cCpCS4lE9YVpCFVZXH0OcLERfEGKREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDyrVSAQLyyeKL8iaML1gzPwmGtVPrgQ3QZk/2z7his=;
 b=b3c48RvEIlBFddCfsG78RPfSr1KjiXVnrupU9RnpGRgPjuP46n+sCiDDUm0d5DAFKk4r9jEE4KNWKK4vv3t7/QHev72AGM8ZVL5s0ALKfcjObK7aJgeWyw2Tk0/PJF1/1Lwha1PLspFh1cpxuiovNpQCEu6mlNPPNxIgKkQvlY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 14:20:02 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 14:20:01 +0000
Message-ID: <1868d9ae-1376-d91d-a789-9e510bde96a7@amd.com>
Date:   Tue, 9 May 2023 16:19:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] dt-bindings: usb: Add binding for Microchip usb5744
 hub controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <dd31f987316fb2739644628b5840a6d447b5a587.1683293125.git.michal.simek@amd.com>
 <32aa46df-9ed5-7d2a-868f-a36414f54534@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <32aa46df-9ed5-7d2a-868f-a36414f54534@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::25) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec104ee-adf6-489c-76f4-08db50987a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CE4q/Mob3l4iO4JHbFlCgMqCq8hIe88YHAWjJhkBGOl9YIS3EeBGQR2noGx4IuU6TU0+qOMldKkrrLyhKDu7EzOyEPNFlcNHBnQ9JAU7S2l8MNzwAf5tiWbczJaSupMMCTeiuSr01yDfnIqT+1NMkAozFV1ZNJcNqcU5HPbOTMGvp4VTZjVVdc2AIIsyQ56xBxAzROxPBK6AaqSioFXaZRwTzAk0FlpVis54fZd8khD2ylYsm/1oB0RzglCcyuQIEB02haUVOozrxr1I/v0DoJ83PhAVphBZRoJPmOwImIk5FrOnzi4nbUM7Mgq30yN/ZPClMntIIpuiO3lUUQ8GAUottukEASbt85du+1m3kFggbYHxpfyyt7hBCdSZM1nR6Mwey5284nWMPyhsaanTQtLu5VR/Nfnv8uBw816dgAUGDJKpRAoeoi4U+gmgtzXcwINVSRGskGTTyMiJZe3XgaWYCgw/ennuXlZZ8I9my5/pX7GOAYT3+cK2ilb47bbbqb0iXyeMB9HaTxKCiUI0EkhiBz8W7cFooBWWZGu9wWp467d5tbPCsExWyC1cT8G9dzYquml18X94Hjo4qzoN+RbFpJIvaPkH/TDqxIteXjIAHTfmrzK9WsMDDxBeMQG/uXIPDHKC0fYk/B/T/L6/TFL1+xcIabeAC4Bih9XcbSki9ayV4jO2iMjWmT8eQlBo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(2616005)(8676002)(8936002)(66899021)(53546011)(6512007)(6506007)(38100700002)(26005)(7416002)(478600001)(44832011)(36756003)(5660300002)(186003)(2906002)(66946007)(66556008)(66476007)(31686004)(4326008)(54906003)(6486002)(316002)(966005)(86362001)(31696002)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJGcXBrdHVpKzlYVlhUZEM1L3pIbEpjZ1BCK1N6U050UExlL0YvV1l6cVJx?=
 =?utf-8?B?NWE3TU50ekp6ZzRzazI1eDF6S3VCZk5UY3VOSEdYa3RhMWZmbENOTTBZNUtR?=
 =?utf-8?B?RFhHcmxVNThwVkYvUzUzQjhHTWRxTElwOUYxN1hXU0gyRERnQzE1U3B6UHor?=
 =?utf-8?B?QW42SGZLM3ZZaENQZVFSRDNHQTUwTFkvU1pKSytvKzRmN2gwYk5ESko4UGV0?=
 =?utf-8?B?ZG1yaEdqSlIvZ2NSaDFLSFVuZHZIaXVaYjFVbEUzcERrY3RWZUZkV1F6T0Rw?=
 =?utf-8?B?UUwvZkNQdU9TSXZHSmdsQXNwbVl5MU9xZGhDM21vdTl6d3dGRHY1TTNHU2ow?=
 =?utf-8?B?UjZGS0pRMFdPR1J5OVc4QjNsUFZCS0VnQXludzZBYkxGbFFRV2lxbFdsTTZx?=
 =?utf-8?B?cElqT0VPd25XR25lbmZ6RGdnUW16by8vOUd0eU5Ed2o1ak43RjdiUi9ibUR5?=
 =?utf-8?B?TGM4WDdHcXhzbjY3cHhlSUs4MzhEekN0UjdrdGNocUxBcmVzaERzK24yY0Rv?=
 =?utf-8?B?ZHVjd2VKSi84WVVPeDhvNnBtbGNleVBuY2VpMExqUmhQSHk4STRCZjV3TWp4?=
 =?utf-8?B?dlFyVTd4NEg1T2JtMUxkMHplZGxVdlZkVFBFZG16ZVROUldRZXVnejc4TVBC?=
 =?utf-8?B?VWpMZEd4aWUzbzc0KytKVnIwYTNPQStmN1g3SW5Qb1FHRXQyZHFyRFR0ZGJR?=
 =?utf-8?B?WWVyeUEyM3Y2NnNlOXlUKzV5LzZkamw4eGlRQ3QvVVg0T1dQTjg1WGNwbld3?=
 =?utf-8?B?cHA5WlZZUFpYWGVBVEtkaEdOQnZHbDhjWk9YTit2cmRaQ1Nwem0yUjZQcWM0?=
 =?utf-8?B?ZkErdEJ0bW9mSnBiMGhNRjZPeHc5T2lOejdONW5yK1NIWkhSQ2h1NklRa3Iz?=
 =?utf-8?B?MUtEWVppK2JhZThjMlViS081QkI1L3RCVE5IWE9ZV01qeTc3S3VjMW1VV29k?=
 =?utf-8?B?OHZsSEE4c1dCL1g1SUtYdG5pUW05WDFxVkw3K2RNbEdYMzVzTEJuYzRka2p6?=
 =?utf-8?B?TWlhRkZHVEpGRzBWZG1NV0ZWalcvTytIMU1CQjIyK2VIaHNDc0JpVE5CRXFT?=
 =?utf-8?B?S2p4dWxzVzJkai9SdUxpaXJZM2ZZeWlSWXd5SEVzKzJKamdUVU9vYjdnTWdt?=
 =?utf-8?B?YU5Vc1FDV2RCbVpYNmVLNFpyYzdmL01vMVMrSzR2REZidGh4dmdaNytRQytC?=
 =?utf-8?B?bitNZGtTeC9UbkxxTW10aDF4QS9JUXExczVvV3pwZVU3cnBBSW91YU5CTWFX?=
 =?utf-8?B?YjR2OWRtNDBldTZ1MjlTZHhiV1YzQ2txRFhxbzN6a09qdkRvdmJ0NU5Dc3hk?=
 =?utf-8?B?amsxNWUvUkV3NGxZd1lDOUovRGlOUGIxdm8zMTVxM3c0aTgxVFl1L1VlcHpK?=
 =?utf-8?B?TkdzU1RsZ2ZWbUJueFNPeEV2amdhUnNwdmVOZ1hoTmErY2E3S09WOXdUWDFp?=
 =?utf-8?B?R0RLR2ZtK3pTTHFUUTUrbzVpdHVEMFU1VDNCVkcxTUpxMHFpU3RIeXl5c0xu?=
 =?utf-8?B?MHp5T3V4Y1pTeXdiSnNSSEQxNDN3TzdOUDNxUUY0Nm5WZVR4d3ZWQjBJeUdS?=
 =?utf-8?B?bzlqQS9ydzJ2eHBHQWMrRGc1ZERRaDY1Q1NBNmxSQ0hpSmRwblBxNnd1N2pi?=
 =?utf-8?B?UktleTJLbXN5KzhpUE1FMk9oR0ptZ2tJc2sxd0JjWURMQnpoY1NKS2J0aUFF?=
 =?utf-8?B?R3drS0VRd2hqT3FGSExXUDA2Snkxd044TlMybDloMHFqNXhLVXdKMWdwY1pw?=
 =?utf-8?B?VExKWmNIOGhmOVdxaTdHUUg3N3pRSGtjZTA0RXVReklYbCtFKzgzN0RZOHpZ?=
 =?utf-8?B?bjR0N0h6VTloVjh2b2RZaTh3MC8rTHJOMzlMNUdVQStYZFJGcnJ3ZjZrSlZ3?=
 =?utf-8?B?RXVOSndicUpKRzFDblhqSms3dVBKaTd1YUFaMTR3bHdGSGlvWmJSMlJjTlhM?=
 =?utf-8?B?U3B5a3VJZHhONXlzUjh3dmtEdVptUnkrMXUxL3I0aFNzaFhHL01sNFBrQXl5?=
 =?utf-8?B?K2xMaHdmWng3TVNwZUNrZDFsdndwek9DaGM0UjVmMVFVMUhoZW9US253dXNl?=
 =?utf-8?B?anEzWGF1aUNPemNudTBoMC9Ea1ZYMWxxTjYyWEVTbmo5K2hJOXNKd2dmRksw?=
 =?utf-8?Q?zsIFS/YG6X5MvMgpyI29ZWP1n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec104ee-adf6-489c-76f4-08db50987a0a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:20:01.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moTf+dvZ1vXoRw5uQ4Rqf8QqHQPPAemS7yb3a1xdLRW78BRHlat80vWCKgQweekJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/23 10:07, Krzysztof Kozlowski wrote:
> On 05/05/2023 15:25, Michal Simek wrote:
>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>> The binding describes USB related aspects of the USB5744 hub, it as
>> well cover the option of connecting the controller as an i2c slave.
>> When i2c interface is connected hub needs to be initialized first.
>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>> idea because address can be shifted by i2c address translator in the
>> middle.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - fix i2c-bus property
>> - swap usb2.0/3.0 compatible strings
>> - fix indentation in example (4 spaces)
>> - add new i2c node with microchip,usb5744 compatible property
>>
>> It looks like that usb8041 has also an optional i2c interface which is not
>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>> Add binding for TI USB8041 hub controller").
>>
>> i2c-bus name property was suggested by Rob at
>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>> and
>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>
>> the question is if adding address like this is acceptable.
>> But it must be specified.
>>
>> Driver will follow based on final dt-binding.
>>
>> $ref: usb-device.yaml# should be also added but have no idea how to wire it
>> up to be applied only on usb node not i2c one.
>>
>> ---
>>   .../bindings/usb/microchip,usb5744.yaml       | 110 ++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>> new file mode 100644
>> index 000000000000..7e0a3472ea95
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
>> @@ -0,0 +1,110 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/microchip,usb5744.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Microchip USB5744 4-port Hub Controller
>> +
>> +description:
>> +  Microchip's USB5744 SmartHubTM IC is a 4 port, SuperSpeed (SS)/Hi-Speed (HS),
>> +  low power, low pin count configurable and fully compliant with the USB 3.1
>> +  Gen 1 specification. The USB5744 also supports Full Speed (FS) and Low Speed
>> +  (LS) USB signaling, offering complete coverage of all defined USB operating
>> +  speeds. The new SuperSpeed hubs operate in parallel with the USB 2.0
>> +  controller, so 5 Gbps SuperSpeed data transfers are not affected by slower
>> +  USB 2.0 traffic.
>> +
>> +maintainers:
>> +  - Piyush Mehta <piyush.mehta@amd.com>
>> +  - Michal Simek <michal.simek@amd.com>
>> +
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: microchip,usb5744
>> +  required:
>> +    - compatible
> 
> I don't understand why do you need this select. It basically disables
> schema matching for other ones.

I didn't find a way how to have usbXXX,XXXX compatible strings and 
microchip,usb5744 compatible in the same file. I am definitely lacking knowledge 
how to write it properly that's why any advise is welcome.

Thanks,
Michal

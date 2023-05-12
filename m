Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390E700122
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjELHLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbjELHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:11:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17A1157E;
        Fri, 12 May 2023 00:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHDyfs9a/017lR1CfnvDw1VSGka20PuDH2+PHi7VmvggMUCdlcTuvg+Bg/UUCfUYW08gqmqmElakgIqUdL/PurLJxXMoa4XCUFW37QEVjPBWPx6yVZkoN1Ulg0c/ZFRTPbnK/0mKQLPqYcqW9x/XHOqTRTy2WW7UZBkXXuDyMakq3lZBg+5uihIc2Fp40Uskqkv3Rc/WmeUOCQ45q+g92ZrHkSVpoYUGVcwtGQkIgVOpdW6eqNJJI4SFXrb+ex33LNFf857FAAuBHhiKIK/YKFb9x6fEOle7ZnmyEZsWzc/MLnYw1dyfZBTQ/RlExGuCp2I8TmBo9FfGDrxInoA+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5JFep9X40NUoygaTHAIWr3Y+nd6x8k9mbwBErBPtXY=;
 b=L6gfoP9tzuIh8uxrMM/EJ+eA7xOBXlaIAfyii8HduHIYiPHQgAYnA7vAdJfTllwKn33qCWHCSFlPHlm3uK+nd2unVkb4M/z8RAg6sBaYxIKhaWDUX6i1aERkdz9/ZZQNF0CN7y4T0s/dq9fc2U306aj/F0XzVDXbg4PNM89j33xZ5/vFXXKEhc3uY0xH5nP/dJ5Vpy6k2cw24L4B7bzrkllTGyHuWcptXy2+jz+XT9uwYce3tH3jhSbEraAGqOHEJOkrT9qA6clVCVXsJgSulY9pi6HTt6pa1E2RUp7A+PlpfMJNYw1Q6n8VLst1Z7fUQMvB+NobeqJH4C5+472fjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5JFep9X40NUoygaTHAIWr3Y+nd6x8k9mbwBErBPtXY=;
 b=G81cB9d6bYpjBV9wM4y0HnZLHpPeW3MNNxzi7faGqrOjq/GA/hCctIJJMm+/umSsTZbspFXDjGbo/MJb9Xt4HMNJLxaVYETXdW/6nQQFRrkT1JXGJp/U7bB2nJMRQ9KXidVhmRo+7XT9Oc8qYhKkpBsUCj5/JBsu7hsXEPALKo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DU0PR08MB7835.eurprd08.prod.outlook.com (2603:10a6:10:3b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Fri, 12 May
 2023 07:09:00 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%6]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 07:08:59 +0000
Message-ID: <eb3f40e6-a604-39f2-eb49-8b41590a65d4@wolfvision.net>
Date:   Fri, 12 May 2023 09:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] dt-bindings: touchscreen: add virtual-touchscreen and
 virtual-buttons properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v1-2-5ae5e81bc264@wolfvision.net>
 <280ab18d-bbfa-9920-5f1b-d069fd866e1f@linaro.org>
 <18526d2a-ac5f-2b26-9ed3-5a82f20cac86@wolfvision.net>
 <a7261bc1-902d-99f9-aa3e-2c90dd264c8d@linaro.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <a7261bc1-902d-99f9-aa3e-2c90dd264c8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DU0PR08MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 889e4565-335d-448c-e403-08db52b7c243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mC6SX/MZrgSw0JMjtItC665TI4fgibs2M6c4A8W4wMtJbjvIIwZ3oKWkipJfuP1Yu821PCIWstDxE68qevZ0qvDJeLs9cFfKkL91iiJdQsZATjSWGayWVrkC9kHAcK1Dl1O2CheB2rWiHx1KZ65Gx+zs+JLQs2jvGhjWI+Wsx14On9h4dBfdVMb13J8IzqX4YqHWQB33JBSTBNm6WP+fLEVSdpgdCT2m7jrstttoLXXuLsDPGeoYlMn0d60QVIbYqZksD59yQKyDhfK3Nj7NxC1qGBaCfTS4Cdu8z+C9s8Tuzr7EdDvfwBMoV44WLqRKYB7M+5E9d7+t+4jOQssEUEgUDulRdhLpfbM/RYCg1HtrBDTvSphNNnWkLY6cytYb9KkbmWic3wabaSZRcQnkV9uiSKXtnm79AJ6wrRt0+XLuxUvyX6D+Xh4EF4zmoVPs7gaKJEs19qPTvIdczrYL6GOgG6r6m5EzhP53phkYNzLGbQhG2tHP8/xx/jL8s2uLPWAnCbCsj2sZWJcEn+R1ki8y/bJUluwQu/ak6zq7yWJJTOFs+AzzlZDFFHheC+NABgSEAiezBYlqpEnZUFUABEYytRAsa42HaqiNAW7jvxrBOl43Y+RzrIzZ5dKG8Qm1A3ZUvQHcx9T6R00/ysCiNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39850400004)(451199021)(2906002)(2616005)(186003)(53546011)(6512007)(66556008)(66946007)(41300700001)(4326008)(316002)(110136005)(66476007)(7416002)(478600001)(44832011)(6506007)(5660300002)(8676002)(966005)(8936002)(6486002)(31696002)(38100700002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZFTjE5emMyRjlFbzdZdENIck5HRG8zdURHZTZ4NCtheHplZ0p0WlA2cGpG?=
 =?utf-8?B?OVJHcmxXZUgwQ3FuWEV6cWU3WVpWaDhzQk5SQ0paTGgvd1EyMXJqVW5CTVdR?=
 =?utf-8?B?WWFBQ3dZTExsQ3pkMjBERlVHcXhiSnJLcTJlVkVqUFprN0lST1ZoUGNIdHJz?=
 =?utf-8?B?eVFkSllwTkg0WWR4VHV1am9kZEMxdmFTbEJEanVTRG1acWNMMWRwRngzRmQz?=
 =?utf-8?B?N1NvRjdLeHkzcjAvSWhGME1TTzM5SFc1bkRyMVkyTDZEbmY4MDl4a0tlMkYw?=
 =?utf-8?B?b3E1dDBJWkFFeG8rOHM3QVBYNkRpUjdNSDlibjVFZER0TmVPUG9NNFdpNUxi?=
 =?utf-8?B?VDVDQzhiOStKb2JoZkMxajNXVVdWMWRFcDNFLzNJMFcyOS9yNlBWdkJDNTFW?=
 =?utf-8?B?TWF1UmtOR0loSHpSeTRqUHgyTDNQK3pDSmFKaG44RVkwSEUrVFR2RDFEcU5h?=
 =?utf-8?B?bk9lK3UwdS9USHlyemhGazUrQm5waUc1Zm5Ca1FuUVRTeENxN2ZsYkpRMDVa?=
 =?utf-8?B?SXFQRkpRaHhONW5BZjIxcFBoNEYzNWdIWjNDb2RWVFdwbi9DT1BwZndSTzJM?=
 =?utf-8?B?NGpHNCtDbC9STWtYVkJjVm0wQ05neTJFblVUS1dEOE8rMkRpMS81dUFmNlVy?=
 =?utf-8?B?YWZJaFExQ2NwYldxdlJjQmgxZVQrRzN0Wm16UDBreUVKYVZKMERBVDl3Q2VT?=
 =?utf-8?B?R1hKZ05tS1NnSmZWeG5UVlVJUGdwcU4yQUpQZE5kRVRua1d4TlYvWVE5NmtC?=
 =?utf-8?B?aVAzWGNzbVdJUWVHUkRNckxpdWg0S2dWMTRad2w3dThiRzNnQ1lBZVJMck1y?=
 =?utf-8?B?Nkk4TW0xYlM0VE85cXFBaGRDNVdPYzNYWG51cHoraDZJMXRCOTQ3eFZ1a1pZ?=
 =?utf-8?B?V1NtOVNTRmVLajlvVVlqTHE1RVkxa09XNnppWEVEa0tsVTR5cmlhMzhlaEp0?=
 =?utf-8?B?MW9ieGh0dVRnRGxhSGt3V1phbm9QVlJLbmxGdlczY3cxbCs2UVZUc1ZhV1dK?=
 =?utf-8?B?SVU2MVVndCtOR2U2eDJuRjFRWERSTGxqRmMxZzQ5NGVuVENJVmJrNWphcFpo?=
 =?utf-8?B?RUVDNmUrSHhoTWNQM25JNDR2MnFmamtHVUN0dlh3N2tmREdKZ1RnZ1RGUDYw?=
 =?utf-8?B?MitnWVJpdUpVTEcvcGRxc0l6T3Nmc1dsVmMzSHRXRS81eUtPRGZpU1JWdklM?=
 =?utf-8?B?SW1kMDBHajdxTUJUWnpIMENlMjlMVGZwa3VLNUpWSVN3WW41WG5WU0d1K1pK?=
 =?utf-8?B?WG14enhhRjF6azNtTEJ3QlR5SVhpbDNOMDhMSXZTOXE1WTJGRUk2ZlNkZVZN?=
 =?utf-8?B?Z0ZnRW83Q1lSUFBTeDVDSEtDcy9qWVl4bFc4QUtKakExTnNWMmlJWVUxbHlN?=
 =?utf-8?B?TkZoODlkMmUreDlmMFNmeExZR1Bua2RBcW1kVHJCZmJxcSsyTlczd0ZOdHF4?=
 =?utf-8?B?U1ArYXE0SFdValBHdzBlbDc1dkNNeHUrQ2RmN1R6QTNueEpEclBQL0FVczdC?=
 =?utf-8?B?NWhPZkx4RnRZSnZ1Rzg0bHdtcTV6MDU5NmdlTG4yUHhvTEtwUnZKN2hHS0w1?=
 =?utf-8?B?SDZEdFBZbGUrcStpWUtIaHVoQzUxR3FNVTVaQWRlUm8rNTJiSWNpaGJUZWhU?=
 =?utf-8?B?WjJZS01zZlZrRW4xcGd4RDYrb0cxWGR1RkcyaGcvY3EySFdqU0lXS0RPMnhB?=
 =?utf-8?B?aERpTWdrVHdlQ2swa0g1OW5zWEd1eUU5L2c3WlJidVF0VkM3UUFRVXJpd1Fv?=
 =?utf-8?B?OGFxSWd4dDlYZ1IrVmU1UTJwZmZMbVZrRU9XdisyemlpQnVVZnY3dWxXWlVz?=
 =?utf-8?B?a1JMWmt4bndNMU5NM2Q3MjNEMGF2NkdqV3J6K3dDZUF0azhHNWNMWE1ORHE2?=
 =?utf-8?B?bXdQa0UwTnR1dU5HdlkwRzZNa0ppS2NvTGRFbnIvenNqRGZZbzRDLzVhKzk0?=
 =?utf-8?B?bnAxbUs4R1R3OWhtVWxrR1pLUWdmWHpRTzNlUWFoV2hLdTFWN21QOWNqZVVq?=
 =?utf-8?B?dkVtcXBLdXQzVndpSGpHZGNOc25QdTUwVnhBVmtlekV1cThhV0praUhvY21E?=
 =?utf-8?B?ZDQwYWplZk54aFN5SDVIazd0VE4rYnoyRjRyQ1dtSk9RRHBaNFB4dnpXNXlZ?=
 =?utf-8?B?U2ZiMXVwWlFUVGo0Yk4rdTB1QVQ2d3RHL2xMUXhyckM3S0NBc3JSbFJmb2U1?=
 =?utf-8?B?elNBOWxVbWNXQ2NYQnJHdU93Y082TEJwZmFNTlNXQTB5SjUzMVpTSnZMNHVp?=
 =?utf-8?B?QUhzRXVVZGVUcHh1V0k2WUFLenJnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 889e4565-335d-448c-e403-08db52b7c243
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:08:59.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vygfVp4CD0HrstUgeC10b0/9bvyFGnApVjVftABXDDLy5FhmnqG43stRaLGII75Pt6GO+cm0jMWNuPIiGf4lKCMd9eFi48aA9/O4XlhJP5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7835
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/12/23 08:25, Krzysztof Kozlowski wrote:
> On 11/05/2023 12:28, Javier Carrasco wrote:
>> On 11.05.23 11:45, Krzysztof Kozlowski wrote:
>>> On 10/05/2023 15:50, Javier Carrasco wrote:
>>>> The virtual-touchscreen object defines an area within the touchscreen
>>>> where touch events are reported and their coordinates get converted to
>>>> the virtual origin. This object avoids getting events from areas that
>>>> are physically hidden by overlay frames.
>>>>
>>>> For touchscreens where overlay buttons on the touchscreen surface are
>>>> provided, the virtual-buttons object contains a node for every button
>>>> and the key event that should be reported when pressed.
>>>
>>> Hm, I don't understand - are these separate physical buttons? If so, why
>>> would they be part of touchscreen? Where do the wires go?
>> Those buttons are actually printed on some overlays which are mounted on
>> top of the touchscreen and  they are used to provide a predefined
>> functionality to that touchscreen region. Any touchscreen with such a
>> physical overlay with buttons printed on them or clipped touchscreen
>> areas might use this functionality.
>>
>> These buttons are actually physical i.e. printed and with a given
>> functionality, but still part of the touchscreen as the physical device
>> is not aware of them. Therefore they only make sense in the touchscreen
>> context.
> 
> So basically you still have the same touchscreen under the buttons and
> these are not separate devices. Whether someone put a sticker on
> touchscreen, does not really change hardware behavior and it's up to
> system to handle this. What you are trying to do here is to create
> virtual buttons through Devicetree and DT is not for that.

I have already addressed a similar statement here:
https://lore.kernel.org/lkml/20230504042927.GA1129520@quokka/t/#m1a93595c36535312df0061459a1da5e062de6c44
but let me extend this comment a bit.

The notion of "someone putting a sticker on touchscreen" does not really
reflect the use case we have in mind. We are talking about devices that
are shipped from the factory in a particular configuration, e.g.,

+-----------------------+---------+
|                       |  power  |
|                       |  button |
|   touchscreen         +---------+
|   (behind: display)   |  return |
|                       |  button |
+-----------------------+---------+

Here, the real touchscreen is larger than the display. The display is
behind the "touchscreen" part. Behind the buttons there are symbols
engraved in metal or printed foils or what not. I just would like to
make it clear that these symbols are not going to change.

We believe that the engraved or printed symbols actually define the
(expected) hardware behavior. Of course there is a virtual notion to
that, and of course it would be possible to let the power button work as
return button and vice versa in software. However, the user sees the
engraved or printed symbols (which are not going to change) and expects
the device to react appropriately.

Now if you suggest that the system (that is user space, right?) should
handle this, then the question would be which component is supposed to
handle the touchscreen events and react accordingly. I don't have an
answer to that and hope I don't need to find one. But independent of
that, a configuration file is required that defines the area of the
virtual buttons etc. Wouldn't this be similar to the (mostly) beloved
xorg.conf containing the definitions of input devices?

Best regards,
Michael

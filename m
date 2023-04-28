Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2526F119B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjD1GIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD1GIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:08:53 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7D2735;
        Thu, 27 Apr 2023 23:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYi9KjBJyPCjs4Ni/MZbqw6I9OkZfDF7kwdPR3c8KNbup64aGEprxKS34jabo4eK/dcMYrYoQMMRHAPLawvFaRnQ54bi+eyQooPZC50hjz4dQUi8QqEJ53nuKSMEnvtcs+PnsggS4rXTfiTbqM4jtwRVuLMpYpkUXlaOi31VAUVuVwF8EY4amLz8Ax42ceXQafx09KGO287XmGb05vd32PaKr2n7WXhTNBNV5byYNn5ux/GIM0eedP3IdnMHZidex3JqG5qLx2QZ07YUZaJJApoaZYxV6nA+dhZXuDdxSdNDy1YyEQQSJjx9i9xCi39rfXI1WMf8eA7R4WdusYm67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7/2/ICOmRRXx+vmxnHFG+dyhUDGcaH5AtwZDmi7F0E=;
 b=YDiKF5E26ZLI4Np3IJAvNI+onMm7PD2sGsNMtDCvOoz5oOCM6k3L107votFtOd5mu67mdU6MAnx7koLCu5z4D+SmNTolGr3jA9vAQc0KhffypbrLxtkuypR95E2t6XXGCgz1iB2YzPZL51IYlgWkvPFlXqMEZppcrjuB2SA3DZU1PM8GjYpl/2hPX66HCKAAsYmlFOgDRUqRBDX59ViGIg1Bk+++DjHb6ABjxFc84FGnIsHh15v1+HsUC6ukimyeysYZde/kfaqhHelTrNu1fdB6y7jpefyxc4GFTTeQqSnxRdzZcRK0ktSF9i0lwyaqSr+d9Hk/W89/iUQyk1yhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7/2/ICOmRRXx+vmxnHFG+dyhUDGcaH5AtwZDmi7F0E=;
 b=AqYemXLqlGjwQacj2cARurSR8Tl56OUDjcYGe4V8+Zb8y5hK++5ZYGXMIXc0c29S2Wfx17YmbkT/kBRQ64AoONLznmmDxd0f4o5WOwlHQez6UKoiqdGYRhWNOgW1TE68upXioKfapMNtEVmJ8sDSXdIphZXjvCTHyEUKjCcKfVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB9992.eurprd08.prod.outlook.com (2603:10a6:10:490::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 06:08:48 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 06:08:47 +0000
Message-ID: <1896d060-1079-06be-3a2f-373dc99ebe2f@wolfvision.net>
Date:   Fri, 28 Apr 2023 08:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <419c9d72-9791-46ff-8317-b4dfe2e2d0a3@t-8ch.de> <ZEf5rfzs22HtQivB@nixie71>
 <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
 <ZEqvgnhzm7r4O7hz@nixie71>
Content-Language: en-US
In-Reply-To: <ZEqvgnhzm7r4O7hz@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0279.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::46) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB9992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c57187c-8e2e-4423-e922-08db47af077b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36ARaBrhAZ+rtNLN5iygu4AUnKczdXbiRjAAhACRo+ZXGkLPELaZ1HwpSp1FWYp018On95S2wwyvpgPoDKr1MsOa/iykSLWkAmaw9XYC/mx7ytuTLKm7H0i3aMlegW2TolBuuqayEsEOfNcFuB8jsgSVu2DJz2THyrJOXGZxbYiFbKotEnzG8yqCxhzeb2ozesfDy6vcDnrANV9bkX4XM6svXmUz6xx6b3CnX+ULzlUILkFUxw+VVI34a4/Q0qOdCcdzaUH4T5xHRpJ0bfDCWEhEfINCmWPeE1NYsTv1A5iKYs4whAc6eBiMIxDJxUr1OjTlqWnpW6EgV1Kz92Qrv1HbNzBa7i4E3klZMzYQz+9mRB6ORdnkvbVbHirsqtZOffAyqZjt3x0TmXjbeLWqnzQpLT9pCtKHhLlZIJ5kHPOPLlch90XQsZ8DnsofrgAhmkd6M1+jp0IpSm0yh0+jRvJwArrN7qhd8nJSmE5T5Ht4aq7NaYlGksemadlo3MEkLF6NAOYtYKyM0MaQ4rkGuLPiaMoHyCRbg3kbDT+OT8xeqmiClrRdBm3VH4ZRT+nn3bbKfIDx5bJIeQhgocAUiRRSLJhyBzuL+DJQvNHMGOssULejOvfpVxhzUX3gomNwzd3DbQG+N6UB1qTBTQVNTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(376002)(346002)(396003)(366004)(451199021)(53546011)(6512007)(107886003)(6506007)(186003)(2616005)(66899021)(31686004)(966005)(66476007)(66556008)(83380400001)(6486002)(66574015)(6666004)(36756003)(45080400002)(44832011)(5660300002)(54906003)(316002)(41300700001)(478600001)(2906002)(8936002)(31696002)(86362001)(7416002)(38100700002)(66946007)(6916009)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJpdzlhdEZxa0pjQUgvdE9PQWlxTmhvbmZvY3E5UFh3aHFXbHB1d2NCbDRP?=
 =?utf-8?B?cFYzQkxiN2VwZ0VwdkF6bzI1WmJuNEZtUFdEUDRyV3BLSDl5K3U3U3lkM2lL?=
 =?utf-8?B?ekNva3RPT2VRcU4wYjU1dUhvZHRGdVYxMUV5d24yYklMZ051UVd4OWtBOXFS?=
 =?utf-8?B?UlVxZnNlWVhBRlV2OCtLcWlibk5uMU9aYW9tZ0Nkcmh5YmFkaHZYTUZHZGFX?=
 =?utf-8?B?aWcwWDBmYVI3LzFxS09RUXRveUlkbjRhN0VoOFZxUzRGWnlNb2pjSlk0OUlQ?=
 =?utf-8?B?SFYzbkptTUxpS0xvalVQbEFLUUhwK2pNMXhxdklCckY4ZjBwZW5CL2tDcitk?=
 =?utf-8?B?QU52ZHBqb1QzZE9wYWNNeEhPVWhzS1dDelovNlJRWXc5WTh6UTRRNkFFb3lU?=
 =?utf-8?B?M0wzdVgzMW5qdHJ5eGVuRkFMMHdDKzZCVHZ0UWl5NzRvSjM3QVRPN0Eyb3la?=
 =?utf-8?B?eUNkVk45RDAxVjMyeHgxMXRuY01RQzV1UHNGU3I5azYvV05WWGlLUi9lVFlR?=
 =?utf-8?B?QXpCWlZBUjJ6ZVM1QnVsNjZPelQ5eHRoWjUxMUl5Ky80QlRrOXRuY1VLUDhX?=
 =?utf-8?B?dndQdWhCUWRLamh1K1ViV0s2S3BGRUtMQnJLcnhVWlI4dHhTeFdSR0l5NEQy?=
 =?utf-8?B?VkhhUUxkbWdCYnd6OXdNYU8vK1V4YWNuT2diQWxFN0xyMmRPdktzN0hmS3Zy?=
 =?utf-8?B?dEpJT2tyOFBucXdNVlhBVTRrZW9HZUNmb0ZKVVZwbmxYZnYzVGVzS0NhZDBJ?=
 =?utf-8?B?RFpKR29uUWJ6elN1UHlHaWVDeVlZMnBJN2luYmVodzVqRW5CcWJBUVl1Rm9h?=
 =?utf-8?B?MVBlNWtkRE9EclhkdnA4aVRaVXo4VHhUblNhZ0t6amVqSFVOL0dLZDErWEQw?=
 =?utf-8?B?WnBhdTdtMVhISFdTQk94K2xsV3RKckhPNVFHNWhIN3FkRVdseWJOWEdaaWdC?=
 =?utf-8?B?ankrZGhLMkdHYXJKVXFabGw3djRReWloTnhzeHFrUmU2R1h3aExWT3lVTWQ0?=
 =?utf-8?B?NW9lMldlWnB6QWlvS00zbnZyOUM5Z1kyeTZzSEtKTm95dmpXNGRRRU14UTRE?=
 =?utf-8?B?L3QzTVFxSjFiVmk2YUk0S3ovUHQ4aXRkMWNPSnV6aTN3QnRTbjdoYkplMkNv?=
 =?utf-8?B?L09IaGJxMnlRVjZPVjlZSkV4SmNQeU9ZNXlwODJuR2dQK0dxdDdSNlVwc3h6?=
 =?utf-8?B?V3g4bEZUZDV2L0J2aWw5SExUbWgrYU4vcjhpUlhXeUNoTkVYRERQaUlrTk5q?=
 =?utf-8?B?TDFXOStncHdIays3aWlZVzFGeFUxTGU3S3BHTC9lY0FESWI1WFNBaTA2WElW?=
 =?utf-8?B?OVVuNis2dWRqQXBwM3RmQWFKUi9pUnpZM2xXNjYrU0h0UmlJNENVRkk3SFEx?=
 =?utf-8?B?V1FVcVZCcWVvV1BnL0d1M29xd3hxbEtTODNJNmNPOGRoN0p5YWFNNHpsMk91?=
 =?utf-8?B?OEdtaE96WGxaajFhYU1QOXhzd0xENjY0b0pyYjBFS2paS0NPNDM2a25MTUk5?=
 =?utf-8?B?ZERDMThXbXNncEFWakgwYkVtWDFLdDlRWjduaFZZNXZodnV6elh6N093TGo4?=
 =?utf-8?B?OUVkZWdCbG5RRkxvcFBPbFEzTFBBR2srNnBrQU94d1o4eHJEZ1JOWnlUU1dR?=
 =?utf-8?B?YzZqMGpuZWNGakdSQ2ZUNFlYUkxGR2I3N0g4Mzc1Wkk5b1BLd1VPWHpDTFVs?=
 =?utf-8?B?cnl6Q0tYTGZvQ3hTT0hhQi9FNGdMdnZKaEtubXhRc3RMOW82NzJ1V2dWOU5m?=
 =?utf-8?B?RFVqRTRFQXJWY1o0c1FyeXR0VjkxQTFlOVJtMjQxb3hzd3Nqcmt0VXJCVFY0?=
 =?utf-8?B?ZGhubHB4cUtyVFB1S3RITGJaUEdSbHZZbHdvbEdOZmxOY1ZKdzRXa0VtbVMv?=
 =?utf-8?B?eXZpUXRNRERjUWo3Rnk3VXRaUWU0QnU3N2xRaVZ6L1U4ZFcrZjVydmRhRnp0?=
 =?utf-8?B?TnduYitxZFNJOXQ5Sm44S1Q1b3N6SHVSMU5UVUNMNHUrbVBkY0lMMmNsbHBK?=
 =?utf-8?B?MWNzenorM3FpQXExM0NNWXB6eFpTOW91NEZqeFdmdkFwWXpuSDRBLzE1dGtv?=
 =?utf-8?B?NHFwZE5UR05Vd3dRVFZlcStLMENraktLOFBkaE4vQWRGdjNHTkRGL2hNL2F1?=
 =?utf-8?B?c0kwOUh4eFBrZS8vT1pVc1duVDYvWFFSNGJzRnhnQzl0Zy93L3htT0ZDeVdJ?=
 =?utf-8?B?SjR4K3dSdmo0RC84azd4REF6M0w1ZVE2VU1IbDQxSTBQQm1sb0FLY2FhbUt6?=
 =?utf-8?Q?bkVocvHBXQLJQ7BYQ6GyRVmIBmlun3Qb1sSnU4azYM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c57187c-8e2e-4423-e922-08db47af077b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 06:08:47.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZqr1VKXdxdA3RXYHhPW66OJLRzMarettVssCy54JLzIc6lGtLom80SHzBVaiFgxUnVQCkJ8V6byQLUinc1Vr20ml/nZ6fZkM9JCOrrSugE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9992
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 27.04.23 19:23, Jeff LaBundy wrote:
> Hi Javier,
> 
> On Thu, Apr 27, 2023 at 05:59:42PM +0200, Javier Carrasco wrote:
>> Hi,
>>
>> On 25.04.23 18:02, Jeff LaBundy wrote:
>>> Hi Thomas,
>>>
>>> On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
>>>> Hi Javier,
>>>>
>>>> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
>>>>> Some touchscreens are shipped with a physical layer on top of them where
>>>>> a number of buttons and a resized touchscreen surface might be available.
>>>>>
>>>>> In order to generate proper key events by overlay buttons and adjust the
>>>>> touch events to a clipped surface, these patches offer a documented,
>>>>> device-tree-based solution by means of helper functions.
>>>>> An implementation for a specific touchscreen driver is also included.
>>>>>
>>>>> The functions in ts-virtobj provide a simple workflow to acquire
>>>>> physical objects from the device tree, map them into the device driver
>>>>> structures as virtual objects and generate events according to
>>>>> the object descriptions.
>>>>>
>>>>> This solution has been tested with a JT240MHQS-E3 display, which uses
>>>>> the st1624 as a touchscreen and provides two overly buttons and a frame
>>>>> that clips its effective surface.
>>>>
>>>> There are quite a few of notebooks from Asus that feature a printed
>>>> numpad on their touchpad [0]. The mapping from the touch events to the
>>>> numpad events needs to happen in software.
>>>
>>> That example seems a kind of fringe use-case in my opinion; I think the
>>> gap filled by this RFC is the case where a touchscreen has a printed
>>> overlay with a key that represents a fixed function.
>>
>>  Exactly, this RFC addresses exactly such printed overlays.
>>>
>>> One problem I do see here is something like libinput or multitouch taking
>>> hold of the input device, and swallowing the key presses because it sees
>>> the device as a touchscreen and is not interested in these keys.
>>
>> Unfortunately I do not know libinput or multitouch and I might be
>> getting you wrong, but I guess the same would apply to any event
>> consumer that takes touchscreens as touch event producers and nothing else.
>>
>> Should they not check the supported events from the device instead of
>> making such assumptions? This RFC adds key events defined in the device
>> tree and they are therefore available and published as device
>> capabilities. That is for example what evtest does to report the
>> supported events and they are then notified accordingly. Is that not the
>> right way to do it?
> 
> evtest is just that, a test tool. It's handy for ensuring the device emits
> the appropriate input events in response to hardware inputs, but it is not
> necessarily representative of how the input device may be used in practice.

You are right. I might have been biased by my use case though, where a
touchscreen with key capabilities is is exactly that and there is no
reason to ignore any event if the capabilities are available.

Well, props to evtest for being representative of at least that
practical use.
> 
> I would encourage you to test this solution with a simple use-case such as
> Raspbian, and the virtual keys mapped to easily recognizable functions like
> volume up/down.
> 
> Here, you will find that libinput will grab the device and declare it to be
> a touchscreen based on the input events it advertises. However, you will not
> see volume up/down keys are handled.
> 
> If you break out the virtual keypad as a separate input device, however, you
> will see libinput additionally recognize it as a keyboard and volume up/down
> keys will be handled. It is for this reason that a handful of drivers with
> this kind of mixed functionality (e.g. ad714x) already branch out multiple
> input devices for each function.
> 
> As a matter of principle, I find it to be most flexible for logically separate
> functions to be represented as logically separate input devices, even if those
> input devices all stem from the same piece of hardware. Not only does it allow
> you to attach different handlers to each device (i.e. file descriptor), but it
> also allows user space to inhibit one device but not the other, etc.

I had complex devices in mind where many capabilities are provided (like
a mouse with several buttons, wheels, and who knows what else or a bunch
of other complex pieces of hardware) but are still registered as a
single input device. That makes the whole functionality accessible
within a single object that translates 1:1 to the actual hardware, but
on the other hand it lacks of the flexibility you mention.

Nevertheless, in the end this RFC applies to touchscreens and if the
existing tools do not expect them to have key events, they must be
advertised in a different way. And ss I want any tool to identify the
touchscreen and the keys properly, I will go for the multi-device solution.

> Maybe the right approach, which your RFC already seems to support, is to simply
> let the driver decide whether to pass the touchscreen input_dev or a different
> input_dev. The driver would be responsible for allocating and registering the
> keypad; your functions simply set the capabilities for, and report events from,Y
> whichever input_dev is passed to them. This is something to consider for your
> st1232 example.

I would let the drivers register the devices that fit better in each
case according to the objects defined in the device tree and the
hardware configuration. Of course I could include the device
registration too, but that would probably reduce flexibility with no
real gain.

This RFC will not work out of the box with several input devices from a
single driver because it sets the key capabilities right away as it
always supposes there is only one input device. But splitting that part
is rather trivial and the rest does not need to change much as it works
with generic input devices.

The st1232 example will need some bigger changes though, so that part
will change a bit in the next version.
> 
>>
>> Thanks a lot for your feedback!
>>>
>>> Therefore, my first impression is that the virtual keypad may be better
>>> served by registering its own input device.
>>>
>>> Great work by the way, Javier!
>>>
>>>>
>>>> Do you think your solution is general enough to also support this
>>>> usecase?
>>>>
>>>> The differences I see are
>>>> * not device-tree based
>>>> * touchpads instead of touchscreens
>>>>
>>>>> [..]
>>>>
>>>> [0] https://unix.stackexchange.com/q/494400
>>>
>>> Kind regards,
>>> Jeff LaBundy
> 
> Kind regards,
> Jeff LaBundy

Thanks again for your feedback, I will keep your comments in mind for
the next version.

Best regards,
Javier Carrasco

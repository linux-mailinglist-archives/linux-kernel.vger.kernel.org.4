Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347406F08E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbjD0P74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbjD0P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:59:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B921989;
        Thu, 27 Apr 2023 08:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeSVpf6fgAk9RbfuwoUqxOYKDtIIy+C9HYNZCmlqi+90Pj4995I2iesCRpGLOO1XlC75Tx9gEiyZcnuWBifJMJz0LcAMK7pqVqBHbDRu9lqNl/htB7vU+uwL3yzuSLkQhyBxnyWf9M+5rTWsjeoO5kmxO2uXF1TUBAIEjEy/W+rWhdfgRPV+a1/cePS9QeWuzCe3qR2oXRRTGipepVdcrJ3d/AR72MAZCDu/PO3SOev7wpRvFI/uZWEgMrdIkKVA2hrP53p08ULrO5pkYzJ/YltOrmkSUChBNqPOPPFU+K6lwQ2wWHAVAgKNXaJlEbL+ThDVPe2dBWr9rj/85tItIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYJEJ1pfXBm8i0RBqYnM9qja+ijU93cy2jQiKNVXj5w=;
 b=E6Dzsgzg7dYaJqI7cju7gc7np/cWqixFG1pGcPwi4v5mgBfxwjETQjo4T8L4SSfvquzd+0lFzPJYwybYkaAw82YctSe0bS28s9jt9U1NYqdsh1ey2V3IyC9Mmoz0uxyDlMBxv89Q+YKzyyezcgDjyEU6z6IEAp8JlMRP78qQZ3rPcumwrV7wtQJC4pc6uOVycqn8Fw87C1SqAhWo452RENLBD/9yLXhcI8/h2qTm6mJsOV0XaLXwdXbp43Xf/oWaDiT44boH0GSAGl2Z8tjn9944fyH3g3+P2GeDnGmTkPEYUxVtJyhKBanRLXxJg5zLkqzFR5Nkv+kt5idAJtjlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYJEJ1pfXBm8i0RBqYnM9qja+ijU93cy2jQiKNVXj5w=;
 b=Zrwe+G89Xmu2+2iSQFsCBnARRC+EhcLYnIEGTH+0QX/ku6UwB+WHo30NoM7f7IvCTciATBEoQgMpd2F21sVegmhFqClmLazgK6kakk7ckkDaUmMvnhuW5Y6og/Jz2050vW7oCVmfh4OMuJFYu6pnl3PhDwrud7ySqJMDKtgH9gY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com (2603:10a6:20b:d4::23)
 by DBAPR08MB5831.eurprd08.prod.outlook.com (2603:10a6:10:1a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:59:46 +0000
Received: from AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::b0b:e088:c212:d47b]) by AM6PR08MB4966.eurprd08.prod.outlook.com
 ([fe80::b0b:e088:c212:d47b%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 15:59:44 +0000
Message-ID: <aa6125d9-1233-7aab-1811-29acd4ad49a5@wolfvision.net>
Date:   Thu, 27 Apr 2023 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
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
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZEf5rfzs22HtQivB@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0701CA0040.eurprd07.prod.outlook.com
 (2603:10a6:800:90::26) To AM6PR08MB4966.eurprd08.prod.outlook.com
 (2603:10a6:20b:d4::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4966:EE_|DBAPR08MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6dd45c-49fc-4b19-49dc-08db47386b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPMbIMyGdBq/gjZFnHk1nA+M50LBtn7t0BCY5BIpRqVv/ICwt5HbHYit1PHpk1+jAK8o4kp9vvnF7TZR/k9oxSjzMdcEu42qy6rUgki3mOYxQ0gLsC8uJbgTZJ0J8T6oWGxTZ7Y8GIhuthgXy3bgMH+NjJDYHgpW8mMkPXtL+TS9CyESZEiIzeYvMW1Z7DaQWzS24AlgLBFy6He6UAwqBC3gh0CYok3JMXVGyMKfWl8TW6SMx7vszecJOWSkpfsf6PlliKK5Cc7/w86nW74ROwATMmGXh6FiyuSgdsOi5UdyGZZj6/0apjXSz1qajFEsA+bnKoet+NyqMoUWlPfOYzKU/NUO0hj3UPpIe04I8Efa5C8d1MT9J81i8lmABaqIY6Dl5TcDP5s5TAvClaa7yp6OLKdtWvtmrED31vRiMzPB/gDo99zsYlsdy6h6CAww15EBo89DKjQPCaOUk0/VQ2egEdylRvxmAHBn+tsdw0wXCdJChwNLf/Vj7hqABzrfBFbcxQNUDb79YcC4qTBqvqLoO1tDQZEIxlQmRxoNXYWQ/KvoTV5bUlsFzHjyY+AsXxI3ms2325gQHwN2UnNiuJH0I3b8pG9YZ1dWZ0E5zml+NmITb9FOzPE32O/nZYm8A7wjWT1xXffCpcpWnLvkLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4966.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(451199021)(110136005)(4326008)(66946007)(478600001)(54906003)(7416002)(8936002)(8676002)(38100700002)(41300700001)(316002)(5660300002)(66574015)(186003)(2616005)(83380400001)(6486002)(45080400002)(53546011)(966005)(66556008)(6506007)(26005)(66476007)(107886003)(6512007)(86362001)(31696002)(2906002)(36756003)(44832011)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFrZDZ2S3dBMnpRc2RhRFlvbVY4RDl2NXJadXdBMllRcWNIZnBpdlBVQnNN?=
 =?utf-8?B?a2JhS2ZJTzUwanJiUVZrZ1FaR0hSZ2oxZjA5THFQNUpyZmZmTnExMmppUHBK?=
 =?utf-8?B?ZGc1azNIUGJ0bGI5d2ZFMEZybWs3Y0NPZ2srVTcwTDdxRnlMYnUyZEtPUjJa?=
 =?utf-8?B?V2N3NFFaUm1XbktiY0FBeFV5Z25kcnNYZlczeW9lUnRmOC9lUDdlc3V1cG4y?=
 =?utf-8?B?UDZmcTQxT0dZdzR6a2dvVElOZmcxdDk2SGxzT3QxNkNZTXNEVlh4cm1jWnhp?=
 =?utf-8?B?dGxNNnp4OW9PVWovRnprNDc3OXRFbFVYb0xJcEoyTlJaeUZHenY1V3dCcXBC?=
 =?utf-8?B?T3luaG42b1VJSXZjSWxkSWZLZkFteTI2Sjk4MGt2Z2hXaG0yTXJWS0xiNHV6?=
 =?utf-8?B?QlJPVTA5UWpiYkFGN01iQ2tySVNnOXNRR1R2K3J3Wk5ickQ1VUZ1U04xTjVk?=
 =?utf-8?B?RHdFcS9nd0VoZWJIQ25IallPUmZ0YW42TlkzUnh1Z1Jmb2V2S29vNGliNHlw?=
 =?utf-8?B?ZC9MMGdia0tVUzZhZVZXNDJVSTZ5TXIwbmNXblY5V20yUFdvWWlWSkU4RGJi?=
 =?utf-8?B?RktSdzdlWVI0QjdSbGVybFFXd0QyMU1hZHRmN05tWGsrd1VJUUJsUFlGQlV1?=
 =?utf-8?B?OEtSZTBOYWZ6eHZyU0h5SEc5NkcrSTdLdXlrQk5NMUVqazN3YS9PUFJjL0Yx?=
 =?utf-8?B?MUhtZWdGbEYvOTFYODdhNXJDVDdsS0s3TVRveE1BZC9RQlY3UWxyM1ROY1ZK?=
 =?utf-8?B?ZEx0eEVVNDlkcmdBN1Npd1paZ2tUeklXNXVUTEV6Snk2TE5xb3BlOWwzdE9W?=
 =?utf-8?B?TGl0cmR2OFZKWk9obDdNTmdyaFVrMnMwRzFIU2NVVWlXOWE3MkNRMXg2V0Ix?=
 =?utf-8?B?STJhMkpUR3BmbzBOSGZJNjBtaVRDblovWlZlL3Y0dkd0UGVtZkpvS3VUQy9v?=
 =?utf-8?B?T3Y1eHlEaEpHY1hNQUoyUTNkQVJnTjJSejVnbG5lelRuNXFNSXppYkhzU1M2?=
 =?utf-8?B?VWdHS0tvbmhwS2ZKOUNOemxCbTc4VkROVGYwUjZYUzJ5UnU3T3BXZ2prRjJU?=
 =?utf-8?B?bTFRSGJEVlV6TlZWMXk0TExWdXFlSE10alRmenVObHQ5dytsd2s3SnhqQ2l1?=
 =?utf-8?B?c0h2RWl5Vk5ycmRiS0svZlBwbXA5b0tXK25JRTlRT0sxYzhMYTVXZzRyak1U?=
 =?utf-8?B?TldNNTRaK0ZIWFJ3OVhLeFdxNW5OdzB5eVljRXAzYXA2Y2xKaFNXUXhPeS83?=
 =?utf-8?B?RkNJczNVb0xNVXNIZWY3a1NFM2sxQzNVTU5GRXBBVlZzRVNhcGt5djZPa3B3?=
 =?utf-8?B?eCtGMkx1WkU1UmxQK2l0ODJaNkF1UEVwN3lnWUZ3RWM1Yzk1Z3RFVFlhUnNM?=
 =?utf-8?B?bUtIbWltVjFqQ0VRNjk2UFpkNXV1WXJyWGh4dWMzc1cyTEphc3ByajcwZmJ3?=
 =?utf-8?B?UWd3UFZwVE93WGh3MXpWRFJTYjVBRUFKV1o1QjNMaS8yVUkwTk83bXNLeTdr?=
 =?utf-8?B?bFhrdzlsZzJnbU4rbUVwditvODhHTElpaHhVRFBndlJEeHdkbEFTMlhyNGlU?=
 =?utf-8?B?U0ZwMDFmZklPRTU4YXZXUVVxSkV6SWJTNVJDSU5GU2FVRVh3SVYvcmgrMXFz?=
 =?utf-8?B?endQSmorbS9Pa01pT2lTT3l4Y3ZUK09MQW1Dd3pxbVM5amZMbVJXaHZ4ZEVE?=
 =?utf-8?B?cGRiR1NoYm8rZmtncGlOeWI0L3A5VG9nS1dtQmRwM1d1aittU0tiMk1Yb3p2?=
 =?utf-8?B?WDQzeUltTXllcW56OFNLbXpMUVk4NjZ4clNvMTh0MmpoUGQrM2U4WS9IVDB2?=
 =?utf-8?B?VXpvVFAvT25PcjhFNzM2TDgrc29xdis0Wlo4QitXSHlyQkpRNGxwblNPY1Vp?=
 =?utf-8?B?RWJ3U0JTMjVvQnA3VmdGZ25NOEpwSTRiU2x1bVBuL1Q3SGFKNFBZYjhBUDNy?=
 =?utf-8?B?RytZc3NtTzJTUGdJNEFLc1hrMkJIUDMxOHlkRGltb2pqd2dnTldCd3Y5Q00w?=
 =?utf-8?B?REZHWE1KZzdndENIVkw0M2pObG9RTWhENzl5ZHdJMnVzK0JjZFdIYmQyd0RL?=
 =?utf-8?B?b2RQd3VpcWZSWGZKajZsWUZpL1NFVzBYR3p1aHJ6My9QZ0o3OTl5d3kyeWFB?=
 =?utf-8?B?ckloTG5vdGh1QkpEcmtla0J1QnN6SXlyTXVSdUEzcWVvYlpra3hId25HNzE2?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6dd45c-49fc-4b19-49dc-08db47386b0a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4966.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:59:44.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtovrspnXg9ijxgHxreaUzQzgu+35SDz9WXjB3pknCdMiApnaMm7oWPFMvI8s7gmcFkZEJ4/9bcgjJ0BqNlv1x6IB5ew+sDV5/cfgp7MJ+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5831
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25.04.23 18:02, Jeff LaBundy wrote:
> Hi Thomas,
> 
> On Tue, Apr 25, 2023 at 05:29:39PM +0200, Thomas Weißschuh wrote:
>> Hi Javier,
>>
>> On 2023-04-25 13:50:45+0200, Javier Carrasco wrote:
>>> Some touchscreens are shipped with a physical layer on top of them where
>>> a number of buttons and a resized touchscreen surface might be available.
>>>
>>> In order to generate proper key events by overlay buttons and adjust the
>>> touch events to a clipped surface, these patches offer a documented,
>>> device-tree-based solution by means of helper functions.
>>> An implementation for a specific touchscreen driver is also included.
>>>
>>> The functions in ts-virtobj provide a simple workflow to acquire
>>> physical objects from the device tree, map them into the device driver
>>> structures as virtual objects and generate events according to
>>> the object descriptions.
>>>
>>> This solution has been tested with a JT240MHQS-E3 display, which uses
>>> the st1624 as a touchscreen and provides two overly buttons and a frame
>>> that clips its effective surface.
>>
>> There are quite a few of notebooks from Asus that feature a printed
>> numpad on their touchpad [0]. The mapping from the touch events to the
>> numpad events needs to happen in software.
> 
> That example seems a kind of fringe use-case in my opinion; I think the
> gap filled by this RFC is the case where a touchscreen has a printed
> overlay with a key that represents a fixed function.

 Exactly, this RFC addresses exactly such printed overlays.
> 
> One problem I do see here is something like libinput or multitouch taking
> hold of the input device, and swallowing the key presses because it sees
> the device as a touchscreen and is not interested in these keys.

Unfortunately I do not know libinput or multitouch and I might be
getting you wrong, but I guess the same would apply to any event
consumer that takes touchscreens as touch event producers and nothing else.

Should they not check the supported events from the device instead of
making such assumptions? This RFC adds key events defined in the device
tree and they are therefore available and published as device
capabilities. That is for example what evtest does to report the
supported events and they are then notified accordingly. Is that not the
right way to do it?

Thanks a lot for your feedback!
> 
> Therefore, my first impression is that the virtual keypad may be better
> served by registering its own input device.
> 
> Great work by the way, Javier!
> 
>>
>> Do you think your solution is general enough to also support this
>> usecase?
>>
>> The differences I see are
>> * not device-tree based
>> * touchpads instead of touchscreens
>>
>>> [..]
>>
>> [0] https://unix.stackexchange.com/q/494400
> 
> Kind regards,
> Jeff LaBundy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990A36187CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiKCSlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:41:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67E2638;
        Thu,  3 Nov 2022 11:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSAwM0NW1VjCbUVd0mohu0FKO9mhCQwytSmweIpR//pM+DwNLND48QibPgMLa2mEAqvKG53RVUxkzhs+9sdko7b9Y3BxHFaMW5lK1v+u+q+OvINdvFfxVzBiTz+cFWdliZshf8KcP2vwrXRjHCigKV91U1zzjqWKrZM8OIGHjfY/k077tjO/vTaTLrhif8gLbLymAxw1N4NGWx+z4Ds/ocF1mtcxcHGWArLJ0GYOwsQeVuzG1vAfbGm9Ub9rEeHec+bIfTf0+nvnAOn1ECs7CBwxYEEeiQLDlZtae90GW3KN/RLufylxOYJ6iOgH9O0NE18984oxzJmrrcx5YdO/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+WjX3WCd7rPK1e6XkvxBrA7iAfWJe8JkPjikmIL01Y=;
 b=XJrE3RkDEybOiUf7HwGDIvii/S3LvZ9Xal4onIZXPzakjRuifYT4VHCwSvDdq01H62lKUXcWnpxs7YdIZGwylI4aqtu2Jkc0x16bflGH5XIQaNeOls0lVk08t1YrEwTIQ8Sq+VNTqZNBEBIJPkKYLLIhqrEmtppUKKmq9Dugi8p/gPcDedxAzAGFcRtHOthxRw4kW8OHXYDGRVB0/ZTq3sDvKAVayNfkdbixpkUd2QDQmTWb4KlAktBqHQTJoht9vJQQZNvTYI4P0LuRJEGGNsRaSoOChKnQZ6xCDrAIURU3dRFf8AtCUm1VVbXBi/0A1bVoUsDuA/+jTQza6VYcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+WjX3WCd7rPK1e6XkvxBrA7iAfWJe8JkPjikmIL01Y=;
 b=P32Am70NPX/NxSq8XMzFZQ9AXWMknesvH8eB5Rqn7SrR55LpqiqHPpTFI3FnfsIme/TilS6vi1FU1KlIdzrIDiLm4+NqGsmJKsXrXdllAIvQtLlJbsFJb1Lk2ua4elT0l5lU9peUzhlixWY9y1kXPBKuDzmSrmS94GS7x4SdUuzElchrLgnu5JS7v88ED+ti2sLDr19wtsdHTgWlnKwfE4Y1VZyg/QK3oXYTVUDFEtRtsBvRh+QZ3PEFob+EE9Jq/apN6sDUacpUZQrna368zS+mk3EjLigSwz7MX8kJ+vQNipSrYeOS+oLMeiHeB0WbRkNeJUApKmZOlB+k3U85eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 18:41:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 18:41:16 +0000
Message-ID: <267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com>
Date:   Thu, 3 Nov 2022 19:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 1/7] Input: goodix - fix reset polarity
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, hadess@hadess.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v1-1-87b49ae589f1@theobroma-systems.com>
 <1fa371bd-78a6-bb7c-4692-1d8132ec2ab1@redhat.com>
 <Y2P7SsPa04975Rkm@google.com>
 <692fd16e-4183-d58d-802e-2b83563aee4b@redhat.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <692fd16e-4183-d58d-802e-2b83563aee4b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcef8fc-fae5-436b-a1f0-08dabdcafd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTkux9J55AvebI+9XPzadU7lYFMiL2mJWDMfcwmP3wphBja/Zg0kP2n1alTE67vTLcBJTykyBPbmo6ytdegHeXhgTc1D/Yb0LLcICpnckjGshJh3bKWA40MEBmHbRj/5IF2cDKR08v8J0KVgMjXZioJQhk1Xm4h4kEg5r6TpKgJI2jpCGOeB5XHm1xTEh8ZcwPYvsNGyjBxx70RNllc3Z121Cf7g/kSi4caB12yxQiihnPqDiajXxAZ7vsuOAUWIEFZf719EqXi60QHG4UaRawW9WY8Cof/NkZrB9UnlZ3TfpaOkOr8zHTFwp4B6iBsrA8kUGAsEx//J+g1zXLWScXZtiF6Z+LY7yCdf2lTYRYII1sGTxhyOp6LEMR51sOARiFoL+bmfBUkbFzqLP4o15ZChJ4+IYKoX6cJWeMdQW3KXi7i6l1yhK7cEzNjDqXbpQTCL/3ivOZuJEuGKtUJKEI5fAOn4gnczV9Je++veVkwIoG/pIQpK8P4qqpzilWGexSHkFTqfnn6L8U8SQzSOZvcujGY93S/DntSLLZWnA83tPQ6Hib1GztNSdH1m/ydKfDoCo/2b8LRCM3YMPiTc+QjXif/VONKnJln6M5niXUDMQjYA2ljxcHn5BPFe0SznkCW8T4h+0Roy3+K7csi34G50OJ0Ux+37k3xeEXRwVNszSTRXf7mKYEKm2/CeF3Jn5I7cJtIEKqY/lzeZA8jfWEwrR2sCd55XbttncjVS41LjT/1lbMSZqqv7y7HkjQL2oYD8TnjjO2AsssjZv3EoAZHn/Yw+llws+PDTR08UDbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199015)(66899015)(53546011)(6506007)(31686004)(6512007)(26005)(31696002)(8936002)(86362001)(2616005)(7416002)(186003)(5660300002)(8676002)(4326008)(66476007)(6666004)(44832011)(6486002)(478600001)(66556008)(66946007)(110136005)(83380400001)(54906003)(36756003)(38100700002)(316002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJjSXhEcEM0OGdHR3YvNHNhUENCVS82QmVJWWhhSXVXZzFsNmlqWjlMbTdp?=
 =?utf-8?B?VXdWTDN0VGJmc0lvMHZCdHlnbTZEVldKY0lNck14SEZrL1V3cGM0dyszUlBN?=
 =?utf-8?B?QlhVUE81VkVwOUFWclY1MHh0dEZPc0Z3Y2cwNXBwR3daSjVTVkIvRGw0NFN6?=
 =?utf-8?B?dGtwcVI0WndPT1F3M3VDUnEyM0FDMW1CT1RXSzU1QWc4TFhkaE14Qi9KN2p5?=
 =?utf-8?B?REt4bUNpOWNXb0JtUTFDU2hGU1JORTJCRUY3TnZITis3emdIMExnL1dFWjU5?=
 =?utf-8?B?c05uWWN6TTlwM1l4Z3RGMy9iVnJxd1Z0QW9GYkFMSk5DOTU0QjJ4eVBud2lQ?=
 =?utf-8?B?ODhBMENWNGJ1UDlLVmJWWjcwc2t2d01HUGRjSW9sSW9lSWhXUU9OYVMwenlE?=
 =?utf-8?B?bnpuYVRack9hZXg1aFJNSlFRWldmUWVZNlU1VzFFNElzZjVXMVhNb0ZpSHdk?=
 =?utf-8?B?b0RzM3U2cmdlYzdlOGY3cTZlRzVGNDZwZ0tvVXMvaW1EMm9nMXdmTmltZmFS?=
 =?utf-8?B?UnRrbGhLSHN6YWtieHZROS9OSk81ZW5YYXN3NXZNdC9sM3NLaGdWSlNJOXdV?=
 =?utf-8?B?dWNKWG92V2kxVmdYMXlTRjRGMlNoeGZQT0d3Zk5VRDNhR3JUVDZOMWJDb05i?=
 =?utf-8?B?SnFnMWx2R0gxdjJSb1huT1JHMHRIZEh0MWtpWHEwUVRVNnFrWk5vYVpJYys4?=
 =?utf-8?B?TjdSc1dXc0JxSiszTlV3MThEeHloNzNuZ243empidU44WGF2Q0dSdS9qUGQ0?=
 =?utf-8?B?YkRoWE1YY3ViMDBhb3ZUbm9LQ3UxZFZoRmVBRk1mSExqTGt6dWU2bHd6bHdB?=
 =?utf-8?B?cS9VR1oyM1dsRmIxK1NNYlpXUWdJT1BWdlNOM1MwWWpuNStaZDA5SlZXUnRE?=
 =?utf-8?B?d2tYS0doZU9ZU1NGNkg3ZGVEcEQ2Mm5KVjVLVTV0OXZvWXV6SkRHbzhxWjhz?=
 =?utf-8?B?UnoraEE2Sm9kVmRaSy9aK1E0U2MzeDltbUZMYkxMRG93ZndjcGhYYW1JTnlP?=
 =?utf-8?B?UDNNMXN2K2JZL1hnVXQwSStOZVp0UXptQTJmTEFmWm5namViVjJ3U2lQYjFP?=
 =?utf-8?B?WTJZQmR1MThGSmFBenAyTi9iWElkUmpEYWRrQU5wb3FkaWpIYVVFU2F3QklL?=
 =?utf-8?B?NUdaZzl0YXMzTk05YVJRRG5ndnBQdXhVek9RYkk2R1k3Z2RsS2FNQWV0d2ZS?=
 =?utf-8?B?T0JVMy8zK1BpMmJNNnhuSWJJUXRnN2xMajlpSGRibWVGbk4zUEhHV1RsNmVQ?=
 =?utf-8?B?V1BkU3drbzlEOTlXK2ZTaDE2YXhJL241bUNJRmtXVGFaKzduOHZDVTlYU05C?=
 =?utf-8?B?N2N5RnNBUk5uZmVQYzdVbDUzRks5UXlsay9Fd3VhTDJuRzlGeUFJVTFUL1Nw?=
 =?utf-8?B?QlpISzlra1piUWg5WXJXaTNmZ21aeVpmSU9LZkNick5JK2RyYWY1WWY1ZUE1?=
 =?utf-8?B?VjFIRXBWWHFSTlp4S1R1b2hIaGcyaVd5c0s5RW9xb3Rib3lUOFBjM08xNXFM?=
 =?utf-8?B?OVRDSGZ3ZjI3YlIwcFJiRXlYeVJyeUlmT1B1TlhsK0tpcHJoNWVHODcxRXBu?=
 =?utf-8?B?L3ZsanRsNjk3SWFXQWVRWGx5QjBmWnlXUWF6OGRLL0o2VUhwakYzMk9JcnFk?=
 =?utf-8?B?NURQVkZySUZmS1pkNFdycWF3MWNoV0wzNGpmYklpNTlRZGtJbnprT2NWV1Zp?=
 =?utf-8?B?NWtRanN5cXhNczEzd3NwbWFYVlFSUU9pU0paK241WEsvdG5IM3plQWNoUGpk?=
 =?utf-8?B?WFgxT09laWZvUlpsZzRGakI1eFJETTB5MXdsVHhqNzl3Ti9KWlVPdUI3UDRK?=
 =?utf-8?B?b2Rsa20wUVhhRDFQMG9ORnhBTkNPeFdaalE3eC9HT1JGYjd1bUdla3lqWUNS?=
 =?utf-8?B?ZEJSeWxram9hYm5idWdIdmpCR29UMWNGNVREWE1nZEU1S2ROMlV0RlZDRDAx?=
 =?utf-8?B?eElJM1V1WDVKWXZ6L2JLNU9vbnRKUHVncTE1S3M5OWhHZ0s5QjkrLzQrd1RL?=
 =?utf-8?B?dEtzUW56TW9tUU9jVGxnQy9mWHVHc0Z4eUhxNG41LzFBNVo1TmZDSG5OL1Yy?=
 =?utf-8?B?NVFSZkxUTlNYcjFRUmQxSTVFcWlLa2xuWjBFdmNuL3Q2NlFqNGFHZU9LSFMx?=
 =?utf-8?B?dXB4Vy9TYnR2U1FpUU53R3ZXY3dtd1dWQjhrMnp4VER6SDFNV0tzM29HaEo0?=
 =?utf-8?Q?hTnopTCxWkfZbYbID3I1LRQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcef8fc-fae5-436b-a1f0-08dabdcafd6c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 18:41:16.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf40sDkE9nIfNTQqlP+05PmDRpMx82P/o+Gi7Rk+Vxob5CRLeqlKw+NP34xOYh/wv73VZe1GKqnPJSsCjAA6fE4v3ucTFBdMJCHQZ/KRsjB3vQPw8jGIDMQeN46cGqdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 11/3/22 18:45, Hans de Goede wrote:
> Hi,
> 
> On 11/3/22 18:32, Dmitry Torokhov wrote:
>> Hi Hans,
>>
>> On Thu, Nov 03, 2022 at 03:58:47PM +0100, Hans de Goede wrote:
>>> Hi Quentin,
>>>
>>> On 11/3/22 15:43, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> The reset line is asserted for selecting the I2C target address and then
>>>> deasserted.
>>>
>>> It is not asserted/deasserted, asserted/deasserted is reset-controller/
>>> reset-framework (drivers/reset/*) terminology.
>>>
>>> We are driving GPIOs here and those are driven low/high.
>>
>> Not quite. GPIOD API operates on a logival level (think of them as
>> active/inactive) and allows platform/firmware to specify polarity from
>> the AP point of view (as opposed to device). This important if the
>> peripheral is not attached directly, but potentially through an inverter
>> or something similar).
> 
> Right and if a line runs through an inverting buffer then marking
> the pin as active-low in the DT makes a lot of sense here.
> 

It doesn't to me. /me shrugs

> But as I mentioned before the datasheet spells out a very specific
> init-sequence.
> 

As Dmitry pointed out, we're talking about logical vs physical level. 
The driver tries to enforce physical level (on the touchscreen 
controller side) by expecting the logical level (of the gpio controller) 
to match.

> By default marking all the direct-attached RST pin connections as
> active-low (1) to then invert the value again in the driver
> (from the datasheet init sequence specified values pov) IMHO
> just makes the driver code harder to read when putting it side
> to side by the init-sequence specified in the datasheet.
> 

When I want to put a device into reset mode, I activate/assert the line 
so that its logical state is "active". For Goodix, its reset line is 
active low. I do a "positive" action, so I activate something. If it was 
called nreset, that would be a different story. If it was named 
enable-gpios, I would understand. I just don't get the current 
implementation with reset-gpios in DT.

Reading:
reset-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
means that I need to set the logical output to HIGH to have a HW reset, 
which is not what happens for this driver.

> I don't see how playing this double-invert game is going to help
> us / gives us any added value, in any way.
> 

The current implementation is playing the double-invert game for me.

So clearly, we do not agree on what, at least in the DT, the level of a 
reset gpio should mean.

> And in all the ACPI tables the GPIOs are marked as active-high
> so changing this to have the driver now all of a sudden expect
> the reset-gpio to be marked as active-low at the gpio-subsys
> level will be quite cumbersome since normally the active-low vs
> -high info comes from the firmware-tables and now all of a sudden
> we need to override this.
> 

We have the information from which standard we got the GPIO, so we could 
always invert the flag we get from DT to match whatever is in ACPI.

Blindly ignoring the DT flag is not an option since the HW design could 
actually require an inversion (GPIO connected to a transistor for 
example). I'm not sure what exactly could be done on the gpio-subsys 
level to deal with this. I think we just disagree on what the reset 
"active state" should mean and no amount of code would fix that?

> During all my work on the goodix driver I have always been very
> careful to not introduce any behavior changes for the DT users
> of the drivers. It would be nice if this courtesy could also
> be extended in the other direction.
> 

This RFC is clearly breaking ACPI support. I have zero knowledge about 
ACPI and didn't know that devm_gpiod_get_optional fetches from OF or 
ACPI. It was not my intention to break ACPI, sorry if it came this way.

I frankly didn't expect this to be an easy discussion, since changing 
the DT is usually a no-go, but as is making the DT binding 
implementation-specific (which is the current state of affairs), e.g. 
we'll need U-Boot/BSD/whatever driver to also use the same logic. I want 
to be noted that I like none of the options I offered so far.

As I was surprised by the (for me) inverted logic of the GPIO state, I 
preferred fixing the driver and DT to match what my expectations were.

I'm looking for guidance on how we can deal with this, I do not claim 
what I suggest is what we should absolutely go for.

Maybe my expectations were misguided and I should just tell my brain to 
invert whatever my intuition tells me, it wouldn't be the first time.

Cheers,
Quentin

P.S.: I've been notified only the cover letter made it to the mailing 
lists, so adding the mailing lists in Cc right now. Hopefully enough 
context is left in the mail. Apologies.

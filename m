Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF12E6E7F81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjDSQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjDSQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:22:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7519773;
        Wed, 19 Apr 2023 09:21:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy21so40248305ejb.9;
        Wed, 19 Apr 2023 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681921318; x=1684513318;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BEvd+Ckhfg92pd/KODoBmrL0OH00ykJT8cB5I+RP/8=;
        b=LblpJsms5ybwCCZcdSpJHeE5wh5fwEK5Dq7hrVBOvCzO0AEZOE78qdsJMvbFgXot0r
         pKUUa+C2WBQLmLoeSDzyqXyOBzvZhNOGdrVAJmT+mR5CYqg1zN28qidyBa2sIdah6yrU
         ANql85gy5Y6ec6ne9KukD9xhgVkLUJ/42dmfzUm7R9hUnncW+/gotu7M5Jyc8L8HR9lz
         tbdKZPyvmQs3ZSkEGYSRPM8BWlee5VW7UDRKaBHYdMW3+u9+551nXhk9ZV3DiYw7SGVx
         zzYTKVThrvlk066b6woWwnj5Uyalepkgmf//XBhSD4Ed3rgmALQ//AgCRRITsVCxrJcA
         2nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921318; x=1684513318;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BEvd+Ckhfg92pd/KODoBmrL0OH00ykJT8cB5I+RP/8=;
        b=Z5+QqbeFMwIvznImBhuwAP35f+pwbc2e87r9UtW7Tauuj5ttMYS8ZueoaewFPp5qY6
         lsj5OoSomP9urH4G4ns5KGarAJpCZDbUYcv+oGOlt+zGTV+ZHJeSQbQ0gVspyEiMe3Hc
         wNW/29AFSIlZrOS8gzi6hAPUu/WrVcsi9NXzJPgYqrUEfUfGmdu9fp7q9SxN7K+A4PDt
         wyLSfkZ8uDQ0KNmUMMVcIY3qmbNGNpBSqWtF1oRCJKWWNLSlzjnBFgePKe6AeEjV7ATM
         ULFuH30G48ib5E+Kuym8CBfdl1TJfBhVJHIzwl1XnBbKkFaGQSDO4c+tYAKw3rcpLR9k
         Vm0g==
X-Gm-Message-State: AAQBX9dpYFcOYKN8cvtz4qGe/koW78RIhWPhkx3O20EvI5GgYlhJGLCg
        OxDw88vc81JfzS+O1il1a7o=
X-Google-Smtp-Source: AKy350b06YeOMKY/GSVYDQZ/QrxVBtpQ9wR4js7+KniwtxAqj4Nli9vG7PpXMWczRAVGaexGhqRjJA==
X-Received: by 2002:a17:907:8a21:b0:94f:3521:394 with SMTP id sc33-20020a1709078a2100b0094f35210394mr13935287ejc.51.1681921317551;
        Wed, 19 Apr 2023 09:21:57 -0700 (PDT)
Received: from smtpclient.apple (120.87.196.178.dynamic.wline.res.cust.swisscom.ch. [178.196.87.120])
        by smtp.gmail.com with ESMTPSA id ry13-20020a1709068d8d00b0094ee3e4c934sm7996459ejc.221.2023.04.19.09.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:21:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?G=C3=A9_Koerkamp?= <ge.koerkamp@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b: touchscreen: no touch events with kernel 6.1.4
Date:   Wed, 19 Apr 2023 18:21:46 +0200
Message-Id: <E4123C4B-D6C0-4CB2-8328-E0D03599ED16@gmail.com>
References: <993dd537-2f74-3657-1dd3-c3a0a74e37e1@leemhuis.info>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <993dd537-2f74-3657-1dd3-c3a0a74e37e1@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: iPhone Mail (20E252)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

travelling at the moment, but I=E2=80=99ll try. Not really into bisecting ke=
rnel issues, but let=E2=80=99s see where this goes. Another issue is, that I=
 don=E2=80=99t have a Toshiba Mini Click myself, so I need to build the test=
 Volumio images (volumio.org) with the different 5.16-rc kernel patch versio=
ns for a colleague to work with, hopefully  he has time to do this.

Thanks - G=C3=A9

Sent from my iPhone

> On 17 Apr 2023, at 13:55, Linux regression tracking (Thorsten Leemhuis) <r=
egressions@leemhuis.info> wrote:
>=20
> =EF=BB=BF
>=20
>> On 01.03.23 12:41, Hans de Goede wrote:
>>> On 2/28/23 14:26, Benjamin Tissoires wrote:
>>> On Tue, Feb 28, 2023 at 12:32=E2=80=AFPM Thorsten Leemhuis
>>> <regressions@leemhuis.info> wrote:
>>>>=20
>>>> On 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemhuis)=

>>>> wrote:
>>>>> Hi, this is your Linux kernel regression tracker.
>>>>>=20
>>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>>> kernel developer don't keep an eye on it, I decided to forward it by
>>>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D21694=
6 :
>>>>=20
>>>> The reporter recently confirmed in the ticket that the issue still
>>>> happens with 6.2.
>>>>=20
>>>> There wasn't any reply from any of the input developers here or in
>>>> bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
>>>> take a minute and at least briefly look into this as answer something
>>>> like "that might be due to a problem in subsystem 'foo'", "maybe ask ba=
r
>>>> for an option", or "we have no idea what might cause this, this needs t=
o
>>>> be bisected"? That would help a lot.
>>>=20
>>> The working dmesg shows a line with:
>>> hid-generic 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00 Device
>>> [SIS0817:00 0457:10FB] on i2c-SIS0817:00
>>> and then
>>> hid-multitouch 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00
>>> Device [SIS0817:00 0457:10FB] on i2c-SIS0817:00
>>>=20
>>> But these 2 lines do not appear on the 6.1.4 logs.
>>>=20
>>> So the device is not properly enumerated by ACPI or I2C. Hans might
>>> have an idea on how to debug/solve that issue.
>>=20
>> I actually have a Toshiba satellite click mini l9w-b lying around
>> myself. I already made a note to try and reproduce this
>>=20
>> But I'm very much swamped with too much kernel work, so no promises
>> when I will get around to this ...
>=20
> Has anyone made any progress with this? Doesn't look like it, hence I
> wondered if this fall through the cracks; but maybe I'm just missing
> something.
>=20
> G=C3=A9 Koerkamp: with a bit of luck Hans sooner or later will have time t=
o
> look into this, but it might speed things up if you could try to bisect
> this.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>=20
>>>> #regzbot poke
>>>>>> G=C3=A9 Koerkamp 2023-01-17 20:21:51 UTC
>>>>>>=20
>>>>>> Created attachment 303619 [details]
>>>>>> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
>>>>>>=20
>>>>>> Overview:
>>>>>> The touchscreen does not react on touch events.
>>>>>> Touchscreen display and touchpad are working.
>>>>>>=20
>>>>>> Step to reproduce:
>>>>>> Open any UI page
>>>>>> Try to use touch on relevant UI controls (buttons etc.)
>>>>>>=20
>>>>>> Result:
>>>>>> No reaction on screen touches
>>>>>>=20
>>>>>> Expected result:
>>>>>> Reaction on touched control, same as when using the touch pad or conn=
ected mouse (which do work).
>>>>>>=20
>>>>>> Build information:
>>>>>> The error happens with kernel version 6.1.4
>>>>>> After rebuilding with different kernel versions, it appears that it f=
irst fails with kernel 5.16
>>>>>>=20
>>>>>> Additional builds:
>>>>>> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LT=
S.
>>>>>>=20
>>>>>> Important remark:
>>>>>> Touchscreen still works fine with kernel 6.1.4 using
>>>>>> - an HP x2 detachable 10-p0xx or
>>>>>> - a Lenovo yoga 520-14ikb
>>>>>>=20
>>>>>> So it could be a hardware dependent issue
>>>>>=20
>>>>> See the ticket for more details.
>>>>>=20
>>>>>=20
>>>>> [TLDR for the rest of this mail: I'm adding this report to the list of=

>>>>> tracked Linux kernel regressions; the text you find below is based on a=

>>>>> few templates paragraphs you might have encountered already in similar=

>>>>> form.]
>>>>>=20
>>>>> BTW, let me use this mail to also add the report to the list of tracke=
d
>>>>> regressions to ensure it's doesn't fall through the cracks:
>>>>>=20
>>>>> #regzbot introduced: v5.15..v5.16
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D216946
>>>>> #regzbot title: hid: touchscreen broken with Toshiba satellite click
>>>>> mini l9w-b
>>>>> #regzbot ignore-activity
>>>>>=20
>>>>> This isn't a regression? This issue or a fix for it are already
>>>>> discussed somewhere else? It was fixed already? You want to clarify wh=
en
>>>>> the regression started to happen? Or point out I got the title or
>>>>> something else totally wrong? Then just reply and tell me -- ideally
>>>>> while also telling regzbot about it, as explained by the page listed i=
n
>>>>> the footer of this mail.
>>>>>=20
>>>>> Developers: When fixing the issue, remember to add 'Link:' tags pointi=
ng
>>>>> to the report (e.g. the buzgzilla ticket and maybe this mail as well, i=
f
>>>>> this thread sees some discussion). See page linked in footer for detai=
ls.
>>>>>=20
>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
>>>>> --
>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>> If I did something stupid, please tell me, as explained on that page.
>>>>=20
>>>=20
>>=20
>>=20
>>=20

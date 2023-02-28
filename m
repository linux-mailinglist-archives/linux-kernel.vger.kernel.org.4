Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2116A58DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjB1MK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjB1MK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:10:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA81D910;
        Tue, 28 Feb 2023 04:10:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cq23so39081704edb.1;
        Tue, 28 Feb 2023 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzGiX5oItZA3FXYXirsZd2ttUBOvOMFOuarqaBNhpNE=;
        b=YdXywtUBYefrWb0SAhAESxZVRE1cgk/LE/PzB5T0DXIMjAKwetyl5RF1hu/R1XOVww
         v0l3U7xuMU2QjRGctTlxlzG3CIGtBLHMQJZM4YfkFMNpexashSxqmDLUK96aq/QeAvvX
         LkUInkorD7+J3a5iJow90ReXRvMsUK/O1hRWd+J4M3KAkYLSRwkLSCXgcQSqOhIT+x2N
         Xs0y67nTUYrOf8Q8ExTSCsHVch6QHkRl77W1Jne3YtpR//nQc65sh5zwQMvqvWF9NPGB
         UmqoAsizpuAvb9obiuMWIcKarcOStf8RRdjismZ+BFSAJ8WUiGZ6fpr9IZ9TG7yZj6He
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzGiX5oItZA3FXYXirsZd2ttUBOvOMFOuarqaBNhpNE=;
        b=Vrt8tCtL+W1TtqeafP6mx8cqEjjetci73j+NCYKe/Ivx6Ii35gv51yBdb4g7jK8aG7
         r/hYNoJmlaesR1bloPjXEF7662OQ224juX5fa0SqPgGzyxgLo0JsT4JNKxf/ZuQ/jw0m
         BpjtOY0mrbHuzcNckqZ3I4JySZv99rgNFzgrDY0D25I5t+zZZnwGWiJzDX4iX0XZiND8
         krtebBt2HFPqH91HG879Tj+9hJd/m9K10uXAsyuYJu+HwFpM7LvIbnv7bprLAqzzsY4j
         29ug/xL4gUP1/SXDMs5uh64pXmFjGxfLzlOVov6YXW+Z/gIMjU4iUEIaT+hTjBcN+QS5
         EPuQ==
X-Gm-Message-State: AO0yUKW3hUgN8k5bPqFYgkwVW5rMH2WJRK+9d45Cc4oHKiGmX7PWi2F3
        Go5yVpKA2ypktDjAiQqWhNs=
X-Google-Smtp-Source: AK7set/uKluGfXdjIfoZg+D9ARlvY6PEJqaSoRNvczp7EGvTKSzakcyzPGj0PbASt3rv7RR4YLQxkA==
X-Received: by 2002:a17:907:25c2:b0:8e1:12b6:a8fc with SMTP id ae2-20020a17090725c200b008e112b6a8fcmr2729860ejc.4.1677586223873;
        Tue, 28 Feb 2023 04:10:23 -0800 (PST)
Received: from smtpclient.apple ([45.86.200.169])
        by smtp.gmail.com with ESMTPSA id le13-20020a170907170d00b008c44438734csm4482570ejc.113.2023.02.28.04.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 04:10:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?G=C3=A9_Koerkamp?= <ge.koerkamp@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b: touchscreen: no touch events with kernel 6.1.4
Date:   Tue, 28 Feb 2023 13:10:11 +0100
Message-Id: <15A82C8F-324B-4E99-B388-27F1480B7959@gmail.com>
References: <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: iPad Mail (20C65)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
additionally, I searched for any reported SIS0817 issues, yet did not find a=
ny.
But perhaps it rings a bell.
Cheers - G=C3=A9

On 28 Feb 2023, at 12:32, Thorsten Leemhuis <regressions@leemhuis.info> wrot=
e:

=EF=BB=BFOn 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemh=
uis)
wrote:
> Hi, this is your Linux kernel regression tracker.
>=20
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216946 :

The reporter recently confirmed in the ticket that the issue still
happens with 6.2.

There wasn't any reply from any of the input developers here or in
bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
take a minute and at least briefly look into this as answer something
like "that might be due to a problem in subsystem 'foo'", "maybe ask bar
for an option", or "we have no idea what might cause this, this needs to
be bisected"? That would help a lot.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
>> G=C3=A9 Koerkamp 2023-01-17 20:21:51 UTC
>>=20
>> Created attachment 303619 [details]
>> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
>>=20
>> Overview:=20
>> The touchscreen does not react on touch events.
>> Touchscreen display and touchpad are working.
>>=20
>> Step to reproduce:
>> Open any UI page
>> Try to use touch on relevant UI controls (buttons etc.)
>>=20
>> Result:
>> No reaction on screen touches
>>=20
>> Expected result:
>> Reaction on touched control, same as when using the touch pad or connecte=
d mouse (which do work).
>>=20
>> Build information:
>> The error happens with kernel version 6.1.4
>> After rebuilding with different kernel versions, it appears that it first=
 fails with kernel 5.16
>>=20
>> Additional builds:
>> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS.
>>=20
>> Important remark:
>> Touchscreen still works fine with kernel 6.1.4 using =20
>> - an HP x2 detachable 10-p0xx or
>> - a Lenovo yoga 520-14ikb
>>=20
>> So it could be a hardware dependent issue
>=20
> See the ticket for more details.
>=20
>=20
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
>=20
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>=20
> #regzbot introduced: v5.15..v5.16
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216946
> #regzbot title: hid: touchscreen broken with Toshiba satellite click
> mini l9w-b
> #regzbot ignore-activity
>=20
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>=20
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

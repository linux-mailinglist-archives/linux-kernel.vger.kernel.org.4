Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2110465C06E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbjACNFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjACNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:05:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E56B7F7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:05:02 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso19025522oto.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFWumH4KGoJlzNmef6ZMjYRxtRsQ29aHRzvDO3z+tjc=;
        b=gkqcLNSyQ1SoNGqsQulv14lK6VLDieljM1vMmMHcBBEj9FvyUJ3xHp86HLZ+XEQu23
         Ajd2INzfS1b+m3xeLAzvp3xVpYqVn0ct/+2skVuSzJcMC//FmDnjZ8/wlAAu60oIfZ5o
         KYrUqEpgJxbAXZ471IAK8m9q7VPTHWMBHF2GyVSUbAaSMQlgXZfIL406ja5fh5TUVbuY
         +J3A9lHDPxjtU1DdMqCg+wTY0KvH8sZTsCelZUOvVQ7Hi1eBDoKmz3Z0lq8QTAIoGKoD
         TaOmxAzPkksr07Ufd/qeBx6dLWAusB2cqkB5jkqGDBU4X/M41tEGYOUaYvX/zcAh3dkY
         PuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFWumH4KGoJlzNmef6ZMjYRxtRsQ29aHRzvDO3z+tjc=;
        b=C47+dXj+jkVEOS5csnjqOcyM05pcNfQJCy0lkRJz+YZFyjoDPT7psUt2UmPgagfV7W
         WYe6SNvJMQ26YO3wfIF9JaXhztzMEr+vQxPdEWb0zrYgwILDEri2g9glvQtIgfAYzLxI
         SKVMmwj+/ZfnAwDdzwGTk9dBangwU2/UOhxmAhIOqH50PENGKXXaBGslauYlVz1+IX/E
         O7aikfbjgsZrfXNsiP9HlwB7EV1mvXY41pWXp+dd6/LZjVGEGdctBYhwIw3D7kmtqDsg
         rRzaLTiWOryCX7lFHGdpbA9Sa6XS1EYSvBM52vOSdEbYPrGvBsNKow4r896pQWg15thY
         B/dw==
X-Gm-Message-State: AFqh2kp5E9iWuctlotlrFLlVJIvswV6Y+KmbC+/G2w3hUIlJ40bL7vTJ
        mNokr8n7C+EWpgK/MMadRbJiTBucNMp/gWpOPQM=
X-Google-Smtp-Source: AMrXdXsGYVYpKbI6S6663PlQdTnmgt06lm9E/ZDIAC1Rp+m7YS1pi2lxmj7Z5ARv3PUGlUQfOsRhvMKw34pLbAAb7gQ=
X-Received: by 2002:a05:6830:1443:b0:66d:8e24:8038 with SMTP id
 w3-20020a056830144300b0066d8e248038mr2182829otp.9.1672751101733; Tue, 03 Jan
 2023 05:05:01 -0800 (PST)
MIME-Version: 1.0
References: <bebd692d-7d21-6648-6b7a-c91063bb51c2@leemhuis.info>
 <Y7K1WDmPYi3EMOn1@eldamar.lan> <87wn65umye.wl-tiwai@suse.de> <CALp6mkJhM1zDcNr9X_7WL09+uqcaAhNFFMhrjme0r7584O+Lgw@mail.gmail.com>
In-Reply-To: <CALp6mkJhM1zDcNr9X_7WL09+uqcaAhNFFMhrjme0r7584O+Lgw@mail.gmail.com>
From:   =?UTF-8?B?UMOBTEZGWSBEw6FuaWVs?= <dpalffy@gmail.com>
Date:   Tue, 3 Jan 2023 14:04:50 +0100
Message-ID: <CALp6mk+rdqGXySUowxZv3kEEVWrh96m_x-h8xcFNQ9YZPkbc5w@mail.gmail.com>
Subject: Re: [regression, 5.10.y] Bug 216861 - sound disappearance on Acer
 Swift 3 SF314-59-78UR after update to 5.10.157
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Sergey <zagagyka@basealt.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And confirming, 5.10.161 with e8444560b4d9302a511f0996f4cfdf85b628f4ca
and 636110411ca726f19ef8e87b0be51bb9a4cdef06 cherry-picked works for
me.

On Tue, Jan 3, 2023 at 1:05 PM P=C3=81LFFY D=C3=A1niel <dpalffy@gmail.com> =
wrote:
>
> Another report: https://bugs.archlinux.org/task/76795
> Apparently, folks at alsa-devel traced down the dependencies of that patc=
h, see the mail thread at https://lore.kernel.org/all/dc65501c-c2fd-5608-c3=
d9-7cea184c3989%40opensource.cirrus.com/
>
> On Mon, Jan 2, 2023 at 1:42 PM Takashi Iwai <tiwai@suse.de> wrote:
>>
>> On Mon, 02 Jan 2023 11:43:36 +0100,
>> Salvatore Bonaccorso wrote:
>> >
>> > Hi,
>> >
>> > [Adding as well Richard Fitzgerald and P=C3=81LFFY D=C3=A1niel to reci=
pients]
>> >
>> > On Fri, Dec 30, 2022 at 09:08:57AM +0100, Thorsten Leemhuis wrote:
>> > > Hi, this is your Linux kernel regression tracker speaking.
>> > >
>> > > I noticed a regression report in bugzilla.kernel.org. As many (most?=
)
>> > > kernel developer don't keep an eye on it, I decided to forward it by
>> > > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216=
861 :
>> > >
>> > > >  Sergey 2022-12-29 10:07:51 UTC
>> > > >
>> > > > Created attachment 303497 [details]
>> > > > pulseaudio.log
>> > > >
>> > > > Sudden sound disappearance was reported for some laptops, e.g.
>> > > >
>> > > > Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ =
2.80GHz
>> > > >
>> > > > # lspci
>> > > > 0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger =
Lake-LP Smart Sound Technology Audio Controller (rev 20)
>> > > >         Subsystem: Acer Incorporated [ALI] Device 148c
>> > > >         Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU=
 group 12
>> > > >         Memory at 601f270000 (64-bit, non-prefetchable) [size=3D16=
K]
>> > > >         Memory at 601f000000 (64-bit, non-prefetchable) [size=3D1M=
]
>> > > >         Capabilities: [50] Power Management version 3
>> > > >         Capabilities: [80] Vendor Specific Information: Len=3D14 <=
?>
>> > > >         Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bi=
t+
>> > > >         Kernel driver in use: sof-audio-pci
>> > > >
>> > > > I am attaching the pulseaudio and dmesg logs
>> > > >
>> > > > This bug started reproducing after updating the kernel from 5.10.1=
56 to 5.10.157
>> > > >
>> > > > Bisection revealed the commit being reverted:
>> > > >
>> > > > c34db0d6b88b1da95e7ab3353e674f4f574cccee is the first bad commit
>> > > > commit c34db0d6b88b1da95e7ab3353e674f4f574cccee
>> > > > Author: Richard Fitzgerald <rf@opensource.cirrus.com>
>> > > > Date:   Fri Nov 4 13:22:13 2022 +0000
>> > > >
>> > > >     ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
>> > > >
>> > > >     [ Upstream commit 39bd801d6908900e9ab0cdc2655150f95ddd4f1a ]
>> > > >
>> > > >     The DAI tx_mask and rx_mask are set by snd_soc_dai_set_tdm_slo=
t()
>> > > >     and used by later code that depends on the TDM settings. So
>> > > >     __soc_pcm_open() should not be obliterating those mask values.
>> > > >
>> > > > [...]
>> > > > Original bug report: https://bugzilla.altlinux.org/44690
>> > >
>> > > See the ticket for more details.
>> > >
>> > > BTW, let me use this mail to also add the report to the list of trac=
ked
>> > > regressions to ensure it's doesn't fall through the cracks:
>> > >
>> > > #regzbot introduced: c34db0d6b88b1d
>> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D216861
>> > > #regzbot title: sound: asoc: sudden sound disappearance
>> > > #regzbot ignore-activity
>> >
>> > FWIW, we had as well reports in Debian after having updated the kernel
>> > from 5.10.149 based one to 5.10.158 based one in the last point
>> > releases, they are at least:
>> >
>> > https://bugs.debian.org/1027483
>> > https://bugs.debian.org/1027430
>>
>> I got another report while the commit was backported to 5.14-based
>> openSUSE Leap kernel, and I ended up with dropping it.
>>
>> So, IMO, it's safer to drop this patch from the older stable trees.
>> As far as I see, 5.15.y and 5.10.y got this.
>>
>> Unless anyone gives a better fix, I'm going to submit a revert patch
>> for those trees.
>>
>>
>> thanks,
>>
>> Takashi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036965CF48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjADJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjADJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:13:03 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFCFD2B;
        Wed,  4 Jan 2023 01:13:01 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id i188so34231388vsi.8;
        Wed, 04 Jan 2023 01:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPMX5kWJZPRRY4wnvXmSYf/iEepycQO9qoz1tO03Y7E=;
        b=V5CHBHmD0S3FbkXFR+gItsN90huqqoo5uYdU3eF8jc9PWKVQPmONGIcPnPtLRvlj8W
         aV2Qr7a0+07PeaMz5mL93zB69HtQifJXnmqseFsOAI4tm/UJBnyf8kT8WPFhsq16Zy0C
         FiR4ay1mvoDxnXMMBZRHJlRM/LA+I2cjFE1hYMFfOMeg/xvt4WheNQZ9a50r5yzkD2Ou
         f/+jpLcxTSotclANBYL9H5j+Ffjp8wuyKs63qKx25pifjjdOVXtGZ5vTQ6yYlW1RAgdN
         3Nz6Wyqb4WyL280TZ17G/vBkRBkqHW/wcb61rIi5eO5VE1BGuKrSsezv16qndtj1OMiJ
         IiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPMX5kWJZPRRY4wnvXmSYf/iEepycQO9qoz1tO03Y7E=;
        b=RNC2A/xtBhSXPoI2EANEcHJS79ofhIzyoLVg4ySYJvaJjFhHRU8kBiQflPfTp3Fv4E
         sIS5qJdIvPgZkRtZ+V2bAzgLdpRejbEqtvaau1Td/HAvaT5IGSPB4ipaxyQGx/KCZm1U
         mqTSSi/a4WsQL8F+ssDZUXmRyYUyJikvgVn7k1xr5I/CwXlmXJrORNyAhQZLfsByalhE
         yj21VAucoSuvvjFhzHcto6mmhNvAv+4RxtYNKeHbgxkLHjmmbR0boK6YknaP91+DbuNH
         cVhIDMUOW9r8D+ypg1cD/pwBpv20DmU9ulzAz5eK+3JaOBbjfD2fD49mEwfGY1fryyqE
         Ur3g==
X-Gm-Message-State: AFqh2kpYNbBz1qeEv3NEZYSUaRt0FLlGfC+/rS1GMaQ2r6sOwXRBWO8R
        e0gGnava3JplYP3HZHTQt//DU23+cfT03JiVTbY=
X-Google-Smtp-Source: AMrXdXvTAdvAkZT6n8ezEcrJXpeklPvOVSosiAD0Vx17p4+/0cH66MykDFyoZ+aMSBUgDhRY9po3H9T6OpYe5jZNSAs=
X-Received: by 2002:a05:6102:e94:b0:3b1:3231:ac9e with SMTP id
 l20-20020a0561020e9400b003b13231ac9emr5119931vst.50.1672823580988; Wed, 04
 Jan 2023 01:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20221227095123.2447948-1-milkfafa@gmail.com> <20221227095123.2447948-8-milkfafa@gmail.com>
 <b8f173c0-6d40-d6aa-543e-fa8b06557f4f@molgen.mpg.de> <CADnNmFr1naRfam=z0p-4hEugSDJy_HCK8XZyQJ0eFirnmwuH4A@mail.gmail.com>
 <4d64e3f9-57a3-c6be-2709-36e9a1617bf9@molgen.mpg.de>
In-Reply-To: <4d64e3f9-57a3-c6be-2709-36e9a1617bf9@molgen.mpg.de>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Wed, 4 Jan 2023 17:12:49 +0800
Message-ID: <CADnNmFqFMBUj07oAZze3eeXAR0hbep4p9za=XNu5YrLVqUex=w@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, kwliu@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kflin@nuvoton.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > How about "The VCD can capture a frame from digital video input and
> > compare two frames in memory, then the ECE will compress the frame
> > data into HEXTITLE format", is it better?
>
> Yes, I prefer your suggestion.
>
> >> Wich VNC viewer and version?
> >
> > I used RealVNC version 6.21.1109 to test.
> > Do I have to add this information in the commit message?
>
> I do not think there are rules, but I prefer to have the test
> environment and procedure information in the commit message in case
> there are problems, and you want to reproduce things.

OK, I'll do that.


> Yes, that is what I meant. Maybe even the debug messages.

I get these debug messages after VNC viewer connected:

npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD mode = 0x1000b, Hi Res mode
npcm-video f0810000.video: Digital mode: 1600 x 1200 x 2, pixelclock
161666000, bytesperline 4096
npcm-video f0810000.video: ECE open: client 1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: offset = 0, ed_size = 1540907, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: offset = 0, ed_size = 1539638, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: offset = 0, ed_size = 1539638, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: offset = 0, ed_size = 1539638, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: offset = 0, ed_size = 1539638, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: offset = 0, ed_size = 1539638, gap = 12
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
npcm-video f0810000.video: VCD irq status 0x84b00ff1
npcm-video f0810000.video: Got resolution[1600x1200] -> [1600x1200], status 0
[...]


> > I can note the datasheet name and revision in the commit message but
> > can't provide the file link because it is not public.
> > Is it ok with you?
>
> Yes, that would be ok with me.

> > So what I have to do is replace "u8/u16/u32" with "unsigned int" for
> > generic local variables as much as possible.
> > Is my understanding correct?
>
> Yes, I would say so.

> >>> +MODULE_AUTHOR("Joseph Liu<kwliu@nuvoton.com>");
> >>> +MODULE_AUTHOR("Marvin Lin<kflin@nuvoton.com>");
> >>
> >> Please add a space before the <.
> >>
> >>> +MODULE_DESCRIPTION("Driver for Nuvoton NPCM Video Capture/Encode Engine");
> >>> +MODULE_LICENSE("GPL");
> >>
> >> Not GPL v2?
> >
> > I'll correct them in the next patch.
>
> Awesome.

 Thank you for your feedback.

Regards,
Marvin

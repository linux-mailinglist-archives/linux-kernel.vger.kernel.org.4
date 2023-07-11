Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEF74E954
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGKIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGKIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:45:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768D1A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:45:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26304be177fso2641247a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689065141; x=1691657141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rAyfFYEC54lt2EK8plIE5lUAw75Zdb2J3/mCKsVdFc=;
        b=osMyAeVS9EE7oQ72ept+nuFwXTGDZis3UCeZJLu4UFhMCl5FqF0UqU8ZGadQdmgYd1
         WBYIfLYja43fjc+Sou3CD8s0QT0hu2AVFWVCc64mXvK4AkQAFf/i41Z+SVsD5vgzGo8W
         JcywYnI+Uw26sosc1BCOQaQ5ZIK4L0LJDRyQ0aDtVpAd38m4x0MPxUB80sPshH9bD1AI
         nNsR0M1I5hFQdbxga5MBJU14uaDwnpzQZY4sZUDsi8C2e3ubUuBXnrdwOXvxNqW09C2h
         GPTEsjcspu1XSf+PutOWGbjULtlBTs6GVod+d3N0SmM/kTwfm+3OFHNnf8U9u/dHy0/Q
         hrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065141; x=1691657141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rAyfFYEC54lt2EK8plIE5lUAw75Zdb2J3/mCKsVdFc=;
        b=VQ6riWuIrvQmdZDfM/XNyqPbmV34iei8nudjMthS+7Oo70vxT5l3N71KgNN0MAQkuP
         u16juwACl8rG5JvAMULt36p/yzrcHK5Mtur0SOHayWpTWX5y2lNW6JB07vefXg3J+uLC
         yNgiW2qbo/Ck2i86yrjP9LR+4CVOftUDsSczO2qBliukoqoFaQCmlbR7imuM7H5Itu0W
         T2sNPu9k8HalvQY5m4SzLDwzgIH33e2HwYioEKeGNIe7AmyeGZ394ClwHTg0jl0Wg8xN
         15aqY4OyCGv2AW2OlnRsKZ0+LYNCVGyrNiNCOttyBCZ1gvYfc9LN7Lmien+0GxMshbGj
         G+yQ==
X-Gm-Message-State: ABy/qLaXFtxkwUHfZsNpvFzSUDwTFir6wUkhVeQ8rFtpD0kwzn5N+AvB
        pzNnfAZdWkwx++Vtv3AXNFjLNySDVAxpMu8Pf+Qoxw==
X-Google-Smtp-Source: APBJJlEEpeiJ/C75pcZKME2sORsUVGMbgtRVsaSJNvTBpYj9gubvUdJuoy+wl7zoQ6u18+207M8ubOvzyKvqaQDqYR8=
X-Received: by 2002:a17:90a:fb93:b0:262:f06a:13e0 with SMTP id
 cp19-20020a17090afb9300b00262f06a13e0mr11892966pjb.5.1689065140955; Tue, 11
 Jul 2023 01:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050744.1196293-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WNLcw2JbMf7tfob2KgjB8eXTC0p1J4OYnQL4k3Mz3mgA@mail.gmail.com>
 <CAHwB_NJbtvXNCFj5=NMBXWCt1S1_WrgGij2Kqdr1omno66kVUw@mail.gmail.com> <CAD=FV=W5adfzPkP6dJGwfGO+mcbTdg8v9A0Sd4-FozF+W7nSrA@mail.gmail.com>
In-Reply-To: <CAD=FV=W5adfzPkP6dJGwfGO+mcbTdg8v9A0Sd4-FozF+W7nSrA@mail.gmail.com>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Tue, 11 Jul 2023 16:45:29 +0800
Message-ID: <CAHwB_NLQcL7sDPAp10njng+r=UjmesHyWK6DHxJLYOatemYWLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Add avdd/avee delay for Starry-himax83102-j02
 and Starry-ili9882t panel
To:     Doug Anderson <dianders@google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        airlied@gmail.com, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 7, 2023 at 11:15=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Thu, Jul 6, 2023 at 6:20=E2=80=AFPM cong yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Hi,
> >
> > On Fri, Jul 7, 2023 at 3:32=E2=80=AFAM Doug Anderson <dianders@google.c=
om> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Jul 3, 2023 at 10:07=E2=80=AFPM Cong Yang
> > > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > > >
> > > > From power on/off sequence for panel data sheet[1], T2 timing VSP t=
o VSN
> > > > needs 1ms delay when power on, and VSN to VSP also needs 1ms delay =
when
> > > > power off. Some pmic may not be able to adjust the delay internally=
, so
> > > > let's add a delay between avdd/avee regulator gpio to meet the timi=
ng of
> > > > panel.
> > >
> > > Unless I'm mistaken, all of this is best handled via regulator
> > > constraints in the device tree. See the file:
> > >
> > > Documentation/devicetree/bindings/regulator/regulator.yaml
> > >
> > > Specifically, any delays related to actually ramping up / down the
> > > regulator can be specified in the device tree. Nominally, you could
> > > argue that the 1 ms delay actually _does_ belong in the driver, but
> > > IMO the 1 ms number there is really just there because someone though=
t
> > > it was weird to specify a delay of 0 ms. Given that you already need
> > > remp delays in the device tree, it feels OK to me to just include the
> > > 1 ms there.
> >
> > The regulator device tree has only the power on attribute
> > "regulator-enable-ramp-delay",
> > not has power off attribute. The regulator delay looks more like the
> > HW voltage requirement
> > of the power ic itself, and I just want to meet the panel spec
> > requirement. I add regulator-enable-ramp-delay
> > in dts he can also meet my requirement, but I have no way to control
> > the power off delays.
>
> Hmmm, I guess the fact that the delay needed can be different for
> different boards / PMICs still makes me think that the delay doesn't
> belong in the panel driver. Different boards using the same panel
> would need different delays, right?
>
> So, thinking more...
>
> You're saying that you _can_ specify the enable delay in the device
> tree, but not the disable one, right? However, the timing diagram you
> provided doesn't seem to show the "disable" part. Since that's the
> part we're talking about now, could you provide a more complete timing
> diagram? Can you also talk to the panel vendor and confirm that the "1
> ms" actually matters or if they just put that there to ensure
> ordering? In other words, is it simply important that VDD1 gets to
> ~90% before you turn on VSP, or do they truly need a full 1 ms delay?
>
> Can you provide any more details about the power IC you're using? Is
> it just a discrete PMIC with a GPIO enable, or is it something
> fancier? Correct me if I'm confused (entirely possible!), but I think
> some PMICs have a feature where they can turn on "active discharge" so
> that they ramp down more quickly when they're disabled. Any chance
> your PMIC has this?
>
> In general the fact that nobody has added
> "regulator-disable-ramp-delay" to the regulator framework already
> means that the problem you're facing isn't really a common problem.
> There are lots of devices out there that have more than one regulator
> but I don't see examples where drivers need to delay between turning
> all their regulators off. Are you positive that this is something that
> you really need to worry about?
>
> The above is a bit rambling (sorry!), but I guess the summary is:
>
> 1. Please confirm that the panel driver truly needs 1 ms between
> regulators enabled.
>
> 2. Please provide the power sequence diagram for disable. If there's a
> 1 ms delay between regulators being disabled then please confirm.
>
> 3. If the 1 ms delay isn't truly needed then we can just drop this patch,=
 right?

https://github.com/ILITEK-LoganLin/Document/tree/main/ILITEK_Power_Sequence

Ask the vendor to evaluate this 1ms delay again, they think that
current ramp time
does not need 1ms delay, so drop this patch.

>
> 4. IMO if the panel itself truly requires 1 ms between regulators
> being enabled and/or disabled, it would be OK to put the 1 ms delay in
> the driver but it feels wrong to be accounting for ramp time in the
> driver. This should be specified in the device tree.
>
> 5. If we really need to account for the ramp down time, it would at
> least be good to submit a regulator framework patch proposing a way to
> specify this. We'd have to figure out how to make this work since I'd
> imagine that most regulator consumers don't care that much about ramp
> down time. Mark would be the real person to get advice from, but
> perhaps an API call like "regulator_wait_discharged(percent)" that a
> client could call?
>
>
> -Doug

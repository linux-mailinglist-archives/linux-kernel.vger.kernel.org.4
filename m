Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A57130D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjE0ANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjE0ANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:13:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A58FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:13:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso70841cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685146424; x=1687738424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX+3O8FScht0vPmOFufzj92trtq9QMFzIYaCLdQKLns=;
        b=AirNbMnhntbS9xYWNYaxm6nDZkFpIaC7TenLdOjRkbmyJ0AAI406n/1V2fzdlhVfUy
         Ft3PHD1zQMgm5KI+M/iXlNeTQ+fid7BjDj2saYzeRB3fncuDEcJWa5KbDSmGD5xBIXkQ
         n89iiNq0kCSC1swDCNBTirmEz7hNyVCpNB8bktLLVNH5VR8/Qml9U6JY5Biz82Y6BxMl
         5ciRrJWUhK3ciGCfYZrNlG9zXLKWAkdAIF0+AzDxY19U/SpT4mOyl/1nktsOlpAXZmo0
         8lLj+JX5vOUBt11pOQSXOVE50QpvSeSBM3ECh18olhmRz8nCZq8Hxc4U8LUstK4i4R+3
         bLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685146424; x=1687738424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX+3O8FScht0vPmOFufzj92trtq9QMFzIYaCLdQKLns=;
        b=g3izOuMEweE/Kxw+36X6asoTV/msQMb6av4hsKP6TNhN3HIgWu0WPH07vBqtjAzvhW
         IDQLY8D0z9a33Fq0HeR7O1GTwyPmfaV/Gxxuk4tuTJQCHiRzvzxs6IPvo3AsoomfxqG0
         UTLf0JvPxbA2Z//WLXPxBa2kPV5KBvqiQAjf8l8kNv+QOOAjlweBZ7NLwjHnIvz50YNu
         ozegK3t/qMPBuP/O7dK4JjENiLhR1yvF9ul2T7cCssbHJWsbm+Htc2NZlE8Tiz58GON+
         4YhAVLJ37arVaNrSRX9ze+zR+Pv0wzW9QH1lhWO0wac6t3qF+6YZC2g+dYZMmAPoGCJ9
         2Gyw==
X-Gm-Message-State: AC+VfDynOdHL9LrJ/4beFywgeOtaUSxhYCeyuJvbrQyflyZ+ra5D7tpZ
        73ytoyJMlAbr02jlmwlckRu5zh2d1O05/CNje+rj8Q==
X-Google-Smtp-Source: ACHHUZ5crN1yuzxj1zz/kaUYin08SHjyJFP1zU6XVWZomEISK24zQprd2KboOIp1DhtBF0poc9lAlCV6z50I+pfIpBw=
X-Received: by 2002:ac8:5f86:0:b0:3f6:97b4:1a4a with SMTP id
 j6-20020ac85f86000000b003f697b41a4amr84333qta.20.1685146424179; Fri, 26 May
 2023 17:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <Y/OV3CF0ootyooDJ@linaro.org>
 <Y/OfjbxI1tHYJHNv@linaro.org> <CAGETcx_mD3pbAmT5FDZaVAsKb_2PAnrHL8B_6gSR=+a0O4kHfQ@mail.gmail.com>
 <Y/PALlrQpwPlum9M@linaro.org> <CAGETcx_TZN3=GKrEf5fy_tA=JnOfw7m-N=+hD=qhe_yRRpngPw@mail.gmail.com>
 <ZFzmaavGYy4isU7J@linaro.org> <CAGETcx8_maXSCmQcU_UE499pwJRLY4E7yydWsxbU91==vgCoFw@mail.gmail.com>
 <ZF4VY2ngPtg9Xytc@linaro.org>
In-Reply-To: <ZF4VY2ngPtg9Xytc@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 May 2023 17:13:08 -0700
Message-ID: <CAGETcx_Kkc_OST8LObdprea=N8P7RrssnP230MQpoBW5ajpaUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for disabling
 unused clocks
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 3:31=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> On 23-05-11 17:46:16, Saravana Kannan wrote:
> > On Thu, May 11, 2023 at 5:58=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org=
> wrote:
> > >
> > > On 23-02-21 11:58:24, Saravana Kannan wrote:
> > > > On Mon, Feb 20, 2023 at 10:47 AM Abel Vesa <abel.vesa@linaro.org> w=
rote:
> > > > >
> > > > > On 23-02-20 09:51:55, Saravana Kannan wrote:
> > > > > > On Mon, Feb 20, 2023 at 8:28 AM Abel Vesa <abel.vesa@linaro.org=
> wrote:
> > > > > > >
> > > > > > > On 23-02-20 17:46:36, Abel Vesa wrote:
> > > > > > > > On 23-02-17 21:38:22, Stephen Boyd wrote:
> > > > > > > > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > > > > > > > There are unused clocks that need to remain untouched b=
y clk_disable_unused,
> > > > > > > > > > and most likely could be disabled later on sync_state. =
So provide a generic
> > > > > > > > > > sync_state callback for the clock providers that regist=
er such clocks.
> > > > > > > > > > Then, use the same mechanism as clk_disable_unused from=
 that generic
> > > > > > > > > > callback, but pass the device to make sure only the clo=
cks belonging to
> > > > > > > > > > the current clock provider get disabled, if unused. Als=
o, during the
> > > > > > > > > > default clk_disable_unused, if the driver that register=
ed the clock has
> > > > > > > > > > the generic clk_sync_state_disable_unused callback set =
for sync_state,
> > > > > > > > > > skip disabling its clocks.
> > > > > >
> > > > > > Hi Abel,
> > > > > >
> > > > > > We have the day off today, so I'll respond more later. Also, pl=
ease cc
> > > > > > me on all sync_state() related patches in the future.
> > > > > >
> > > > >
> > > > > Sure thing.
> > > > >
> > > > > > I haven't taken a close look at your series yet, but at a glanc=
e it
> > > > > > seems incomplete.
> > > > > >
> > > > > > Any reason you didn't just try to revive my series[1] or nudge =
me?
> > > > > > [1]- https://lore.kernel.org/lkml/20210407034456.516204-3-sarav=
anak@google.com/
> > > > >
> > > > > This patchset is heavily reworked and much more simpler as it rel=
ies
> > > > > strictly on the sync_state being registered by the clock provider=
.
> > > >
> > > > It's simpler because it's not complete. It for sure doesn't handle
> > > > orphan-reparenting. It also doesn't make a lot of sense for only so=
me
> > > > clock providers registering for sync_state(). If CC-A is feeding a
> > > > clock signal that's used as a root for clocks in CC-B, then what
> > > > happens if only CC-B implements sync_state() but CC-A doesn't. The
> > > > clocks from CC-B are still going to turn off when CC-A turns off it=
s
> > > > PLL before CC-B registers.
> > >
> > > I gave your patchset a try and it breaks the uart for qcom platforms.
> > > That is because your patchset enables the clock on __clk_core_init an=
d
> > > does not take into account the fact that 'boot enabled' clocks should=
 be
> > > left untouched.
> >
> > Those are probably just hacks when we didn't have sync_state(). But
> > sure, we can make sure existing drivers aren't broken if the flag is
> > set.
>
> I probably didn't make myself clear enough here. ANY clock that is
> enabled (HW-wise) before the kernel boots should remain AS IS, that is, n=
o writing
> the enable bit, no reparenting, and so on. This rule applies to the clock=
 itself
> and for all of its parents. This is because, for some clocks, writing the
> enable bit might lead to glitches. UART is just one example. So, please, =
do not
> try enabling such clocks until the consumer driver does so.
>
> >
> > > This also means the orphan-reparenting enabling should
> > > be dropped as well.
> >
> > No, maybe for boot enabled clocks, but not for all clocks in general.
> > You need this for sync_state() to work correctly for clocks left on at
> > boot but "boot enabled" isn't set.
>
> I think you lost me here. What do you mean by 'this'? If you mean the
> enabling of orphan clocks, then the rule above still applies. It
> doesn't matter if the clock is an orphan one or not. It can be orphan
> from linux point of view, but the actual parent (even if it is not
> registered with the linux clock tree) might still be enabled. This means
> the clock itself will be also enabled. And by enabling them when
> registering, we can have glitches. Therefore, please, do not do this
> either.
>
> The registering of a boot enabled clock should not change/override/touch
> the current state of it in any way!
>
> Stephen, can you confirm this as well?
>
> >
> > > As for the second part, related to providers that might not have a
> > > registered sync_state(), your patchset sets the clock core generic
> > > one. This is also wrong because it doesn't take into account the fact
> > > that there might be providers that need to do their own stuff on
> > > sync_state() and should do that by registering their own implementati=
on
> > > of it.
> >
> > Right, in which case, they can set theirs or they get the default one.
>
> I'm still not sure that defaulting to the clk_sync_state callback is a
> good choice here. I have to think some more about what the impact is for
> providers that do not have any sync_state callback registered currently.
>
> >
> > > Therefore, I'll respin your patchset and use only the skipping of
> > > disabling the unused clocks, but I'll drop all the enable on init and=
 orphan
> > > reparenting changes.
> >
> > I think it'll result in a broken patch.
>
> Yep, tried that and it doesn't work. What happened was that, because you
> were enabling the 'boot enabled' clocks when registering them (on __clk_c=
ore_init),
> the disabling from the sync state needs to be without dropping the enable=
/prepare
> counts. This is why I think my patchset here is the best alternative he h=
ave
> currently, as it does exactly what it is supposed to do, namingly, to lea=
ve
> untouched the boot enabled clocks until sync state and then disabling
> them with via clk_disable_unused_subtree which calls the disable and
> unprepare ops without decrementing the prepare and enable counts.
>
> >
> > Sorry, I've been a bit busy with some other work and I haven't been
> > able to get to the clk_sync_state(). I'll try to rebase it soon and
> > send it out too.
>
> Well, I already did that and I described above why that won't help.

The biggest disconnect is that you seem to think boot enabled clocks
should be untouched until sync_state() is called on them. But that's
not a valid assumption. Boot enabled clocks can have multiple
consumers and one of them might want to change the frequency before
the other one probes. That's perfectly valid. In some cases, we might
need to make sure the clock frequency doesn't go higher than the clock
frequency at boot (we can make that a flag). Actually, even if there's
only one consumer, that consumer might change the clock frequency at
probe -- since sync_state() only comes after the probe(), we need to
make sure we allow reparenting and frequency changes to boot enabled
clocks before sync_state() is called.

Also, consider this example.

PLL1 -> mux1 -> clock_gate1 -> consumer1.
PLL1 -> mux2 -> clock_gate2 -> consumer2.

If I don't do orphan handling/reparenting like I do so in my patch,
PLL1 could get turned off after consumer 1 probes depending on which
clock controller each of those blocks are on.

I'm pretty sure I actually identified this issue when I wrote my patch
by testing it on QC hardware. So this is not some "other" hardware
issue. This actually affects QC hardware too. Maybe you haven't
upstreamed all of your hardware drivers, but this is not some
imaginary scenario.

Your main problem seems to be that your hardware can't handle writing
1 to the enable bit of a clock that's already on. If that's the case,
protect against that inside your driver. I'm even okay with figuring
out a way to try and support that at a framework level. But to say you
don't need to reparenting or the orphan handling is definitely wrong.

-Saravana

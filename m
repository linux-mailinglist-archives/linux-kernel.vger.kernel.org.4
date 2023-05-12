Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092BE6FFE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjELAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjELAqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:46:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E65BB4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:46:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aae90f5ebcso430485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683852413; x=1686444413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T10+eZtv1P+sem5SVFeRBdSEdRHCp+2rjVXG+IX1VZU=;
        b=gIHAFdeEe1rnnfoFGIl/9aXpKSDBFR9XdszD8qHiGqo2Kshj+VfKQZUvxSBhs23kVg
         wNyv9TldElL0ea4PE82pLgbczZDxEKtOZ1oaIfl4YT3q3Oq4drZpUuHBHWhbdeUTLWkx
         O5DzckwPk2Ta4BXxUomEHQnbHOrQBGYXcy6M9GyAUBEbi6YFDSu6lD5mUp4sNxBAzU2c
         Q4aiDwwHkV/SSEQZfpPJDZ8wdNXCjvyO+otiUiWU8a/gPuMT+524O7S0eCPfSQGblDj6
         CW3aoqYZNERuloOxNEfq/787dzrcMaDPh3+Bei/HEVtFVYrU1qiGXGXQoxBPhqOAUB6d
         O1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852413; x=1686444413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T10+eZtv1P+sem5SVFeRBdSEdRHCp+2rjVXG+IX1VZU=;
        b=Qhgfq18BTArPJlJyXOMTKcUjvhhMy2qUt6RLSVb0Wg5651Jr6gqlxVvr5rSrN0Oi2L
         ubMkyu1WOjtNDa26ZQUXQMSfswhtNdDV0R1Q10nkouqXY03XlZFbiEoe1CPY4Qi3J4Px
         vzIQJNmmIU/WEjFmq5SgS4n0lFkeNHHd2yjhb7zBA5UZtu9+GuKH0zJ3hWiHx14bTZXf
         YMwP1rUP9WOdTf0z0Ued7XVzT/aNd69PvL+A1q0tqk8cXaW7uMnW+gN/ibELm770X6gQ
         IvG1RDBi0eSYS3xYMxSV9093wuSILBdoVnLSROhPgLp9Dhcik1a7WJVnX/Ah6uWRzsZ9
         E28w==
X-Gm-Message-State: AC+VfDxcrfRmmhGTlXQ3r0yYzfYglTjl8CtqDEYH30P5BZn9k6gAg7fN
        JKNo2oAhp1VbjPViRXbAXkpr0b7nPpKn6a3JB+c8NA==
X-Google-Smtp-Source: ACHHUZ6C90xQqot7Pn5snLVCYUAcVqM4UmA6opiCWqzhJzBIjgxyvC/9CH3mnuUtcd3S6uVRB9XzCnGt/fID8eiOS0Q=
X-Received: by 2002:a17:902:dacd:b0:1ac:8835:b890 with SMTP id
 q13-20020a170902dacd00b001ac8835b890mr117014plx.14.1683852412825; Thu, 11 May
 2023 17:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org> <Y/OV3CF0ootyooDJ@linaro.org>
 <Y/OfjbxI1tHYJHNv@linaro.org> <CAGETcx_mD3pbAmT5FDZaVAsKb_2PAnrHL8B_6gSR=+a0O4kHfQ@mail.gmail.com>
 <Y/PALlrQpwPlum9M@linaro.org> <CAGETcx_TZN3=GKrEf5fy_tA=JnOfw7m-N=+hD=qhe_yRRpngPw@mail.gmail.com>
 <ZFzmaavGYy4isU7J@linaro.org>
In-Reply-To: <ZFzmaavGYy4isU7J@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 May 2023 17:46:16 -0700
Message-ID: <CAGETcx8_maXSCmQcU_UE499pwJRLY4E7yydWsxbU91==vgCoFw@mail.gmail.com>
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

On Thu, May 11, 2023 at 5:58=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> On 23-02-21 11:58:24, Saravana Kannan wrote:
> > On Mon, Feb 20, 2023 at 10:47 AM Abel Vesa <abel.vesa@linaro.org> wrote=
:
> > >
> > > On 23-02-20 09:51:55, Saravana Kannan wrote:
> > > > On Mon, Feb 20, 2023 at 8:28 AM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
> > > > >
> > > > > On 23-02-20 17:46:36, Abel Vesa wrote:
> > > > > > On 23-02-17 21:38:22, Stephen Boyd wrote:
> > > > > > > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > > > > > > There are unused clocks that need to remain untouched by cl=
k_disable_unused,
> > > > > > > > and most likely could be disabled later on sync_state. So p=
rovide a generic
> > > > > > > > sync_state callback for the clock providers that register s=
uch clocks.
> > > > > > > > Then, use the same mechanism as clk_disable_unused from tha=
t generic
> > > > > > > > callback, but pass the device to make sure only the clocks =
belonging to
> > > > > > > > the current clock provider get disabled, if unused. Also, d=
uring the
> > > > > > > > default clk_disable_unused, if the driver that registered t=
he clock has
> > > > > > > > the generic clk_sync_state_disable_unused callback set for =
sync_state,
> > > > > > > > skip disabling its clocks.
> > > >
> > > > Hi Abel,
> > > >
> > > > We have the day off today, so I'll respond more later. Also, please=
 cc
> > > > me on all sync_state() related patches in the future.
> > > >
> > >
> > > Sure thing.
> > >
> > > > I haven't taken a close look at your series yet, but at a glance it
> > > > seems incomplete.
> > > >
> > > > Any reason you didn't just try to revive my series[1] or nudge me?
> > > > [1]- https://lore.kernel.org/lkml/20210407034456.516204-3-saravanak=
@google.com/
> > >
> > > This patchset is heavily reworked and much more simpler as it relies
> > > strictly on the sync_state being registered by the clock provider.
> >
> > It's simpler because it's not complete. It for sure doesn't handle
> > orphan-reparenting. It also doesn't make a lot of sense for only some
> > clock providers registering for sync_state(). If CC-A is feeding a
> > clock signal that's used as a root for clocks in CC-B, then what
> > happens if only CC-B implements sync_state() but CC-A doesn't. The
> > clocks from CC-B are still going to turn off when CC-A turns off its
> > PLL before CC-B registers.
>
> I gave your patchset a try and it breaks the uart for qcom platforms.
> That is because your patchset enables the clock on __clk_core_init and
> does not take into account the fact that 'boot enabled' clocks should be
> left untouched.

Those are probably just hacks when we didn't have sync_state(). But
sure, we can make sure existing drivers aren't broken if the flag is
set.

> This also means the orphan-reparenting enabling should
> be dropped as well.

No, maybe for boot enabled clocks, but not for all clocks in general.
You need this for sync_state() to work correctly for clocks left on at
boot but "boot enabled" isn't set.

> As for the second part, related to providers that might not have a
> registered sync_state(), your patchset sets the clock core generic
> one. This is also wrong because it doesn't take into account the fact
> that there might be providers that need to do their own stuff on
> sync_state() and should do that by registering their own implementation
> of it.

Right, in which case, they can set theirs or they get the default one.

> Therefore, I'll respin your patchset and use only the skipping of
> disabling the unused clocks, but I'll drop all the enable on init and orp=
han
> reparenting changes.

I think it'll result in a broken patch.

Sorry, I've been a bit busy with some other work and I haven't been
able to get to the clk_sync_state(). I'll try to rebase it soon and
send it out too.

-Saravana

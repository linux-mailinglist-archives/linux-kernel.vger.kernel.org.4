Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2826D9495
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjDFK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDFK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:59:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E17A97
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:59:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-545e907790fso616187867b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680778786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD1WTAK58/vqm28JkhVU6GZOl4ufBXsw089tkC+xpWw=;
        b=rstXWKv7UVHpBvrj+D64aEpmhqkUePscquDSERUiqCo/2kvTPcISLn9/T2z9bf71N5
         y0F67VeMCuWYtTzRt5GraOjnIm0DMkNgtxlH3xUKfYpi+g9eqKFeWWifs/ffvnsshV8M
         zfXSNfMUBkYgvZx5x8XwfQELCVomMs8nyj8GHtdNZPBpsBLi068gpr7siuqqTOgoYdIM
         dRmcs9prAopv9R3upqAW3YKcWonOSqYQKnyvCcP3BQuCoUmQq7vqqSgiaXBXdZgbVh/9
         8pnZ/+3XBphz+u92hF1zMFIvv1FTUubcEn4lCz1GlGMus7rbkeBCuajJ/JNYDZzTsGUV
         edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD1WTAK58/vqm28JkhVU6GZOl4ufBXsw089tkC+xpWw=;
        b=oXrxe2ZrGnCAkWv5OB22lVsfUm3fkrrb8X1spc9Mdwx47/M9GCk/0TPUmwxpj69K+V
         SIDcshqGGYHrA72/2eMqx4+Sc+mSeZgtDNMH2b+micLJaWcdjzas9UdfsivgzkUi+m26
         sNaQv6cA2VwE5bQIsQACwG9sA8u8KNHGP5OSfPQ0g+lMFTHSOUojIMpBaaHtKGLaDujU
         udQDhzTislM5Afe/uWA0W+Y58DTOfjvDpmVVtH1yM7qhaxjwPEwMC1edO4yPELVLPopS
         mkWcKpesuFoMYKEiaDERX+JtdwMqUhDaKuSdpDHypDHwNeKMH7A1NhiSdjJfmg9tmvAd
         XxVw==
X-Gm-Message-State: AAQBX9eQ1ZArKO6aTen6ttc+Je2S6HDW6C3xNW5qy2GYIDznJgFy0+ye
        kQ5H/u1lx0fsBn77a5AJaVkdvH0FP62e8G1VEIpZKA==
X-Google-Smtp-Source: AKy350ZACGkl1itmcqbB+J8+S3w/c5Fd4Xstg5YxzxM0WeHeUtq63AtbTh7cY2Mf2KPnXQ8bjOeG3IRZrGTmICYhEDs=
X-Received: by 2002:a81:c509:0:b0:549:143f:3d3 with SMTP id
 k9-20020a81c509000000b00549143f03d3mr5573053ywi.0.1680778786661; Thu, 06 Apr
 2023 03:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
 <ZCVyBuKMvDV0gQPW@linaro.org> <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
 <ZCZolyDL/awnt73K@linaro.org> <CAPDyKFprQwBfya-TpaVJfn82LgM9N_iE8npO9r-HzAyJXpb-hQ@mail.gmail.com>
 <ZC6QLZOldOLNaCSg@linaro.org>
In-Reply-To: <ZC6QLZOldOLNaCSg@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Apr 2023 12:59:10 +0200
Message-ID: <CAPDyKFo+_qxjMaQyT9=zDOuTYjF35G2q=DfS+AhHr+PdJZJz6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on sync state
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 at 11:26, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 23-04-05 16:11:18, Ulf Hansson wrote:
> > Abel, Saravana,
> >
> > On Fri, 31 Mar 2023 at 06:59, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > On 23-03-30 12:50:44, Saravana Kannan wrote:
> > > > On Thu, Mar 30, 2023 at 4:27=E2=80=AFAM Abel Vesa <abel.vesa@linaro=
.org> wrote:
> > > > >
> > > > > On 23-03-27 17:17:28, Saravana Kannan wrote:
> > > > > > On Mon, Mar 27, 2023 at 12:38=E2=80=AFPM Abel Vesa <abel.vesa@l=
inaro.org> wrote:
> > > > > > >
> > > > > > > There have been already a couple of tries to make the genpd "=
disable
> > > > > > > unused" late initcall skip the powering off of domains that m=
ight be
> > > > > > > needed until later on (i.e. until some consumer probes). The =
conclusion
> > > > > > > was that the provider could return -EBUSY from the power_off =
callback
> > > > > > > until the provider's sync state has been reached. This patch =
series tries
> > > > > > > to provide a proof-of-concept that is working on Qualcomm pla=
tforms.
> > > > > >
> > > > > > I'm giving my thoughts in the cover letter instead of spreading=
 it
> > > > > > around all the patches so that there's context between the comm=
ents.
> > > > > >
> > > > > > 1) Why can't all the logic in this patch series be implemented =
at the
> > > > > > framework level? And then allow the drivers to opt into this be=
havior
> > > > > > by setting the sync_state() callback.
> > > > > >
> > > > > > That way, you can land it only for QC drivers by setting up
> > > > > > sync_state() callback only for QC drivers, but actually have th=
e same
> > > > > > code function correctly for non-QC drivers too. And then once w=
e have
> > > > > > this functionality working properly for QC drivers for one kern=
el
> > > > > > version (or two), we'll just have the framework set the device'=
s
> > > > > > driver's sync_state() if it doesn't have one already.
> > > > >
> > > > > I think Ulf has already NACK'ed that approach here:
> > > > > [1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y=
1Sir-G+GoxkCvpN=3DiiA@mail.gmail.com/
> > > >
> > > > I would have NACK'ed that too because that's an incomplete fix. As =
I
> > > > said further below, the fix needs to be at the aggregation level wh=
ere
> > > > you aggregate all the current consumer requests. In there, you need=
 to
> > > > add in the "state at boot" input that gets cleared out after a
> > > > sync_state() call is received for that power domain.
> > > >
> > >
> > > So, just to make sure I understand your point. You would rather have =
the
> > > genpd_power_off check if 'state at boot' is 'on' and return busy and
> > > then clear then, via a generic genpd sync state you would mark 'state=
 at
> > > boot' as 'off' and queue up a power off request for each PD from ther=
e.
> > > And as for 'state at boot' it would check the enable bit through
> > > provider.
> > >
> > > Am I right so far?
> >
> > I am not sure I completely follow what you are suggesting here.
>
> Please have a look at this:
> https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/commit=
/?h=3Dqcom/genpd/ignore_unused_until_sync_state&id=3D4f9e6140dfe77884012383=
f8ba2140cadb62ca4a
>
> Keep in mind that is WIP for now. Once I have something, I'll post it on
> mailing list. Right now, there is a missing piece mentioned in that
> commit message.

I had a quick look and it seems rather promising, but I will have a
closer look when you post it.

>
> >
> > Although, let me point out that there is no requirement from the genpd
> > API point of view, that the provider needs to be a driver. This means
> > that the sync_state callback may not even be applicable for all genpd
> > providers.
>
> Yes, I'm considering that case too.

Good.

>
> >
> > In other words, it looks to me that we may need some new genpd helper
> > functions, no matter what. More importantly, it looks like we need an
> > opt-in behaviour, unless we can figure out a common way for genpd to
> > understand whether the sync_state thing is going to be applicable or
> > not. Maybe Saravana has some ideas around this?
> >
> > Note that, I don't object to extending genpd to be more clever and to
> > share common code, of course. We could, for example, make
> > genpd_power_off() to bail out earlier, rather than calling the
> > ->power_off() callback and waiting for it to return -EBUSY. Both of
> > you have pointed this out to me, in some of the earlier
> > replies/discussions too.
>
> The above link basically does this. I hope this is what Saravana has in
> mind as well.

Okay, let's see what Saravana thinks.

Maybe it's easier to post an RFC, based upon the above and continue
the discussion around that?

Kind regards
Uffe

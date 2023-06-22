Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD52373A012
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjFVLtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFVLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:48:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2AE1A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:48:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-630074df712so51282936d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687434526; x=1690026526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRNXXzDvxFGlDR0rIu/cnMH16Thw35CVdY0uuwW92MI=;
        b=qD/hy4tmMxs4KxrxVDR2KlTRSdNI8BnPp+WNRuhvC2wnqO9iJtY9NqWHujJfB2U1y+
         9SC6tlP/SR9qwKYSiXzbZ86FKWVPNpDFOuUxfq4Q38tcIaNp6Y3GZmvD0tjivNNrDo2X
         VWNrVubn1O/XgCdvylp8VRvlWkMy2OfkygF1WuU2qS+K3SslL/HpFkkpq0YL3SdaIc4L
         1ZpTkX8J1dy56Zq6/cl2ub6L8BJl/RcpcM+FUYm44P6dEOA186caxcxkzA0LqQZnS986
         wJUlGewC5ScWT58/ZhGvXu5Is5CyeE9GSbjvKIDN8Bs0AGjjMnP4kB2CZl0JucuQ+CD9
         JkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434526; x=1690026526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRNXXzDvxFGlDR0rIu/cnMH16Thw35CVdY0uuwW92MI=;
        b=hRkWMo8ea/2ZDKd5VdLeYW0lO/7o81SEycKaSPjdhdpA6eXPbSL50B4ag8jcqaBFjk
         Rl9PHXaztZW+Q9Gm6FpAhnfOrpfMImTjvSg6UiAuc06xMYbnFmYKne8AuuKwYQqR3vkb
         RRfUNgUZgZXM9RkLBhT1sc68SqFEFc201chIl1UkM/+n6Eeh2ENgn0Mm2dgH3SAKaXFL
         Y2EhmgJTR0Q5buitS+XcwbuLD+XCav+Y/dj/5P6CTBvatiNI3NVUXWRFe0M0UF0YskPQ
         YWw+yoNSXMxIE3fU1IDBRtrs0U6gkJd2HrOQjbt//gyiNVZMuk+yzOqNyEED2wRZP4Km
         A8dg==
X-Gm-Message-State: AC+VfDwHqTzj2uN6NbFrXdUnMG/t0A7cP1cF6OSNRKIhOzi3FcF344wB
        n9bjf6QNo94MLx0xQlIY0kilv2De2jF4uWXDalT9yg==
X-Google-Smtp-Source: ACHHUZ4/BsJLeju2PLbt5pAlNKs9HCs+L/a+aoGadZdc5126qFYXsWl4ZqqsKOGOHls+GZh/YouqzAYQs4MpSz2iIZM=
X-Received: by 2002:a05:6214:27c6:b0:632:2101:c449 with SMTP id
 ge6-20020a05621427c600b006322101c449mr1727469qvb.25.1687434525929; Thu, 22
 Jun 2023 04:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info> <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAD=FV=Xt2KYGY15+f+nHxkzKnwhHzw1A7=o+5kgCDWvHDv0DNg@mail.gmail.com>
 <20230620155902.clspxncyvpodixft@ripper> <5240ce3f-37fa-2747-92ee-23d71619f3ef@leemhuis.info>
In-Reply-To: <5240ce3f-37fa-2747-92ee-23d71619f3ef@leemhuis.info>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 22 Jun 2023 17:18:09 +0530
Message-ID: <CAMi1Hd2zunc=WNUE7KT-423RXTiX6LrY2hcWQdV3Dp3o8RdJtg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 13:17, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> As Linus will likely release 6.4 on this or the following Sunday a quick
> status inquiry so I can brief him appropriately: is there any hope the
> regression this patch tried to fix will be resolved any time soon?

We are most likely to miss v6.4. I'm trying to reproduce the crash
with tracing enabled, to share some more debug information.

Regards,
Amit Pundir

> Doesn't look like it from below message and this thread, but maybe I
> missed something.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 20.06.23 17:59, Bjorn Andersson wrote:
> > On Wed, Jun 14, 2023 at 12:44:15PM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Wed, Jun 14, 2023 at 11:47=E2=80=AFAM Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 14/06/2023 20:18, Linux regression tracking (Thorsten Leemhuis) wr=
ote:
> >>>> On 02.06.23 18:12, Amit Pundir wrote:
> >>>>> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
> >>>>> list to workaround a boot regression uncovered by the upstream
> >>>>> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
> >>>>> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
> >>>>>
> >>>>> Without this fix DB845c fail to boot at times because one of the
> >>>>> lvs1 or lvs2 regulators fail to turn ON in time.
> >>>>
> >>>> /me waves friendly
> >>>>
> >>>> FWIW, as it's not obvious: this...
> >>>>
> >>>>> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8=
YGrLZsw5edb-NtRJRw@mail.gmail.com/
> >>>>
> >>>> ...is a report about a regression. One that we could still solve bef=
ore
> >>>> 6.4 is out. One I'll likely will point Linus to, unless a fix comes =
into
> >>>> sight.
> >>>>
> >>>> When I noticed the reluctant replies to this patch I earlier today a=
sked
> >>>> in the thread with the report what the plan forward was:
> >>>> https://lore.kernel.org/all/CAD%3DFV%3DV-h4EUKHCM9UivsFHRsJPY5sAiwXV=
3a1hUX9DUMkkxdg@mail.gmail.com/
> >>>>
> >>>> Dough there replied:
> >>>>
> >>>> ```
> >>>> Of the two proposals made (the revert vs. the reordering of the dts)=
,
> >>>> the reordering of the dts seems better. It only affects the one bugg=
y
> >>>> board (rather than preventing us to move to async probe for everyone=
)
> >>>> and it also has a chance of actually fixing something (changing the
> >>>> order that regulators probe in rpmh-regulator might legitimately wor=
k
> >>>> around the problem). That being said, just like the revert the dts
> >>>> reordering is still just papering over the problem and is fragile /
> >>>> not guaranteed to work forever.
> >>>> ```
> >>>>
> >>>> Papering over obviously is not good, but has anyone a better idea to=
 fix
> >>>> this? Or is "not fixing" for some reason an viable option here?
> >>>>
> >>>
> >>> I understand there is a regression, although kernel is not mainline
> >>> (hash df7443a96851 is unknown) and the only solutions were papering t=
he
> >>> problem. Reverting commit is a temporary workaround. Moving nodes in =
DTS
> >>> is not acceptable because it hides actual problem and only solves thi=
s
> >>> one particular observed problem, while actual issue is still there. I=
t
> >>> would be nice to be able to reproduce it on real mainline with normal
> >>> operating system (not AOSP) - with ramdiks/without/whatever. So far n=
o
> >>> one did it, right?
> >>
> >> The worry I have about the revert here is that it will never be able
> >> to be undone and that doesn't seem great long term. I'm all for a
> >> temporary revert to fix a problem while the root cause is understood,
> >> but in this case I have a hard time believing that we'll make more
> >> progress towards a root cause once the revert lands. All the
> >> investigation we've done so far seems to indicate that the revert only
> >> fixes the problem by luck...
> >>
> >> I completely agree that moving the nodes in the DTS is a hack and just
> >> hides the problem. However, it also at least limits the workaround to
> >> the one board showing the problem and doesn't mean we're stuck with
> >> synchronous probe for rpmh-regulator for all eternity because nobody
> >> can understand this timing issue on db845c.
> >>
> >
> > I agree that we shouldn't hide this by reverting the regulator change.
> >
> >
> > And as has been stated a few times already, the symptom indicates that
> > we have a misconfigured system.
> >
> > Before accepting a patch just shuffling the bricks, I'd like to see som=
e
> > more analysis of what happens wrt the rpmh right before the timeout.
> > Perhaps the landing team can assist here?
> >
> > Regards,
> > Bjorn
> >
> >

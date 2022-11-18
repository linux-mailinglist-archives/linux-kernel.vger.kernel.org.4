Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433262F223
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiKRKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbiKRKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:06:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E358FB1E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:06:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w23so4117270ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uh3YxDgspkB68SJoIPbAc50d6XGVfp5931wp78ekCo=;
        b=hs2eonUzH3U51NbUg0vNsd5tQ0Z1HqnyDlCfH1qE2oZqGApg8MIgzun6Ze88oUOO/J
         ewfn0OyHrsF1os3fvp7YGC8JJ1uA2Tm4oVxe7VmZPu4u2Z/2jzgbXpwHhKnfKNi6PTtH
         xDsl5Hy5omYexkgisVxzwjIjvNdCwPRbcjI9IZA18WnC6VgBVo6XM9a4jWJzFePT4z4J
         cAuMJ2KMk2I+tlNpkmr7eLUIZaEgi//zFzKchwN+H3insIS+AWPiXIxQ0IB1MRYkPah+
         LJahjP8cnuCmkW9s1TX+6iZd1TC49N0+EMAl5NwX7WXgsvg4ypBGLikFouVUct2V0y5x
         LAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uh3YxDgspkB68SJoIPbAc50d6XGVfp5931wp78ekCo=;
        b=NysI7CeYca3BdTYmO0EEhR04vmSFpZ504s2o96B+eDwmMKQu1v9482gb0Cwyle3GTN
         0y3CpT3vyaaDmf7SdSqsZh0UxucjNhxKMoqk24UiOCxA6neff9ToL/zvzfIPJSy17tEH
         9C2CuNDb7jptEVRMrlLeExVqmtktcSZlavyTZj41BpvqICOFKxQ/VVemG4cZTWkQrOO5
         6eA592VSkcGCXlfko2eOSOncZKwXZ2TPioHEcv7BVU1JKrcOwatPBNPiHGuVWiSSdTtn
         UFw3irxBctVvnXPvPRZlJhMa54ZI57TlWYpnl6URxOQGpA3kgOusaP9KalXirAjFPIPD
         N6Cg==
X-Gm-Message-State: ANoB5pkoVWnp7Mexdwr6CwmtdXYte1MzRFMs3htMLnGSKRr4p/wM0Uif
        0dU4YoKMTkCQNKRYwYuzFOMQtPJ8sjBrgnyl/bC6Pg==
X-Google-Smtp-Source: AA0mqf5DQ+7W6xK4uZyzaxH1CPEq0BqnknF+w4PGK0v1UlGT6oDvQqas4LBFkLxvPhpjLRDpZu78WhKSiUk6wGZeezQ=
X-Received: by 2002:a17:902:bcc9:b0:186:be05:798e with SMTP id
 o9-20020a170902bcc900b00186be05798emr6832336pls.37.1668766016568; Fri, 18 Nov
 2022 02:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20221108045300.2084671-1-lis8215@gmail.com> <20221108045300.2084671-2-lis8215@gmail.com>
 <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
 <59EJLR.DQ7KHQEAEUSG2@crapouillou.net> <CAKNVLfYpmJjQYFOy__PkmqcftQcQUYEKJ2V2K90MfG-1MBC_uA@mail.gmail.com>
In-Reply-To: <CAKNVLfYpmJjQYFOy__PkmqcftQcQUYEKJ2V2K90MfG-1MBC_uA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 11:06:19 +0100
Message-ID: <CAPDyKFpNMfru+U8r-pnFpyfZ_3_7RdrApdBvcpykV1ccaMMaHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some SoCs
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 10:52, Siarhei Volkau <lis8215@gmail.com> wrote:
>
> =D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 12:27, Pau=
l Cercueil <paul@crapouillou.net>:
> >
> > Hi,
> >
> > (Ingenic SoCs maintainer here)
> >
> > Le ven. 18 nov. 2022 =C3=A0 09:45:48 +0100, Ulf Hansson
> > <ulf.hansson@linaro.org> a =C3=A9crit :
> > > On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wrote=
:
> > >>
> > >>  Some SoCs have one clock divider for all MMC units, thus changing
> > >> one
> > >>  affects others as well. This leads to random hangs and memory
> > >>  corruptions, observed on the JZ4755 based device with two MMC slots
> > >>  used at the same time.
> > >
> > > Urgh, that sounds like broken HW to me.
> > >
> > > The MMC blocks could share a parent clock (that would need a fixed
> > > rate for it to be applied), assuming there is a separate gate/divider
> > > available per block. But there isn't'?
> >
> > They do share a parent clock and have separate gates, and each MMC IP
> > block has an internal divider for the bus frequency derived from that
> > shared clock.
> >
> > >>
> > >>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b=
.
> > >>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
> > >>  which shall remain its behavior. For the JZ4755 is sufficient to
> > >>  use JZ4725b's binding. JZ4750 is outside of the patch.
> > >>
> > >>  The MMC core has its own clock divisor, rather coarse but suitable
> > >> well,
> > >>  and it shall keep the role of tuning clock for the MMC host in that
> > >>  case.
> > >
> > > The mmc core doesn't have a clock divisor, but it does control the bu=
s
> > > clock frequency through the ->set_ios() host ops. It needs to do that=
,
> > > to be able to conform to the (e)MMC, SD and SDIO specifications.
> > >
> > > Can you please try to elaborate on the above, so I can better
> > > understand your point?
> >
> > Yes, I don't really understand the patch, TBH.
> >
> > The "clk_set_rate" call will only set the shared clock to the *maximum*
> > clock frequency (host->mmc->f_max) which should be the exact same
> > across all MMC IPs.
>
> That's the case I need different "f_max" for my HW, for some reason
> internal slot can't do a full rate (48MHz) but the external can, the same
> card used for checking. So I want to set 24M for mmc0, and 48M for mmc1
> with respect to hardware limitation.

This sounds like a board specific problem, right?

The simple solution would be to use 24M for both hosts, but that would
unnecessarily degrade the speed for the host for the internal slot.

It sounds like we need a new DT binding to describe a capped
max-frequency for the "broken slot". And in case that is available in
the DTS, the mmc->f_max value should be overridden with it, while also
respecting the original f_max value while calling clk_set_rate().

Br
Uffe

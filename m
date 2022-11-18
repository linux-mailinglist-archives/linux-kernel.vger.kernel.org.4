Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3162F551
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiKRMss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbiKRMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:48:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71697655;
        Fri, 18 Nov 2022 04:48:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f7so6995041edc.6;
        Fri, 18 Nov 2022 04:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkf+vf5H99m28DXni9JA8v6TuHcwaOr7fkrAsoxdAJo=;
        b=azckUTFwl5+mcmV9ZvXGrNxfypC5unle8kmUw73iVO21n7hARbaVF9tOy012c8JhI6
         PQfilSi3CANlmk4DU1fXnx2fX41wPEkmFbYLTYWzAr88FjjLEvTWlByuucH1EzXBX+XU
         gBLcr85qUg0I4vDW9c1v8aRmA9Sk7N4iNjqdGtBfU9PeWbPOCBb1ONsx+k+WNUQzp3tI
         iTcZhogHs6M3NeCMELorsaCL6RDFeLmPK4ZdDyItgsVP3Dy1OLBIVkCpRZDJjJnLOX3J
         EbzBnM1iiAZ2NXHdCEVLWJUGBNV98wsL0vidgO4qbmrNU2joZeFKyItaW5yP/qGdpZyi
         UATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkf+vf5H99m28DXni9JA8v6TuHcwaOr7fkrAsoxdAJo=;
        b=kmdxr/7zavXNN1bsun8WNB1nE3NeuH33mPVhh3w/J/oFJ+VKQx3I9csRjGHxakkByj
         6hsWkQPSRTixRXiC4fT+kTptqoDoYbVypzixQoKmC3bYxbtm2n5zDFdcp9AKVR5LqQEb
         C128PFMlmXjPF3dZOs0P6ube9ped+BIU9yG2bnqClE/3T7+y2Tvmn1i/wO3rAnurYTiS
         xewrNmOha/63EifbBVsqy7QZwa+0pMoehcIv8P9pgxCWLuhwk27oN05w7F3pCSxkaaW4
         dK+Svbb60zr0+THYPTbYGqcBGTqTBEtWsUmgE9tCV2yoiJdaqJILmkzAyjRoOEg5KoMH
         e0mA==
X-Gm-Message-State: ANoB5pmhQ/hsuM1sAZNwuw9I+ootHdOgepP8aDLsAUWtUWStywqcf0G3
        Zy3uAiVBt/VEkfQENMjKFcYtSlsz9kq3n3+i9mw=
X-Google-Smtp-Source: AA0mqf71tBnaz8hkADRoxmAofrunH7v9OzKJ8sYvsMQGeNNKjlJGnl5xdl4X47mYMcPcWRJACPqG1rhZdKdMZ5+0huA=
X-Received: by 2002:a05:6402:702:b0:461:ed76:cb42 with SMTP id
 w2-20020a056402070200b00461ed76cb42mr6187221edx.229.1668775706846; Fri, 18
 Nov 2022 04:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20221108045300.2084671-1-lis8215@gmail.com> <20221108045300.2084671-2-lis8215@gmail.com>
 <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
 <59EJLR.DQ7KHQEAEUSG2@crapouillou.net> <CAKNVLfYpmJjQYFOy__PkmqcftQcQUYEKJ2V2K90MfG-1MBC_uA@mail.gmail.com>
 <CAPDyKFpNMfru+U8r-pnFpyfZ_3_7RdrApdBvcpykV1ccaMMaHQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpNMfru+U8r-pnFpyfZ_3_7RdrApdBvcpykV1ccaMMaHQ@mail.gmail.com>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Fri, 18 Nov 2022 15:48:15 +0300
Message-ID: <CAKNVLfbKPveW+k9FWZob=7VYu4UD6sPNct3TiMpdn0QvJp41Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some SoCs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 13:06, Ulf H=
ansson <ulf.hansson@linaro.org>:
>
> On Fri, 18 Nov 2022 at 10:52, Siarhei Volkau <lis8215@gmail.com> wrote:
> >
> > =D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 12:27, P=
aul Cercueil <paul@crapouillou.net>:
> > >
> > > Hi,
> > >
> > > (Ingenic SoCs maintainer here)
> > >
> > > Le ven. 18 nov. 2022 =C3=A0 09:45:48 +0100, Ulf Hansson
> > > <ulf.hansson@linaro.org> a =C3=A9crit :
> > > > On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wro=
te:
> > > >>
> > > >>  Some SoCs have one clock divider for all MMC units, thus changing
> > > >> one
> > > >>  affects others as well. This leads to random hangs and memory
> > > >>  corruptions, observed on the JZ4755 based device with two MMC slo=
ts
> > > >>  used at the same time.
> > > >
> > > > Urgh, that sounds like broken HW to me.
> > > >
> > > > The MMC blocks could share a parent clock (that would need a fixed
> > > > rate for it to be applied), assuming there is a separate gate/divid=
er
> > > > available per block. But there isn't'?
> > >
> > > They do share a parent clock and have separate gates, and each MMC IP
> > > block has an internal divider for the bus frequency derived from that
> > > shared clock.
> > >
> > > >>
> > > >>  List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ476=
0b.
> > > >>  However, the MMC driver doesn't distinguish JZ4760 and JZ4770
> > > >>  which shall remain its behavior. For the JZ4755 is sufficient to
> > > >>  use JZ4725b's binding. JZ4750 is outside of the patch.
> > > >>
> > > >>  The MMC core has its own clock divisor, rather coarse but suitabl=
e
> > > >> well,
> > > >>  and it shall keep the role of tuning clock for the MMC host in th=
at
> > > >>  case.
> > > >
> > > > The mmc core doesn't have a clock divisor, but it does control the =
bus
> > > > clock frequency through the ->set_ios() host ops. It needs to do th=
at,
> > > > to be able to conform to the (e)MMC, SD and SDIO specifications.
> > > >
> > > > Can you please try to elaborate on the above, so I can better
> > > > understand your point?
> > >
> > > Yes, I don't really understand the patch, TBH.
> > >
> > > The "clk_set_rate" call will only set the shared clock to the *maximu=
m*
> > > clock frequency (host->mmc->f_max) which should be the exact same
> > > across all MMC IPs.
> >
> > That's the case I need different "f_max" for my HW, for some reason
> > internal slot can't do a full rate (48MHz) but the external can, the sa=
me
> > card used for checking. So I want to set 24M for mmc0, and 48M for mmc1
> > with respect to hardware limitation.
>
> This sounds like a board specific problem, right?

Exactly.

>
> The simple solution would be to use 24M for both hosts, but that would
> unnecessarily degrade the speed for the host for the internal slot.
>
Indeed.

> It sounds like we need a new DT binding to describe a capped
> max-frequency for the "broken slot". And in case that is available in
> the DTS, the mmc->f_max value should be overridden with it, while also
> respecting the original f_max value while calling clk_set_rate().
>
> Br
> Uffe

I think it is unnecessary, "max-frequency" is enough and clear to use here,
it just needs to be tuned independently for each controller. However, the
controllers have hidden dependency on each other. Break this dependency
that's the subject of the patchset.

Siarhei

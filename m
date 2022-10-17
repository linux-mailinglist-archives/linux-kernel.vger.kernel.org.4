Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FDB6015F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJQSIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJQSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:08:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD0F74B8C;
        Mon, 17 Oct 2022 11:07:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h203so9785958iof.1;
        Mon, 17 Oct 2022 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEOWtVNjYdH9YkaPM5vlZiYdAHpFwckF9QtAFSfsGqA=;
        b=pKRP1zgd6Q4k0q1nFaZ4ByQLmGLR4yopgzx4PRvBUNcappOfoWqE4JZhudsG0GffKG
         vk2i4pydG1QSnz5rfF6kEAKjzYByjxFgEClxI6yu5E6GHDNa9k0sC+vqvaewVhWFSFuv
         2ryvlMbrazWuTubDcOAMvD8gia7zy0a94rI8DE/8ycz1jRGQJ1peutbYG0Inm+WDJQnl
         AZKSDEsamQlwcjgkUbBWrJHqS6KvIaHJMF+gZSPGX4DJrfDzySSPuAjTXaLnS2Hq+YN5
         mETENz3PpTRUVLEbo3ZR+drpeA/6u2mAeDDhKYuWuNt/yKsiPWnyMz3jxWJ3aMaZS1pw
         8Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEOWtVNjYdH9YkaPM5vlZiYdAHpFwckF9QtAFSfsGqA=;
        b=te0fAfPquR84XlIMquZkO4+CRpEmPmHdnhsMSDLd0I6b5GeHeizTzDOyFOfQ/FCF1D
         GCitoaz/9iR/9HXVHluEHb2MODS8PjOmBEL1eb+ZvonU+RLGCY4rZFU7n/NYLVZyeXDZ
         05eW2E26dCrVVTu7SmE/AAjkFzBT1y0XHnM1g7JwL8do3YbRN4YBN6KNg6LTV2smN/jF
         t5TxWRfmbilOTiJRR4AvFRI2/itIu6/QXdUnCBBMWfYvQIdurIu80sGVowlFzURZXj2u
         YBTa/2GycUs7sEbtQFXHgcXamPlsGCZVD95IzHiAJh2csFYRgUQd8+rbHmHWN1zqkHyF
         cXtQ==
X-Gm-Message-State: ACrzQf1b29Z7tXmnJwc2FD3ajfUSenyK0DdLKeFt3icPjY2nxx6YhRBj
        ahd+gk9AOm86ZtZ+SonSOjKKM3HuiC7Xp/JkFLE=
X-Google-Smtp-Source: AMsMyM77udb/S0MFXl+h+5pev1FZzF+2DS+r+HaH7gx3h1Jnzv0Dg4P2eFjll2WthNs/nHDpoV70jmtvXekovGsFHRk=
X-Received: by 2002:a6b:6716:0:b0:6bc:113c:22a2 with SMTP id
 b22-20020a6b6716000000b006bc113c22a2mr4946988ioc.12.1666030079215; Mon, 17
 Oct 2022 11:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221016150110.3020451-1-lis8215@gmail.com> <20221016150110.3020451-5-lis8215@gmail.com>
 <0S4WJR.4KB18PR21S9K1@crapouillou.net> <CAKNVLfYEMwRC+4VuGcaENd1eTvbhWD9=uFDAhaz+1Fd8Aaqg_w@mail.gmail.com>
 <M0RWJR.TI6Q9ATD37DF3@crapouillou.net>
In-Reply-To: <M0RWJR.TI6Q9ATD37DF3@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 17 Oct 2022 21:07:47 +0300
Message-ID: <CAKNVLfbbAaNdhWDo10XrUtyCM4R5E1CidC+TTQt8tUYbBU93qw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clk: Add Ingenic JZ4755 CGU driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
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

=D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 20:24, Paul Cercue=
il <paul@crapouillou.net>:
>
>
>
> Le lun., oct. 17 2022 at 20:10:56 +0300, Siarhei Volkau
> <lis8215@gmail.com> a =C3=A9crit :
> > =D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:24, Paul Ce=
rcueil
> > <paul@crapouillou.net>:
> >
> >>  > +     [JZ4755_CLK_AIC] =3D {
> >>  > +             "aic", CGU_CLK_GATE,
> >>  > +             .parents =3D { JZ4755_CLK_I2S, -1, -1, -1 },
> >>
> >>  Wrong parent here, should be JZ4755_CLK_EXT_HALF.
> >
> > I don't  agree, see Figure 20-13 in the JZ4755 PM.
>
> 20-13 describes the I2S clock, no?

See 20.4.9 Serial Audio Clocks and Sampling Frequencies.
It stated that: "For internal CODEC ... CODEC needs a 12MHz
clock from CPM called SYS_CLK ...", but SYS_CLK is described
only in the I2S Controller section. I assume it is the same clock.

>
> AIC clock's parent is EXT/2 according to the diagram in 8.2.2.
>

It's a bit cryptic manual, who knows how it's done in the HW.
I observed that codec runs on a desired sample rate only when PLL
equals 432 or 216 MHz, but SYS_CLK is definitely configured to be
12MHz - from EXTCLK. On other PLL frequencies it is lower by
2-4% than expected. That isn't observed on JZ4725B.

> >>  Well it would be good to know...
> >
> > Indeed, I will try to figure it out.
>
> Cheers,
> -Paul
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB0745B71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGCLos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGCLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:44:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA410E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:44:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so69122571fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1688384683; x=1690976683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaNHFGtqidFFoc879AcjoyLmp2ttt/EsaJvpqNaeTBg=;
        b=tG+WDuV6RlFBC96XU0zrBQAAznnNTMP26skrKr0lEq/LIRouxE23HHH8iDMF4HOaXP
         hv3CqtSeblorPsoUJGIMgX7Oir0zrOLXdgvaNSB+w0Wqw3SZxROIFKgYSZHaqRbrVAaQ
         TcSpQp9U0PtgaAXgUwZqPFJsb9TwF4HGqi45jUzgW5lBGeXnMOUQySyltDC9Waalxbcg
         4tMW/i5QTGtZFcFEysu+wWvFktGkmSr8vucZV3vdv2dLXXoA4mqPGcU2vi5vr2wFwaq2
         q6ep/ns6phzhjdHnjjs0PC1VfilxQ3rwxQOgQfzMi2Rt/kkjFMzyN4dBi/Kh6v+SZZsE
         lIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384683; x=1690976683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaNHFGtqidFFoc879AcjoyLmp2ttt/EsaJvpqNaeTBg=;
        b=NG8K1K3rXOSeLk0XtbFenp230V4EFL11ktN0xOrUGCwFdfbmi9LY5PF4pRK6P9UIOS
         7WTFp2feLUKfYY2CFx2HfMW5KCNjOILPJwkxv9mbax/Cem9w1tSvPEy3bT+VO8htlQYy
         fmO8XEMji4snTiSsmwwsRkTpMmNcYkPaZN7nDnjJsSyPRyFIneqsgIbgrxut3qG7UkuE
         rfhvWZlV4NH8QBBqb6j9Je+wcg2RIHroQpScb4fk+XRSrEo/hnmdMr2rShqiZ7SeHQy7
         9Oyd0kek6v8EcdsW4VhKbW/m97WDhfBhZ4RoGc8yyXwWqYnXnKn5MfX7y9OMQREIPW5T
         8+eA==
X-Gm-Message-State: ABy/qLbUPWtgOHKzTL2GYfw8cUS0exetcvRlNOkF+nQzi++MLAYoAtn2
        ftqC/XgiiqGMJPqcrqp6veGAIlBgqcXFR+6qbOaASQ==
X-Google-Smtp-Source: APBJJlGbheteHmbNZEDEkZHAuIEEMQkHMHMiMY31fEaVpgo1N30lf/fgRzYRxG7UFIccv4g/oQFL+6AtzrHyfgR4dtI=
X-Received: by 2002:a2e:98d6:0:b0:2b6:9930:871 with SMTP id
 s22-20020a2e98d6000000b002b699300871mr6735718ljj.13.1688384682883; Mon, 03
 Jul 2023 04:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230630144006.1513270-1-pan@semihalf.com> <20230630144006.1513270-4-pan@semihalf.com>
 <20230630-scrimmage-antelope-7d1f82d491fc@spud>
In-Reply-To: <20230630-scrimmage-antelope-7d1f82d491fc@spud>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Mon, 3 Jul 2023 13:44:31 +0200
Message-ID: <CAF9_jYT1Fz4hBQrNtgkM6mU-JVH=ZxsJnkaLDsa5uoEV_hTLVA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] ARM: dts: Add Chameleon v3 video node
To:     Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, upstream@semihalf.com,
        amstan@chromium.org, ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jun 30, 2023 at 04:40:06PM +0200, Pawe=C5=82 Anikiel wrote:
> > Add node for the video system device.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> > ---
> >  .../socfpga/socfpga_arria10_chameleonv3.dts   | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv=
3.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> > index 422d00cd4c74..5e66363d4ab5 100644
> > --- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> > +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_chameleonv3.dts
> > @@ -10,6 +10,60 @@ / {
> >       compatible =3D "google,chameleon-v3", "enclustra,mercury-aa1",
> >                    "altr,socfpga-arria10", "altr,socfpga";
> >
> > +     soc {
> > +             video@c0060500 {
> > +                     compatible =3D "google,chv3-video";
>
> This compatible does not seem to be documented & I did not see a comment
> about the lack of a binding in the cover letter. What am I missing?

Yes, the compatible is not documented for now (I'll do that in a later
patchset), sorry for not mentioning that in the cover letter.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A367EFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjA0UrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjA0UrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:47:15 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422C7DB1;
        Fri, 27 Jan 2023 12:47:02 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-50aa54cc7c0so55279317b3.8;
        Fri, 27 Jan 2023 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kouO7u+bs7T+iMfnYDkSLAukyRnuu6BxC2pSxSTT8zg=;
        b=DlvsIkX0qN3inFNrOB4prIdQvqtqmM16FWIvEo371ExtB8L0aAXJqh2LkG6stQ+Tte
         YvUeABbNooq+g0nhZz5ql5sDcq+wn1akooKJ5P9MAER5ilcm/ZogorOdGYf3bWMuFT+2
         7hR8BT8gqKHN7zyoI+M4nQptlOgsTvKtO4cuxwrqs/vFacQHKJpszHZCD2Kb4MZ6Hi9k
         LCN54Wbx0e3y6MdJuBfEZu1Eij077oGmGz6DNzo68fyi4DY8X7ekRiuIRg4pokEEsshB
         MJOTbceR+55QYCGodv7VZFAAIKJnwqBKrSrKZoPr6r3B/occc6uyfaThO/oXzW773Fg9
         T7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kouO7u+bs7T+iMfnYDkSLAukyRnuu6BxC2pSxSTT8zg=;
        b=PEdX9sP4fuP3vUvPlz4jDpex/z+65nxaqRf86he7w4RGqu/F2TKitO7XDhxzLc0aEJ
         XN+kKNGj4fKGhK7BT066IlGZGAGohM24+Ps/64SHPHMTc2EC3EztAt/Z4d9bnDAOzEvv
         ZVPe9i1018gadEa/dQJ7iyVkAnmoeCZiBKjSVcC9yWwRG+wfrslKXFOChE0M0aiXNsuW
         T/C62tP26I1kiiYYyPobJsGd9Q52PgFvBxiooFcqgEQUGeN3/Hg1asVxr51699+W+lmf
         gkgrOodWH+Aa0jr8rG6CjXxMVxraWTlLFu85KomekA8/bvvtFxv4Qg5zuNHs7Jyca1Mf
         R9ig==
X-Gm-Message-State: AO0yUKVY5ugXnQB79pq6qTIufQEarpuGGikIDOcnBOyk6Otxa2OPGRxt
        xZdqctiPONUfTVZ2MpJ5TuC5vqiqjrQ5lD0M5e8VBdBzPmo=
X-Google-Smtp-Source: AK7set9HVG30cY8SO6wA6h66En9OSKjkd+dbQHrXILG1Tsakenlpav9gzJn47RMq8PaYRXejvbM0XW1rdaPOXXaVAvk=
X-Received: by 2002:a81:4656:0:b0:4fd:9685:d982 with SMTP id
 t83-20020a814656000000b004fd9685d982mr19640ywa.304.1674852422199; Fri, 27 Jan
 2023 12:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <6faa66a5-8f86-1a22-df51-2c8fa62054a2@linaro.org>
In-Reply-To: <6faa66a5-8f86-1a22-df51-2c8fa62054a2@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 27 Jan 2023 20:46:36 +0000
Message-ID: <CA+V-a8uDfpfZJGK8jZB=8_VApAN+GCu_SC7RDoYvzL+s8M261A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Krzysztof,

Thank you for the review.

On Fri, Jan 27, 2023 at 5:54 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 27/01/2023 18:40, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable the performance monitor unit for the Cortex-A55 cores on the
> > RZ/G2L (r9a07g044) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > index 80b2332798d9..ff9bdc03a3ed 100644
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > @@ -161,6 +161,11 @@ opp-50000000 {
> >               };
> >       };
> >
> > +     pmu_a55 {
>
> No underscores in node names. This is usually called just 'pmu'.
>
Ok, I will update it in the next version.

Cheers,
Prabhakar

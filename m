Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2F6D1CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjCaJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjCaJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:41:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9E4EC9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5445009c26bso404711787b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680255709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo2e908Td2gve6mc5SW+VA1nrFzqtdIPvQwGYibnpiE=;
        b=uBMQIM9oghtu65OYry7lh4Mg9Ey6cTyShHDuQhNvkKE7cvwdYHy8HnejROCk4ISgBp
         n4e9O+dpRLoxInIr0AZo6wccf2QiNwAmGY6ht9Plojz33GD3k3FLmtt9lRBB2OoL5AhL
         q2tQFIWfJ/sC6d85vYFLRhLcrxJBPlr1eaExYaWQbIa5/50Jh2eHlnucVQQ3EXIqsMhF
         Xn7baerAqsPtuvTx5Dhgm9XDMjpTYzSMOsnAxiuciECoi/2dtVis3DjNLK35S0dVG0KG
         wAvNRlq2DbLnfG9+b2gm/R5ppzBZy9uGHsRoJDKHucpOb8KGlIogRpALWSfLixgMC6r8
         opMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680255709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo2e908Td2gve6mc5SW+VA1nrFzqtdIPvQwGYibnpiE=;
        b=Nigkcf2tIGib1n9mlV+V9NofOKKtRYbthJnsPfjocHoINo/SzwMXxXq4pZxo0pwyDB
         R2UrwTI9aCBaVdG091RzsgZBqpFy4rxZTXq9uS10jOuQQMYwWa/nbvPZetrdmJ+ODunh
         zFQdlaISfPq4yN2zcV7CVqbHO1tKO3hGsOcHtsCEVbhpUkaZISzLNS1aZfTGR2NY8ICn
         05uuIF0aEywC08GMJSavfx+okQF7UAJQF57uJ/c9Rnnw87UNctU+PlzWcIgM9KqXtyyd
         xfzvDR2ClK1ZwuAlJd0OXitYVt51T1CT2prUFs9Yj0/s1A9+Txqk43+SZ4zXLZ6ivEW+
         HLWQ==
X-Gm-Message-State: AAQBX9fOyX0WHa7FgL46Tm7VPfzIAmECf7/IJKsI9n7buMAYLvTvzg7F
        5qDySFQL+aL0ZstfPP46A0Dabti27pQ/JvVUdbEz7Q==
X-Google-Smtp-Source: AKy350Zp7b7rjPNqqt62mXM2VNu7M6RMNX9eWwNzvLF+Jhy96wQfhw+jaU3Fvyd5viiVC5EgACPo2KWYnzUvEMriI7w=
X-Received: by 2002:a81:b620:0:b0:541:8995:5334 with SMTP id
 u32-20020a81b620000000b0054189955334mr13089289ywh.3.1680255709091; Fri, 31
 Mar 2023 02:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-5-0003e80e0095@baylibre.com> <889be563-78d6-7148-f7d2-09ae21383ee4@collabora.com>
In-Reply-To: <889be563-78d6-7148-f7d2-09ae21383ee4@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 11:41:38 +0200
Message-ID: <CAFGrd9rGoAN=B6O=X7peOtyYuWpWkMBFakrkLp2fcD-D2uajqw@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm64: dts: mediatek: add mt6357 device-tree
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 29 mars 2023 =C3=A0 15:17, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Il 29/03/23 10:54, amergnat@baylibre.com ha scritto:
> > From: Fabien Parent <fparent@baylibre.com>
> >
> > This new device-tree add the regulators, rtc and keys support
> > for the MT6357 PMIC.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt6357.dtsi | 282 ++++++++++++++++++++++=
+++++++++
> >   1 file changed, 282 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot=
/dts/mediatek/mt6357.dtsi
> > new file mode 100644
> > index 000000000000..3330a03c2f74
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
> > @@ -0,0 +1,282 @@
>
> ..snip..
>
> > +
> > +             keys {
> > +                     compatible =3D "mediatek,mt6357-keys";
> > +
> > +                     key-power {
> > +                             linux,keycodes =3D <KEY_POWER>;
> > +                             wakeup-source;
> > +                     };
> > +
> > +                     key-home {
> > +                             linux,keycodes =3D <KEY_HOME>;
> > +                             wakeup-source;
>
> KEY_HOME is a wakeup-source?! are you sure?!
>
> (P.S.: I'm just checking if that was intended)

Yes it's the setup used in the official Mediatek Rity project.

Regards,
Alex

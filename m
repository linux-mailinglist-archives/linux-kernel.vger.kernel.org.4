Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E46780FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAWQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjAWQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:11:08 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C023DB4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:11:02 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-15bb8ec196aso14480550fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrw9IaKBt2RjGFFOLVmUTAC2ysW/K7FJYVGxgEZT6RI=;
        b=4+nypBxcvKlmdQifMiVAOKFFCDGoqo0UYC7kFTEqUq3/3B7HBju9+zs+AhD43xFNTH
         4P5H+FtPQyj9+ZHS6iZkVvtG0b74k2+dbv5msX7EdzA8NExYb01S2F6xNB6kmcVMjaZl
         wKb1mLTeq5P50r2MvsT1XJoey9531BySinmBn3ehYmkCqcfILqrrgd/QQ2/MrsZy0qME
         xSCucu/NQc8NfV48Zp3kJhghNJVZhtfLgiyRBxmHgknfXVc0DXONAkXV9jYvohTLKSus
         nDR1JZJEWpaFCPMMB+CO/QsQ4jqY9lRQtnBiYLRgzoY1CNbkgCtFd60TG6A/0dSy4+5c
         zW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrw9IaKBt2RjGFFOLVmUTAC2ysW/K7FJYVGxgEZT6RI=;
        b=JBiG+1HCBnCzeyh0wj2pm4YKjSnDgAhdQVrJ3Uen4DaJX1fp4KvkifqHn1N6zXi7Ji
         FsrXOdkRNdzMSsRdpkykBbBiL+BPfak177lWM6bCiC9z98aFkXQEebWhPvx6zLPRugv0
         ljWtn8yssD02wiaeBOmf2zbCnjdeVcnfBj35nsUx6VWHMKVaH0qtqbm7Jc0ucJZbRseC
         Vi5/CsxsZ6LKStAqIj66QbPX5e7sMEku4ISWwnc2Q8cZSS+C2EuFBdXcHNsYDTjv8cJ/
         3CnKl07gkm4LzQ6i//DKABgHlS8/tNsxyvSb6gRNgGfHMsq6Pg0uywb2oelbANk7bg72
         VSrA==
X-Gm-Message-State: AFqh2koeT/0qRwCWY7gsCQeWiD+kAmZhzCnxvaIojeJ0waEFohgkbzWb
        drHGHRnY3s2o6YRKcEIFc0Q+Cs9wcsRqC8J/Ncw3/g==
X-Google-Smtp-Source: AMrXdXvbHVHozpchrZ4CeX9zV23v8gu6ze5x0q8sEBYOdMn3jkh5JF2UpYM+ROxk6lJdCZFAWjMwAAh3hoimr7umhp0=
X-Received: by 2002:a05:6870:9729:b0:14f:bcdb:3061 with SMTP id
 n41-20020a056870972900b0014fbcdb3061mr1577867oaq.152.1674490261334; Mon, 23
 Jan 2023 08:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20230101220149.3035048-1-bero@baylibre.com> <20230101220149.3035048-8-bero@baylibre.com>
 <18e6d30d-15ee-3d88-e9d3-f8dad6034760@gmail.com>
In-Reply-To: <18e6d30d-15ee-3d88-e9d3-f8dad6034760@gmail.com>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Mon, 23 Jan 2023 17:10:50 +0100
Message-ID: <CAP2ifjNpPFRGJ+dLJPw4tHP1vApyTeuynA_53V8xNQ9SpaxXnA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] arm64: dts: mediatek: Initial mt8365-evk support
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        linus.walleij@linaro.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 20, 2023 at 11:57 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On 01/01/2023 23:01, Bernhard Rosenkr=C3=A4nzer wrote:
> > +             uart0: serial@11002000 {
> > +                     compatible =3D "mediatek,mt8365-uart", "mediatek,=
mt6577-uart";
>
> Unfortunately we are missing this compatible in the binding description.

True, overlooked that one.

> > +             ssusb: usb@11201000 {
> > +                     compatible =3D "mediatek,mt8365-mtu3", "mediatek,=
mtu3";
>
> Same here.

This is actually added by an earlier patch within this series (5/7),
but since it isn't used anywhere yet, might as well drop it for now,
"mediatek,mtu3" by itself works.

> > +                     usb_host: usb@11200000 {
> > +                             compatible =3D "mediatek,mt8365-xhci", "m=
ediatek,mtk-xhci";
>
> Same here.

Also added by an earlier patch within the series (6/7), and also not
used anywhere yet.

> > +     systimer: timer@10017000 {
> > +             compatible =3D "mediatek,mt6795-systimer";
>
> Why don't we use a compatible like
> "mediatek,mt8365-systimer", "mediatek,mt6795-systimer";

That was in an earlier revision and removed (because the binding
description wasn't merged yet). Can add it of course (but then
mediatek,mt8365-uart and friends should probably stay as well).

I'll post a new revision adding it back (along with the binding
description) and add the binding description for mt8365-uart as well
(getting it to the same place mediatek,mt8365-mtu3 and
mediatek,mt8365-xhci are now).
Let me know if you'd prefer a variant that drops mediatek,mt8365-uart,
mediatek,mt8365-mtu3, mediatek,mt8365-xhci and doesn't bring back
mediatek,mt8365-systimer -- either one works for me, the fallbacks are
sufficient to make it work.

ttyl
bero

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446E602466
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJRG27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJRG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:28:54 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14DBA599A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:28:52 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a8so5169946uaj.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAGj1lKGN9zHdLIAaa+8k2WGvGRtgT1Nau/Jlmhp4JI=;
        b=PI5cJjdk125nNbORefNwPn3dHrb2DtMqrwV5OXfVD43plQbvrx5fUPudwMhDnjNrfg
         G9EppTZJ3Q1Y9WAJGE4DwwxHkn5xuZmObKFVPgks31eGfJlhD9u9Ay9cO6i7deDNmBgQ
         ja1HckyzidsXZaj/5AfHUDtw0laL4iGuEQuqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAGj1lKGN9zHdLIAaa+8k2WGvGRtgT1Nau/Jlmhp4JI=;
        b=ds09mnSpW/JsR++S1R385Uu9+V1ZhrKQvpcJVu6URO1BKDZ0xMtNYJDoHtTu/+xp6y
         YrxBD/RF5rMmWDtuvmnVPEHZDCo7KzLpH+eojW0L3Lhn5vcbrHSmQDBQm6zO2XNijdYZ
         EMythBPzE9pE7e2C5IGlE4AnLh0fRkjtGamG295X4Jve+BN5+/yOlWN6ypQKpVDgqffD
         SWc4Mw3yoIg3BkadHC/VfhnK2EdYKW5y7KSt7UNe2ibFcDHHXUQ0O7VE9zzL3ZJjDcMv
         F8oYb3mdVtLMiPfV/Vdue49QYFgPFPy558j/poNQj+G7ekZxEzUUxveqbyw6kVHE2WcW
         saLA==
X-Gm-Message-State: ACrzQf2d4oBNDgD2wZ+l0+TVCD6FOg0f5aegpiZ75gsWVa14lK3DVKcg
        14ijSsRJ+v94u/7//gNd1wVL7xME8K9lvUmjEf/8Kg==
X-Google-Smtp-Source: AMsMyM4J1/pYS6uRKCnZ0z/WETNX/uPZ1lRyX+7KVLa0Zu3m64DyjaaSm7FddeBarCnYjlNrz5KH/F9aLYq9wS3rt6E=
X-Received: by 2002:ab0:38c5:0:b0:383:eed8:dd45 with SMTP id
 l5-20020ab038c5000000b00383eed8dd45mr785773uaw.11.1666074532048; Mon, 17 Oct
 2022 23:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-6-nfraprado@collabora.com> <CAGXv+5GmJOYnfLsovO_+piuJ1ry1R0ZQqALRGK3MNp=nUO-TNw@mail.gmail.com>
 <CAGXv+5HGodRWbawEpDppZWM_EiuzdvZC9h4XBoAPo=FQ7yNotA@mail.gmail.com> <20221013202438.unfa4fqinwhgvfiz@notapiano>
In-Reply-To: <20221013202438.unfa4fqinwhgvfiz@notapiano>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Oct 2022 14:28:40 +0800
Message-ID: <CAGXv+5HHMuFgrKge8dd+yoH8Vo1_k8nG=QUD3GDrUKnAMeh1+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: asurada: Add aliases for i2c
 and mmc
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 4:24 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Fri, Oct 07, 2022 at 12:02:03PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Oct 7, 2022 at 11:51 AM Chen-Yu Tsai <wenst@chromium.org> wrote=
:
> > >
> > > On Fri, Oct 7, 2022 at 5:25 AM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > Add aliases for the i2c and mmc nodes on the Asurada platform DT to
> > > > ensure that we get stable ids for those devices on userspace.
> > > >
> > > > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com=
>
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Added this commit
> > > >
> > > >  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > > index dac2d4f5e670..758ca42a6156 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > > > @@ -11,6 +11,18 @@
> > > >
> > > >  / {
> > > >         aliases {
> > > > +               i2c0 =3D &i2c0;
> > > > +               i2c1 =3D &i2c1;
> > > > +               i2c2 =3D &i2c2;
> > > > +               i2c3 =3D &i2c3;
> > > > +               i2c4 =3D &i2c4;
> > > > +               i2c5 =3D &i2c5;
> > > > +               i2c6 =3D &i2c6;
> > > > +               i2c7 =3D &i2c7;
> > > > +               i2c8 =3D &i2c8;
> > > > +               i2c9 =3D &i2c9;
> > >
> > > You should only add aliases for interfaces that are actually enabled.
>
> Ok, will drop the extra ones.
>
> > >
> > > Also, I think we can disable i2c6. None of the current products use i=
t.
>
> It's already disabled upstream.
>
> > >
> > > ChenYu
> > >
> > > > +               mmc0 =3D &mmc0;
> > > > +               mmc1 =3D &mmc1;
> >
> > Also, Spherion does not have an SD card slot. It might be better to mov=
e
> > the mmc aliases to the end .dts files.
>
> Based on the downstream dts, rev0 and rev1 do have SD card slot (or at le=
ast the
> mmc1 controller isn't disabled on those). However upstream we have a sing=
le dts
> (asurada-spherion-r0) shared by those two and rev2 and rev3 (which don't =
have
> the SD card slot), given that this way we can have a single dts and there=
's no
> disadvantage to keeping the mmc1 node enabled because the CD IRQ will nev=
er be
> triggered. With this in mind, I think it makes more sense to keep the mmc
> aliases in the asurada dtsi, as there's no harm in having them, and will =
ensure
> fixed ids for the rev0 and rev1 spherion boards.

Sounds good to me.

ChenYu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17E16ADA45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCGJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCGJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:24:44 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECCEB43
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:24:40 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id l24so8365858uac.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678181079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KEjIGIP7k4933B+btGoksmvrPyH6BRppEBQn/EZ6nA=;
        b=hVe6Sb3vULw3t8joPXyJizdO/5PxqGwox55+I7vxTiXYKJ0qwlXt6/LqiGX9tqqE/b
         nk4UimZQaU0d9iKv62y+OHGrxmGZ30Rg+l1tmtH486aWXB/oPzRZJOCh98gaG8qn2iOQ
         asNP6HvdtcY8Jj1N2XPu2lCt+dWqp9/a2Dai0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KEjIGIP7k4933B+btGoksmvrPyH6BRppEBQn/EZ6nA=;
        b=dqYH5Hwmi6rAe3IuCRBNaqAtG/+qd6zbqVo607gVI1K73GdaOCH1Pic836Tc8n5v6b
         lHM174VH8KctPO1KX20h5Oy/ZpRPNXLatdvM2xtb3/wxP7nkiVlqpHjGoTle0xyfdZX1
         xSNOUyfGnrY5opTm3abhqohmierjA78fwoPwY2qCWNwDDTr/SK920urIaPDjJomWUqMB
         MXgxJgKuX9Ei6oDryXcHjHrWydEEVnZhE4jctVlNNhu5e82/XBQofsHURoVi3/w8dvrQ
         z0/nx8uUsnM0RXJXnM2YWJRQP0ebRROroLO1un9EA99Ebc3FAC9VNfkoQIDdzEbdWzKP
         JW/Q==
X-Gm-Message-State: AO0yUKUbA17bx9Ylgx8E8nAu+MpfrwsV72bzFRPDZ9bt1GrL9zzeIFTm
        RgcV8pjFuh5DqhcipRPj1IoYvwpLL42WKwh7TxV9lA==
X-Google-Smtp-Source: AK7set+da9sAeR326t9LNfp7UZouQJyP9uKjC8RgBcg9Kg3WklPbE8tDN9/nwn0EBb9q00Bh4xZa0t6X7HiSBNUylAo=
X-Received: by 2002:a9f:3104:0:b0:68a:5bba:ba40 with SMTP id
 m4-20020a9f3104000000b0068a5bbaba40mr8809625uab.1.1678181079476; Tue, 07 Mar
 2023 01:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
 <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com> <CAGXv+5FwNfZ7TwKVMM5_uAjYQ6ZmhZVFsWREb_da-jxC6EUVJw@mail.gmail.com>
In-Reply-To: <CAGXv+5FwNfZ7TwKVMM5_uAjYQ6ZmhZVFsWREb_da-jxC6EUVJw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:24:27 +0800
Message-ID: <CAGXv+5F8A4kLq3y8dE4mrcVb338-afDorWsS5MRBvWVPgiAhEA@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 12:09=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Thu, Mar 2, 2023 at 6:17=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 02/03/23 11:03, Chen-Yu Tsai ha scritto:
> > > On Wed, Mar 1, 2023 at 5:55=E2=80=AFPM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > >>
> > >> Add coupling for these regulators, as VSRAM_OTHER is used to power t=
he
> > >> GPU SRAM, and they have a strict voltage output relation to satisfy =
in
> > >> order to ensure GPU stable operation.
> > >> While at it, also add voltage constraint overrides for the GPU SRAM
> > >> regulator "mt6359_vsram_others" so that we stay in a safe range of
> > >> 0.75-0.80V.
> > >>
> > >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno=
@collabora.com>
> > >> ---
> > >>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch=
/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > >> index 8570b78c04a4..f858eca219d7 100644
> > >> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > >> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> > >> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
> > >>          regulator-always-on;
> > >>   };
> > >>
> > >> +&mt6359_vsram_others_ldo_reg {
> > >> +       regulator-min-microvolt =3D <750000>;
> > >> +       regulator-max-microvolt =3D <800000>;
> > >> +       regulator-coupled-with =3D <&mt6315_7_vbuck1>;
> > >> +       regulator-coupled-max-spread =3D <10000>;
> > >
> > > Looking again at the downstream OPP table, it seems there's no voltag=
e
> > > difference requirement. It only needs V_SRAM >=3D V_GPU. Same applies=
 to
> > > MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >=3D 10=
000.
> >
> > On MT8195 we don't need any regulator coupling. There, the GPU-SRAM vol=
tage
> > is fixed at .. I don't remember, 0.7V? - anyway - MT8195 doesn't need t=
o
> > scale the vsram.
>
> Looks like it's fixed at 0.75V. I guess we're Ok on MT8195.
>
> > >
> > > Would setting max-spread to 0 work? I ask because with both regulator=
's
> > > maximum voltage set to 0.8V, there's no way we can reach the highest
> > > OPP.
> > >
> >
> > No that doesn't work. I can raise the Vgpu max voltage to 0.88V to solv=
e the
> > issue right here and right now, or we can leave it like that and revisi=
t it
> > later.
> >
> > I would at this point go for setting mt6315_7_vbuck1's max-microvolt to
> > 880000, as this is the maximum recommended voltage for the GPU as per t=
he
> > MT8192 datasheet, it would also make sense as we would be still describ=
ing
> > the hardware in a correct manner.
> >
> > What do you think?
>
> If it's just to accommodate the coupler stuff, I say just set the maximum
> at the lowest possible setting that satisfies the coupler constraint and
> granularity of the regulator. The regulator does 6250 uV steps, so I gues=
s
> we could set the maximum at 812500 uV, with a comment stating the nominal
> voltage of 800000 uV and that the extra 12500 uV is to workaround coupler
> limitations.
>
> Does that sound OK?

Even without changing anything, the coupler seems to work OK:

 vsram_others                     1    1      0  normal   800mV
0mA   750mV   800mV
    10006000.syscon:power-controller-domain   1
         0mA     0mV     0mV
 Vgpu                             2    2      0  normal   800mV
0mA   606mV   800mV
    13000000.gpu-mali             1
0mA   800mV   800mV
    10006000.syscon:power-controller-domain   1
         0mA     0mV     0mV

Am I missing something?

ChenYu

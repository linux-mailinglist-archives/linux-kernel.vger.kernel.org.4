Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968A6A900D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 05:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjCCEKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 23:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:10:10 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED4815556
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 20:10:09 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id d20so1278375vsf.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 20:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677816608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRC4YLaEQEHKXN/6JGBdTnUfCKse6BmeeCh40b97lyU=;
        b=J0MMw125d6BUUD2+AWqFnAyv/kyC+C8t2mo+dbXO0bnEX355WlX9Q8LyZ7B1xTyhRB
         SJO0yGDk1xFfdVyMDPIL4Cpju727DBv/06HO3ZbVgKT4tqt/GT8QTL7C+CgBduekqZoX
         Y8yGhzkKeWknSRPQtmGy+02d0EXtiBZ/IGn68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677816608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRC4YLaEQEHKXN/6JGBdTnUfCKse6BmeeCh40b97lyU=;
        b=sYFbarvz6Zl7BRsFx0s3qqiGhekUMsc6KDwmkmPhKuXKhkycqmmRnZbRSdNlUb8E42
         V0MAMGdm5Aava8MkYmPqX+/XtdKFiQucfI7aMEsH07o4kvaIe0Pp40brGIzDhSsH0HWc
         HFuZWmoB8VUsjmlV9l+hHL398d0QIkhkf2+Png2C20A5kvuYylpwJ2ka7ghkpSRSlYjH
         4fSC+nuvkLT1xWldha9eFoXUvLwsQOruxrtJzGszm9hgvoPmukhfhmUtXJ8xNiPzWUBo
         zphmYzxK3JR3Jo3DWaFxwIvQxFbFU1siq1s3qtT8TWMVrxHuU50Wywyz27YGQhKac/dw
         KD+w==
X-Gm-Message-State: AO0yUKU032WoXI+yAiRGNOh+SmWkh6iTWoA4f5uSBhFZJ1YPP7K5SZpg
        3A85vM77SIJDZRXIpj3ww19zYN+fDMnxHdVb+mlqUQ==
X-Google-Smtp-Source: AK7set9++Bot24TdBbob3L+v00rJIcqvEsIVWfPdrz7FFzAkveckkAMrXFyxCkw7zTJ7CrHhOeb6JCtaprEtFG9gu5c=
X-Received: by 2002:a67:d583:0:b0:411:fff6:3cc4 with SMTP id
 m3-20020a67d583000000b00411fff63cc4mr328329vsj.3.1677816608206; Thu, 02 Mar
 2023 20:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com> <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com>
In-Reply-To: <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 3 Mar 2023 12:09:57 +0800
Message-ID: <CAGXv+5FwNfZ7TwKVMM5_uAjYQ6ZmhZVFsWREb_da-jxC6EUVJw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 6:17=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/03/23 11:03, Chen-Yu Tsai ha scritto:
> > On Wed, Mar 1, 2023 at 5:55=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Add coupling for these regulators, as VSRAM_OTHER is used to power the
> >> GPU SRAM, and they have a strict voltage output relation to satisfy in
> >> order to ensure GPU stable operation.
> >> While at it, also add voltage constraint overrides for the GPU SRAM
> >> regulator "mt6359_vsram_others" so that we stay in a safe range of
> >> 0.75-0.80V.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/a=
rm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >> index 8570b78c04a4..f858eca219d7 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> >> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
> >>          regulator-always-on;
> >>   };
> >>
> >> +&mt6359_vsram_others_ldo_reg {
> >> +       regulator-min-microvolt =3D <750000>;
> >> +       regulator-max-microvolt =3D <800000>;
> >> +       regulator-coupled-with =3D <&mt6315_7_vbuck1>;
> >> +       regulator-coupled-max-spread =3D <10000>;
> >
> > Looking again at the downstream OPP table, it seems there's no voltage
> > difference requirement. It only needs V_SRAM >=3D V_GPU. Same applies t=
o
> > MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >=3D 1000=
0.
>
> On MT8195 we don't need any regulator coupling. There, the GPU-SRAM volta=
ge
> is fixed at .. I don't remember, 0.7V? - anyway - MT8195 doesn't need to
> scale the vsram.

Looks like it's fixed at 0.75V. I guess we're Ok on MT8195.

> >
> > Would setting max-spread to 0 work? I ask because with both regulator's
> > maximum voltage set to 0.8V, there's no way we can reach the highest
> > OPP.
> >
>
> No that doesn't work. I can raise the Vgpu max voltage to 0.88V to solve =
the
> issue right here and right now, or we can leave it like that and revisit =
it
> later.
>
> I would at this point go for setting mt6315_7_vbuck1's max-microvolt to
> 880000, as this is the maximum recommended voltage for the GPU as per the
> MT8192 datasheet, it would also make sense as we would be still describin=
g
> the hardware in a correct manner.
>
> What do you think?

If it's just to accommodate the coupler stuff, I say just set the maximum
at the lowest possible setting that satisfies the coupler constraint and
granularity of the regulator. The regulator does 6250 uV steps, so I guess
we could set the maximum at 812500 uV, with a comment stating the nominal
voltage of 800000 uV and that the extra 12500 uV is to workaround coupler
limitations.

Does that sound OK?

ChenYu

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E266E6A6728
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCAEx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:53:57 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2AB30B28
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:53:55 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id x1so2850138uav.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsJY49rW0m3b+G5kgYFzLlLOQxDPcqcLAB93HQM1XRw=;
        b=kTGgIXpp9BkG67kug4bzyfR4XkDFSu3l/FGwmHMasBIncT4Jk7oZY3QL5i3c4ZEvtS
         pcu8YDwV8fCaq27Qv74HBbd4P8CKlmc1ninWIfcTbXEgIVSvxaaKunYpBV0IItksEQ8I
         vXi3TT15PHS3DtBvhGdKqkGdbkG04GSytuLgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsJY49rW0m3b+G5kgYFzLlLOQxDPcqcLAB93HQM1XRw=;
        b=I/uyToL5DcO0L2pCN6H2hPxVi+XBsfPVaVcKyoLeI0h1jqCopfauPouoPE0cXszDap
         rgT/1h8B+su3cdxt4q1WEBMr8W43O9FQK91AJA6M8Nlazl5T65uGs91roHZh48Tuq8kH
         xbG+b3ssex40xVotPSMo9Jlbaszs3lnNVFzxc8G+1ZNuZR41BiQvEVwKiYgfdXzZj/5P
         dkshM3aSdI8zxp7+a0wVrPVXjRiANXq01EFMsnJLNt4zzZw7zlQPD/N5gnwfKZvmVp66
         1GuK/O9oWk+yYH/ebYzKg4ns+jf1gv4jfjXI9Nn0WnrnvNwjEp+KiyxE9T+xR15Ekgx+
         nPvQ==
X-Gm-Message-State: AO0yUKVUyLcjKV1/wW4/N1QwMkMVst4nxgzf6QdoRA6i0Fu0DU+Z+/fX
        ip/camqc3+O9zHdyLEiogEJ+VadSHOsD4w/uoDw4cw==
X-Google-Smtp-Source: AK7set+GqkcxiNkM6nfCo0ys3BssCg6pLDlWZZDXStf63Q01t3V/mLIYphnNot1tZH0dtLtqPgc8cgjBonaVaVMNvps=
X-Received: by 2002:a1f:58c5:0:b0:413:1498:e843 with SMTP id
 m188-20020a1f58c5000000b004131498e843mr2809198vkb.0.1677646435063; Tue, 28
 Feb 2023 20:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com> <20230228104741.717819-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230228104741.717819-12-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Mar 2023 12:53:43 +0800
Message-ID: <CAGXv+5FyjoLo1VW2Kep5JWH0tz5JE77XjbwWiKusnTntj2eZHQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] arm64: dts: mediatek: mt8192-asurada: Couple
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

On Tue, Feb 28, 2023 at 6:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as VSRAM_OTHER is used to power the
> GPU SRAM, and they have a strict voltage output relation to satisfy in
> order to ensure GPU stable operation.
> While at it, also add voltage constraint overrides for the GPU SRAM
> regulator "mt6359_vsram_others", but don't touch mt6315's vbuck1 as
> its constraints are fine.

The minimum voltage on vbuck1 matches the lowest OPP. However the maximum
voltage is set to the maximum of the regulator itself. The MT8192 datasheet
says the absolute maximum for the GPU is 0.8V, and the recommended range
for 0.8V is 0.72V ~ 0.88V. The highest OPP we have is 0.8V, so I would
just set the maximum voltage to that?

ChenYu

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index df477eb89f21..c8b6e1a9605b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>         regulator-always-on;
>  };
>
> +&mt6359_vsram_others_ldo_reg {
> +       regulator-min-microvolt =3D <750000>;
> +       regulator-max-microvolt =3D <850000>;
> +       regulator-coupled-with =3D <&mt6315_7_vbuck1>;
> +       regulator-coupled-max-spread =3D <10000>;
> +};
> +
>  &mt6359_vufs_ldo_reg {
>         regulator-always-on;
>  };
> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>                                 regulator-max-microvolt =3D <1193750>;
>                                 regulator-enable-ramp-delay =3D <256>;
>                                 regulator-allowed-modes =3D <0 1 2>;
> +                               regulator-coupled-with =3D <&mt6359_vsram=
_others_ldo_reg>;
> +                               regulator-coupled-max-spread =3D <10000>;
>                         };
>                 };
>         };
> --
> 2.39.2
>

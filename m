Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E66A1936
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBXJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjBXJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:55:49 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFE963DF0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:55:43 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id a3so7648367vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfijubv01mZGVzHbC70CoXeXFHSitTu3ah+CLJlrtMU=;
        b=YN6gwgAtMOuJN4hv+VJMZWdMyQlkH1J3uJbZKe7L8CUovbBPCiOb/QeBlZNK1354U4
         ujsWLINYib0s5gkjzt3PyGiagaPxr9LGFjhQf7djo66Hw/r3KfNk/OgaczGkPyinK3Sy
         CxTUlpc3LalSB/OWaNRej75eiCNec+Q7e43+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfijubv01mZGVzHbC70CoXeXFHSitTu3ah+CLJlrtMU=;
        b=5m2buA9KMpmpc13ZBO+bqP3aKgZM79u1u8r+ONSkQTQXcvc/zhG13hvdksYsvdUU9j
         ohuJJTY6cQCVENz0eY/m3QPPAQuG8IgVp/IrTSsK9dBPnceu7863Ii+xBB9ZhoqnuirW
         SOaE3/y8GVvsBYrWGxtDYII9vIn0JehvDMF0Qj/Tqa//BBETQorcVpWH1N0/ouwzRCRI
         NIi/rZ6bLCVjHhfarmGVmjUZwHFTqqOGhNACwFtgYzRtKVnuKgzNAPlDRNkhHEgUu/jR
         +LV5m46SrixFZEDhZyVMK9bpktIWGoR3q96aoOwxSBQR9nWjcrYFk8klhUVwSdr0jJDp
         rp+g==
X-Gm-Message-State: AO0yUKVYEkY0VYUKXkxwQ99Pd0u3VtUScnc9WZOqdyrGXMbVtMSNSKWP
        x0U/SNhZcDJwT6kGOBjyV2nJ9taa5pjsfQjUS2GQSA==
X-Google-Smtp-Source: AK7set+BLbWM4vwOZ/kL8dEafMsH9ImLZl2f7DMC/6vh5cp8DYQMfIz7ULzLSZcck+JM3pbxpwKK5dbEbgLEwPp5Iaw=
X-Received: by 2002:a67:d21c:0:b0:402:999f:51dd with SMTP id
 y28-20020a67d21c000000b00402999f51ddmr2196895vsi.3.1677232542557; Fri, 24 Feb
 2023 01:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:55:31 +0800
Message-ID: <CAGXv+5H4a686nZPWjd7yFXSDCjttg0OPz1VD_8ppGASKgTWc7g@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] arm64: dts: mediatek: mt8192: Add GPU nodes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> The MediaTek MT8192 includes a Mali-G57 GPU supported in Panfrost. Add
> the GPU node to the device tree to enable 3D acceleration.
>
> The GPU node is disabled by default. It should be enabled by board with
> its power supplies correctly assigned.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> [nfraprado: removed sram supply, tweaked opp node name, adjusted commit m=
essage]
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> [wenst@: disable GPU by default; adjusted prefix; split out board change]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 109 +++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8192.dtsi
> index 87b91c8feaf9..2a3606f68ae4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -312,6 +312,91 @@ timer: timer {
>                 clock-frequency =3D <13000000>;
>         };
>
> +       gpu_opp_table: opp-table-0 {
> +               compatible =3D "operating-points-v2";
> +               opp-shared;
> +
> +               opp-358000000 {
> +                       opp-hz =3D /bits/ 64 <358000000>;
> +                       opp-microvolt =3D <606250>;
> +               };
> +
> +               opp-399000000 {
> +                       opp-hz =3D /bits/ 64 <399000000>;
> +                       opp-microvolt =3D <618750>;
> +               };
> +
> +               opp-440000000 {
> +                       opp-hz =3D /bits/ 64 <440000000>;
> +                       opp-microvolt =3D <631250>;
> +               };
> +
> +               opp-482000000 {
> +                       opp-hz =3D /bits/ 64 <482000000>;
> +                       opp-microvolt =3D <643750>;
> +               };
> +
> +               opp-523000000 {
> +                       opp-hz =3D /bits/ 64 <523000000>;
> +                       opp-microvolt =3D <656250>;
> +               };
> +
> +               opp-564000000 {
> +                       opp-hz =3D /bits/ 64 <564000000>;
> +                       opp-microvolt =3D <668750>;
> +               };
> +
> +               opp-605000000 {
> +                       opp-hz =3D /bits/ 64 <605000000>;
> +                       opp-microvolt =3D <681250>;
> +               };
> +
> +               opp-647000000 {
> +                       opp-hz =3D /bits/ 64 <647000000>;
> +                       opp-microvolt =3D <693750>;
> +               };
> +
> +               opp-688000000 {
> +                       opp-hz =3D /bits/ 64 <688000000>;
> +                       opp-microvolt =3D <706250>;
> +               };
> +
> +               opp-724000000 {
> +                       opp-hz =3D /bits/ 64 <724000000>;
> +                       opp-microvolt =3D <725000>;
> +               };
> +
> +               opp-748000000 {
> +                       opp-hz =3D /bits/ 64 <748000000>;
> +                       opp-microvolt =3D <737500>;
> +               };
> +
> +               opp-772000000 {
> +                       opp-hz =3D /bits/ 64 <772000000>;
> +                       opp-microvolt =3D <750000>;
> +               };
> +
> +               opp-795000000 {
> +                       opp-hz =3D /bits/ 64 <795000000>;
> +                       opp-microvolt =3D <762500>;
> +               };
> +
> +               opp-819000000 {
> +                       opp-hz =3D /bits/ 64 <819000000>;
> +                       opp-microvolt =3D <775000>;
> +               };
> +
> +               opp-843000000 {
> +                       opp-hz =3D /bits/ 64 <843000000>;
> +                       opp-microvolt =3D <787500>;
> +               };
> +
> +               opp-866000000 {
> +                       opp-hz =3D /bits/ 64 <866000000>;
> +                       opp-microvolt =3D <800000>;
> +               };
> +       };
> +
>         soc {
>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
> @@ -1266,6 +1351,30 @@ mmc1: mmc@11f70000 {
>                         status =3D "disabled";
>                 };
>
> +               gpu: gpu@13000000 {
> +                       compatible =3D "mediatek,mt8192-mali", "arm,mali-=
valhall-jm";
> +                       reg =3D <0 0x13000000 0 0x4000>;
> +                       interrupts =3D
> +                               <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
> +                               <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
> +                               <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>;

Nit: Move the first entry to the same line as the property, and align
the following lines' angle brackets?

Same for the power-domains.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +                       interrupt-names =3D "job", "mmu", "gpu";
> +
> +                       clocks =3D <&apmixedsys CLK_APMIXED_MFGPLL>;
> +
> +                       power-domains =3D
> +                               <&spm MT8192_POWER_DOMAIN_MFG2>,
> +                               <&spm MT8192_POWER_DOMAIN_MFG3>,
> +                               <&spm MT8192_POWER_DOMAIN_MFG4>,
> +                               <&spm MT8192_POWER_DOMAIN_MFG5>,
> +                               <&spm MT8192_POWER_DOMAIN_MFG6>;
> +                       power-domain-names =3D "core0", "core1", "core2",=
 "core3", "core4";
> +
> +                       operating-points-v2 =3D <&gpu_opp_table>;
> +
> +                       status =3D "disabled";
> +               };
> +
>                 mfgcfg: clock-controller@13fbf000 {
>                         compatible =3D "mediatek,mt8192-mfgcfg";
>                         reg =3D <0 0x13fbf000 0 0x1000>;
> --
> 2.39.2
>

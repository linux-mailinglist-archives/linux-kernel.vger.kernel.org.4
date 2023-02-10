Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F236916C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjBJCoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjBJCoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:44:38 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306DC70952
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:44:37 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so4272903vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxKcD5MHPeq8MW1BxCC2B2HCW247AyxiuibPeYpJLy0=;
        b=WQkeb8HRZt6mt0Ws9HllUpsfUrgKa8s9at6qO+rVthEmiAc9amoTtOnzqJEmH1BFeZ
         asqVFIfptZupwd2MwiZ2DDmlc/9w3dKQTrZnnsmQiigaSBMnimX0pciG3LuyWeI4fUjT
         DCfgGNGZeXGPitNNKFNOaOJh6uI8dktnbgnGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxKcD5MHPeq8MW1BxCC2B2HCW247AyxiuibPeYpJLy0=;
        b=iFa9IkCvcc+R14neAOehk9fl4WDFcB4mfzmBpTVEWfsVAythN971QGyUt+HIowMjSt
         gLahFgBR+a666xTJ41poc6oii3kCQx1yC2hQ/MrdTyHYYvClUCxnC6mfXNGBr5v9+wFb
         j2fijX9Sx7HY1DigsB+RR3zM6whHFGI53C3MEFZmGK+tppfhQusAoffVgPIWTEpt+eQV
         fFZmWnfNpfQKG+6tWGAUWCDnm3YVhtHJXL/7+k0RM4+mjJ9VTXo2fTUvTNh1wp5wcGkG
         fj6oAULIZn1rY99L5Mgn2JvUavYhPr7QHeXtNd2ecRcMZHEkvblTl+ohPFEc55iyrRnJ
         Bdgw==
X-Gm-Message-State: AO0yUKWVOhmxjpROAvJZrIbPt/uATA3HPh4jTQJL6l/xYLxmm82INmVW
        9qkV6TObNkSyLI2Hs3J9TRnp8mNfrBzLSup3Jn77Vg==
X-Google-Smtp-Source: AK7set8rmT5dBRiIMSgQxob4EVFEZikOUhOwE5/3kSmzkpF4EKHK+ockF47cKpiLEoE6PwJMZW4tFwy49H4pgkx46b8=
X-Received: by 2002:a67:d202:0:b0:411:c830:e5b5 with SMTP id
 y2-20020a67d202000000b00411c830e5b5mr952691vsi.65.1675997076332; Thu, 09 Feb
 2023 18:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20230209160357.19307-1-matthias.bgg@kernel.org> <20230209160357.19307-4-matthias.bgg@kernel.org>
In-Reply-To: <20230209160357.19307-4-matthias.bgg@kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Feb 2023 10:44:25 +0800
Message-ID: <CAGXv+5FnXtR+KP6GZ2ut1cUwo0z-SBs1zTPWMSvm9dF-NNn--g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] Revert "arm64: dts: mt8173: add mmsel clocks for
 4K support"
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:05 AM <matthias.bgg@kernel.org> wrote:
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> This reverts commit fc6634ac0e5380aeb1063275a2e9a583d41b2306.
>
> The mmsys is a clock provider but does not have any clocks connected to
> it. Therefore assigned-clock properties should be applied to the users of mmsys.

If there are multiple users that need this, then it should be moved to
the clock provider node topckgen.

> This fixes the DT schema check:
> mediatek/mt8173-elm.dtb: syscon@14000000: 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index c47d7d900f283..b753547e250fe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -988,8 +988,6 @@ mmsys: syscon@14000000 {
>                         compatible = "mediatek,mt8173-mmsys", "syscon";
>                         reg = <0 0x14000000 0 0x1000>;
>                         power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
> -                       assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
> -                       assigned-clock-rates = <400000000>;
>                         #clock-cells = <1>;
>                         #reset-cells = <1>;
>                         mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> --
> 2.39.0
>
>

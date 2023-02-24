Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407D86A1945
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBXJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBXJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:59:07 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C291525A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:59:06 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id v27so12755390vsa.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHLbgtC9eaEy5W5YoFrWu6seyn59kvRi1Sqb5aL8SbQ=;
        b=b69Xf5nQRII8T75C7CsYVxwf87GZLuEg4VUM/9OzTISPIzUjpLShl0lZFXdWbKCt+X
         WJzVjMA3yOfm2KzrLljPqDRvdVly5mzoYjxjQPT371EwoEUaMw+v8yBdF0Z0fpc/clGU
         ld/oyVLQr9zvQC3Pb0luxYoNfHWC65IpaqVjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHLbgtC9eaEy5W5YoFrWu6seyn59kvRi1Sqb5aL8SbQ=;
        b=M19WIomKZ/FiqO0EeN7tti8YMW+M/qzPGbu7KhSuQIj45pd0x/Xa8rqwOtatoO757g
         ahFsR+rI3ogw/CY9QH/76wCHcjLYGXdre3RGUQw82xp+PmbgYb7pdv2u6avvAigLRnMx
         MCsyj1TQHsEGxIvBQD9kKUiDC6Q1LnvQcceyENkS5+w6Uy2hzZiagAWuNgbkKOJnBWol
         irMxLIn71PyN2wrwIZnxbJ+6KotcWkp8f7I/Sb2sXvkQSvcY355muDWFhh3rhY6XE6IT
         S8MIF2VjNZvHDj/e9rXjy4uz6muebMTL8CO8S13UM7n10TA8d7fC8ptOfHd5J/clDjZy
         Xt6w==
X-Gm-Message-State: AO0yUKVHXS1cPF0ytyOuTKAwrp8+eZi0dg/7kJgc3hsLZq5VPwL69+nv
        Gi0O4LaiSamBViR82wwfu1Qt5H4LiXkUdzctUcLHIg==
X-Google-Smtp-Source: AK7set8HsPgFjiHEs8kJFwTbhza2xbhJLtQBIrep9NpSiN29T9vZ8VfsQAshILBJ+x0txHKlIjDOG6ygccqaFbZz+/k=
X-Received: by 2002:a67:c584:0:b0:41f:641c:f775 with SMTP id
 h4-20020a67c584000000b0041f641cf775mr317973vsk.3.1677232745205; Fri, 24 Feb
 2023 01:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-12-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:58:54 +0800
Message-ID: <CAGXv+5ER-Z9WiRAKEbfKV3hzNQu0Xru-z5QUJA85wzrwzY7hcw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:44 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as VSRAM_OTHER is used to power the
> GPU SRAM, and they have a strict voltage output relation to satisfy in
> order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index df477eb89f21..c8b6e1a9605b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>         regulator-always-on;
>  };
>
> +&mt6359_vsram_others_ldo_reg {
> +       regulator-min-microvolt = <750000>;
> +       regulator-max-microvolt = <850000>;
> +       regulator-coupled-with = <&mt6315_7_vbuck1>;
> +       regulator-coupled-max-spread = <10000>;
> +};
> +
>  &mt6359_vufs_ldo_reg {
>         regulator-always-on;
>  };
> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>                                 regulator-max-microvolt = <1193750>;
>                                 regulator-enable-ramp-delay = <256>;
>                                 regulator-allowed-modes = <0 1 2>;
> +                               regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
> +                               regulator-coupled-max-spread = <10000>;

Also fix the constraints here? And overriding the constraints should be
mentioned in the commit log.

>                         };
>                 };
>         };
> --
> 2.39.2
>

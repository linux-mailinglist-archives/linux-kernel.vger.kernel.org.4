Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0C65B3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjABPHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjABPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:07:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AA165F8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:07:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 18so6630559pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nClTvw3x5UpoXSS3lmQgHVtktuQgAyEIPFgxXiI2CRU=;
        b=ZAe5Zm8Lq4YLvVjJQ+pmrNnfMWOE/zOYifWmty4ralCouP2eBKqFNGGZ4YpaPydhKT
         KNArdt0IHS/kg7wh0SHMKYo8AULNj9TjsV46Bl0jfAQGeyCNn/ChVX0SiPU0gu10cjS0
         TOUGc9gh6LbvVw7B3lsh5n2fq3AyQnTw1bZeZGamr8wTiwdXXPyO+N+8BEspV5+JEZSG
         3vR5jWkDHX04t2fwqUIOdFFSnkvM2eZZ0KHJAlYKAWr9aRERCGPLidIiPgV0dhSCns5p
         TwFcDwLV4PKoEvztwG0x9EPA6GONvM8MAkux6xGTlm4rbG/8AXsGkAkpUJP8iWIbLj66
         fDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nClTvw3x5UpoXSS3lmQgHVtktuQgAyEIPFgxXiI2CRU=;
        b=fydusqGZAh0xL91i0/5G9uypiKBHlKeArfwjnJkdKG6NwMRqcyWXXjCt1HY5mWr95f
         W0sjmE76Cwen4wwhVagw6VY+Xt3yPCKiVdbjctFEaz98qOirVbfS+2beHR0PTa5oEQEv
         s/w1GOkWeu09aXJWNZqJYfBF0sJS6iP4i3lYrvzHl4XP4jvTNEpvZyKDYJkiovR92vA9
         C+NiMN5/0r2Ncua/AGyUaZYMK+aSdPbzU1xiTXjPFoJn1QLzbxf6uHGY1OUi2AtzqRGw
         guimubkFhZgVZB/KYHiIjzF2Vl49eJZVLNWDJrCliFpZddclbIsY3OaDzlJmVBKieRmV
         oVbQ==
X-Gm-Message-State: AFqh2kqBuCWAHmktAW75ykrl1iQnfBpDQ/TPDTNDEquJ+/CXmdQzzjKP
        TZ94D6YwOLFPplN6+bhoQltQfRLv3e0zOwJA3lZDIA==
X-Google-Smtp-Source: AMrXdXsb2gnvbcsfCCOAD77/bs/+lKzGdoQtyiaMmxIIZCeJ99couOSFA526lQDkn6TFwYzOkRTjF+oFokHMThfLQY4=
X-Received: by 2002:a63:ba09:0:b0:479:2227:3aa1 with SMTP id
 k9-20020a63ba09000000b0047922273aa1mr1767902pgf.595.1672672038011; Mon, 02
 Jan 2023 07:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com> <20221213230129.549968-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221213230129.549968-4-fabrizio.castro.jz@renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:41 +0100
Message-ID: <CAPDyKFoo3G-dsdfTQ1eN8SdVSakKRi3RHbX1eFJ2=AceXMDy_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmc: renesas_sdhi: Add RZ/V2M compatible string
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 00:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> The SDHI/eMMC IPs found with the RZ/V2M (a.k.a. r9a09g011), are
> very similar to the ones found in R-Car Gen3, but they are not
> exactly the same, and as a result need an SoC specific compatible
> string for fine tuning driver support.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 29f562115c66..f38003f6b1ca 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -210,6 +210,11 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
>         .manual_tap_correction = true,
>  };
>
> +static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
> +       .fixed_addr_mode = true,
> +       .hs400_disabled = true,
> +};
> +
>  /*
>   * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
>   * So, we want to treat them equally and only have a match for ES1.2 to enforce
> @@ -251,6 +256,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
>         .quirks = &sdhi_quirks_r8a77990,
>  };
>
> +static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compatible = {
> +       .of_data = &of_data_rcar_gen3,
> +       .quirks = &sdhi_quirks_r9a09g011,
> +};
> +
>  static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
>         .of_data = &of_data_rcar_gen3,
>  };
> @@ -274,6 +284,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
>         { .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
>         { .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
> +       { .compatible = "renesas,sdhi-r9a09g011", .data = &of_r9a09g011_compatible, },
>         { .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
>         { .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
>         {},
> --
> 2.34.1
>

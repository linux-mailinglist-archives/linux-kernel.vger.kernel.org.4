Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D2696359
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBNMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:19:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2552799D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:19:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so15306373pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uSyTPuLuU1wBaDbWkcoFTMyZUSCsuecKMj0PYuIA5S0=;
        b=UtyFQDh00wwW4KU//WECOJIVyRndF4FW071LndcUwBkhKWW6ETfQGjngKJyH/WLIkO
         HHY3PJL0xDode7S+nxPASS+y+MuAATdqfpNv3VkNNgV/Sxh1gby588iCkO3BJtXnQVsK
         i5Uhg2bvAHkaa5LLYw0up2TgGRQuKydeyZh/ZG9219bxWZOP4Q1FZqJVwlQyktQIV8tB
         hAhV5gu5YkCULjmdugBAyYSyFgjkikIdt85pin/NgfVYeMxxx9ofi9SUCZW9WPXNJup1
         +JeV5ksPQWUKAVej86tjPkY+ahVFKtvScCSpLdzmhMF+FJ9t+XfO/Reg2vsSxkQWq8lb
         hrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSyTPuLuU1wBaDbWkcoFTMyZUSCsuecKMj0PYuIA5S0=;
        b=t/XnsLi1eFqkT1x7uHd+oP5SAJRyUmpCWUOT7o6QXTKyGGFuX0U8jnA3BoVyRXTYUk
         3BJjAimO04dwZFel6+RZuAW5AyeeOtJoIQav06EZ8Ap9CdY5lqaK7oAZkqLYPe4flooZ
         LpjfYlUmPszH2wUuploEnaYNU5MOpTCAWuqjf+aXKAG8sqPvdLG+UOrqak6WG+xPiyne
         ylzoESe1gvXoIhfxFzrRMwz58IhFwUHtm/eXGzMZ0a3tbPT1sTgyYHejMe7fJ9H3SNKu
         PXSp69OcR7sc7426Y8hdc/AwAEPFL8TQXVogJIf/MePgoZCvHvScAH2rA4g5ZnBunI8p
         +UQQ==
X-Gm-Message-State: AO0yUKWxBi+OV7QSDUavOVJYmwvjoV8N9P8w5UnV4exDLzUw/bc7OQ8Z
        lks37JbkvwOpZ5iiARVAqZD4WxNxONWXm4NMen0K+fSro9L3ng==
X-Google-Smtp-Source: AK7set/rppMKL8PmLlE6ZEPS+7aWqreZKZYPF7wXZqHbPA1PNgDb/YZ4rvKhpOEHETPhdtpvcTko9h+d92SGx9X/SuA=
X-Received: by 2002:a17:90a:c710:b0:233:ce0b:5f78 with SMTP id
 o16-20020a17090ac71000b00233ce0b5f78mr2138910pjt.32.1676377147435; Tue, 14
 Feb 2023 04:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20230213045233.32470-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20230213045233.32470-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:31 +0100
Message-ID: <CAPDyKFo7LizvRzjbohy9XcL=Nyscj9Dp-VNvUnx94fF409uzZg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Add resets property to cadence SDHCI binding
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 05:52, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Cadence SDHCI controller allows reset control support on UniPhier SoC.
> Add resets property to cadence SDHCI binding.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> Changes since v1:
> - Add Acked-by: line
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index d3dce4d6c168..adacd0535c14 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -29,6 +29,9 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  resets:
> +    maxItems: 1
> +
>    # PHY DLL input delays:
>    # They are used to delay the data valid window, and align the window to
>    # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
> --
> 2.25.1
>

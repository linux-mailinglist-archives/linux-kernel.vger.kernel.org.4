Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BD6B7805
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCMMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCMMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:50:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120434002
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:49:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 132so6800710pgh.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678711794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx8jF7FKGmBoaIt+aFf1/ouqS3HHqR+OXeKb+Cy9oZE=;
        b=HKEZDOm+mV1HAdL7ER3iR1vWEz+4AMwcB8/eiYzfDT6G3vlc/AaUcvMnA+QJ8TeT8y
         VFxsnjxJGqsNiwUpJ+hn81fvGKZv4x+d58+sjI9u4cMRSUA0YEmcNXr/ygpARwkw+f7/
         eAchNtNYJBBtn/PE4ARsywNpqb/J+N4HdfukwE8Mvc+YC+nrIxTOndCSaacbcVKRBN/3
         DBI2ew5D4qaoQmlBSUIF6ZG1KxARWrGfgil/kWwcGRNUbrJOfxigAjZTxycUfS7z1Wpf
         9kpY6jDanHkZIjl420k/BbT1PmWkmPeGFVFO3WSLSBbMcAU9MfOXdev+i0VBNBL/JRUj
         XQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx8jF7FKGmBoaIt+aFf1/ouqS3HHqR+OXeKb+Cy9oZE=;
        b=XWIqGut5mTRllKJIu0FnuVMBLB0Gj+XQCkr9nRJCqK2OCeyV2h6bsea1b/K/L86s34
         bEkJ8hE6F9LPlJALIob4v0jAiUfuhPKezqhXAd4wwchGpyYlx/fbRZGlGVLeBxblMr5k
         zbMuKz1+/uHNAfdwrZPrlNhq5BdQzrNwOSnW2HHI7Hsmiq752ByoXGLQarZ86tV46SOT
         xkRYHAt5h7sMxftxDwwTyebeDWo7bYOJaorkt2n1eTIoyZA6zR0jBJo/E7a2x5fzOyhO
         9pn+2024KIwt3DVQHdQb/5NfcwXsIm5x8Ij5zpn6sA0lLIsrKKPO8jJ1Ew8lR6gtojrq
         o1dg==
X-Gm-Message-State: AO0yUKXNCEsCTCGZ7EpS877LjPNeipuyVvt6xRLuk9vIYVAHEMyqiDyp
        XR53Wn3QK25tAUMN5uZugO7QWAOn3wtd8UHgyo1uTg==
X-Google-Smtp-Source: AK7set+nraYkEbzD7lEiHtt/giSmKeJ3bPG/6dv6QjfYN2aLbyojc2xt8UY2wcR2r3heZo8J5ExHI7B2fVzTC6vEaTg=
X-Received: by 2002:a63:f91d:0:b0:502:fd12:83ce with SMTP id
 h29-20020a63f91d000000b00502fd1283cemr12062421pgi.5.1678711794210; Mon, 13
 Mar 2023 05:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Mar 2023 13:49:17 +0100
Message-ID: <CAPDyKFqaq5ysudyqOe0dB8fm=+p_ywpXdqQr33QUCq3j+Bqnrw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: add static to !OF stub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 at 12:12, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The sdhci_get_compatibility() is not used outside of the unit:
>
>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for =
=E2=80=98sdhci_get_compatibility=E2=80=99 [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 328b132bbe57..245e56324dff 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -73,7 +73,7 @@ static void sdhci_get_compatibility(struct platform_dev=
ice *pdev)
>                 host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
>  #else
> -void sdhci_get_compatibility(struct platform_device *pdev) {}
> +static void sdhci_get_compatibility(struct platform_device *pdev) {}
>  #endif /* CONFIG_OF */

sdhci_get_compatibility() is using OF functions with stubs for !OF.

Perhaps a cleaner option is to drop the #ifdef CONFIG_OF completely
around sdhci_get_compatibility(), thus we can drop the stub too.

>
>  void sdhci_get_property(struct platform_device *pdev)
> --
> 2.34.1
>

Kind regards
Uffe

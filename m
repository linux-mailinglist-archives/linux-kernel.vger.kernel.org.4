Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8365BAD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIPM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiIPM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:27:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3DB24AA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:27:11 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t184so32350909yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qBkP79CdibdL0KXmDwvIhKSe/JzNo6nfeWqbrVhoNo0=;
        b=dzbYY0vlZ7i6Yr8v8Apr+D9xXAqxbRmUiJughxVFjAL6TOyk0vSgprK09vqNX/Je3N
         o66NEofmPmhKHxB0QvanN8/hcYj7BoCdnyOOHbarUZQ08ZSimNs1jPhugBLpKAcU+1Zu
         qJU0yAkFA7SgxiyFxQdFXgejHUAAhlboD/x2MLsegN7gspeKAZuoIiNaVS0DE5P9CYX9
         tn3tYlmiCauzVqoPx2W/yWzIDcJ5ke+fk3kanAKcQ3LRiK8Tmiyts9lAsXtTJWSxLsYT
         3OYhkupOoIQwwcbmZJak7hQR3xGaapN6GqjO3gZ+W3+7qyAmFiuzbWfFtzoK8QiNW5o/
         HgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qBkP79CdibdL0KXmDwvIhKSe/JzNo6nfeWqbrVhoNo0=;
        b=d1phG4n6RPadCwxUU2HjipV8Q2cAhWGenPkSgl0Ho/sXFzeviNKO4+FPV69t7sUoKI
         +smxexXZtLbqxS+V2g8wrEWL08/qUPGXykjKLylUfpsmYZzZkyyNZD2HifiWvsWDzPgJ
         bbTQx4C3L7ojJ3cqTPZYluoSkTG0DMotxg+bTlWfZHDmZuX9pJWmsENuEILms1wudoo+
         1bx9DefhGBaC60ZdPiJQUaSWqDknT4ZqGQA33DpCLoAH1lvx272oUsKHrdXufXrExN64
         hAoevrBHkrKVWQRWf/jRUxmmagv12RN2FGCEwf820t0Ekpx56ECXG/M41Gx64+wAfJI+
         GjrQ==
X-Gm-Message-State: ACrzQf0gJWo2jbwxzwU4H+MsRsEGeXnepnE3M7HTpiJ9vQDYgcWm3eD1
        edCyrrhhANrphow6bVj8salfWxaLwri1X2ctZqDpeQ==
X-Google-Smtp-Source: AMsMyM7exBoaSPI97ztz9uzm41FgmreUvtJV9LBBNHgaf3EvM9E/3gry+tdHRjk0JGUiZrtkyBEPOBNexhun2Afb8vs=
X-Received: by 2002:a25:ba45:0:b0:67a:6298:7bac with SMTP id
 z5-20020a25ba45000000b0067a62987bacmr4566691ybj.194.1663331230592; Fri, 16
 Sep 2022 05:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220916121204.3880182-1-vkoul@kernel.org> <20220916121204.3880182-7-vkoul@kernel.org>
In-Reply-To: <20220916121204.3880182-7-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 16 Sep 2022 15:26:59 +0300
Message-ID: <CAA8EJprcqrmHQCtYbOT=DWp-0iEWWVC0=-KZRz1DZqK6gE94qA@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 16 Sept 2022 at 15:13, Vinod Koul <vkoul@kernel.org> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Introduce support for the Lenovo Flex 5G laptop, built on the Qualcomm
> SC8180X platform. Supported peripherals includes keyboard, touchpad,
> UFS storage, external USB and WiFi.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 590 ++++++++++++++++++
>  2 files changed, 591 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
>

[skipped]

> +&gpu {
> +       status = "okay";
> +
> +       zap-shader {
> +               memory-region = <&gpu_mem>;
> +               firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";

Is the firmware signed with the test key or with the proper vendor
key? If the latter is true, the firmware should go to the subdir
inside the SoC (I'd suggest following the example and using
sc8180x/LENOVO/dmi_id/)

> +       };
> +};
> +

-- 
With best wishes
Dmitry

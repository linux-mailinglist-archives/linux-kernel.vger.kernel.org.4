Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62E5E7738
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiIWJcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiIWJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:31:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886A399EE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:31:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j24so13467490lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=loilT9KOrc8UgH6EVysVDR9IA3XxRhSds+VZ69dyocA=;
        b=tKLpy2UwHDJcgXNYiAbhs5SI5sJHw23wtrZtVFWcXI8ADmftNYt9f9eqzGbmFjGO5B
         NzXpwiN+FfIrULrse9QbxxKmF23tyTNCZVU7bhZ2CA4zzWuTJQC0DxQhlZaW9JGbrvI+
         6+ZBM9zRYxIJKOZSk3gpYzQFjzFjgLf68rc6Ckzk2M2BgUdI/Ve1EGg4TiCJ1PKHYIVe
         sLk7PPl8X9EuVw7x16TmD0VksSNJIhoHp/cYFZ8iRE/EZgkTC0a1JysQ2ux5EMnhL9Km
         JWG2t0zq2ryD9zW5Pi9/w3dl+90iIKqT6FTAwSCe/G9MNlcA78cf6tRhQJmP79XdzrUb
         LSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=loilT9KOrc8UgH6EVysVDR9IA3XxRhSds+VZ69dyocA=;
        b=pff6xpeng6JHSUK/7A+h0h9dIkekOBAoa6/IJDsOw0jKAGNXOczq1u7NE+buLB0BaW
         ldalGJK1cC32vIvmO5M/whJd+KeXs1ERsJB0ZkctuKiNot6vc0MgDF7HAS82QFbPdOJ/
         g7CsSxHmh6AinkozaH3SeaHDzZgLOS3gL9XrAEZV74NmUTWa0hCU8i3gKLrXO6upiamC
         OBqlNsQpdNN64QVfyXYq0fFjM+3Hzjn3Bhb6Cf4NReYaiUUFgY3ySAIMdcv9qMmLf0TN
         BuAJ8o04jeSLZijgyCTeUt1SBo0WIFebzEM3ITVPykmAvSapTXUPEAH5X4SbByZhYLWJ
         Sf5A==
X-Gm-Message-State: ACrzQf3usyCw7CB2PTSzl/zHH8A9/6II0TRD6ATV4ISpEGhZIicrOvkC
        OuKmCq8Ut36NV1dVJcphj2uTug==
X-Google-Smtp-Source: AMsMyM5pu4SglWelw1JOJblaAvHizdmtgcvDCNQ6UzszauiF6a9na7nIKBo2/ir/pFTyjxwg3tIZ3Q==
X-Received: by 2002:a2e:a28e:0:b0:25e:734f:38fa with SMTP id k14-20020a2ea28e000000b0025e734f38famr2522446lja.446.1663925493539;
        Fri, 23 Sep 2022 02:31:33 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n5-20020ac24905000000b0048a934168c0sm1367297lfi.35.2022.09.23.02.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:31:33 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:31:31 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 08/12] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: add
 bias-bus-hold and input-enable
Message-ID: <20220923093131.5fb5co5i3f4eybcs@krzk-bin>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 21:56:47 +0200, Krzysztof Kozlowski wrote:
> The existing SC7280 LPASS pin controller nodes use bias-bus-hold and
> input-enable, so allow them.  Squash also blank lines for readability.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1681325


pinctrl@33c0000: 'dmic01-active-pins', 'dmic01-sleep-pins', 'rx_swr-active-pins', 'tx_swr-active-pins', 'tx_swr-sleep-pins', 'wsa-swr-active-pins', 'wsa-swr-sleep-pins' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb
	arch/arm64/boot/dts/qcom/sm8250-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8250-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dtb
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dtb

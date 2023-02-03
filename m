Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33368A5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjBCWRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjBCWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:17:43 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D34222E0;
        Fri,  3 Feb 2023 14:17:36 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id t24-20020a4a8258000000b005170b789faaso644468oog.5;
        Fri, 03 Feb 2023 14:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaXGaKW+ohSkXXsLhQu+iHszhSK5QnksGcgtJk81JU4=;
        b=OMir23uJQXkKw89oyV8QRiSZdzYmThEBHEwo7N+lATzY40NZQmErXjPyGqyzYVN3cd
         iP1W/Cwo4T141RSia+XwlKwxmC2PyX0MRQ97tbXX2DZk/wNNDyu4p6AEZM9dL9CO8iES
         Yo++rAN0/GRHAQTcSBcuXsbAib02PbmiyC7GYJJ1EGf1onmeWgZQJJDAifcE7ztOF/9L
         /0mzppelIc5qsn8M6jbRpmxJsrnjNHcCSbI3IH01qNzurvdfXcmb73hh48GJ7qZ8KoIz
         Wkve8vJaNnMGlxld0tZw4wUQ//0jSHtwQ9Hh0eHIEIxczMpWAapMNpBhBBq21Decx7Gk
         Xfyw==
X-Gm-Message-State: AO0yUKWHiXDbttqI4VWmroCktFgeU1bSAixzx86aGLrKy9xONJ/YtAF/
        Yn0p78d/Ahl4CAsLIpRrqA==
X-Google-Smtp-Source: AK7set+5c+eqnVd/uxUqLnQueS3Zhu43iQkACj+Gw9CFd6XBlhssgtQul6Opmi7JR7nSnXfFQv5Ftw==
X-Received: by 2002:a4a:d898:0:b0:519:8d8:515b with SMTP id b24-20020a4ad898000000b0051908d8515bmr5252471oov.1.1675462655391;
        Fri, 03 Feb 2023 14:17:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y2-20020a4a86c2000000b0051a2a5c8ac6sm34559ooh.36.2023.02.03.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:17:35 -0800 (PST)
Received: (nullmailer pid 972057 invoked by uid 1000);
        Fri, 03 Feb 2023 22:17:34 -0000
Date:   Fri, 3 Feb 2023 16:17:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: correct
 GPIO name pattern
Message-ID: <167546265129.971964.9986247753799776073.robh@kernel.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
 <20230203164854.390080-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164854.390080-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 17:48:51 +0100, Krzysztof Kozlowski wrote:
> The SM8250 LPASS pin controller has GPIOs 0-13, so narrow the pattern of
> possible GPIO names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5996566190C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjAHUIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjAHUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:08:33 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F2DF9F;
        Sun,  8 Jan 2023 12:08:32 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id i16so3420584ilq.9;
        Sun, 08 Jan 2023 12:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6qFMj8l+ipPL83CwbU3UOHpDArXzes4bLrB2i8j8C0=;
        b=7ilri7i6r8qvT1mkNBj/pqMMnfOPRy/kXWLcWC4/Mo1ca+MR4RnYqcEl7KY5oME6ZJ
         EsFmF+/lQPufLPS6YMnIoR3l39//XypU2NzsN/fNfLnjA10GIXD1saQ66eHEQlZQQdJ+
         LIi6u/vyt5nCYf1qCHWaBjCCcWd1UiLtqMyHyudqkf57skQAAQk+lTWhVnn4fwaZVDFV
         S3DbmExRMDeNVuC49lb2+CpiMV2DFGCQo42JSYAoqXmyD/ODJKIgCA3ZsD1CHEdyTkKg
         ybiwOREYXeUZT5K8KWTIjllH5ZUm1MXN4gyL/4GPlyB+rFSNLqiXiP1zNkchNbcIMUzS
         HnjQ==
X-Gm-Message-State: AFqh2kqsM6N7UvSJp1BDc4G8TL1pJB2/BNeFeZeN7lRaZjsp/8WgH08b
        voUe+zJFalk72pZ+/YPIOQ==
X-Google-Smtp-Source: AMrXdXvTkWGHCGzQ0jeyIBp5MoDkQ1m6A/r1AhuDG3PVHNXHTZwOWX8rnUo7yhgV2FIj9xuZxwbnvw==
X-Received: by 2002:a92:870d:0:b0:307:739a:db47 with SMTP id m13-20020a92870d000000b00307739adb47mr45025387ild.27.1673208511869;
        Sun, 08 Jan 2023 12:08:31 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id j7-20020a056e020ee700b0030c463d743esm1071801ilk.85.2023.01.08.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:08:31 -0800 (PST)
Received: (nullmailer pid 212759 invoked by uid 1000);
        Sun, 08 Jan 2023 20:08:26 -0000
Date:   Sun, 8 Jan 2023 14:08:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Iskren Chernev <me@iskren.info>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 1/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi:
 correct pins pattern
Message-ID: <167320850561.212688.17704162807220133540.robh@kernel.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Dec 2022 14:56:37 +0100, Krzysztof Kozlowski wrote:
> SC8280XP LPASS LPI pin controller has GPIO 0-18:
> 
>   sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
>     'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
>     'gpio2' does not match '^gpio([0-1]|1[0-8])$'
> 
> Fixes: 958bb025f5b3 ("dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

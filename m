Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC25C688B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjBCAFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjBCAFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:05:47 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A27DBFD;
        Thu,  2 Feb 2023 16:05:32 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so938104otl.6;
        Thu, 02 Feb 2023 16:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAR7stm4FO+9ZeYY2pkj/tjbP1bR77xTUVOCKvk7f60=;
        b=XEwGpA2xMfOjD8Rm+PpR5R1TgG/qTMVa1qflRLwVj+MDdKFgzSUnXmX+Ht+iqj+ay/
         xGZtkCFP2QinPBg8DsL/GdgDwFfnpOmUl3h5stC4OYt0T4rkQkjvfGJ5iU+p3FUI40Ws
         ULMdcu7dYKmlyHUguruNZX+mHU1xJeXQ2uUQOjYU/9b1waLox/mNFc8XOWAUdH+x7u6j
         kxa7V0tcm0967r/NEaW6nYB5seX4umduztg3Fo9CKK3xkl7Bd51VMJ+62kf5A9whgsNP
         bQxmoPcZgPD6vWad/fmVIm5fptVNIYz8eR3ZnAxABdy53JAeEl7FoEO1hoyJdbZI1WNd
         Q7rw==
X-Gm-Message-State: AO0yUKW5ztXUWO093nTvtB815+wYtPGh6xK5S3tKncr8nemRnMGqfs/D
        XEgz86nRYXe8yOTmffBpOjD5fH8PRg==
X-Google-Smtp-Source: AK7set/TmK1oNVOTa6E6tGOmkjcZ7Q41JvDKbFgAXYBYicW6UhE6TOr/ORqSxRTmyUu/CVvY5UV9dQ==
X-Received: by 2002:a9d:1b27:0:b0:68b:dd09:2b6 with SMTP id l36-20020a9d1b27000000b0068bdd0902b6mr4825161otl.25.1675382731766;
        Thu, 02 Feb 2023 16:05:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a056830155400b006729fab72f0sm470280otp.3.2023.02.02.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:05:30 -0800 (PST)
Received: (nullmailer pid 2940040 invoked by uid 1000);
        Fri, 03 Feb 2023 00:05:29 -0000
Date:   Thu, 2 Feb 2023 18:05:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-gpio@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 07/10] dt-bindings: pinctrl: qcom: correct gpio-ranges
 in examples
Message-ID: <167538272876.2939986.18199534176902821462.robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-8-krzysztof.kozlowski@linaro.org>
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


On Thu, 02 Feb 2023 11:44:49 +0100, Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in gpio-ranges to match reality.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml        | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


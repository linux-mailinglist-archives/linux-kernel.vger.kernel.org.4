Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFF5F6F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiJFUdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiJFUdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:33:38 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F51BB06D;
        Thu,  6 Oct 2022 13:33:37 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1326637be6eso3495314fac.13;
        Thu, 06 Oct 2022 13:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ryTf815CP8mTaX8naXavpJPkG+pmwwQCJIpcVgnlLg=;
        b=XNZJJDhsmk8kRaF94P/EvKxWQtBfBWo7anclzjvN5aiCCW6z7T0du3uvId5H4o4PIp
         RWHBW6nIg5te8Kw42174EV4k4kqN+6o2cvEh+05X+//E4XffcfTVyrSexhAyAt1NfcgE
         iDeSo6VysngfmSCQ4+WXK2aLuIHxgw++D7+HvodxvZtAnenMqfnjP/sH1jc2fXD8H5f2
         ZphkyNc6kIUiAiiY6slysvGIumpCGC3/WSVjHx2m3JMVxI4mzpjmwXo1kCz0QNnCS6kp
         5qaeyloiS997pK2Im8kuPEGja0FQIuBvntXg0f46qLU6dnIdjlqBRRZoDENHvvUeitiM
         4+pA==
X-Gm-Message-State: ACrzQf1Sa2mPC3Ew0Wtl5vO4lbEoqHOYQpMJboEfgwVxi91YnQy9iLz7
        U0fVFN7yEw0n1YC3Wc9uwQ==
X-Google-Smtp-Source: AMsMyM64X4TRQmTSQUPXXcOOjET/PHcXtcBymnZV3MpC1V3ixIibyn5/TyEZ++64hbXR2NEJpCcMKw==
X-Received: by 2002:a05:6870:4798:b0:12c:fdf7:e948 with SMTP id c24-20020a056870479800b0012cfdf7e948mr806717oaq.247.1665088416782;
        Thu, 06 Oct 2022 13:33:36 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id r14-20020a056870414e00b00127a6357bd5sm291007oad.49.2022.10.06.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:33:36 -0700 (PDT)
Received: (nullmailer pid 112305 invoked by uid 1000);
        Thu, 06 Oct 2022 20:33:34 -0000
Date:   Thu, 6 Oct 2022 15:33:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     krishna Lanka <quic_vamslank@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-gpio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 17/34] dt-bindings: pinctrl: qcom,mdm9607: minor style
 cleanups
Message-ID: <166508840211.112097.14312248298488004366.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-18-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:20 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,mdm9607-pinctrl.yaml    | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

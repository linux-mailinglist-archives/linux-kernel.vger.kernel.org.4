Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0545F6F86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiJFUmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiJFUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:41:55 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274299C2D2;
        Thu,  6 Oct 2022 13:41:43 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3574139fac.1;
        Thu, 06 Oct 2022 13:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZrY5wrEfiPQFKCBqZiRWp+hyujoJ/ZhHEyAYAsTtgs=;
        b=COzzPHpsahVC0L7uSdQfoXdIEel7kiB9rDnKuq1tLnq0KLBjcYnts5EW5sgFTmn8fb
         a+rD0VTIIITOMt/pqyDhjzm7XakLpL/WsEs+WC4Rct+BHgg9Ux400viDtaZkx4+qlhVQ
         vqwWr24nhp6ONC+p92cmtAlceUK4SdHmHkHyruP56/++K2AOU4T6e1n5v361JcimIACl
         0/Jc8fJ10Yt/8o6E10LdotozfGZHHRk5VUHO8mEz9sp4JRjv3o/7ipglAbszN3zV9G87
         Q0OComJ8BJb9n2v+Uu0YT7ZJG0icSh8n2idY7kN43PDCXqBS+EztFCMcuwFynWA39bWF
         Lw6w==
X-Gm-Message-State: ACrzQf3048oRN9WBkQwt5fRuknEWD1AzpbHkcv+R+Tjlb1m2kYRtRdiO
        92HVojauRegYdydAHBpn1A==
X-Google-Smtp-Source: AMsMyM7FcQx52PXZkljcrvwyaJ0DLgNa/LWl554KuLDblIGW2q38PzpOp/Wi9nSaHTMJLxzda5MqQg==
X-Received: by 2002:a05:6870:a713:b0:131:8f4f:b8ea with SMTP id g19-20020a056870a71300b001318f4fb8eamr6441428oam.138.1665088886696;
        Thu, 06 Oct 2022 13:41:26 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b006393ea22c1csm306945oth.16.2022.10.06.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:41:26 -0700 (PDT)
Received: (nullmailer pid 120200 invoked by uid 1000);
        Thu, 06 Oct 2022 20:41:18 -0000
Date:   Thu, 6 Oct 2022 15:41:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: [PATCH 31/34] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor
 style cleanups
Message-ID: <166508887569.120045.1434104375900994989.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-32-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-32-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:34 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), drop redundant minItems, use double quotes
> consistently and drop redundant quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml   | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

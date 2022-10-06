Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6379C5F6EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiJFUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiJFUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:23:11 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6ABB055;
        Thu,  6 Oct 2022 13:23:09 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-132fb4fd495so3470411fac.12;
        Thu, 06 Oct 2022 13:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXmsJXm8qAKcDsAMINrVhnlhcXR46BWqr/NBXyVq01g=;
        b=YJzQ5leJ9vEaC4sJy5RWjGGoLAKb8XxttEBzApIhAqr4cqfoCcYXFwZTlmjGMmjb60
         hajKZw4hM5QZHi1ufJtOv+7tj959FW7zdJgQZeTo4khcmi2+99Zw8XNbYaUI13E6Vkow
         mF/5ZzSyuEmqU+01ANZziuEgOBGkuVaw2gEd4jBDMYs/0MyZfjaxnmJd9ChC3ELhUG9b
         4eMvUOBwmv7gNnSEAI2+L3EQg2IBo+amZEAqo6kaC7vFttXil+8OGaXIO9brCbAaHUVr
         ZMAvtIq6ywYMeuHvS8Btczmex0zINRCGLkemvOX8BbDP2euewOppji9lYcK7EULDBCw+
         sM+w==
X-Gm-Message-State: ACrzQf1ol4nnuV8roeaqv54PWRCFLAIOXaTYc8eU38cQBKVSWWagzv9u
        uh3r4e+6Ee3IGZswP98sTg==
X-Google-Smtp-Source: AMsMyM6DjXow+Vxadv1NnOq2beef8//PtNdKZ13etWLtPl8aLI0y9NsM50/OgcLFFZ3aN8jZo8eNRw==
X-Received: by 2002:a05:6870:f227:b0:132:f26c:e911 with SMTP id t39-20020a056870f22700b00132f26ce911mr797330oao.279.1665087788981;
        Thu, 06 Oct 2022 13:23:08 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id s41-20020a056870eaa900b0010c727a3c79sm271720oap.26.2022.10.06.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:23:08 -0700 (PDT)
Received: (nullmailer pid 102332 invoked by uid 1000);
        Thu, 06 Oct 2022 20:23:06 -0000
Date:   Thu, 6 Oct 2022 15:23:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 03/34] dt-bindings: pinctrl: qcom,sc8180x: drop ref to
 pinctrl.yaml
Message-ID: <166508778613.102272.15729900029858769511.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:06 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml        | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

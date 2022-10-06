Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3375F6EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJFUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJFUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:22:56 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D3BB045;
        Thu,  6 Oct 2022 13:22:54 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1326637be6eso3465486fac.13;
        Thu, 06 Oct 2022 13:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz05ziFdQHcIDdbf8AtMZfIAqsXVA71IRQiqHWHv0UQ=;
        b=Tm/WdavxSKJXbv0t1mCHeSw/KFpSppZWx5GnuMcm1j5QFNNJLR+HxK9vjYZWgIO6j+
         2e0jJgErFviOG233SjSG5xhlDz91NiNkClWB4tDb+alN5ZXV6BkVX4BjFDk+DwLRxM1T
         ApN7MR3KykqKTlvmLAEs0vKseluTDvntXeU6cAwDGeGossMAdwhxIdA4DPeDaZLMbuRn
         s3zutwjjNWli36ryMVAF1AYjJp9Aq42qy+CfJohm3Gu0GegCH3dmRmody1CUx9+A3OMh
         ibZrHD1Sv0ORmA9MRfbepYA8YjNkw6u0Z4BEnJyOL1vJz3KFL0ZxhFi+f3qxbF28F9zW
         WIbg==
X-Gm-Message-State: ACrzQf0mm3wUt7kKdOa1lSUU2iZZjK8kLoNq6dLFFgGgama7SjPtAM38
        D7vyIKg2PsaI57QOeFJ28g==
X-Google-Smtp-Source: AMsMyM7HPUc4niKYRFe9mA7DOmnA3+YT7xoJaYem3AbSc1NQbfDX+kwthiDryaXumJOBwt3KIEcjPA==
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id eo40-20020a056870eca800b00132df465c66mr790042oab.280.1665087773526;
        Thu, 06 Oct 2022 13:22:53 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id u18-20020a056870f29200b0012b298699dbsm387067oap.1.2022.10.06.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:22:53 -0700 (PDT)
Received: (nullmailer pid 101975 invoked by uid 1000);
        Thu, 06 Oct 2022 20:22:51 -0000
Date:   Thu, 6 Oct 2022 15:22:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 02/34] dt-bindings: pinctrl: qcom,sc7280: drop checks
 used in common TLMM
Message-ID: <166508777122.101924.4829010852888888622.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-3-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:05 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

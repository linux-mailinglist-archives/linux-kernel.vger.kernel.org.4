Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997505F6F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiJFU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiJFU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:27:37 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA4BEFA5;
        Thu,  6 Oct 2022 13:27:31 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1326637be6eso3477921fac.13;
        Thu, 06 Oct 2022 13:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP+Gzu0YP2WDiHdI3hIMst3oInf+/lguHR5tActNSM4=;
        b=lCx/k5iyW2OaNBgy2O+nC7YyFIGy8MjECURERoV5zclLCqzq5o9qr8HAqCxumgiloh
         mY9FRIQ5vJMe1ONcviUQXIFtfYZKrofmxIgto5BoRW03MpXNf+Rq2sCdeRxKm77VWVcs
         i3ZO4dWGhQYwvSZTbOCqXG9j5HoKkwDSC+ASm2utwZoyNABq37vxB87czRWWnI5cRODN
         6eFjE8/7ZyV/MtqlYnbQJpAtTnVyOn2waYVjnzFZZj9gLttmjSwkv/n3An81QGD20Th3
         6ZynDJsUH9pkBZxPduCVClfWCOdhWz2EPg01g2mH5XcTiCEI4tDyMv/661SaieN5RdJH
         PtVA==
X-Gm-Message-State: ACrzQf3b0F4PUn+yVrds7k95fijzK/l/FV0bAQ8yt5p8r1+ePJzudgp1
        k3N0b7AdOdi9gxJlWBCJlw==
X-Google-Smtp-Source: AMsMyM7G4CWXEymU1hRGKMoMqgRlwj5vQua4l01gHGzlnDJPm+ko5R70BoPZShM4nmU2GAwpqd8Qcw==
X-Received: by 2002:a05:6871:207:b0:132:7706:e74f with SMTP id t7-20020a056871020700b001327706e74fmr6501172oad.8.1665088050285;
        Thu, 06 Oct 2022 13:27:30 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id d21-20020a056830139500b00655fd5b878fsm219955otq.74.2022.10.06.13.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:27:29 -0700 (PDT)
Received: (nullmailer pid 106993 invoked by uid 1000);
        Thu, 06 Oct 2022 20:27:26 -0000
Date:   Thu, 6 Oct 2022 15:27:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 13/34] dt-bindings: pinctrl: qcom,sm8250: use common TLMM
 schema
Message-ID: <166508804230.106836.11124330711126453180.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:16 +0200, Krzysztof Kozlowski wrote:
> Reference common Qualcomm TLMM pin controller schema, to bring common
> properties, other pinctrl schemas and additional checks, like function
> required only for GPIOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 34 ++++---------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81A5F6F10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiJFU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiJFU0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:26:52 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4F6291F;
        Thu,  6 Oct 2022 13:26:52 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2201892ooi.5;
        Thu, 06 Oct 2022 13:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xtXq3LACMxF0hQI9vzZkJGBpiCLfYGlaBnsJAppXkw=;
        b=SLZOnt6lQQLzOv7XJ55Z2oFd13HUuHO4q8QEfSRQEwgNeZ1aKTFR21+4itUjRvqT8I
         8FUR2fQCS5TBuRB3H301/e63SBeWDF21dZPFcgc0k66grVHY8LPRROm3h1OlrM6eusO2
         Y9VfuMhHv/IEFKDBrWkCJFqrabCDfukmKlFu1N7BojeK2ieRLJea4tZcJjRvCzGRUmCL
         tfMjRI7ocUP77Nlfg8XWe4mNGgbs3Z0OrHLZz0AYDR7mWd7kJcJcdT0r82UymL+SWDVR
         BNorY8U5W9liFBKMRWKSPMk7AwsEQglKSMLOeYq6OJLZDUbEp/OX4c21aylQ7Pk4iiDf
         Vzdg==
X-Gm-Message-State: ACrzQf3TK4HvfFpkv8T2KU9IlizaERAgHOK7GqIMBi4OwVt+MucgISUc
        Xo1jjVrhwZbNwmgDFL0B1g==
X-Google-Smtp-Source: AMsMyM4ZcMsYqnoAk8O9Cz9G/+uc9kpESWWi5AxIt3XFGoNq8uirpO+Tiga/9VP0e061JToSvLD5NA==
X-Received: by 2002:a9d:4f07:0:b0:65c:257f:f1ee with SMTP id d7-20020a9d4f07000000b0065c257ff1eemr693506otl.167.1665088011616;
        Thu, 06 Oct 2022 13:26:51 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id ej22-20020a056870f71600b001312f3254besm356727oab.10.2022.10.06.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:26:51 -0700 (PDT)
Received: (nullmailer pid 106256 invoked by uid 1000);
        Thu, 06 Oct 2022 20:26:49 -0000
Date:   Thu, 6 Oct 2022 15:26:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 11/34] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref
 to pinctrl.yaml
Message-ID: <166508800859.106192.11062938687992682220.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-12-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:14 +0200, Krzysztof Kozlowski wrote:
> The binding references common Qualcomm TLMM pin controller schema, which
> references pinctrl.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

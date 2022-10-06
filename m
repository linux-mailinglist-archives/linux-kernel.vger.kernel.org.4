Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041CC5F6F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiJFUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiJFUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:40:29 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FAFF8C1;
        Thu,  6 Oct 2022 13:40:15 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so2223355ooi.5;
        Thu, 06 Oct 2022 13:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz80GL++KR/FTz9rhtlus6+2V94gyd7X2OzQeH+cLrU=;
        b=vJ7ZNwla3Fe9FkttNKiACz1BVioqqpA5Fh3ZT/e1UgZt/XZAlWDTlK4AwmxjcL93P8
         pQvqgcuFxNHWIHtwaSUJwUdR4goybXGro4bAeSVrCqYF3fbbZyPkpVdS3b4M1d6YkCbX
         C6qHgokKM/2ywDebR1ptYew8Ycdmvc98LigH/5rBA9mBh0uJR/D4Z8d92UN5XIXzHACe
         b9oYi/Ri9k6ZkS1ebrn7IRMMzkdpWN4OYYtUgww7rc4cAqmyJ2YO0/QsAxbT7xgPbtdK
         R8AfIV/PVADLfMieFddr7meA190dOyDfLQSijHqX6FkNC19w3q0XJveWgJ01TimmQswz
         AvUg==
X-Gm-Message-State: ACrzQf3GS8UN8A2cOQNY/twF6wYwcHFFhN94wG2SMfx63M8Xdg8bfdVO
        XF0teISMDW8gN81/4A+S2A==
X-Google-Smtp-Source: AMsMyM6Q94D0YOLeuvh/bo9dxEWdxiXmIeWTlIRsTYdxbLBRd/ZPZqwrpLVAr6yOmZWFVkUQrfVp1g==
X-Received: by 2002:a05:6830:440b:b0:65a:127d:89a9 with SMTP id q11-20020a056830440b00b0065a127d89a9mr672668otv.103.1665088814126;
        Thu, 06 Oct 2022 13:40:14 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id 61-20020a9d0ec3000000b00660f49411e0sm296190otj.33.2022.10.06.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:40:12 -0700 (PDT)
Received: (nullmailer pid 118795 invoked by uid 1000);
        Thu, 06 Oct 2022 20:40:10 -0000
Date:   Thu, 6 Oct 2022 15:40:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 27/34] dt-bindings: pinctrl: qcom,sm8250: minor style
 cleanups
Message-ID: <166508881010.118750.10139079465227677694.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-28-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-28-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:30 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), drop redundant minItems, use double quotes
> consistently and drop redundant quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 36 +++++++++----------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

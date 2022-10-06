Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AE5F6F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiJFUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiJFUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:40:10 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA638A0D;
        Thu,  6 Oct 2022 13:40:02 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1322d768ba7so3554732fac.5;
        Thu, 06 Oct 2022 13:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQuNjCu+ToILutx7eGhrZCTcZaR6VUEfa+DTU1Soqgo=;
        b=mTla8uGBkMCNSnxnGgujAVFHZQYe6trSQ4RfF4abvhisqM5bfS+2QJ8TgugjPTo7f4
         VUmH+u2yzPE6L9EsQxMEGRhIHUHTcwb3nQQIRaOf3drjaUidOKZ2dcjiV9r3WYd9UJc8
         eu3Nu1eJPKK9cIX3KNTintbTubCyuMf+GkwNNNraesqZowhpu6Hn2zEPpUnk/Su2Khq5
         UrWykaXNJsDQu0z9VzRIuIKx1lXhLU59Nb6Pq/1hia7wXX3fSGV505OoCB7DT7D1QYWd
         Aq8AQYlUHpu2XKcL5uIgHJDkYDdjdiIwhAXQn+CCjz3CrGeFk7yoyUfUJXovvf+ZMq/S
         HoOA==
X-Gm-Message-State: ACrzQf2Fk7600fSQ+Mti2bzd5YHSIT3F1W4VivKmK8AA/RFlCEkh6VD3
        nVkaXQw+UKsCIH5/wlhScw==
X-Google-Smtp-Source: AMsMyM4krxQuhaleOEEEkdl1mnp5SHi+5EEfAKGx/h98k40TcW6U+zg3NNYJNNrMQHYOsrObJB7FQQ==
X-Received: by 2002:a05:6870:ac21:b0:132:f716:763b with SMTP id kw33-20020a056870ac2100b00132f716763bmr832108oab.61.1665088800371;
        Thu, 06 Oct 2022 13:40:00 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id w4-20020a4a7644000000b004763bad30f1sm130338ooe.11.2022.10.06.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:39:59 -0700 (PDT)
Received: (nullmailer pid 118435 invoked by uid 1000);
        Thu, 06 Oct 2022 20:39:52 -0000
Date:   Thu, 6 Oct 2022 15:39:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 26/34] dt-bindings: pinctrl: qcom,sm6375: minor style
 cleanups
Message-ID: <166508879206.118321.2265671698107114222.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-27-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-27-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:29 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BE5F6FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiJFUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiJFUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:49:16 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27794C4C3D;
        Thu,  6 Oct 2022 13:48:53 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1326637be6eso3536411fac.13;
        Thu, 06 Oct 2022 13:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUoKpp08KcOu7enzmUu763DBGuIPIYQ71NO67QCw6ZE=;
        b=oTBEQ/rBibEh1/SFXoXOweg91pOd3ork/45zfdUnfT9S37xeiZX5Wxg1fr3SpMsVDD
         uvO0Gcnl0hxsd0M11ketQlkrfPvEYV00c4P/ojBa4XARpqrmYFnkGpc0BENIdlMRjVC5
         ERf7rpQ6RO99gHg5Af9Tz6/1mYqnrhu/Bq58yCLouGi6agY9zTbNHXQNL9zf5rdH7ZaJ
         YY3DZtb1J2hPNGVPMA8xtDwT+tiyncZGQ0EZG98WbxwkMN4oZUHeFmcpCY3JDWhcIFv3
         kd9qHBeZ09oM8jCnsVtrJA4nz3EUpi4UZI3g5dEQidHVq9tWl6d6lQ+624C5SPdoi1qI
         zkeg==
X-Gm-Message-State: ACrzQf01NexpE9PF+WAgdKrIkvfrQCkfBb6CcCb6Cjx681mIh9gRNTYj
        klGk12qFAQ1N/PfKJ/D1tA==
X-Google-Smtp-Source: AMsMyM7BpsTTIoHn0ES3wP1slRfw1RJ2KMQO/9fCNj/lGCmCgIYw2s94Oozbup3JuO4k6O3ykZIgBw==
X-Received: by 2002:a05:6870:b49e:b0:131:c074:8d3 with SMTP id y30-20020a056870b49e00b00131c07408d3mr870545oap.32.1665089332812;
        Thu, 06 Oct 2022 13:48:52 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id a16-20020a9d6e90000000b00638ac7ddb77sm333114otr.10.2022.10.06.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:48:52 -0700 (PDT)
Received: (nullmailer pid 126334 invoked by uid 1000);
        Thu, 06 Oct 2022 20:48:45 -0000
Date:   Thu, 6 Oct 2022 15:48:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        linux-gpio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 33/34] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor
 style cleanups
Message-ID: <166508932453.126269.7712330755235468535.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-34-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-34-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:36 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml      | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

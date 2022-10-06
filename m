Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E45F6F77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiJFUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiJFUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:40:42 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613414085;
        Thu,  6 Oct 2022 13:40:29 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id n83so3350365oif.11;
        Thu, 06 Oct 2022 13:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wat8ZsnPaEUF2A/rm7qwzuPwW2LE+hCQyveexLvOqpU=;
        b=IAxF0PTvr1HqlyBlZY2uDFwnGDj8LFkxXQ3Dmlq6EUJEl9rDXhvT8x7lf8p9wEkssE
         fWDQDX5q2jkJpdXFYhxDDsHUDcoaarXXGtvO4CEDym1IuiqxtDGQD0ku11BKlYgFv01e
         Op1pKuGAHeIAZtfkiMwPWpSh8fRz1fBojGuMeRwYxiY5s6v0EaXghl3EO9phkyqCKqH3
         hjjBNTQxTspRlNmmVZmpgt8zY+zcAI+xD8izmveBH4IhvBkR/c0E4SHQfDSdOn4RHZMU
         HvTsf0UvdKQRVSuPtiyg0X0IlLsToQFp62/LbguaLFFGniBDD+91nPavAQ+ADNvH74/u
         bGeQ==
X-Gm-Message-State: ACrzQf2fwetN4gyoQTC/jFnbDgSq4cIxay0/AE0jDslD5UVrDdREg2db
        SPT90r7RJhFR08AfEDJXoA==
X-Google-Smtp-Source: AMsMyM4BR7QhUF8v+2hiLku7r1ttUVpFqQ146B+h6udKl9FH5k1gYVjsGN9cV2SaQMEpU3Ab1/Vdtg==
X-Received: by 2002:a05:6808:1a29:b0:354:1d24:82ef with SMTP id bk41-20020a0568081a2900b003541d2482efmr1920633oib.169.1665088825670;
        Thu, 06 Oct 2022 13:40:25 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id x15-20020a056870b40f00b0011d02a3fa63sm371009oap.14.2022.10.06.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:40:24 -0700 (PDT)
Received: (nullmailer pid 119090 invoked by uid 1000);
        Thu, 06 Oct 2022 20:40:22 -0000
Date:   Thu, 6 Oct 2022 15:40:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 28/34] dt-bindings: pinctrl: qcom,sm8350: minor style
 cleanups
Message-ID: <166508882102.118988.2155388199982534838.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-29-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-29-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 16:06:31 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml         | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

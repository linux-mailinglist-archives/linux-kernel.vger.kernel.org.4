Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FA5EB537
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiIZXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIZXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:13:34 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D76B0296;
        Mon, 26 Sep 2022 16:13:33 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id m130so10093778oif.6;
        Mon, 26 Sep 2022 16:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IzuQH1Pzdy/HheRMqXmvvBxvMP+T4mGJS+1zvE3rxNM=;
        b=cCCtOEl11MsTp5ziHoNPkhTcBzWSLIaYmFUTEGqa/Sqhefd2OOuiJrqaSxNfEbX01h
         Wr1B5Mk7cZ89BxwMWY4UjaskmYAgZmqQrgqzrwodCeStdFNLuIWS4+lsaVuOqM5dAfvU
         6gnbDfrqbhD3SxQQ5YqUuGiU2Xb045B8qONs5tlCGsByQP9LmiGwfubOyThIfIYNSLTO
         AWrmQDfcn8TFX7cZv4gRnB0746w7ink4TYgwg9Td5YRktIkCDDab78VB6gzKr/V3vsfW
         sxMjaYPC9BWcgoq7orG3zy7oxvvjdeUjbcnaVv4EHjWcmYEZr9J3zBIEO8BAbKKYTK95
         R9SQ==
X-Gm-Message-State: ACrzQf29aDe2nYZor0vh847IX4C6mQjxonWOw0v0cViDvsOeBlKxW/5y
        ST6bddQnqX7mnIsoEbp5kqlUGs8JXg==
X-Google-Smtp-Source: AMsMyM5eU0qp7iFbLVkyPSNboCPNjWxmKiZ5S1x1eN1tzjGH3mdWFnnkxUSBjmZcHIUJMYMWW+t8MQ==
X-Received: by 2002:a05:6808:211a:b0:34f:bc03:d5b2 with SMTP id r26-20020a056808211a00b0034fbc03d5b2mr554587oiw.158.1664234012772;
        Mon, 26 Sep 2022 16:13:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q185-20020a4a33c2000000b0044ae10c5974sm7164313ooq.34.2022.09.26.16.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:13:32 -0700 (PDT)
Received: (nullmailer pid 3147856 invoked by uid 1000);
        Mon, 26 Sep 2022 23:13:31 -0000
Date:   Mon, 26 Sep 2022 18:13:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Sricharan R <sricharan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 13/32] dt-bindings: pinctrl: qcom,msm8226: do not require
 function on non-GPIOs
Message-ID: <20220926231331.GA3147792-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 10:04:40 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml       | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

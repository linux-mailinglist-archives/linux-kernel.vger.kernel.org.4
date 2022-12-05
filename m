Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC156437B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiLEWJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiLEWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:09:27 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC66163B3;
        Mon,  5 Dec 2022 14:09:26 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-14455716674so9006431fac.7;
        Mon, 05 Dec 2022 14:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDYK7cF7r7VtSosxWG6tO2zJ0ZY9i6iI6vk4huWOsd0=;
        b=KggNIxn1wNqWw3K2Ik7mTfNjiwa0rOrzi6uEPrwa3yaHZ4+0roE1jkdC/1FPOyQHwl
         A57IPW5FkuDqtJIHhKtS70kFYN0bp1pUvYsLc6xhZ349mmFd6cAuZ1YzgUGIU6HUkLtZ
         hOqb590fdi/x7tCot0LoeBAQ0LkHHZP9ptAbe7Da9JxPKYRox+9xO+IQiBuqWX2B+KFp
         rg7RhNp/EobmqScFi+N4W1nmGTtxIYMn7BPUn9cQkS/JYVsFHcy6axHqvU9lWG27m6p2
         bnUOK6xPlSFAoDchQwWvQMU2bC28MflhMdedfxtgxCgZQ9V896P7MMwpyglUow3KsK3R
         wtTw==
X-Gm-Message-State: ANoB5pl29EGGVRmtDhbL4bVbcQvAX6RFiMPdunjK5HlgoSrSTgFqnHZu
        nAocVisK1gpKWHBsQ8Ef9irH4fTjrA==
X-Google-Smtp-Source: AA0mqf43fWx8mQv18bdFGFgF1PyPi2JsinU+oHRBj0pAxWMIgpXZI2YelajYW6DqarzGI98ngxwASw==
X-Received: by 2002:a05:6871:4607:b0:13b:9bf2:25a8 with SMTP id nf7-20020a056871460700b0013b9bf225a8mr36136268oab.102.1670278166142;
        Mon, 05 Dec 2022 14:09:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x22-20020a056830245600b0066eab2ec808sm3419605otr.1.2022.12.05.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:09:25 -0800 (PST)
Received: (nullmailer pid 2753233 invoked by uid 1000);
        Mon, 05 Dec 2022 22:09:25 -0000
Date:   Mon, 5 Dec 2022 16:09:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, abel.vesa@linaro.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: mmc: sdhci-msm: cleanup style
Message-ID: <167027816452.2752604.1047095638115671266.robh@kernel.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
 <20221204094717.74016-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204094717.74016-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 04 Dec 2022 10:47:15 +0100, Krzysztof Kozlowski wrote:
> Drop unnecessary quotes from $ref.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

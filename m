Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAE5F6F34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiJFUdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJFUc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:32:57 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD50BBEAC7;
        Thu,  6 Oct 2022 13:32:56 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id h1-20020a4aa741000000b004756c611188so2222493oom.4;
        Thu, 06 Oct 2022 13:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcOyRcRSx0+Y9wlXvIvsToGECYGmWrmaG0LazNTO+Zk=;
        b=WnQGJ+9jjMnUpUfLrLb5mFXhSuF0ssHGgTlDuMAexmEOKFckRcpqYNKruXc5q91r4B
         cqjaFDxHwS46V4XIrFamCKsCccNnv0Xf6bSgxMI7FfMGc2eBH6diqFhdg79URuKlE1UU
         dBPffTv7QWV+XLk3KbxUJuycC2C4QETZ9WusXz6cxVY1ASkFh8FALMpbOCj3hkkje5ca
         JB/PKce5yly+E+n2EZnOI+5mCuJpVFh/keY22VSNqERFS9cZg8lsMffKvNOg+2pyFbro
         r2VDCs3DcL+GHNQ8KW1uCYqpWC2hwTRoKlfUmtcshDJ232ujUmhnsxtL1UVO8jXFCjxG
         LJLg==
X-Gm-Message-State: ACrzQf1rtFxWpJa345WjQ70o9lsrM6jynUKKBbDII7sVqfIvMmuBND3v
        7eassPg9zzyokBWYEE6GFQ==
X-Google-Smtp-Source: AMsMyM4KBH5UCLaQijb729zMpfbHKEq4T/nNQDoXT7CCYZykGTol9PlzV+Kz1mpqPA3u2wZkcnluBw==
X-Received: by 2002:a05:6830:1e14:b0:65c:5217:ca02 with SMTP id s20-20020a0568301e1400b0065c5217ca02mr707678otr.203.1665088375969;
        Thu, 06 Oct 2022 13:32:55 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id cm21-20020a056830651500b00660d73c8bdesm274750otb.50.2022.10.06.13.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:32:55 -0700 (PDT)
Received: (nullmailer pid 111642 invoked by uid 1000);
        Thu, 06 Oct 2022 20:32:53 -0000
Date:   Thu, 6 Oct 2022 15:32:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: [PATCH 16/34] dt-bindings: pinctrl: qcom,sm8450: drop checks
 used in common TLMM
Message-ID: <166508837168.111515.15485282892901000258.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-17-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-17-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:19 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

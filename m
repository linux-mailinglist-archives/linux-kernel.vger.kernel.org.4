Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E65F6F03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiJFUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiJFUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:25:46 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC157207;
        Thu,  6 Oct 2022 13:25:31 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso2238998ook.0;
        Thu, 06 Oct 2022 13:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omh8kakAllyJm9DSI5n7aG4HEm/LKc4+50l/HSBM8Nc=;
        b=uB+HnIhTYKKLi4L8Utv0pMhJ8FkxQST0iRUzp+6IVSdaGE3NNFzPUzLY0OAUdrfBXT
         9Q4cXezRxR3Le2uITT9HmLYz9P5qthNa/8WHeSd+mTyo+KrAxjSx03BXtAQCdtfrLob7
         ecXNi1FqAz/KeJz/7OQvMk1VrD3zfplqVO/xA4x9GHwFtQx1Fs6iaThmIUivmD91rhe2
         Yh+bV1wAH8MGcegwjfhnzoJ2UDYbQFe9yHAyfZg1i9C2ly0Jryqm9YLbVnFmFlQc3Ge2
         qwrjVfOAHceBTPa2WBOZC7fWpF9+sXxxzI6S7pj8BEeb5UcL+d3/J6VW3+JZL8gmZGKQ
         huXg==
X-Gm-Message-State: ACrzQf3lcIItODby3Jmec9PvVzCEC3q2oAEmEcZ4RycQZ2wBhVAf45L2
        ZXMqNdvBKvZDCwYxpdh3+Q==
X-Google-Smtp-Source: AMsMyM7TLIWE04z82fppkzpZH9khyh3WjObuvfMRDem51D9ui+75Yg6wD9dwSqJ1H0kIGbOEd2aOqw==
X-Received: by 2002:a05:6830:1559:b0:660:f124:8e60 with SMTP id l25-20020a056830155900b00660f1248e60mr717198otp.175.1665087929771;
        Thu, 06 Oct 2022 13:25:29 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870c14100b0012752d3212fsm301926oad.53.2022.10.06.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:25:29 -0700 (PDT)
Received: (nullmailer pid 104716 invoked by uid 1000);
        Thu, 06 Oct 2022 20:25:27 -0000
Date:   Thu, 6 Oct 2022 15:25:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: Re: [PATCH 07/34] dt-bindings: pinctrl: qcom,sm6125: drop checks
 used in common TLMM
Message-ID: <166508791303.104483.63652313407043516.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-8-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:10 +0200, Krzysztof Kozlowski wrote:
> The common Qualcomm TLMM pin controller schema already brings
> requirement of function for GPIO pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml         | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

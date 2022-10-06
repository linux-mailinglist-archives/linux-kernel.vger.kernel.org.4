Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70CB5F6F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiJFUl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiJFUlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:41:21 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36303C4C27;
        Thu,  6 Oct 2022 13:41:10 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so2239691oop.3;
        Thu, 06 Oct 2022 13:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWj9QQLFRsfB1M1R3XGBpkYsKsdp0pHYSKahVr8E05Q=;
        b=f+rqPRxgF0JKaDUXOC//h4nxfjvtPWMjFwlMWZAu4Ale7OZxnTJ/K7N7QqXCIHLGER
         hm0Bhw/mcATB1jg21paO4um8wlqYON4EFQfq5kkCvSDtvhYuwZhr920xeTIxgEmUkNf0
         IpI2P2AnvnE++FbkT+5WN3A67vptWoRj0itcaYQ3/gwi2005VbwclzMs9Hti27NYADTk
         GsGH1Pn49Tnt9J/qlUWHuWCR4iBKB0WGLUsVcGIRATs43MHglOzaLkUESHfzGmkhZw5/
         uZPCye3iGlTY5cSHosZcYS9E82zkvmuQX5/4tID6mIB2oI4FAJheIaJtdKTnGki95y3X
         UKZw==
X-Gm-Message-State: ACrzQf2X2EofEDOVKwsTvXbEBoeJpuLBpICr6XuTcLkB/uM14VPj64bj
        58s3GDRPdhFxwRNC3jFr+OXo2W4FFg==
X-Google-Smtp-Source: AMsMyM5locNpnmsCWO0k/smFynYtOsuOMyMgvmlEzDwvy80CsNznBMVEduxJYjwAtvCYZ+gHOlkeow==
X-Received: by 2002:a05:6830:4102:b0:658:bc45:675e with SMTP id w2-20020a056830410200b00658bc45675emr673240ott.309.1665088848979;
        Thu, 06 Oct 2022 13:40:48 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id s41-20020a056870eaa900b0010c727a3c79sm289965oap.26.2022.10.06.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:40:48 -0700 (PDT)
Received: (nullmailer pid 119450 invoked by uid 1000);
        Thu, 06 Oct 2022 20:40:41 -0000
Date:   Thu, 6 Oct 2022 15:40:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 29/34] dt-bindings: pinctrl: qcom,sm8450: minor style
 cleanups
Message-ID: <166508884089.119397.10140513213696129829.robh@kernel.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-30-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-30-krzysztof.kozlowski@linaro.org>
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

On Thu, 06 Oct 2022 16:06:32 +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml         | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

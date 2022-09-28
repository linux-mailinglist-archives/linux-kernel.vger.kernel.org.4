Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A385ED1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiI1ATq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiI1ATm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:19:42 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D191F2FA;
        Tue, 27 Sep 2022 17:19:39 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so7295726oto.5;
        Tue, 27 Sep 2022 17:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gQo6SXQcHOKaD6dluUUN9F3GstldERjXH14eVa5dKDc=;
        b=dXPADdvgMhzEzzATHOVVji8jBXh6q1WlWEJdINyUCCJlKxiuhCCpc8Ju8YgrCaSm/V
         E9VLKXxVZJ6Pw7oKcldafAImUlymDcExk7GF1FdzvNVcmg2hODvu3qCaoexzGJD13wuY
         D69j7yaYDIJF9WlX1oCryL3wQK/4U/aJhipp9TyteqTjFdHmP1gW9I6Up+c/ewY6Kg8f
         Po1k8qjtQ83DW3GKCGwcUpIqK1l5bk4WR8HvOzDxByrp+7VojRLNbLPbwt3dAgSOLb8Y
         dUB/Qh23EhL3H99+rHZkiwZBQKcVUrj2h0SquOK/DtHSKP3QJ7aQ+KN0/xZI4F1/zC/M
         p2pw==
X-Gm-Message-State: ACrzQf3vL7ZHfNuSCYNgY8UjZtzCv7tWNdYPdlbKBSqeB8JVUZy8GN2/
        19iOvKQt0dI1gyq2PnVnrw==
X-Google-Smtp-Source: AMsMyM5l0UOv5QoKtX1icIMLnOhx6feUDJEVH4UXZCIXIsKQq5waaQqHYB0VdQTwocy9VsbQo2/1ew==
X-Received: by 2002:a9d:67da:0:b0:659:f972:996d with SMTP id c26-20020a9d67da000000b00659f972996dmr12965219otn.255.1664324378434;
        Tue, 27 Sep 2022 17:19:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0506000000b003509cc4ad4esm761041oif.39.2022.09.27.17.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:19:38 -0700 (PDT)
Received: (nullmailer pid 2677295 invoked by uid 1000);
        Wed, 28 Sep 2022 00:19:37 -0000
Date:   Tue, 27 Sep 2022 19:19:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix
 matching pin config
Message-ID: <20220928001937.GA2677189-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-19-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-19-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:46 +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml     | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

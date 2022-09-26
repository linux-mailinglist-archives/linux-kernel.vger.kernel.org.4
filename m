Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1707A5EB54F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIZXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiIZXPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:15:47 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F91B7AC;
        Mon, 26 Sep 2022 16:15:44 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13175b79807so1171302fac.9;
        Mon, 26 Sep 2022 16:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eXnGsoXEBMVk+25Y/H9hSERwYN0hFwdWIk8o5p0Bhfw=;
        b=wggsjBwZQA5V4prjjd979LcZPjWSptihPMhzdijUyLweeACgD/yhfxi2dpBgP9J/Ea
         hJfogtpzueAfHH4hrnUay399wfV7MMmP+3xZ46GLytdtTyhMMunwzm7BG/EQsBOrNAxD
         uWr2AxeQ6/agn1D2MkaVjigCREYGtHMkQNEyk1g9CstlLaJGiAUDBL6V5Wfb/teo/XkT
         tvcgC0FsXx9eFQQP2YrkA+YhPg40BhOp7nx3Hi0+GVNYzpDZHCo/0UFucomcnLbHCZgo
         ouQIdFOhXCPHKGLAOIwUjv8mNdP+A5LQOKsFYtWB1BA+EnoJiupKaPGd+6NaobRVu7nW
         69Jg==
X-Gm-Message-State: ACrzQf0X9lXCKGX8BqmL1CohXmLPSUbAuI05LDUVQMmYmsQYdnugKQvb
        ErOLfpaRXga3c9nk6xmn7w==
X-Google-Smtp-Source: AMsMyM7+lHu2zxtPMuWoNy5bd5+qTP2i/6uECrRtOLvZUtoteBBwVo5bAIHjXTGcfVFOXZtk73RAyg==
X-Received: by 2002:a05:6870:f61e:b0:12b:3ba7:701c with SMTP id ek30-20020a056870f61e00b0012b3ba7701cmr594630oab.173.1664234143565;
        Mon, 26 Sep 2022 16:15:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e18-20020a056870c35200b0010efb044e37sm6663604oak.27.2022.09.26.16.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:15:43 -0700 (PDT)
Received: (nullmailer pid 3151875 invoked by uid 1000);
        Mon, 26 Sep 2022 23:15:42 -0000
Date:   Mon, 26 Sep 2022 18:15:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sricharan R <sricharan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 30/32] dt-bindings: pinctrl: qcom,sdx65: do not require
 function on non-GPIOs
Message-ID: <20220926231542.GA3151812-robh@kernel.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-31-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-31-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:04:57 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml         | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

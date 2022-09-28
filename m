Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E65ED195
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiI1ASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI1ASI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:18:08 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D4FE05E;
        Tue, 27 Sep 2022 17:18:07 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13175b79807so5330150fac.9;
        Tue, 27 Sep 2022 17:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5Mixkh+hgg0a5Q9JuSU0eIHC777dA5PmbFb4Ayo6nfE=;
        b=f/UIKZLvjlla9WVpRi/79qAzY4c69wGlcmQlGSyG054NcuTn52DW3oVLcJm3sGTzIC
         pQ+cKVJ/7U0B4yTk8QVeQSIODjKb5O/7uzbIOc+z3zR2hhvqkZUE26SlZeuqj/rCGUBV
         jderPy1bBzwV4BufbTOTKI2DAFQ7nj0d0iTzaiYLsrGWc6Jeez6gD4cQqdvu8VIh9TLv
         R96mk1NCCMF6JgNiT1Sw4yLMmhvGZ8x2gNb3GUOYhdan7KYm/u0uDaZfGfMKHT0UQgH/
         7/yoDS1XGACA/O9t0TKN1tOTOI4N7jvRcvaZLswGT2O3mtQeVGBcC+TKqcFWUc03Jlc5
         KeJA==
X-Gm-Message-State: ACrzQf351O/7CPA4kp43i79yiGyaP1kUIcufbmKb8smXJRiTZpSoUWgD
        15g/+gf7MKa7vVqCozhUJQ==
X-Google-Smtp-Source: AMsMyM4QHGvmNht73iHTdUsiRnrRKFc/5rMDYuhPF9W4GjMSmgzKqW0sclLCNlfX0JB8huHIq1NWAQ==
X-Received: by 2002:a05:6870:3452:b0:127:74a6:365c with SMTP id i18-20020a056870345200b0012774a6365cmr3832812oah.169.1664324286928;
        Tue, 27 Sep 2022 17:18:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z21-20020a056870d69500b001226d2100f2sm1641330oap.33.2022.09.27.17.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:18:06 -0700 (PDT)
Received: (nullmailer pid 2668294 invoked by uid 1000);
        Wed, 28 Sep 2022 00:18:05 -0000
Date:   Tue, 27 Sep 2022 19:18:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 13/34] dt-bindings: pinctrl: qcom,ipq6018: fix
 indentation in example
Message-ID: <20220928001805.GA2668238-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:41 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

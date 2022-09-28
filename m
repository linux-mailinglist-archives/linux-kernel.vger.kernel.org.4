Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947C5ED1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiI1ATW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiI1ATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:19:15 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3314102531;
        Tue, 27 Sep 2022 17:19:11 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12c8312131fso15435506fac.4;
        Tue, 27 Sep 2022 17:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bM4qOHtkqAduAGs2/RByZg1I8QRXjAjzC5kJvZh6ECQ=;
        b=irUHbxAFQyMZ+d9xIwgtwZCfhysNbGTGKVSqWdJhv4rhfw3SxhgVGfks1g+2xAE+0w
         6NpTTRBFOEiTfVK81PFn+O+AsyWU51zO0+fYH49JVEzqp9MLpQpJbqhRoqdJLhEN/Sa5
         iHPac1Jfa1ZwQwQjBXdEH7mC/rh9WBuO1rl16ZGJCgLxEy2fE1srApleHy6REN/2CraQ
         KRnehm8/PWvly70kKtwObdyeHgnjUlGsmFzf7iXKQ57BXRvDqnAEoRYkmcQmr1n8pu9q
         SgAqr6rzxeNAMeyHw75TTIhKB91qjbcnKnp3KreDEX1HIuVuE/Vm7Z6jiCMpfnH1hrSC
         EJzA==
X-Gm-Message-State: ACrzQf2zHGWbT1V1FQZzviMKxlh2MfV836N61apNiB+Kezhku9Bire1g
        jy3mTF7ZnhTBah2Pv/Ss+HplPyY+sA==
X-Google-Smtp-Source: AMsMyM7AINpeRXFVJspezN8/o+ggSRkT7xWqni9YuUo+QbtsboNcypClIuSSsDYOqtaAX5JGvEphkw==
X-Received: by 2002:a05:6870:d181:b0:12d:97b2:7ea9 with SMTP id a1-20020a056870d18100b0012d97b27ea9mr3745899oac.110.1664324350623;
        Tue, 27 Sep 2022 17:19:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v26-20020a9d605a000000b0061b8653b0c9sm1372389otj.22.2022.09.27.17.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:19:10 -0700 (PDT)
Received: (nullmailer pid 2674302 invoked by uid 1000);
        Wed, 28 Sep 2022 00:19:09 -0000
Date:   Tue, 27 Sep 2022 19:19:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 17/34] dt-bindings: pinctrl: qcom,msm8226: fix
 indentation in example
Message-ID: <20220928001909.GA2674123-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-18-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 19:36:45 +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../pinctrl/qcom,msm8226-pinctrl.yaml         | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

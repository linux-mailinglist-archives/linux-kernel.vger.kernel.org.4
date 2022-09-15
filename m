Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5015B984C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIOJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIOJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:53:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932F99B75
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:51:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e16so29977515wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=L9S2V0KF4UdbSZ+qAlnGEJsbuMqREsUyJSrjlKWQqqA=;
        b=ZO0tDmosBU3RHS2fdoy1mJ9nSyilD9I11uK5fg++kJDpIM8sFxIxSXULtogOU/A7+a
         wdJHpKfTa0/FUeDbtl5brg7WaQ5cRapYf0XdJjM05GfkMKUZCXs3EgJB6oPcPIcv0MLE
         Hvk8/KPYv1hZbEzz1s4dEKt8YnIjByL8HtGGOmKA1F+da5RPK9vf5VqRLjkQJ98NayfR
         zEclJmNpXglRkuePR6/ZF5/ujDho6+X9qIIe78IsO0pGuguMp4FmZFwJEJHm0icpinLa
         GoXb+42HZT6koHQS7JEwTvcNJvSrDJXlT6jodP4yB56P6eIuZpGIW55O54ld1lWZMPvs
         +3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=L9S2V0KF4UdbSZ+qAlnGEJsbuMqREsUyJSrjlKWQqqA=;
        b=YsB3giM4jWbpU1lL0TMFcXhtAiPTOXagEgcxkexVEJGPXJPeEzp+BNmpJ45T/veI25
         ncLJ3fjACpXFQzR0lm198xnI+KEIuLNdttyPYe+REii2+56rO+UM9kuTvpa7zIgMTsBM
         ItIwgBzlY2+WT12UIu6m+jAoHy5TirHUpr29wJm1ixzeWkcC/qnYkr30FayLgG5NYK7z
         C6Lx932/N2pXsa+BJvxPO1wbFUfdjylS++a8E8ia8pQ8aTtLHlKq2eRogIsXJJP1HbWP
         EOm5w10ZfwOn1v7Xm7hDN85MLokE+Ieuk3OqSXUTT3u3u96dsj/L8n6l+apyc/S2J7me
         JDUQ==
X-Gm-Message-State: ACgBeo0aOfxMY+WgxkgKvi7vgyraE/NbKZXEFMuiQXlebdOGVC89Pe2y
        8AFHErdHm6yUTIJNYZaJesNMXDs/6eHTOvVe
X-Google-Smtp-Source: AA6agR6nLIzIT7Eqbc095Tt2vG+E8xg+XEJmDTEF1rmC/eYII0W7xxLVHNrErRC8vVdkQWyVqVpZoQ==
X-Received: by 2002:adf:f44c:0:b0:228:8686:552f with SMTP id f12-20020adff44c000000b002288686552fmr22977859wrp.587.1663235465802;
        Thu, 15 Sep 2022 02:51:05 -0700 (PDT)
Received: from krzk-bin ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id f5-20020a7bc8c5000000b003b49aa8083esm2054322wml.42.2022.09.15.02.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:51:05 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:51:03 +0100
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <20220915095103.7qys3ixd6yyngkzs@krzk-bin>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <20220914165212.3705892-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914165212.3705892-2-vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 22:22:11 +0530, Vinod Koul wrote:
> For PMIC arbiter version 7 and beyond we need to define if we are using
> primary or secondary bus, so add a new property of qcom,bus-id
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: Unevaluated properties are not allowed ('dma-channels', 'dma-masters', 'dma-requests' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/st,stm32-dmamux.example.dtb: dma-router@40020800: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/dma-router.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.example.dtb: dma-router@a0: dma-masters:0: [4294967295, 4294967295] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

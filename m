Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E6688101
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBBPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBBPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:03:56 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA749241EF;
        Thu,  2 Feb 2023 07:03:34 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id bx13so1617449oib.13;
        Thu, 02 Feb 2023 07:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXX0hqbNxibIh9MCxkXiGg/t9DnespCyPGgD3gIO8QQ=;
        b=OkY/z0Q37XBYJdCPAnfnv/ZEv/rzwt1GCfeyBZr/lUfH67AKEGZpLvvhzqqkC13qXW
         Ez2X1X4ZxS8npGQ1Qkdxi+Anq59o+IZ8O4CjbBL425+UA5ZEjZsPSo0UNkUy7nX/ucmV
         bM7Q8WsNhsB2FWMplh//nkQDjK3kGi3OmTV5Ptd4L43pPLiRFYWEZwZRaWbse2fWuTGV
         2Mxbk8rtSMBgQOrxOyZwi2N1CTWNe+/3xpOXG1M+R3I76aHNpsw7ENteZAYM+ObZcsyV
         OgpGB9bofdvRnVRFzztnMiK+ZnhpynEi8xc7NZimhlOmZZ/GxWhQqlALthcu9RXZdb4o
         CNPA==
X-Gm-Message-State: AO0yUKWcAGf6Ewby/1SGKOR8qk6Ts0E7NoUMqRNR+R5sUUj266jEt1Xy
        K0Yoxo0RxjpMKUUehoJhvA==
X-Google-Smtp-Source: AK7set9jNto6EojA583eGeA1isZbtX7sjgvWYxC8CJplWmCLVZcK+yXGfL/11mry6PSTtH6mv+VMNw==
X-Received: by 2002:a05:6808:694:b0:378:bf7:84bb with SMTP id k20-20020a056808069400b003780bf784bbmr2840657oig.1.1675350213907;
        Thu, 02 Feb 2023 07:03:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id du24-20020a056808629800b003781a8bcb64sm5717528oib.36.2023.02.02.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:03:33 -0800 (PST)
Received: (nullmailer pid 1858080 invoked by uid 1000);
        Thu, 02 Feb 2023 15:03:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        vkoul@kernel.org
In-Reply-To: <20230202133816.4026990-2-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-2-abel.vesa@linaro.org>
Message-Id: <167535003829.1854190.10009935343094706498.robh@kernel.org>
Subject: Re: [RFC v3 1/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern
 property for phy
Date:   Thu, 02 Feb 2023 09:03:31 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 15:38:10 +0200, Abel Vesa wrote:
> The phy pattern property will be used for providing eUSB2 repeater
> functionality. This will be modelled as a Qualcomm PHY driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/phy/qcom,snps-eusb2-repeater.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230202133816.4026990-2-abel.vesa@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


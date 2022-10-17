Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF79601679
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJQSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJQSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:38:40 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E35C7295E;
        Mon, 17 Oct 2022 11:38:39 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1364357a691so14251644fac.7;
        Mon, 17 Oct 2022 11:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM3Q3f2MnZ8Z3WgbxgHNgXPo0UnewxJXWkTQ3zu0TKQ=;
        b=pNHlpJ6lmXqccKVXwzPnfIvF0RulDBbIVHbwTUNxyIWbD5Dhizlwoaq7eFF70AUY5t
         acrXTtT9adal+oTyNDxNDvgQfiTWWS+smnSBWXU5fHQd6pAid07RNuD5R5nCJWz0qzR5
         kMBAEQL1K6mnWFNgN8S36YixkmXb9/0PuJMNTFbxDS43AofL0LKoZYvpwI+Ese5aDTAR
         evVVzsPLWBxVfY8HxEgBBimejv8nxNV0Ju6X3yrwybTjma3zOsvfqPNbsdPk3fXSuS7f
         FW+lu1+b4dNY77zXnUd+z3+zJpBmv0L8QDhbHjhhm4MUf2ZwadKg9sAPBahB3I/e4qUH
         3v4w==
X-Gm-Message-State: ACrzQf2SrdeQxIO194ybETF5gQHa5xOgFk129UkCJrU/ugtSk0GbE5OA
        SRbkCg4PqIVdltPUVD4osA==
X-Google-Smtp-Source: AMsMyM6C+zeBBGZJCSwfY+2iIcyKtK+G52QfVwFRQWUOEop7c93WviJ7T/Dd5+I8Mhwj/kHB2jpgvw==
X-Received: by 2002:a05:6870:c222:b0:133:3666:2047 with SMTP id z34-20020a056870c22200b0013336662047mr16592884oae.120.1666031918866;
        Mon, 17 Oct 2022 11:38:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cn5-20020a056830658500b00661af2f9a1asm5142944otb.49.2022.10.17.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:38:38 -0700 (PDT)
Received: (nullmailer pid 2259604 invoked by uid 1000);
        Mon, 17 Oct 2022 18:38:38 -0000
Date:   Mon, 17 Oct 2022 13:38:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8974: convert to
 dtschema
Message-ID: <166603191824.2259548.13748226985219678312.robh@kernel.org>
References: <20221017012225.8579-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017012225.8579-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 21:22:24 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8974 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8974-pinctrl.txt | 121 ------------
>  .../pinctrl/qcom,msm8974-pinctrl.yaml         | 179 ++++++++++++++++++
>  2 files changed, 179 insertions(+), 121 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

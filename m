Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4606624C22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKJUrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:47:17 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A34E41E;
        Thu, 10 Nov 2022 12:47:16 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12c8312131fso3474023fac.4;
        Thu, 10 Nov 2022 12:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gwEUKSXC2q8W0MZ5VNX1K1et96Xer1LBkG1sO7qsX0=;
        b=mnVkG66vPfhfaET2XeIzzWL6QZp2R5eBAaZu4oPGalR3UYLMUcJtF5d56yZUeGTbLR
         BUFOC4zFa1GMx8zOSIFHxnW6IEG7YF0d4D9mhxlwtQ7Nb2fIqkmGSJfWzjeOgJUEL4YJ
         xGC/J0E54fER6mYl+1JBY0lbqmLeJxtO0UbVyueW3L7hO5wcWUAMD29UuzpCGwkuJ4qI
         KoZ1aMt+tH9Cix6i3KpH20TOSvVNe1Ib0dgCYXeTv5lKL24DpmA1wUbP0dG+YOTR1byK
         7LMGsr+KQA5Esu/cA5EvkdYH0RWyRO1oUCg7nexyn1iza09bgKAs+Zo9kKitQr656wlt
         2NXg==
X-Gm-Message-State: ACrzQf1n7hGOYRdHAofHyyJOchyVkoFSNMtsUf3E852+NBYG+4ToRp49
        AVuDw4oVxMU2ajbPTsr63A==
X-Google-Smtp-Source: AMsMyM6VW4+1pCBMsQIl7KdJQQ0JAK3VklV+o63SprytCoT4uMUlVeBGulSY4AQyEuEe1248a3NsOQ==
X-Received: by 2002:a05:6870:2895:b0:13c:c80:6b46 with SMTP id gy21-20020a056870289500b0013c0c806b46mr2102986oab.194.1668113236157;
        Thu, 10 Nov 2022 12:47:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a4adc8e000000b004768f725b7csm174425oou.23.2022.11.10.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:47:15 -0800 (PST)
Received: (nullmailer pid 957786 invoked by uid 1000);
        Thu, 10 Nov 2022 20:47:17 -0000
Date:   Thu, 10 Nov 2022 14:47:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8660: convert to
 dtschema
Message-ID: <166811323446.957679.13923991485365016948.robh@kernel.org>
References: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 07 Nov 2022 19:59:30 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8660 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8660-pinctrl.txt |  96 --------------
>  .../pinctrl/qcom,msm8660-pinctrl.yaml         | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 96 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

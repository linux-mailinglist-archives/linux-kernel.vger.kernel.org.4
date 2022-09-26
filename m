Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297B5EB4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIZW7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIZW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:59:33 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF73BC;
        Mon, 26 Sep 2022 15:59:30 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id o64so10034999oib.12;
        Mon, 26 Sep 2022 15:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G1nYtk8mEOVoyeeft0wUFqBP6nfvgAT1OE7LASp1Y7Q=;
        b=rjgiGYmeerZmGKQm+vOzhytHt6g3ZjCfDWIdYj83iR8UCzXMApc7ZY9wpWQV1zpBWj
         O0204MVdEmY0vZ7UJZaTd6WkB3pg6pIVUD5vR/+QTnKwmAGRVzAdGwiK6xbFxu5SDqk/
         g6Ojl6PZzzHLpIgse2hiumt/8WYUsdkw5QoI66fSBpepHXdvk9RBU7tvOf11OcnzZ8Mg
         Qse2rUYSizXXjsTJflUh9GkL04Tq2rW/fTOIF1YGQ4+l4B8/F81HUWugSD74R1j/h5r5
         qShSsJpkZCPcFPCt6dFxYzA+2AhTNHlcWnjfrFWxYGyR7ZsiPSWGSUt/V4Tjec3WKS6X
         K/cg==
X-Gm-Message-State: ACrzQf2r0Q7uzaIV2ZZqJ2g2Ip3NmOFl9O9PKMDtk4IbBpqbP0aHFlEy
        sk90nPYgcaMtbc7v97e1s/hs9p3RTQ==
X-Google-Smtp-Source: AMsMyM68dzdCvNHTwgkYRyIWg2iK9c9WNyjxUq8oaywqVSlqKg/Wq2ekbLSidqq2dSUL+cXlDXZnLw==
X-Received: by 2002:aca:1912:0:b0:350:504b:ee13 with SMTP id l18-20020aca1912000000b00350504bee13mr513201oii.256.1664233169638;
        Mon, 26 Sep 2022 15:59:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f47-20020a4a8932000000b0044b491ccf97sm7062458ooi.25.2022.09.26.15.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:59:29 -0700 (PDT)
Received: (nullmailer pid 3123199 invoked by uid 1000);
        Mon, 26 Sep 2022 22:59:28 -0000
Date:   Mon, 26 Sep 2022 17:59:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/11] dt-bindings: slimbus: qcom,slim-ngd: convert to DT
 schema
Message-ID: <20220926225928.GA3123152-robh@kernel.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
 <20220923161453.469179-12-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923161453.469179-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 18:14:53 +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm SoC SLIMBus Non Generic Device (NGD) controller
> bindings to DT Schema.
> 
> During conversion add iommus already present in DTS and extend the
> example based on SDM845.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/slimbus/qcom,slim-ngd.yaml       | 120 ++++++++++++++++++
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  82 ------------
>  2 files changed, 120 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

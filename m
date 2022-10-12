Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4455FC93F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJLQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJLQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:27:29 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08657C45BA;
        Wed, 12 Oct 2022 09:27:29 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id u15so13718764oie.2;
        Wed, 12 Oct 2022 09:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqO9T0BRgqtI45OY/DP9OUgLBPQ1TydBBs8XSgEA+y8=;
        b=bhyOAIUtC8pXy0Ng5KDk3Ic4TLY1rrLMt+zGatxJfx+maqFVOg1z8DmCEm3/mVpGkq
         GPdSfq0ZU4Vi+YZ1POr2rqm3RVYcmVkT74dhTvbe0pu+bjh/8DHgzSMYlpPGdIk8upBn
         eF3P2Mntsy2yISXB9WQUln4oIb2yUiUWOHnGXd8iEtwyT/tSL4E4Zq6UirqegUJv3rOU
         bIIquOp4Vgevy8qWnTPHywE+FALJHdwg5ZJ+HZntCv2doNJSpbTZdeLXC1pvItw+dqYs
         gHMUE+6GNgZHS9MAH3nFgJaF/IbLfpeckcwtGJNIK2kgumwDwvEgSI/m3gSI4WpJmufw
         ZBww==
X-Gm-Message-State: ACrzQf2eFIqDoO25IIw1C72gkGvgFpQbiIi8IWn8Go+pk2gF00D3MK0r
        NY1QPPMNDnrseo2xhx+s7g==
X-Google-Smtp-Source: AMsMyM5/fblbOEOR8N5ejTd/KkqUzWqa9asSo034kg0FcyYZk8idWV9U5aKLmv5ns/kc5SVvbIXYpw==
X-Received: by 2002:aca:db08:0:b0:351:aab7:c31a with SMTP id s8-20020acadb08000000b00351aab7c31amr2676924oig.138.1665592048345;
        Wed, 12 Oct 2022 09:27:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l10-20020a05687040ca00b0012752d3212fsm1331095oal.53.2022.10.12.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:27:27 -0700 (PDT)
Received: (nullmailer pid 2289051 invoked by uid 1000);
        Wed, 12 Oct 2022 16:27:29 -0000
Date:   Wed, 12 Oct 2022 11:27:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: qcom,msm8996: convert to
 dtschema
Message-ID: <166559204884.2288999.2781596648308541676.robh@kernel.org>
References: <20221012151545.39061-1-krzysztof.kozlowski@linaro.org>
 <20221012151545.39061-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012151545.39061-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 11:15:45 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8996 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,msm8996-pinctrl.txt | 208 ------------------
>  .../pinctrl/qcom,msm8996-pinctrl.yaml         | 187 ++++++++++++++++
>  2 files changed, 187 insertions(+), 208 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

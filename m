Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396505ED178
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiI1APh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiI1APe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:15:34 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED682D35;
        Tue, 27 Sep 2022 17:15:33 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id l5so1430683oif.7;
        Tue, 27 Sep 2022 17:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=r9z0M5rYSS43tH4/L0yudvqdPGfPVs3bGPwIM0KJg58=;
        b=IMRJxubxIGzrd4E54souYaoqYuGAEgJ2qSYXYHtsPeibXRlLsAomumxF2kP/0nopY7
         UbQRHezi7TQyFMQQQT/4wGcFmPnaGgLLI4EGIrdqZaayX5fy1/z9DSAptvNM/JUKODkh
         u5trdAjpKPASo8llEW+bJtcHQuND+CJtuh+FhShJVOzTTiqTdzV7eaEPSV0r4zfYqtYX
         r+pmcyiBsuYuzKLe2QI1igKxeO7RjeYAkoU/+XMf8saf3+Px0ddixxdC8P8XD7WoZTum
         GVwMRilkp00FzYzl2itEbpxBnjxZ+Z3HYlo+Yr4XynnRquOQyfdThl8g3C5o+hW2q7gf
         HxLA==
X-Gm-Message-State: ACrzQf3ijiFvwd9Pim6AuXT97YUgiIHKqVCyHHM/8DsnMs+ObNHj0ELD
        SUdtrIyL8UUayXSpe4H2Dw==
X-Google-Smtp-Source: AMsMyM4opvmz08R2K+ZTJ/IHkVQDTd35a/b+Pb2j/+oA6LkFc/S0Pd0GZ1u1T2B4A/CY34D63Hooug==
X-Received: by 2002:a05:6808:1c2:b0:350:2b01:f324 with SMTP id x2-20020a05680801c200b003502b01f324mr3069289oic.56.1664324132872;
        Tue, 27 Sep 2022 17:15:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u35-20020a4a8c26000000b00475db5c28f9sm1251769ooj.10.2022.09.27.17.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:15:32 -0700 (PDT)
Received: (nullmailer pid 2652622 invoked by uid 1000);
        Wed, 28 Sep 2022 00:15:30 -0000
Date:   Tue, 27 Sep 2022 19:15:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v3 07/34] dt-bindings: pinctrl: qcom,tlmm-common: add
 common check for function
Message-ID: <20220928001530.GA2652496-robh@kernel.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 19:36:35 +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.  Add a check for this in common Qualcomm TLMM pin
> controller schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

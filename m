Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891105FE38A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJMUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJMUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:53:01 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4730569;
        Thu, 13 Oct 2022 13:53:00 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id n83so3043860oif.11;
        Thu, 13 Oct 2022 13:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEa8MzuBXqW8d10/nVywQl6OG+GmLxQIsROSS6dBhAI=;
        b=460D+JcotfrfTz8vvabr/FIMhyqUDEbdD+L69A9j9lSxIEKSvkevuFHEb0eAhQJHF1
         AWIm8GOeXa2Ryri64i3tN6WkfxIme27jztzpqyclzA5FGMVUVefwABfWbUfORLnJCSjQ
         PToLrx0mNcBnOxGoIxQFJk+lQDsomvRU5Z3PCW797jM1TyLRPJfWgA1PJDmzCYW7r/Ed
         jmaNw+M1zwUZBt6zLmi9gZ9eL9FX3X0LfsfZCo90bkT0q8h0RKzidFbItKBN3SrUv9sG
         ag9IidmjqKX9qZeEwgNoBlMoWFLt3yQOAAhxcfbnqmo2tunU8k3s4DQQSZ32tyIUddCE
         Ah5A==
X-Gm-Message-State: ACrzQf2NjRMPn+bENWO+FxSFKMyayCz/103URY665hm3C9W51uXpLok4
        0cY2HrM6cVOfDxINfxSWCg==
X-Google-Smtp-Source: AMsMyM7zy1cDs+EvWqGR047HtGCXe5RqsaoGQbolt9KFGr83b3U6GRoXUxT7cZmKfKuxpyIdO1ihEw==
X-Received: by 2002:a05:6808:d53:b0:354:ba42:bc51 with SMTP id w19-20020a0568080d5300b00354ba42bc51mr873968oik.186.1665694379881;
        Thu, 13 Oct 2022 13:52:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a4adbcc000000b0044884c40c8asm199965oou.30.2022.10.13.13.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:52:59 -0700 (PDT)
Received: (nullmailer pid 198040 invoked by uid 1000);
        Thu, 13 Oct 2022 20:53:00 -0000
Date:   Thu, 13 Oct 2022 15:53:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: pinctrl: qcom,msm8994: convert to
 dtschema
Message-ID: <166569437976.198001.10995993679277186924.robh@kernel.org>
References: <20221013185314.91266-1-krzysztof.kozlowski@linaro.org>
 <20221013185314.91266-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013185314.91266-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 14:53:14 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8994 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Drop default:2 for drive strength
> ---
>  .../bindings/pinctrl/qcom,msm8994-pinctrl.txt | 186 ------------------
>  .../pinctrl/qcom,msm8994-pinctrl.yaml         | 166 ++++++++++++++++
>  2 files changed, 166 insertions(+), 186 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

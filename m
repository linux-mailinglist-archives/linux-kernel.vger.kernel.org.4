Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304F5FC936
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJLQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:26:49 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A626D8;
        Wed, 12 Oct 2022 09:26:48 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id h1-20020a4aa741000000b004756c611188so12496865oom.4;
        Wed, 12 Oct 2022 09:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7brm/LRvaDB5m8VgRnDAJD8a3saeA8bq/AtlBA0Jyvw=;
        b=oB7mylq63eZHfalNHF9RwmqumT9mBA5Asa8ccJfdroHF1e9W+3zURB1sdOiyVkxeMr
         0XekqWa3T/RRH7kTDPPl1GbUaO7emsAMFcwU8FVfI0oI21cQkYrtEsLWKVl+QU67W0JD
         93Nz99Fckj944L7KX9M+PnMhNnvNq5hkfE8cO0LW73NUzdj4EB6a044L3qFJpUhM/XRU
         zRsCHu0yXwJLcwkwHBOpzkusQe+yPyy6vk9kPpuX3+A4baQheSj28dNlqjsERWzLTSE6
         OnX3iHH739wzvFOqkPP2uvrbZI8Y8gdPwwx6rq+IJ7dniYdlM7RSbhnFaEeVkJLZGFal
         GBtQ==
X-Gm-Message-State: ACrzQf1Sanx8hEAp18DxAfVn/F34WE9Lzq/W4LZN+xggPGoMtxezLOqi
        3dwaoJP+ENYXbQHN5/Fku2Rjf+rqcQ==
X-Google-Smtp-Source: AMsMyM45s6hc+x4sN2ls/EBV+RzjRp31Tj3OyrsiomaB5oGkop7xxXW3V3vgz+orvjWH8NK+IhLUxg==
X-Received: by 2002:a05:6830:2647:b0:65a:c6a3:1d09 with SMTP id f7-20020a056830264700b0065ac6a31d09mr13515853otu.279.1665592007944;
        Wed, 12 Oct 2022 09:26:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m23-20020a9d6ad7000000b006619caef3bdsm3784142otq.25.2022.10.12.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:26:47 -0700 (PDT)
Received: (nullmailer pid 2288191 invoked by uid 1000);
        Wed, 12 Oct 2022 16:26:48 -0000
Date:   Wed, 12 Oct 2022 11:26:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: pinctrl: qcom,msm8998: convert to
 dtschema
Message-ID: <166559200836.2288141.12801068494845831235.robh@kernel.org>
References: <20221012151416.38645-1-krzysztof.kozlowski@linaro.org>
 <20221012151416.38645-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012151416.38645-4-krzysztof.kozlowski@linaro.org>
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

On Wed, 12 Oct 2022 11:14:16 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8998 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct bindings description.
> ---
>  .../bindings/pinctrl/qcom,msm8998-pinctrl.txt | 202 ------------------
>  .../pinctrl/qcom,msm8998-pinctrl.yaml         | 176 +++++++++++++++
>  2 files changed, 176 insertions(+), 202 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

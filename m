Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E0620029
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKGVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKGVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:03:45 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0363820186;
        Mon,  7 Nov 2022 13:03:39 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id n205so2441281oib.1;
        Mon, 07 Nov 2022 13:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4c8dBP5xaSdrw9MUp90c5F2l4qFLSsfK0HtqDfUuO0=;
        b=Q03Cg34g0ZJk0yLdmsYDWaV0/2jPu3Z5+oX5ObKqqHv5aMJ6Cg2cLXbWdoq+QMQQH0
         oHabOagPOpAWtp72fjwDSIie3iccL2MnHlVdtotDy26PYE1u+W1vPFV2rOtpvmIVcow7
         +wPYU+dpfSF56T3Zf+z+299Y08GdQh+xtmXTJU5CNZXmYiPe6sLpELiTSMpW8Wv2ZmoI
         ZdcpotcY8Gk0Q4ohLGBBJtivD4tggx430vN0aklYdUIiX+LnyUwezECMhWgr4jARg0hC
         xSkPbrQtabJVeCSGQHAETKiZbxr1000gYzYOlTCcGux48nXPe1Lvc5XmeSxcy0unIfrl
         KXgQ==
X-Gm-Message-State: ACrzQf0BF+xlybfNQB/bwXfdsshyZCbCQi/qZxJgZ3gPs514GwiWwj7a
        77dmORyn1YMHxRXPF787Tw==
X-Google-Smtp-Source: AMsMyM5raPFgmBTtqQVWp4dbwGeTcXxlrBl7Q6X/fuddnH+OzqVKY47O2ut4bqfjD88AKrdLS3go6g==
X-Received: by 2002:a05:6808:200c:b0:35a:3220:f25f with SMTP id q12-20020a056808200c00b0035a3220f25fmr18610607oiw.266.1667855018548;
        Mon, 07 Nov 2022 13:03:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l12-20020aca190c000000b0035a2f3e423esm2240749oii.32.2022.11.07.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:03:38 -0800 (PST)
Received: (nullmailer pid 1624482 invoked by uid 1000);
        Mon, 07 Nov 2022 21:03:40 -0000
Date:   Mon, 7 Nov 2022 15:03:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,qcs404: convert to
 dtschema
Message-ID: <20221107210339.GA1621758-robh@kernel.org>
References: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
 <20221104161131.57719-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104161131.57719-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:11:31PM -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm QCS404 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> Changes during conversion: add sdc1_rclk pins (used in qcs404-evb.dtsi).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  | 199 ------------------
>  .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml | 176 ++++++++++++++++
>  2 files changed, 176 insertions(+), 199 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml


> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
> new file mode 100644
> index 000000000000..3d314458bf84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,qcs404-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SCS404 TLMM pin controller

SCS?

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

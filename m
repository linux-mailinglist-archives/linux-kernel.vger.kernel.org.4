Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC006016D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJQTBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJQTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:01:30 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF4E75CE9;
        Mon, 17 Oct 2022 12:01:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j188so13170118oih.4;
        Mon, 17 Oct 2022 12:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ya5zQpirRV5VCRWYgpeGtu1wg4yHdKjk73OV+sKS9k=;
        b=uperkPoUb75n6jgxVp8oQhP3XytA03h1Nc2wLxTjLG1OVR0pBRCUzq9CTPW31DTqI8
         2AR33vTBOHPv5IfHOAmnIV82bplCEJLuP7wkNQcNBSbz7AyvhPU2TG+aUFMvVCJwEOAw
         UZppRAyaLu9uXyW0CQWGDeOomMEcqzOgYd3IteCkmlH/yN4teP+rSwhwOFhONCOSlDfI
         kSW4KxxVAKH80Vd/5Z5bEAMI0p+qXTiq2vBpIKO3z3QeO35oZzUG0Y6lQVmr0wHwTrcO
         /n0sE10UYAjFbbAVqMPrz8BOYrtQy1G8bZKIJZ2ja3esE6t0m+JN9fIbGBMubaxiGhs8
         oWug==
X-Gm-Message-State: ACrzQf1FWuvANFsrmfneGEHs4Z3KiJ2cEVSchYWAnTYU+jpIFbTlWYNU
        DxsMeXi6RWkz7smj8aOAlg==
X-Google-Smtp-Source: AMsMyM4Aayqqo2DYURBYBzD94O+UlrAb3dm5pzADmv5cziN28DNd+CgXomsJGHtq631vJSS8FzfT8A==
X-Received: by 2002:a05:6808:159b:b0:354:5def:1593 with SMTP id t27-20020a056808159b00b003545def1593mr5611896oiw.140.1666033286499;
        Mon, 17 Oct 2022 12:01:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj21-20020a056808199500b0035485b54caesm4703971oib.28.2022.10.17.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:01:26 -0700 (PDT)
Received: (nullmailer pid 2283860 invoked by uid 1000);
        Mon, 17 Oct 2022 19:01:26 -0000
Date:   Mon, 17 Oct 2022 14:01:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Message-ID: <20221017190126.GA2281409-robh@kernel.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v3-6-531da552c354@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-6-531da552c354@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:45:31AM +0200, Neil Armstrong wrote:
> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/input/qcom,pm8921-pwrkey.yaml         | 75 ++++++++++++++++++++++
>  .../bindings/input/qcom,pm8xxx-pwrkey.txt          | 46 -------------
>  2 files changed, 75 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
> new file mode 100644
> index 000000000000..9591f77aa22a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/qcom,pm8921-pwrkey.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PM8921 PMIC Power Key
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +allOf:
> +  - $ref: input.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - qcom,pm8921-pwrkey
> +          - qcom,pm8058-pwrkey
> +      - items:
> +          - enum:
> +              - qcom,pm8018-pwrkey
> +          - const: qcom,pm8921-pwrkey
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: key release
> +      - description: key press
> +
> +  debounce:
> +    description: |
> +          Time in microseconds that key must be pressed or
> +          released for state change interrupt to trigger.

Don't need '|' and use standard indentation of 2 chars.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  pull-up:
> +    description: |
> +           Presence of this property indicates that the KPDPWR_N
> +           pin should be configured for pull up.

Ditto.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

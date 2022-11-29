Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981F263C7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiK2TMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiK2TLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:11:49 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E35F84C;
        Tue, 29 Nov 2022 11:11:34 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-14263779059so18256584fac.1;
        Tue, 29 Nov 2022 11:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FmgBikZGbFm8f6dDa0H9dHuuET0xAXNxgKTk781FK/4=;
        b=UwPj9FCLS5lllHJoU4UFnyxNU/LYl7rjQYyZlehI9mY4zLyfLVbEUhzOgVoTtDsjGW
         5jgJLjyAc1se8QJ91QC8rD924/wJNfeCxZsm1F7LdtmbOGIW+T0ZsO082BVhm92OUY1N
         U7D3nLcWZ6BeldLN++3Ya+xBIqQvnPJ2vSCe44rz/hJNQbIvFzgu+Ni9GlbbpAUN9GPk
         F5VIuwTz/XnXa5LGN990WiCTUtnvWBfn6PF0NOtPNnqzzhQzIGECcX7uLgJuRBJSc7vh
         Im1+Q9yfg7SHQ29y3MMdwHlwGqkOHWP9EyGQFIGnlnAzT4kOVRJ8ReLXj+neoi/JLjno
         HJ1w==
X-Gm-Message-State: ANoB5pn9Q9JJsIOcAxkaNnPp9MZtqylX6KoKIEF9C2LhNgWz45tGJKbn
        rbsvpWzaAL8HFow2qadukG3xRHNq9w==
X-Google-Smtp-Source: AA0mqf4O1ThZbVD9U3ASMqU0DZ+p03+QtOgZXMviTG7yS3K/RVmFOW1Z6h4HtbEcJNRF3mAtAyaSKA==
X-Received: by 2002:a05:6871:458c:b0:13b:a02f:659e with SMTP id nl12-20020a056871458c00b0013ba02f659emr34931094oab.43.1669749094107;
        Tue, 29 Nov 2022 11:11:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s13-20020a0568302a8d00b00661c0747545sm6403006otu.44.2022.11.29.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:11:33 -0800 (PST)
Received: (nullmailer pid 1871 invoked by uid 1000);
        Tue, 29 Nov 2022 19:11:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221129131203.2197959-2-abel.vesa@linaro.org>
References: <20221129131203.2197959-1-abel.vesa@linaro.org>
 <20221129131203.2197959-2-abel.vesa@linaro.org>
Message-Id: <166974899800.4190554.15519002006398183220.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Tue, 29 Nov 2022 13:11:32 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 15:12:02 +0200, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v2:
>  * Added Neil and I as maintainers in the binding doc, as Krzysztof
>    suggested
>  * Added top-level reg property witg maxItem 1
>  * Fixed the if clause for reg property, like Krzysztof suggested
>  * Added top-level clocks, along with dedicated if clause for clocks
>    property for required/false, like Krzysztof suggested
>  * Kept only clk_virt and aggre1 examples and dropped the rest
>  * Renamed both header and bindings like the compatible
>  * Squashed the bindings schema patch in the one with the header
> 
>  .../interconnect/qcom,sm8550-rpmh.yaml        | 139 +++++++++++++
>  .../interconnect/qcom,sm8550-rpmh.h           | 190 ++++++++++++++++++
>  2 files changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,sm8550-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,sm8550-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129131203.2197959-2-abel.vesa@linaro.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.


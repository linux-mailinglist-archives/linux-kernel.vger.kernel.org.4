Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1436B57F1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCKDBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCKDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:01:34 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBB61151FE;
        Fri, 10 Mar 2023 19:01:32 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id q15so5706486oiw.11;
        Fri, 10 Mar 2023 19:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678503692;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jri5ZvkoWbBWkg71oC+C3ySgZH0mJY2mtT63zB523BU=;
        b=xAvnFn4bTp3vYM+Dm6p5PYKj9zgEn5CbhZIHJe+Kri3gjHyuFR0EMWO/xkBkgNCEt4
         MZZDHxJobgd5Ytg3QFcyeFzM2ucLUznnxkX0Q7E0LZHWQheQsddDBdm7GHR88w0Jq1Jm
         oopyBevQYDDjqSpRfo83iQrs/l1fbYsKC9wmnbNpmwwase/2pYXSpv7qhF6S36mrEOQO
         ZEhJSoDrtYPz3kAbi2wxKiCA0/NHlLBeUkVojeEioDKA03xJc/n4RcpAeSsXduT0J3fB
         yHUIJqmCBG4LTXP9CON75w8HTspodAyBPlEbWQlCMEDNTTpUNIOm9kPa0DLHVKMXP9bB
         s/1g==
X-Gm-Message-State: AO0yUKXqqhVhbb9fs8mclJXpig8lq09vJTnYlsP4n/5R/Ooht0XZz2JV
        1VdnrLxP7Im/UBtucSxbIHewQ2WcLA==
X-Google-Smtp-Source: AK7set8+xv9h4sfYsRTKQE9mJcnl7FoECf5iRh9ipFWm3yGJ8ofnQ/7n2tG/CKcLSjV5vlwe8Mgofw==
X-Received: by 2002:a05:6808:2805:b0:384:3a60:e2de with SMTP id et5-20020a056808280500b003843a60e2demr12638232oib.29.1678503692015;
        Fri, 10 Mar 2023 19:01:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z17-20020a056808049100b0038478923768sm608257oid.3.2023.03.10.19.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 19:01:31 -0800 (PST)
Received: (nullmailer pid 3263027 invoked by uid 1000);
        Sat, 11 Mar 2023 03:01:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230311-topic-msg_ram-v1-1-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
 <20230311-topic-msg_ram-v1-1-e9c2094daf09@linaro.org>
Message-Id: <167850338434.3256356.12674736316044440757.robh@kernel.org>
Subject: Re: [PATCH RFC 01/15] dt-bindings: mfd: Split out Qcom RPM MSG RAM
Date:   Fri, 10 Mar 2023 21:01:27 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Mar 2023 02:21:31 +0100, Konrad Dybcio wrote:
> The RPM Message RAM is a part of the RPM low-power core's RAM that's a
> MMIO-mapped region from the main ARM CPUs' POV. It contains sleep stats
> divided per "RPM master" (ARM cluster, *DSP, ...), an interrupt controller
> (MPM) that's vital in the low-power mode entry/exit sequence, as it
> signals the readiness to enter sleep, replays the interrupts after a total
> power collapse recovery and is able to receive external interrupts from
> other IPs (like the PMIC, TSENS and USB) on the SoC to initiate a wakeup
> sequence.
> 
> On top of that, it contains some regions that are (ab)used by SMEM (by
> design!), but we're not completely sure what ranges are r/w to/from.
> This would probably need to be determined on a SoC-by-SoC - or even worse
> - firmware-by-firmware basis, but since this region is quite "wild west"
> by design (it may be accessed and altered in one form or another by all of
> the subsystems at the same time) this shouldn't really worry us..
> 
> Split out the bindings and re-model it as a simple-mfd to allow for better
> representation of the partitions within and allow child devices (MPM,
> master sleep stats - coming soon).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml  | 82 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/sram/sram.yaml   |  2 -
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,smem.example.dtb: sram@fc428000: compatible: ['qcom,rpm-msg-ram'] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.example.dtb: sram@45f0000: interrupt-controller@1b8: 'oneOf' conditional failed, one must be fixed:
	'#power-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,rpm-msg-ram.example.dtb: interrupt-controller@1b8: '#power-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230311-topic-msg_ram-v1-1-e9c2094daf09@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


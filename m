Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6605368D799
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBGNB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjBGNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:01:07 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406D39B8B;
        Tue,  7 Feb 2023 05:00:28 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id r34-20020a05683044a200b0068d4a8a8d2dso4135414otv.12;
        Tue, 07 Feb 2023 05:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ium/4IrRsQ+k51z0fDzl0DiGIY9oKjxvrSc3Z2yZ6vU=;
        b=OXk+TPLfalbxityzGEMXxwy2UqzZiRsEBFHmgxk/K0n+aEv3AMcxqoGsZoIH049iLF
         4Akz1+txCUFQhccZvINDTHcheJ1yrzTezcMNUi1UNWaTgaUYoQZCct7eIN5qPTirYYoQ
         4ZriJ9GTNu1P5QEKCaLFLO7jzBnHRghnzL8v/LjqdICxNS8a65f79jBb8vw64sDF6qYY
         GEsh4Jcj0mPCxLBXUZTod6hGwtMez6Nqe6BvHS8v0wOo1CKC6FKPi8QFIaCHmWLmL0w4
         QNQvQBE+ttLW7bs8uWwHrh5n8mKIKF90VxyE9hO2iX9n0ADUwLcs5g4a4mkJh6mTmem3
         Okkw==
X-Gm-Message-State: AO0yUKUrKZ/HaWg+hP1eu/tQpu+GvIqwL3SIN/FOt36z2TXOS3TghXtJ
        KkTa/PHu8Kfm4sJvgGt/rQpzIK+cDA==
X-Google-Smtp-Source: AK7set9Voa0znJ6rIxJzug0AagTM9zQ35ONNyQ4dz2EhC9yj1CDlYyczSrfaLArtFj/3ZM5bvTmtWw==
X-Received: by 2002:a05:6830:d19:b0:68d:972c:478d with SMTP id bu25-20020a0568300d1900b0068d972c478dmr2146993otb.16.1675774827878;
        Tue, 07 Feb 2023 05:00:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id do20-20020a0568300e1400b0068bce6239a3sm2395029otb.38.2023.02.07.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:00:27 -0800 (PST)
Received: (nullmailer pid 3216441 invoked by uid 1000);
        Tue, 07 Feb 2023 13:00:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
 <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
Message-Id: <167577470912.3213891.8305591559369987935.robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: remoteproc: qcom,glink-rpm-edge:
 convert to DT schema
Date:   Tue, 07 Feb 2023 07:00:23 -0600
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


On Tue, 07 Feb 2023 10:08:51 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
> remoteproc as it better suits the purpose - communication channel with
> remote processor.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../remoteproc/qcom,glink-rpm-edge.yaml       | 92 ++++++++++++++++++
>  .../bindings/soc/qcom/qcom,glink.txt          | 94 -------------------
>  2 files changed, 92 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.example.dtb: rpm-glink: 'mbox-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230207090852.28421-4-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


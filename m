Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0776AE065
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCGNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCGNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:25:10 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCB4FF29;
        Tue,  7 Mar 2023 05:24:16 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id bo10so8820123qvb.12;
        Tue, 07 Mar 2023 05:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195389;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TT73HblYmd4Cl4RzJ3aLhTvQ1j8Ia1btumyzgFq19Y=;
        b=V3HWr3aIyYa1FrffZHuIQqO6HI9H+uoxHc+GK1zC0LyAltdDwj+Rs3Zk2chfhnxduw
         Wtuq2FMytRBjj36qY7RbOoQA1poEEZk3nkkKJ5J5Mrslf/d+JN1AlL7wJHJzm7IHMbrl
         uKn4H+OlNgHkGwTaqB9HMa1jjs4ohn/dx0t5qurRaN+VZxKRT+a+5WIF/7Vi3QCXagQl
         4GO0uoNFeZmYUpQM1EvXl9S4kmFfZsMCJvfMF2A4hdXkRr4IIR/FHCGJQj1340vXP7jK
         NRmFLOYDuSfuass0ZgW8p0/bHTTW98Nlp2Y/cxFs+XeqeLy0bKWdYdiDG3B7igJ5RGej
         vnKw==
X-Gm-Message-State: AO0yUKV04a5hZN4SbgGJeZ+eko2pUMQt9DeFODYdT++vxRzLwFC/s4j6
        VAigACZvVP9iVqQRzwZORg==
X-Google-Smtp-Source: AK7set/cvqtiDlR5DRDzZx5jxAEYM9HCZiHq15oIGCfmGjA76NEXulbe25U0eVF8MeCYk62BbbCQJA==
X-Received: by 2002:a05:6214:410:b0:56e:98a1:fff1 with SMTP id z16-20020a056214041000b0056e98a1fff1mr25008235qvx.7.1678195389131;
        Tue, 07 Mar 2023 05:23:09 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8082:8c7f:9efe:1ea4:c2ba:e845])
        by smtp.gmail.com with ESMTPSA id t193-20020a37aaca000000b007424239e4casm9431565qke.117.2023.03.07.05.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:23:08 -0800 (PST)
Received: (nullmailer pid 4634 invoked by uid 1000);
        Tue, 07 Mar 2023 13:23:02 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     quic_sjaganat@quicinc.com, quic_gurus@quicinc.com,
        quic_gokulsri@quicinc.com, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, jassisinghbrar@gmail.com,
        konrad.dybcio@linaro.org, quic_eberman@quicinc.com,
        quic_poovendh@quicinc.com, robimarko@gmail.com,
        mturquette@baylibre.com, mathieu.poirier@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, quic_arajkuma@quicinc.com,
        sboyd@kernel.org, robh+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, loic.poulain@linaro.org,
        quic_anusha@quicinc.com, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_kathirav@quicinc.com,
        agross@kernel.org, linux-remoteproc@vger.kernel.org
In-Reply-To: <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
Message-Id: <167819522915.3831.12765243745569076133.robh@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Date:   Tue, 07 Mar 2023 07:23:02 -0600
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


On Tue, 07 Mar 2023 10:11:27 +0530, Manikanta Mylavarapu wrote:
> Add new binding document for multipd model remoteproc.
> IPQ5018, IPQ9574 follows multipd model.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dts:22:18: fatal error: dt-bindings/clock/qcom,gcc-ipq5018.h: No such file or directory
   22 |         #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


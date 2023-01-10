Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066B6637F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAJDw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:52:25 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1868FE9;
        Mon,  9 Jan 2023 19:52:24 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso6306467oto.11;
        Mon, 09 Jan 2023 19:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Den6eVQxTXWgmQYL+6Gk2EvIgXPuCXvXEt4ZGf3AJys=;
        b=eeeW1jgU9R6g28HVUHGMvrKpbnFm4pOp/oc4k1WixQDL2R3/eWcM4y8coTMyVjPfOb
         wBP6666a2NmvdQJVUTJ7lCQ/c1EtVRzFRilrNQAwZff0qpBMu7dlWsJOfPODjuuReUG5
         fszhRPPPpDa+9BMgjTEVBAnwQDlBlInE2NNpcWffHrz5s6DxLrr4koSz8EoVwYhnv7Aj
         NkMhqkLSpfCWPrs3i1WKnjgc1s1mRex1jdmZQ1bwbTgKKIpwE8GAzvXVVO2s5ot1R7y+
         2B182REKUweQyJVj4IXXZoDxsv4IrRT/r8BL1g7QGhu1LIAlTEkiDunH+BrsVnmm3PKm
         V6jA==
X-Gm-Message-State: AFqh2kpXa4vm0zB83+Lltg6oSLe1SbwtVedDEAoWwK+TUI13dlRm1rNv
        gyC5wNgpQR6SO50/53uqvIEyQsfuSg==
X-Google-Smtp-Source: AMrXdXsRMMiHDBIvv6ftgy15vU/Od0B99Vb17vvk1wdENPzm4pEPtH+MZZ4SoXh9P182kbJtokmM2A==
X-Received: by 2002:a9d:17ac:0:b0:66e:a35c:c051 with SMTP id j41-20020a9d17ac000000b0066ea35cc051mr33771762otj.35.1673322743575;
        Mon, 09 Jan 2023 19:52:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f14-20020a9d5e8e000000b006705e35c4e2sm5475603otl.35.2023.01.09.19.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 19:52:22 -0800 (PST)
Received: (nullmailer pid 785952 invoked by uid 1000);
        Tue, 10 Jan 2023 03:52:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     robh+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, konrad.dybcio@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230109193030.42764-2-danila@jiaxyga.com>
References: <20230109193030.42764-1-danila@jiaxyga.com>
 <20230109193030.42764-2-danila@jiaxyga.com>
Message-Id: <167332272486.785431.16211599391425282320.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add SM7150 GCC clock binding
Date:   Mon, 09 Jan 2023 21:52:21 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Jan 2023 22:30:29 +0300, Danila Tikhonov wrote:
> Add device tree bindings for global clock subsystem clock
> controller for Qualcomm Technology Inc's SM7150 SoCs.
> 
> Co-developed-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../bindings/clock/qcom,sm7150-gcc.yaml       |  50 +++++
>  include/dt-bindings/clock/qcom,sm7150-gcc.h   | 193 ++++++++++++++++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml:50:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.example.dtb: clock-controller@100000: '#clock-cells', '#power-domain-cells', '#reset-cells', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230109193030.42764-2-danila@jiaxyga.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


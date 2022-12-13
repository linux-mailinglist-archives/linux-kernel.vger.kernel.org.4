Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8064BA37
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiLMQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiLMQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:51:31 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EDD1580B;
        Tue, 13 Dec 2022 08:51:29 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id v62-20020a4a7c41000000b004a0a214dfbaso2459884ooc.9;
        Tue, 13 Dec 2022 08:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3ZUJv9Y+27Bs9i0rYBQ2dQ+xTle+B/Uw+LnnqewtAI=;
        b=ttrtRAfsjfnxcNpjVSvMFGfmf+TmB908iqlSNhomGlkSeIehvXrIeLjM5tPvSN30zx
         S9zI9+bfSWxCQ7tdc+apeLNdAFZMT83bV9sxgAPRcJvtho3nlqIkXehziffgJQbjInZ2
         dGrYkKINORpCTzwvSG3LNzCX6euw1eQEML1uB1f79fMfloUkBIfGDf6ICA2GZ1y0tVp8
         C5u4T+JnG06qWWCYgzbPuDLMCsIBA+SvdVe4tdXy2Whj2S8irkSYJEPOGizYNVSj+BgD
         IIzIn1pKlqlEEcuESteVxQJgITY0pSQ4rB43K4kx5vO5MLw+ZmRsR6jS9x91zgudRf2x
         SEJw==
X-Gm-Message-State: ANoB5plnxPclqT8303SODIQhnKn/3CR5MTcVXDGGjl2Qxt85RMN4vgYs
        dYkX2lC8/HI/Yqh1sS9K23IqSqDIaQ==
X-Google-Smtp-Source: AA0mqf4uxiz8zVTcATxrPc5TgQzwdrBo/FmFnmMQ4bp0twsxdG8ie2Zm4wjNl+XN7ym6jo+a7thPDg==
X-Received: by 2002:a4a:e051:0:b0:4a0:ad7a:b260 with SMTP id v17-20020a4ae051000000b004a0ad7ab260mr10406051oos.3.1670950289042;
        Tue, 13 Dec 2022 08:51:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h4-20020a4aa284000000b004a3cc18e86asm1288376ool.40.2022.12.13.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:51:28 -0800 (PST)
Received: (nullmailer pid 2037521 invoked by uid 1000);
        Tue, 13 Dec 2022 16:51:27 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, robin.murphy@arm.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, sumit.semwal@linaro.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        catalin.marinas@arm.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, regressions@leemhuis.info,
        will@kernel.org
In-Reply-To: <20221213140409.772-2-quic_sibis@quicinc.com>
References: <20221213140409.772-1-quic_sibis@quicinc.com>
 <20221213140409.772-2-quic_sibis@quicinc.com>
Message-Id: <167095022641.2035001.13548295585567513866.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: Add dt binding for QTI CPUCP
 mailbox controller
Date:   Tue, 13 Dec 2022 10:51:27 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 19:34:08 +0530, Sibi Sankar wrote:
> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
> controller.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../bindings/mailbox/qcom,cpucp-mbox.yaml          | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.example.dtb: mailbox@17400000: reg: [[0, 398458880], [0, 16], [0, 408486656], [0, 1792]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221213140409.772-2-quic_sibis@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


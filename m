Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D59673962
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjASNES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjASND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:03:28 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8561896;
        Thu, 19 Jan 2023 05:02:26 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id d6-20020a056830138600b0068585c52f86so1162736otq.4;
        Thu, 19 Jan 2023 05:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qEzWKNVhTxhmNjpAWCuBDyNcXgW4w9tcJfOj8LQ7RrY=;
        b=W5luZURTg4Ph7qywOByMMFhfDacOPzTNPuK/VtHmVKa+0JKIoA4pXqodZPlqG3wcSS
         2uZKGd73yUOnmR7IG6ccOS/VO1XmzPQzF+8HBEzQj8uMaSI8OeD4ZQ2T9bFEGgZRU2zF
         j7lHmPrBiHUbq2YvuXE3SjT04wVQ5zXWnM4jTiuzALkOI18S/aPkOCUbKUsn31WBGL6U
         kHeDPATjthuWd6gyYEXZNDyTCLvEOJoiGayUNwnzwSGVMgDZOLMzoKWeYIgAEP4vJicj
         pLYbsosqFdD9QH44YRkC5AeUYtupAIJ5dMcsYO9USMcztkOR4S3ww25ACT0HIFO++GWP
         1hTQ==
X-Gm-Message-State: AFqh2kqwsTs0ZT0qZ316av3AVJ1NMuma57qnCqqGfPfboW9W7s7+Sg6f
        mT2FfvAf67KYseOqM0juhA==
X-Google-Smtp-Source: AMrXdXuS0RwLdG32aXLQuMazq1vnSK/yWK2wwrLeyNfrY1C2VusapTqW5U+LsHMCNe53FfekOB/c4w==
X-Received: by 2002:a9d:7113:0:b0:678:2dcc:9277 with SMTP id n19-20020a9d7113000000b006782dcc9277mr5441279otj.31.1674133343855;
        Thu, 19 Jan 2023 05:02:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c4-20020a9d6c84000000b00684eaf9018csm7174270otr.34.2023.01.19.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:02:23 -0800 (PST)
Received: (nullmailer pid 1589489 invoked by uid 1000);
        Thu, 19 Jan 2023 13:02:22 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, quic_plai@quicinc.com,
        devicetree@vger.kernel.org, perex@perex.cz, bgoswami@quicinc.com,
        tiwai@suse.com, quic_rohkumar@quicinc.com, agross@kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com
In-Reply-To: <1674108674-8392-2-git-send-email-quic_srivasam@quicinc.com>
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-2-git-send-email-quic_srivasam@quicinc.com>
Message-Id: <167413318302.1585278.7105957388478984370.robh@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: qcom: dt-bindings: lpass-va-macro: Update clock name
Date:   Thu, 19 Jan 2023 07:02:22 -0600
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


On Thu, 19 Jan 2023 11:41:12 +0530, Srinivasa Rao Mandadapu wrote:
> Upadte clock name from core to macro in lpass-va-macro node
> to make it compatible with existing driver and device tree node.
> 
> Fixes: 67d99b23c881 ("ASoC: qcom: dt-bindings: add bindings for lpass va macro codec")
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.example.dtb: codec@3370000: clock-names: 'oneOf' conditional failed, one must be fixed:
	['mclk', 'core', 'dcodec'] is too long
	'macro' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.example.dtb: codec@3370000: Unevaluated properties are not allowed ('clock-names' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1674108674-8392-2-git-send-email-quic_srivasam@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


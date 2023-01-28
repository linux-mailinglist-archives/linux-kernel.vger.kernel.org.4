Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997267F892
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjA1OUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjA1OUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:20:44 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A424105;
        Sat, 28 Jan 2023 06:20:43 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso10038856fac.4;
        Sat, 28 Jan 2023 06:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1l2mLLlYbX5FcvROmBDp2G5YK69Z7RGJjObdICpK6U=;
        b=UmS7JAaMsaaOzBoPQup43DzerNiBxnVTe+8Ohbli46rziklAwUW5cgbO2H8ucYnP0w
         72wP4RY8F8FKIbYsNqWqXJmGmqkqN8E7zx1Kpe5i7p+rsKNLnaaiAQgh8GwYBcWYSWi7
         onTR6AzMcU6jTJGyjC+hB0rPgz3tkcwX+S0mCig75grhZf++UHJREj2PvsttCYOmBvY3
         qj8Kw8mbFXu2Kzd6eJ5oZ+48aU0BXr74/zY8m0RB7DuMLkSayU5Jau6B0khS3wnLQb9T
         f9YflkelF7EymagO6Ls0+HtwBHd8bJ7NIeywpUIaaiUEFjoa3LVBk5cyTxOCeG2O535X
         GzvQ==
X-Gm-Message-State: AO0yUKUY8dyvofrVg9VB9xn5yLo2pLNiqsIxSyeMZZz9F8DDchzsJbyu
        u9tvfq2nnU5FU50etO5oNQ==
X-Google-Smtp-Source: AK7set9snY+ZQB5PPhgta+nT8AEZXDh26Q1FH5AQJm9pwv4Wt6Jc8SYXcZ2lKHyDq8Xg+tmvF9HQvg==
X-Received: by 2002:a05:6870:f687:b0:160:30d2:e937 with SMTP id el7-20020a056870f68700b0016030d2e937mr10683340oab.32.1674915642187;
        Sat, 28 Jan 2023 06:20:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fr15-20020a056870f80f00b0013bc95650c8sm3102868oab.54.2023.01.28.06.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:20:41 -0800 (PST)
Received: (nullmailer pid 2366813 invoked by uid 1000);
        Sat, 28 Jan 2023 14:20:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mathieu.poirier@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
 <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
Message-Id: <167491555142.2364868.11831106421472878617.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml file
Date:   Sat, 28 Jan 2023 08:20:40 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Jan 2023 11:05:04 +0530, Bhupesh Sharma wrote:
> This documents the aDSP, cDSP and MPSS DSPs present
> on the SM6115 SoC.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm6115-pas.yaml  | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.example.dtb: remoteproc@ab00000: False schema does not allow {'compatible': ['qcom,sm6115-adsp-pas'], 'reg': [[179306496, 256]], 'clocks': [[4294967295, 0]], 'clock-names': ['xo'], 'firmware-name': ['qcom/sm6115/adsp.mdt'], 'interrupts-extended': [[4294967295, 0, 282, 1], [4294967295, 0, 1], [4294967295, 1, 1], [4294967295, 2, 1], [4294967295, 3, 1]], 'interrupt-names': ['wdog', 'fatal', 'ready', 'handover', 'stop-ack'], 'memory-region': [[4294967295]], 'power-domains': [[4294967295, 6], [4294967295, 7]], 'qcom,smem-states': [[4294967295, 0]], 'qcom,smem-state-names': ['stop'], 'glink-edge': {'interrupts': [[0, 277, 1]], 'label': ['lpass'], 'qcom,remote-pid': [[2]], 'mboxes': [[4294967295, 8]]}, '$nodename': ['remoteproc@ab00000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.example.dtb: remoteproc@ab00000: Unevaluated properties are not allowed ('glink-edge', 'qcom,smem-state-names', 'qcom,smem-states' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230128053504.2099620-2-bhupesh.sharma@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


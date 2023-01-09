Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1477662CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjAIRdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjAIRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:32:59 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5554A47E;
        Mon,  9 Jan 2023 09:32:57 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so5559832oto.5;
        Mon, 09 Jan 2023 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vt7DGUy1KFLtewCdpYO+kWiUzbW5gAuQvl+L5yBlJLE=;
        b=zRW6h1FrGcT/RtZxhetriTbBWWfyM1qn+8fc3e/53flwkssqgXZrhemknrrdBuClj7
         xJjFliZ6/68TYRQd0jdN2VeIlWKzHxb8/+9DP+LjhQH3sQn44a+XKfaLkJtAw2/gZqTO
         rzfZXsKUrG5FHbSsv9E5IM5nDAXw78jZlHJ2YNHoRtvst5gxZIh2ph5AJq3INxYK0I7a
         jmxBa1hDfBe8/EE/Pu0mK+mvuoKfNgnQHNCw3u1Quq9EdFTRZ7aW71HrmTzQWTGOeYxF
         a7/IgOEQGWkHO7MBG3toDsqETPmvFUifJk0pUfDI/XVdpP0TJ+OEujFEo3DkmOFet5b8
         Scag==
X-Gm-Message-State: AFqh2kpc66u6C6lUbQczoG7UcvwIHl9MhY+/6ZlmzObcSasuOx4d/KLz
        l2wTeJh3hVevJ7YbgBl+sA==
X-Google-Smtp-Source: AMrXdXsB5bdrYW28/WMqpdBRZNzuh/dd8EtxEGTo5RAGR3aEt6h3yJn+AQWoPreURt1SOKrddRdd/A==
X-Received: by 2002:a05:6830:612:b0:670:97e8:bb88 with SMTP id w18-20020a056830061200b0067097e8bb88mr39230591oti.28.1673285577072;
        Mon, 09 Jan 2023 09:32:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k8-20020a9d7608000000b006708a6274afsm4847417otl.25.2023.01.09.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:32:56 -0800 (PST)
Received: (nullmailer pid 1013201 invoked by uid 1000);
        Mon, 09 Jan 2023 17:32:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20230109135647.339224-2-konrad.dybcio@linaro.org>
References: <20230109135647.339224-1-konrad.dybcio@linaro.org>
 <20230109135647.339224-2-konrad.dybcio@linaro.org>
Message-Id: <167328555792.1012753.8015526796598804432.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: remoteproc: qcom,sm6375-pas: Document
 remoteprocs
Date:   Mon, 09 Jan 2023 11:32:55 -0600
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


On Mon, 09 Jan 2023 14:56:44 +0100, Konrad Dybcio wrote:
> SM6375 hosts an ADSP, CDSP and modem as remote processors. Create
> related bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v2 -> v3:
> - Separate out 6375 bindings
> 
>  .../bindings/remoteproc/qcom,sm6375-pas.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.example.dtb: remoteproc@a400000: False schema does not allow {'compatible': ['qcom,sm6375-adsp-pas'], 'reg': [[171966464, 256]], 'interrupts-extended': [[4294967295, 0, 282, 4], [4294967295, 0, 1], [4294967295, 1, 1], [4294967295, 2, 1], [4294967295, 3, 1]], 'interrupt-names': ['wdog', 'fatal', 'ready', 'handover', 'stop-ack'], 'clocks': [[4294967295, 0]], 'clock-names': ['xo'], 'power-domains': [[4294967295, 8], [4294967295, 9]], 'power-domain-names': ['lcx', 'lmx'], 'memory-region': [[4294967295]], 'qcom,smem-states': [[4294967295, 0]], 'qcom,smem-state-names': ['stop'], 'glink-edge': {'interrupts-extended': [[4294967295, 3, 0, 1]], 'mboxes': [[4294967295, 3, 0]], 'label': ['lpass'], 'qcom,remote-pid': [[2]]}, '$nodename': ['remoteproc@a400000']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.example.dtb: remoteproc@a400000: Unevaluated properties are not allowed ('glink-edge', 'memory-region', 'qcom,smem-state-names', 'qcom,smem-states' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230109135647.339224-2-konrad.dybcio@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


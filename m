Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68E6968F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBNQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBNQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:13:07 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED72C641;
        Tue, 14 Feb 2023 08:12:44 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id w24so6025877iow.13;
        Tue, 14 Feb 2023 08:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2vu6++k15JRjDVyxJeQBID+s0KpNc7BuTyubwrhgk8=;
        b=UozGMPlHJ1dBs72PULnVlL6Y9qZOVyA0ZzgSBWEKrv9ADM0REreKZ4Kts+81heHlNe
         Ug5ycxKDK2hgdbPcQR1g+iH4yLvtGzXdcX3ykWBICmZdbM8c7CHkrs+OVz5DosgBIGAw
         FSAZDDpQ9mAmR/gKadZz7C94/0juGGeD3cKuJUMLnzmIOGCd+XE25nc3IVGdHKctrJVa
         L2kfJKDq52j3PJ66wIhgxazwtSc4lbzL0aZ+AZPh9M7Yrr3VqyAX1Ci10u9F81BT8QE/
         VIVUbVVkoHeSayI7WIRl6Km3KmgYXABO+p4NWikZoMyr3v5oo+5LE5TbCT4dtk7lc10t
         ktpA==
X-Gm-Message-State: AO0yUKXAzjuzCVisfw94Go5qBZfT7L1w91rTz0t7wGFIy6EGmQASQNB6
        nolc/aXYTqS/hl5O5SUNPQ==
X-Google-Smtp-Source: AK7set/TIbQAsjZdAFRtix/0r6pkMddVS7Y1kwUPBuJ2pOziGWg/0QKgjzEYIxATQaZHiYFyGgDJxQ==
X-Received: by 2002:a5e:dc4d:0:b0:734:1c67:5d39 with SMTP id s13-20020a5edc4d000000b007341c675d39mr2071637iop.7.1676391163700;
        Tue, 14 Feb 2023 08:12:43 -0800 (PST)
Received: from robh_at_kernel.org (c-73-14-99-67.hsd1.co.comcast.net. [73.14.99.67])
        by smtp.gmail.com with ESMTPSA id z6-20020a05660217c600b007046e9e138esm5231492iox.22.2023.02.14.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:12:43 -0800 (PST)
Received: (nullmailer pid 76708 invoked by uid 1000);
        Tue, 14 Feb 2023 16:12:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
In-Reply-To: <20230213185218.166520-6-quic_molvera@quicinc.com>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-6-quic_molvera@quicinc.com>
Message-Id: <167638944280.3633.8663576140863665969.robh@kernel.org>
Subject: Re: [PATCH 5/9] dt-bindings: remoteproc: mpss: Document
 QDU1000/QRU1000 mpss devices
Date:   Tue, 14 Feb 2023 10:12:34 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 10:52:14 -0800, Melody Olvera wrote:
> This documents the compatible for the component used to boot the
> MPSS on the QDU1000 and QRU1000 SoCs.
> 
> The QDU1000 and QRU1000 mpss boot process now requires the specification
> of an RMB register space to complete the handshake needed to start or
> attach the mpss.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,qdu1000-pas.yaml | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/remoteproc/qcom,pas-common.yaml
Error: Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.example.dts:30.42-43 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230213185218.166520-6-quic_molvera@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


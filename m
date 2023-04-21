Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65D6EAEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDUQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjDUQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:09:26 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD821444A;
        Fri, 21 Apr 2023 09:09:24 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6a5f21a0604so1769468a34.2;
        Fri, 21 Apr 2023 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682093363; x=1684685363;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dy8PONCFIhkTcUEPgQ+0ISj/L7cH8cV88i3Z2JVEn8I=;
        b=dVhgD6ApEd9IGpLAGpb0LbXCEXG6Eu8QEg9tQqykI4QCfZQ4sp1xuqcg12GsxM2Aq2
         Vf18R/kjBDaeWLq1mKi3r251wdGrRXL/kumXJvL6EV3wHMe212wYdzR/wndDmoWR0Sf/
         zqOBh18t4TzfAf3vxI7uqEKihAA9eLar2W95NAOTvlgctS+XEtk08mQ7XPijJOI6p76Z
         7jISBeioWcqpwIMba7R22tz9AIG7NnL/pnr1rNom5dn+B9eX35eSP7hKuH/2LyW4Xl2I
         kIkySXyiBnNHEVnsottDG2EGCImC1eEIg59CiRQjKTeatPza0YRsgBC6zMp3n0jMkWNK
         1efw==
X-Gm-Message-State: AAQBX9f1UPTGqodCaHvFst7UM+10fMpfwi6tBL3l35onwEo6w6FFWcH3
        fxtXXU8PST9JlAM778gzrg==
X-Google-Smtp-Source: AKy350by7amp0emL+mL2CpzJ0zhDlakUU2+NGUL4HO/d07ZTE3P2I7Im/lYMDDV6YK4JiOm2Espbyw==
X-Received: by 2002:a05:6808:151:b0:38e:46ed:7738 with SMTP id h17-20020a056808015100b0038e46ed7738mr2927007oie.0.1682093363590;
        Fri, 21 Apr 2023 09:09:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a38-20020a4a98a9000000b0053a7aaa85a0sm1916335ooj.0.2023.04.21.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:09:23 -0700 (PDT)
Received: (nullmailer pid 1412184 invoked by uid 1000);
        Fri, 21 Apr 2023 16:09:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     linux-phy@lists.infradead.org, quic_arajkuma@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_kathirav@quicinc.com,
        quic_srichara@quicinc.com, linux-kernel@vger.kernel.org,
        agross@kernel.org, quic_ipkumar@quicinc.com,
        quic_anusha@quicinc.com, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        andersson@kernel.org, quic_sjaganat@quicinc.com
In-Reply-To: <20230421124150.21190-2-quic_devipriy@quicinc.com>
References: <20230421124150.21190-1-quic_devipriy@quicinc.com>
 <20230421124150.21190-2-quic_devipriy@quicinc.com>
Message-Id: <168209295793.1394458.6036002891116983900.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574
 bindings
Date:   Fri, 21 Apr 2023 11:09:21 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Apr 2023 18:11:49 +0530, Devi Priya wrote:
> Add bindings for the PCIe QMP PHYs found on IPQ9574.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V1:
> 	- Introduced a new binding for ipq9574 as suggested by Krzysztof
> 
>  .../phy/qcom,ipq9574-qmp-pcie-phy.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dts:18:18: fatal error: dt-bindings/clock/qcom,ipq9574-gcc.h: No such file or directory
   18 |         #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230421124150.21190-2-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


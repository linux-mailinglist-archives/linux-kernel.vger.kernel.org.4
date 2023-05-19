Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBD7092EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjESJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjESJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:23:08 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB2E47;
        Fri, 19 May 2023 02:23:06 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-392116ae103so1828141b6e.0;
        Fri, 19 May 2023 02:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684488186; x=1687080186;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RrRs7m1C9m+EmWKO0WMeaCgh3OJPLA5+BvKvd2/4zcI=;
        b=bWQDfChZLh/+qRczbv4WkYth3d/59Ug2xHfV0MSPr5DIOMf7pVqr9eC96bB2rXiuNO
         lV5cpjkMCDn9zGdo8FAf+c7q63sGWdpF+z9r5GXOmIVdiehp8Alk/ZVwfeBDYS4980OI
         FhPDFTMSUhJbwOXAc5epLEZtL8gC730pSjj9JGYPKAS7TdJWpaPt7vEM4I7ad2iGHCyk
         cmEefAjPU3JDrVrLlVZRQsqX76UUzkz8i/0xpPoaQ33cnWAle0SL8PMhkUdNfLNQdsIL
         64r3Gz3CKsYmmUZgOlRMO8bxMgOQRVY/wl2d49TY6F2BHdm7CNSArhmTrb0vxQpfJZC3
         Rf6Q==
X-Gm-Message-State: AC+VfDzVfUaEwsl5L32mOkuHE1JmE+8vfNhLASdunbZ7ZApNyQYFd5AB
        MH7OV9QKpZvWtraTUr0bqw==
X-Google-Smtp-Source: ACHHUZ57u3i+SSbVtqMNZMI6jUmfxGleHemSqI5RU40IgUoQx0IFUvSu7hfhjcMeFaohQaq83RSbgg==
X-Received: by 2002:a05:6808:4c4:b0:394:2868:d51f with SMTP id a4-20020a05680804c400b003942868d51fmr787182oie.4.1684488186007;
        Fri, 19 May 2023 02:23:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c24-20020aca1c18000000b00397c03854edsm837946oic.17.2023.05.19.02.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 02:23:05 -0700 (PDT)
Received: (nullmailer pid 3014366 invoked by uid 1000);
        Fri, 19 May 2023 09:23:02 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        quic_srichara@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        quic_sjaganat@quicinc.com, quic_anusha@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_ipkumar@quicinc.com,
        kishon@kernel.org, quic_arajkuma@quicinc.com, conor+dt@kernel.org,
        quic_kathirav@quicinc.com, konrad.dybcio@linaro.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        agross@kernel.org
In-Reply-To: <20230519085723.15601-2-quic_devipriy@quicinc.com>
References: <20230519085723.15601-1-quic_devipriy@quicinc.com>
 <20230519085723.15601-2-quic_devipriy@quicinc.com>
Message-Id: <168448818232.3014347.12687378726384996026.robh@kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: qcom,qmp-pcie: Add ipq9574
 bindings
Date:   Fri, 19 May 2023 04:23:02 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2023 14:27:22 +0530, Devi Priya wrote:
> Add bindings for the PCIe QMP PHYs found on IPQ9574.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Picked up the R-b tag
> 	- Did not convert the clock IDs to numerical values as the clock
> 	  header (dependent patch) is merged in latest rc1.
> 
>  .../phy/qcom,ipq9574-qmp-pcie-phy.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dts:29.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/qcom,ipq9574-qmp-pcie-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230519085723.15601-2-quic_devipriy@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


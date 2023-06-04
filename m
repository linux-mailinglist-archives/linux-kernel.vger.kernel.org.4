Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49027721552
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFDHXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFDHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:23:30 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8CDF;
        Sun,  4 Jun 2023 00:23:29 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33aa60f4094so12024045ab.1;
        Sun, 04 Jun 2023 00:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685863408; x=1688455408;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgPKCKVWGaVP4PRgO+7v9O84nNu7FFnZbyDG2O38/nk=;
        b=TEeUW7+YvLKNYJN6nNn/Ch8rU4TALPH/9HH25DuQlm72ogNRmUQuV1hLdVHSjELapf
         wpEedZnkb/jaSnCzYaymACy7PsXAVU/vEVwpqMCzkiz5NF49ZnqNVBoF/NfJZzgVqdgq
         0Ro1vxKgmnHWRXJP32XIR3ehfEO+2heJ54Rlq3XXXvYjk325oh/vU1GsPqOaZr2/ctlt
         2mv4QD7Y20ncoqtq05v2GDmo/zYyGo6daBBqL0jdKW1AgUiNWT4WwG0UO61BI77O/DKT
         wgIeCCMeO5L3B6/9y9+75G2tKZcQtD8rRa9QFxJ5MDsJWKv0Bi97BHuH42CUzz2yvBGA
         WjuQ==
X-Gm-Message-State: AC+VfDw8PvIgkURkxD1NlU3frLBrOXRpmPg7Sq1/QMWoxbK47MDs/JNZ
        zC1IFWqP+6G0zrX30PmB1Q==
X-Google-Smtp-Source: ACHHUZ5mPo1CZA0UQUsgNUIwwXRnjWLAemMxRkV8hskeXDFwOSorGRHi5TrEITG+gXvs83p52nltEA==
X-Received: by 2002:a92:2808:0:b0:331:acc9:b554 with SMTP id l8-20020a922808000000b00331acc9b554mr8701509ilf.14.1685863408372;
        Sun, 04 Jun 2023 00:23:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m13-20020a924b0d000000b003231580e8e2sm1529159ilg.6.2023.06.04.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 00:23:27 -0700 (PDT)
Received: (nullmailer pid 3052774 invoked by uid 1000);
        Sun, 04 Jun 2023 07:23:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, Olof Johansson <olof@lixom.net>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20230604063032.365775-3-guptarud@gmail.com>
References: <20230604063032.365775-1-guptarud@gmail.com>
 <20230604063032.365775-3-guptarud@gmail.com>
Message-Id: <168586340547.3052749.2763112173580157119.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add
 compatible
Date:   Sun, 04 Jun 2023 01:23:25 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 04 Jun 2023 02:30:19 -0400, Rudraksha Gupta wrote:
> Adds qcom,usb-hs-phy-msm8960 compatible
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.example.dtb: phy: resets: [[4294967295, 10], [1, 0]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.example.dtb: phy: reset-names:0: 'por' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.example.dtb: phy: reset-names: ['phy', 'por'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230604063032.365775-3-guptarud@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


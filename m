Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7029E6BEBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjCQOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCQOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:55:54 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE663B64E;
        Fri, 17 Mar 2023 07:55:24 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h11so2858718ild.11;
        Fri, 17 Mar 2023 07:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064923;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OPDHGlW00DcqYFQkzNIJaresadj1hOtwbNVh2L00JvM=;
        b=KDas3LZ/Ak36KmH+2QiKtJ2mINtkEyX0QBzXYNnpnwEYoUhqU4QIRguqafSLK+bkQ+
         Qg0BrKwerqJIAGmU30Z/X4qNVTsEdLiCUT9tTR6geXJuytzzY5OOC+ujlOz7GAvywBX2
         NGE2TubdKHTatvGiONvPc7eY7ZtHvBvqJJ3xVDEbmghbo2dWPUTZ8kxlkDhiIO06H+sP
         VP0tpvacA7b8LmKvjyao0ja//uA28tTkk8JJcCQw6Kei1txjiK4Og/TkF4z4MZ4o/VgF
         uNTsHKFjK9meLIUgpoSDVKUOWTj9ghy9cPDP2lGZ3l6CvPREJ393fTn/dniIqFIU03a/
         jBQw==
X-Gm-Message-State: AO0yUKUyL64MnP4e/H3Tv12rimSb1R3movn9phWefUbVBEi3uEbmVkyC
        JKz2wdPrcj6P/UHPFRKIcA==
X-Google-Smtp-Source: AK7set9W6q0fozm9+PQJIIav+dAysxpwcQm5IOKQQ3iYBxMSE62YmexVpBQ1kW/GnNTcoWWTEu4yjg==
X-Received: by 2002:a92:cf04:0:b0:31f:9b6e:2f4d with SMTP id c4-20020a92cf04000000b0031f9b6e2f4dmr139249ilo.0.1679064923724;
        Fri, 17 Mar 2023 07:55:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r15-20020a92c5af000000b00313ca4be5e1sm669187ilt.12.2023.03.17.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:55:23 -0700 (PDT)
Received: (nullmailer pid 2039511 invoked by uid 1000);
        Fri, 17 Mar 2023 14:55:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-imx@nxp.com,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, xu.yang_2@nxp.com, robh+dt@kernel.org,
        jun.li@nxp.com, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20230317123708.337286-3-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
 <20230317123708.337286-3-peng.fan@oss.nxp.com>
Message-Id: <167906278443.1989626.14584373898685842817.robh@kernel.org>
Subject: Re: [PATCH V4 2/6] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Date:   Fri, 17 Mar 2023 09:55:19 -0500
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


On Fri, 17 Mar 2023 20:37:04 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format. To fix the dtbs_check
> error, some properties were also added, such as nvidia,phy, reset-names
> ulpi; missing compatibles are added.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 412 ++++++++++++++++++
>  2 files changed, 412 insertions(+), 159 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml: properties:pinctrl-names:items: {'enum': ['default', 'host', 'device', 'idle', 'active']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230317123708.337286-3-peng.fan@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


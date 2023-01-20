Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A96748FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjATBmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjATBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:42:49 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A857241D9;
        Thu, 19 Jan 2023 17:42:48 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-15ebfdf69adso4812101fac.0;
        Thu, 19 Jan 2023 17:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=as+rQjD2NZ3DjEqEhhTfL/YL43Qzpn7OODvQ14Hgoao=;
        b=TabqGPJ0CZi/7pXLhLTdnkMBbulK/PTU2Y+AAw8TlmqkuSE26YN0Raq0hwdjOCTw8w
         14rGBSkidmeGaw6UEocsxyeunawrj74CPOFHrs0qkXmnh8/+xHX32c7KRHDqa7XBuHgG
         7JPAEnoX4AkuQfuZ7v0QmerNwctoDY79iTVDGdWHxM5r52C5zype6BhrdbfvtkJWJPj5
         BW74b7IZ8qusDanuBx5xKMYz5v0e4T2PXltI7lDtg7tkO/7bn4nKgzVWt0ofngFMXwXi
         a63QLX/lLlNIVX6cqcfBJi2XsJcEQ7U5LS9ArMuXjJVPdg4k5s0MesK/2XdurhZqYspk
         XOHQ==
X-Gm-Message-State: AFqh2kq02Qtr6PjwfNnh25CkNQXzQBSg8WkoN1cj/HauBzZk0OvBzehZ
        nA52Gs9ht+LBR9dC/iq1sw==
X-Google-Smtp-Source: AMrXdXsM9AZbNsCKYgA8AuWsupP+79dgYDwWdAfNytrMN/0DIevmyZ0n7VR7h55OmNZ593idK0tMFQ==
X-Received: by 2002:a05:6870:1690:b0:15f:c9d7:a974 with SMTP id j16-20020a056870169000b0015fc9d7a974mr144156oae.13.1674178967351;
        Thu, 19 Jan 2023 17:42:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a056870310b00b00144e6ffe9e5sm4568117oaa.47.2023.01.19.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:42:46 -0800 (PST)
Received: (nullmailer pid 3131597 invoked by uid 1000);
        Fri, 20 Jan 2023 01:42:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     robh+dt@kernel.org, alistair@popple.id.au,
        krzysztof.kozlowski+dt@linaro.org, jk@ozlabs.org,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au
In-Reply-To: <20230119174714.1486042-2-eajames@linux.ibm.com>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
 <20230119174714.1486042-2-eajames@linux.ibm.com>
Message-Id: <167417887833.3129440.15631417350339748655.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: fsi: Document the IBM I2C Responder
 virtual FSI master
Date:   Thu, 19 Jan 2023 19:42:43 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jan 2023 11:47:13 -0600, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/fsi/ibm,i2cr.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml:23:4: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)
./Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml:24:5: [warning] wrong indentation: expected 5 but found 4 (indentation)
./Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml:33:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/fsi/ibm,i2cr.example.dts'
Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml:23:4: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/fsi/ibm,i2cr.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml:23:4: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fsi/ibm,i2cr.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230119174714.1486042-2-eajames@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


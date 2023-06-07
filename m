Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F77255EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjFGHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbjFGHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:36:49 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B121BD0;
        Wed,  7 Jun 2023 00:36:08 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-777a9d7efabso136765439f.0;
        Wed, 07 Jun 2023 00:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123368; x=1688715368;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CxxcKmHOJ7DZft3fg+AhwRSmlF5DrPlySH4CvZ16EHo=;
        b=Z6fxcsi4cgJB61wsSI8Zz8R3f1YduUe9cAr1nWyj5A3C+lCV0CslsFucxcmpS0VT1Z
         /aIlnb34OicS1wUPKmmAv8GMzSgiRsFu0HqhhSj16X+ehbPOvommceH3fRvQkrahDf8Q
         MTfirbE2khI3+Q0lva4V2rWaaaNvD5ua3ChMWvtdFnZVfWv/uJReccY8Kqpq8PR+cxZg
         9tZgXkS6RcaFIHJhtutYITuB4FcGKu56+gxcRYfOTkFCreRQgmKsjXT3Y7WZAXXi2hzj
         cZ/7MxJvftD76tpOPse9rebLvfk/mht5u+OJbgWfCE5b/emJ8QLgPbyFCIanpF9yTwR8
         Fmmg==
X-Gm-Message-State: AC+VfDxJJ1Rpcwl8J/yrR6oTfkX/jS4Ece1MyNbEzmpQgf7c8/PyCXMv
        aRw8wrzhJBDx+bp2bpy3k9hJKiDnxQ==
X-Google-Smtp-Source: ACHHUZ4NB71Gg+BtpBNhZWgonasUu8NJwUn+VBfc92LTbuHxLIf62kvDu55Cj8O7ms18SZjtExuF5w==
X-Received: by 2002:a92:da83:0:b0:331:96e5:678b with SMTP id u3-20020a92da83000000b0033196e5678bmr5732462iln.23.1686123367850;
        Wed, 07 Jun 2023 00:36:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r8-20020a92ce88000000b0032a8e1ba829sm3637418ilo.16.2023.06.07.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:36:07 -0700 (PDT)
Received: (nullmailer pid 2153808 invoked by uid 1000);
        Wed, 07 Jun 2023 07:36:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     p.zabel@pengutronix.de, siva.durga.prasad.paladugu@amd.com,
        michal.simek@xilinx.com, nava.manne@xilinx.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        michal.simek@amd.com, git@amd.com
In-Reply-To: <20230607065121.2265076-2-piyush.mehta@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-2-piyush.mehta@amd.com>
Message-Id: <168612336438.2153757.6000360498539992409.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: convert the
 xlnx,zynqmp-reset.txt to yaml
Date:   Wed, 07 Jun 2023 01:36:05 -0600
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


On Wed, 07 Jun 2023 12:21:20 +0530, Piyush Mehta wrote:
> Convert the binding to DT schema format. It also updates the
> reset-controller description.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
> Note:
> The 1/2 patch introduced a warning related to the dt binding check,
> which was subsequently fixed in the 2/2 patch. This warning is a
> conversion warning due to a dependency on firmware dt binding.
> 
> Warning:
>   DTC_CHK Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb
> /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /scratch/piyushm/torvalds/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> 
> Please suggest to me, if it's fine to make a single patch instead of the
> separate patch 1/2 and 2/2.
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt      | 55 ---------------
>  .../bindings/reset/xlnx,zynqmp-reset.yaml     | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.example.dtb: zynqmp-firmware: 'reset-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230607065121.2265076-2-piyush.mehta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


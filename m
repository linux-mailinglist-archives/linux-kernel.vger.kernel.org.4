Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD16D4F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDCRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDCRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:43:23 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385B1BE4;
        Mon,  3 Apr 2023 10:43:19 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17aaa51a911so31646723fac.5;
        Mon, 03 Apr 2023 10:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543798;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfCEXsX57cKsNPyz9FIcs+msmqH1YDEBuOkXOBloeRg=;
        b=nMk6b5oFcMR39sSLb6sAK1itQ5B2LvGUAalCRXZ2v3AjCwMFJ67HFEcfL8u37ExDUq
         bMRhUW3pnBNabfubNleyv2E82uFplE7tIU5D0JQtxOwtufC1E1xG94zlbkltM9h5uxR3
         8HMq3xqh0FKrYERLFUPy+4jaLIEnwTk2/b1W0gXeeCOqguCIlqVFXFUShlHzvKdJb5NT
         iYzfW3e9LIB+L/0FB2pM5QDwJ1/2yg473ZaaSK8x9vRQVEoSWxPw4FbiCVx5uvgt2zhv
         hEHj/dI9l3ClVll5cScqJYgL3ex68uO6/RmKvfS5OcME3+IOIQGIw4HV0oymMLsDgMbf
         XGRw==
X-Gm-Message-State: AAQBX9ewzRa3qS80V4pLfxfgJYe1yF0aJZoc/rCDHwizcHXfpVJG3Vh7
        vlreeTA6qec3rilEtLCLebjRfj63PQ==
X-Google-Smtp-Source: AKy350Z5Nh2a+sZhW/OKkwgpoM3sxb1RVzAh3FhLu0s0aPGxUXzZ5Jv+jtJU/d5ztBsPQzSEZ5TGww==
X-Received: by 2002:a05:6870:808c:b0:17a:f93c:c00 with SMTP id q12-20020a056870808c00b0017af93c0c00mr106341oab.5.1680543798259;
        Mon, 03 Apr 2023 10:43:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ud9-20020a0568714bc900b001727d67f2dbsm3698973oab.40.2023.04.03.10.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:43:17 -0700 (PDT)
Received: (nullmailer pid 1138631 invoked by uid 1000);
        Mon, 03 Apr 2023 17:43:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Richard Alpe <richard@bit42.se>
Cc:     robh+dt@kernel.org, niklas.soderlund+renesas@ragnatech.se,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230403144106.2776249-1-richard@bit42.se>
References: <20230403144106.2776249-1-richard@bit42.se>
Message-Id: <168054369774.1136152.1343135724254132804.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
Date:   Mon, 03 Apr 2023 12:43:16 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 16:41:05 +0200, Richard Alpe wrote:
> Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.
> 
> Signed-off-by: Richard Alpe <richard@bit42.se>
> ---
> v3: Updates according to feedback from Krzysztof.
> 
>  .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403144106.2776249-1-richard@bit42.se

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


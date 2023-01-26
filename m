Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A667C2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjAZCyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAZCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:54:34 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC56469A;
        Wed, 25 Jan 2023 18:54:33 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id t7-20020a05683014c700b006864760b1caso373833otq.0;
        Wed, 25 Jan 2023 18:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QcPXEvT1pedH9u1w6Jhv/1gc0FF4O/dQCeQVTVS8ME=;
        b=zbYmbZAJBHoLJ/Cx1gYC0txJsN3eVyRVtScxdGfGu/WPbIQHE3b84nIZyxNjmXB7KV
         ORHA7RNxFMkQi0v5vXh9q5ckZq/ljIvXEIzds3xwMhtHIgW/MIlH9ym+EHSPCVEvnMg1
         nrY4TO2Y4jTK1IJAiDr3V2czKVZCkxufzG4SePCatbmoeEc2YV4/8N9RbrO2D5i7o/oG
         KPrCa5JcUWIMukrzZ/oqFgAXRXttn51CiFU738iXqSWOQAZv+IKQjpwkO5anXdaBWV1o
         bB3Gy4exGrD0SltiOEEN92p/jLcUu6gQNwRo02A5XW5bbrEJpYJq3oHRYUggp3wKCRZM
         2mug==
X-Gm-Message-State: AFqh2ko5axw2BHu2f35VBcVHzgkAI9ms7g2sgVUutu5KRAatS89tQYWp
        FWRcwgd0svEmGjRsIjB0kHThmhrNdg==
X-Google-Smtp-Source: AMrXdXvjBV1/2RxdzlYJsd0JJW8lxTIISk3b0T72zFoE7XSt8A8SwGrjWMs7+1eHfgQnVsPCoE15hA==
X-Received: by 2002:a9d:4b19:0:b0:66e:c78e:9ac0 with SMTP id q25-20020a9d4b19000000b0066ec78e9ac0mr15986269otf.31.1674701672508;
        Wed, 25 Jan 2023 18:54:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 8-20020a9d0108000000b00684d5bd56dbsm2872550otu.66.2023.01.25.18.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 18:54:32 -0800 (PST)
Received: (nullmailer pid 75020 invoked by uid 1000);
        Thu, 26 Jan 2023 02:54:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-trace-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        rostedt@goodmis.org, mhiramat@kernel.org, alistair@popple.id.au,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, andrew@aj.id.au,
        linux-fsi@lists.ozlabs.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230125225416.4074040-2-eajames@linux.ibm.com>
References: <20230125225416.4074040-1-eajames@linux.ibm.com>
 <20230125225416.4074040-2-eajames@linux.ibm.com>
Message-Id: <167470157981.71746.7854932259135609750.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: fsi: Document the IBM I2C Responder
 virtual FSI master
Date:   Wed, 25 Jan 2023 20:54:29 -0600
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


On Wed, 25 Jan 2023 16:54:15 -0600, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/fsi/ibm,i2cr-fsi-master.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml:32:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/fsi/ibm,i2cr-fsi-master.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230125225416.4074040-2-eajames@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


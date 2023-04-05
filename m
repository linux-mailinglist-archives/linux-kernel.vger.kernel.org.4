Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23406D7C53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjDEMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjDEMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:22:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA8740F9;
        Wed,  5 Apr 2023 05:22:42 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17ab3a48158so38218817fac.1;
        Wed, 05 Apr 2023 05:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697361;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NSfrPjlVJHzjW3uMoWhp7KM1VxwusN7shMuo2xQFo9k=;
        b=n789P3DaUbyKmiSZ/71NpOQdRrHm9w0/NHmjrbkgQCW8kL3kFq+xMlMT+C9Owz9SIM
         zxN0iOsWwKkl7+ss8vPiQjFPQhFGmVS1/JKBsSZfDeZADKtAsAh4qS+7llVa14PFX5gp
         NEfqWL68259mLaT/TIEqmt4gOoLLuO3HvRAcO0U9iZIxym+1AP2IUZLe9lD3SjzcdOtj
         amcrZjMh9wezo82idO9JeqsF9ctEVBVSjlIhSX7ZWqGNZHM1HB+gxvIf75lnjDhfIJ/G
         y58dq2BlkgjdNJNkZDibzPFyOiq8KmQImQJry7akeeCLMu5X2inKc/KToVVmgQrdwfPc
         7CjA==
X-Gm-Message-State: AAQBX9dZ5pIoB18DY8TqKwc5mMeGCxyiM9/zxx8/QA+h47ljRzH17B0B
        dRg7lZ66BTyI1cnIiU20lg==
X-Google-Smtp-Source: AKy350bxQFOfRudivyMhr/+BCbF7DH18yNjjV6tvn2ySdibKwHxp+oFHq07zqTxzwsCG2CzgtYhEhA==
X-Received: by 2002:a05:6870:4592:b0:177:84b6:95 with SMTP id y18-20020a056870459200b0017784b60095mr3931234oao.15.1680697361204;
        Wed, 05 Apr 2023 05:22:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zg22-20020a0568716b1600b0017eb6cc4609sm5761428oab.39.2023.04.05.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:22:40 -0700 (PDT)
Received: (nullmailer pid 2357971 invoked by uid 1000);
        Wed, 05 Apr 2023 12:22:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, tony@atomide.com, afd@ti.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20230405065533.3561492-2-andreas@kemnade.info>
References: <20230405065533.3561492-1-andreas@kemnade.info>
 <20230405065533.3561492-2-andreas@kemnade.info>
Message-Id: <168069726212.2356047.14984700715493369958.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Wed, 05 Apr 2023 07:22:40 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 08:55:32 +0200, Andreas Kemnade wrote:
> From: Andrew Davis <afd@ti.com>
> 
> Convert omap.txt to yaml.
> 
> CC: linux-omap@vger.kernel.org
> Signed-off-by: Andrew Davis <afd@ti.com>
> [various cleanup, adding Epson Moverio BT-200]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt     | 152 ------------------
>  .../devicetree/bindings/arm/ti/omap.yaml      | 147 +++++++++++++++++
>  2 files changed, 147 insertions(+), 152 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/omap.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/arm/ti/omap.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/arm/ti/omap.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230405065533.3561492-2-andreas@kemnade.info

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


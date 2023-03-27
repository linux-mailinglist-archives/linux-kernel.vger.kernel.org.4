Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C186CA92B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjC0PiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjC0Ph5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:37:57 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5722D5B;
        Mon, 27 Mar 2023 08:37:56 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-177b78067ffso9665701fac.7;
        Mon, 27 Mar 2023 08:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931475;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADGDzjdNZIXAPm6q2RmxWK4kknz8bMhp+eds/86H3bA=;
        b=Bvr1uet/rFFjrHTo7TSXNcNxp6MCXhzAd2ezkSTK5+WSa54E73vRLz1wcNmdXZkWsQ
         ndtXqKzEvZ0kMVZHx2XfyZL0Fd0napN/MNGkYKeoINvHyuBwM+H01YURcpw90zdRuEdS
         NyltIs7lFHjs8UqeSvI8msg1uhP4S8udZCXpjwI/W3D7yg/KMKlTlp7UGyjee3bKUZd0
         DGCjxb76uW54Q8rBSZWyBHvU1wymDz/L3v4LuAvchS1sF8Q2elzV+B51KgW8sVJz38vx
         R7xKpuW5UVDMFufkExMIlc0qg/NzhHnsfRNyLRcSzhi9saebTowDc70lWJA48vv8Q7e+
         noGA==
X-Gm-Message-State: AAQBX9fOAA6ekb5ZBB9EY/HwcLeYn47fi1nLpH/Fs3QjAttYDEdzo8lU
        ovkgwjJyex7AUDHY/8u7og==
X-Google-Smtp-Source: AK7set9WwIq3Ounl5dKyd7+1Y3eYTkTE9XR9QCvnS3mpwSoLpDoAShIdQOml7Z1rNiZy933SfnxelQ==
X-Received: by 2002:a05:6870:d24f:b0:176:52e9:e29c with SMTP id h15-20020a056870d24f00b0017652e9e29cmr7606143oac.30.1679931474956;
        Mon, 27 Mar 2023 08:37:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7381000000b006a1287ccce6sm2321244otk.31.2023.03.27.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:37:54 -0700 (PDT)
Received: (nullmailer pid 3917493 invoked by uid 1000);
        Mon, 27 Mar 2023 15:37:54 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230327130010.8342-2-okan.sahin@analog.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-2-okan.sahin@analog.com>
Message-Id: <167993107072.3909950.17662155564943326691.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
Date:   Mon, 27 Mar 2023 10:37:54 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 16:00:06 +0300, Okan Sahin wrote:
> Add ADI DS4520 devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../bindings/gpio/adi,ds4520-gpio.yaml        | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.example.dtb: /example-0/i2c0/gpio@50: failed to match any schema with compatible: ['adi,ds4520-gpio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230327130010.8342-2-okan.sahin@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


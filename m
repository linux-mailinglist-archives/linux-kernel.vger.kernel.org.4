Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A870B796
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjEVI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:28:08 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CCB6;
        Mon, 22 May 2023 01:28:07 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-19a16355c51so4133124fac.0;
        Mon, 22 May 2023 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744086; x=1687336086;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1HKBQ+akoQdCTF/i+voPCUWtqT/79Q6B4nL7xrEPqw=;
        b=TFUvpVxRi+PYNDjM+UFoJFYgAp9Om8nNMq9gMdhESOBrVHxFCRboONo0gXIN2Ai2SU
         8YKySjOcxhajTY+FqKZcB8ToFvxoPd/92vlB7+w7UpEAbQdr5vqgM0wUrk1egFR1BKyq
         AP/S7GUYPQpQ98cJAv+PC32MnjLlu3egcU1/MfSOKCBBAsSNjNxIIqthdfLudiUcolPY
         aWstTr9xb/oEP8DGi/Kxo+Q6Fv/ajqS3XF14EQyl22MBIJQTcqoBa/iQs/wsAHzu1hso
         ZnBjz7TER8Sln+lZougo9tpSykdS6+dabmty9v5az/0lvuHv8pm6TrQlls4aaepPGVPn
         0Kkg==
X-Gm-Message-State: AC+VfDwz1wexO04vZurKe+Gx5plM/qvSGyHhbzS9sinIFzN6PlX39uKY
        zhujB8NkXBe8/vQCICsQVg==
X-Google-Smtp-Source: ACHHUZ60bBEcwPBbD5uFzJBYz9S2d873YR3ZWPYkaNtRV5mF4vlNlVr8VPzjFAF+HZEQL9I+3sYvxQ==
X-Received: by 2002:a05:6870:a501:b0:17e:cb7:29a3 with SMTP id o1-20020a056870a50100b0017e0cb729a3mr5766837oal.15.1684744086150;
        Mon, 22 May 2023 01:28:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b2-20020a056870918200b0019e59515a0bsm683327oaf.33.2023.05.22.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 01:28:05 -0700 (PDT)
Received: (nullmailer pid 1935868 invoked by uid 1000);
        Mon, 22 May 2023 08:28:04 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20230522074510.16367-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.656f2a13-85bf-42a3-8490-f97f2538d8c3@emailsignatures365.codetwo.com>
 <20230522074510.16367-1-mike.looijmans@topic.nl>
Message-Id: <168474408440.1935852.10036260685386476051.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Date:   Mon, 22 May 2023 03:28:04 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 09:45:09 +0200, Mike Looijmans wrote:
> The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
> This driver resets the chip, optionally allows D+/D- lines to be
> swapped in the devicetree config, and then sends an ATTACH command to
> put the device in operational mode.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v3:
> Add minItems
> 
> Changes in v2:
> Rename to microchip,usb5807.yaml
> Remove reset-gpios description
> Add maxItems
> Add vddXX-supply properties
> 
>  .../bindings/usb/microchip,usb5807.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.example.dtb: usb-hub@2d: swap-dx-lanes: size is 32, expected 8
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb251xb.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230522074510.16367-1-mike.looijmans@topic.nl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539737255ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbjFGHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbjFGHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:36:58 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511E198B;
        Wed,  7 Jun 2023 00:36:11 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso3054375ab.3;
        Wed, 07 Jun 2023 00:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123370; x=1688715370;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PorP53NZ9OBuH3aw2aFAkvF8If4ls06sS/1bEK/BCk8=;
        b=G/9YOlcc0HFaLc176UEDFCv7U37YIeuH43wOjzp98i1fACSQ7Vq5cMFkFWsEuqxejT
         wMm6IJPj+BeJeTvgY9uTy4gf6pyoDUKtZ5tQxqlx3vRed6kKIE02i4h/yt7JkqfZHedj
         LcEG0iZO4uYQwHd0rG+iYgxxYGkjeud1jV2VtbB+GEtlM5UobsCWZonRVsPEEYBhheSw
         qaWrdy00aaV6p6sUspgVHpvWgJSYU0noFu5enyDDRSxBY/XwQzx1wD7TVGaoty4F+b65
         oQgQkY55fLh3itH+rtT7/w8gBRd5HjwkjkIXHY42CBxrHAd2GKAhyye//jf0ZnB965op
         LXxg==
X-Gm-Message-State: AC+VfDzIxkQGpobX5gLThF27bSg0DVaefNRKGeRnwCS3ffBkKhM6p7Be
        uUfn9dEX+8gcN2bfKA3uvw==
X-Google-Smtp-Source: ACHHUZ5L07NJXZ/BXxhducN3o7Nsm5Bbi5HRxiQ4fztSX9i+LlPH4FRjFfXbx+O/OYJW7A8eOyJ5+g==
X-Received: by 2002:a6b:6502:0:b0:777:94ea:3658 with SMTP id z2-20020a6b6502000000b0077794ea3658mr6439914iob.5.1686123370448;
        Wed, 07 Jun 2023 00:36:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d9c8a000000b00704608527d1sm1780699iop.37.2023.06.07.00.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:36:09 -0700 (PDT)
Received: (nullmailer pid 2153811 invoked by uid 1000);
        Wed, 07 Jun 2023 07:36:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     git@amd.com, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        nava.manne@xilinx.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        siva.durga.prasad.paladugu@amd.com, michal.simek@amd.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <20230607065121.2265076-3-piyush.mehta@amd.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-3-piyush.mehta@amd.com>
Message-Id: <168612336540.2153788.14132885081062462478.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: firmware: add reset-controller
 property
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


On Wed, 07 Jun 2023 12:21:21 +0530, Piyush Mehta wrote:
> The reset controller is responsible for managing both device-level resets
> and individual PMC (Power Management Controller) block resets.
> 
> To facilitate this functionality reset-controller property is added to the
> firmware device tree binding.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/reset/xlnx,zynqmp-reset.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.example.dtb: versal-firmware: reset-controller: False schema does not allow {'compatible': ['xlnx,zynqmp-reset'], '#reset-cells': [[1]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.example.dtb: /example-0/versal-firmware/reset-controller: failed to match any schema with compatible: ['xlnx,zynqmp-reset']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230607065121.2265076-3-piyush.mehta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


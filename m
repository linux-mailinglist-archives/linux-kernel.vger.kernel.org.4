Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394674C772
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGISsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjGISsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:48:23 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D1BD7;
        Sun,  9 Jul 2023 11:48:22 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-76c64da0e46so114600039f.0;
        Sun, 09 Jul 2023 11:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688928501; x=1691520501;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4lQFYgNjGGLNzxqxo8Kfz9DCjN7NHsnOH60gjbOH9Y=;
        b=Ret8cRKcwV8Ahe2qGwuer6UIIoat/zmmP8DgysbDUv6QYM2SOrWITfgAOlrqDNGqM4
         yWlHOs0hdMb11NEvHuyj1CZUVS8UDaZdOTyxZ5Y9OWzN8lp7+UVe9H8wgZ/2bUwFWJcC
         9w6nRwA4s89aMhQKSeGkoIMx1dxb5vuAe6XfdzPphZ23Q5lXTewjz6IsVj+fbY5Lw/uh
         xnutHjloM5fJQ3VHfN06zKQ2oldZ6BUZSOG8tIotWfRVa6UHmqhhbwZV8Va/1iDtUQ1q
         TJgGJtrr8Z79mfL6bdEkR2SnL95t35+a+/L7QeSFNR4L9cXGRE8zQORIgCbmmJKZcAn/
         CbiQ==
X-Gm-Message-State: ABy/qLZRXLiWSvaFE0brMPCXO/zhtNzkRpwAhW7YtYR9xFgbmzDGKu9f
        lC8hUZ2s+jiF+AZUHCvQ0qhKwtMbHg==
X-Google-Smtp-Source: APBJJlHJjPkCUjzBIuH1hXcT6BFuGoJDVlNP46jln2r3iYCMqZud1rezHpYm/4xirSkmy6u7760HbA==
X-Received: by 2002:a05:6e02:5cd:b0:346:6507:db89 with SMTP id l13-20020a056e0205cd00b003466507db89mr60357ils.20.1688928501419;
        Sun, 09 Jul 2023 11:48:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h12-20020a02c72c000000b0042acf934cbasm2666490jao.72.2023.07.09.11.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 11:48:20 -0700 (PDT)
Received: (nullmailer pid 136176 invoked by uid 1000);
        Sun, 09 Jul 2023 18:48:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     nava.kishore.manne@amd.com, linux-kernel@vger.kernel.org,
        git@amd.com, wsa@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dlemoal@kernel.org, michal.simek@amd.com,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org
In-Reply-To: <20230709172542.1393828-1-piyush.mehta@amd.com>
References: <20230709172542.1393828-1-piyush.mehta@amd.com>
Message-Id: <168892849854.136160.7620779203584875736.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: add reset-controller property
Date:   Sun, 09 Jul 2023 12:48:18 -0600
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


On Sun, 09 Jul 2023 22:55:42 +0530, Piyush Mehta wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/reset/xlnx,zynqmp-reset.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.example.dtb: versal-firmware: reset-controller: False schema does not allow {'compatible': ['xlnx,zynqmp-reset'], '#reset-cells': [[1]]}
	from schema $id: http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.yaml#
Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.example.dtb: /example-0/versal-firmware/reset-controller: failed to match any schema with compatible: ['xlnx,zynqmp-reset']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230709172542.1393828-1-piyush.mehta@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


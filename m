Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5256DCE46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDJXsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJXsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:48:05 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD641715;
        Mon, 10 Apr 2023 16:48:04 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id m2so3896055oiw.0;
        Mon, 10 Apr 2023 16:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170484; x=1683762484;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sgropNRrE05ElIoWGGtnBq0l7SFJzOMXHEv8LTacl3M=;
        b=UyvG6QvB0me928bdw910Lz4RY0Kova7s44CPlo1QkqulayjNNakRp2xVMrP9/V5fXW
         n/TquraFrdkw7+kr03pgGzewjJM0bKpqbiXaqker4rev0y2rs6P52LaCO91dvFnkyq2n
         qxQwFEnbhn3lhsfF3NMv8m35vvwknLlSSshDoT80bFefIYBGUfTgWnoNvY2Gv4Njb59v
         QeZ54afxYAMcFPqd8SazHGh8+Fo4754ilO4soxBqF2a5udIwfIcfbwJNRjienvJytvpJ
         cyi8UFbff447Or/aG1mkQgnZi0MK2QhDcwDvjLb/OyWPMnXcS+Me9uNKJc/HGJvkKKyV
         dG1w==
X-Gm-Message-State: AAQBX9fL0NN5fsnmPrANMxaHsuHGkbWx+aKGlp/nt3mdpECdmhMs0j2O
        +RZ3R4kezrn1Pb/fe2i5YQl+tCxRWg==
X-Google-Smtp-Source: AKy350Z554Bj2KhLs1nDATV8HxFu1IsscAIjPptfdkTW9sY8Nzu9lo2pgr4uslFKIciMuQAqqup6gw==
X-Received: by 2002:aca:2116:0:b0:38b:de4:e3c5 with SMTP id 22-20020aca2116000000b0038b0de4e3c5mr5577453oiz.43.1681170483840;
        Mon, 10 Apr 2023 16:48:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r142-20020acaa894000000b003871471f894sm4982640oie.27.2023.04.10.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:48:03 -0700 (PDT)
Received: (nullmailer pid 1602128 invoked by uid 1000);
        Mon, 10 Apr 2023 23:48:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     dinh.nguyen@linux.intel.com
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org
In-Reply-To: <20230410153314.27127-2-dinh.nguyen@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-2-dinh.nguyen@linux.intel.com>
Message-Id: <168117031287.1592502.13206866820553188194.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: intel: add hardware monitor
 bindings for SoCFPGA
Date:   Mon, 10 Apr 2023 18:48:02 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2023 10:33:11 -0500, dinh.nguyen@linux.intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> 
> Document the hardware monitoring bindings for SoCFPGA 64-bit platforms.
> 
> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> ---
>  .../bindings/hwmon/intel,socfpga-hwmon.yaml   | 241 ++++++++++++++++++
>  1 file changed, 241 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.example.dtb: temp_volt: 'reg' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230410153314.27127-2-dinh.nguyen@linux.intel.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


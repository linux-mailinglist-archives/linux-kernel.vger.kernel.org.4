Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED896362DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiKWPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiKWPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:07:34 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30362F8;
        Wed, 23 Nov 2022 07:07:28 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id b2so13298395iof.12;
        Wed, 23 Nov 2022 07:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKe49Y1AvVr7GpCr+4nG/0/Dmt7BidrtnVkO1Lu6Igw=;
        b=KUslD+xDUE2rJwarOZGTH5H+06y9TJbbhCDQKVX5caCVeONgPS9MkxnMsupkavpdly
         4fzfgvvbtnxBo6owA0e0/4RVobMRi59RyeAIQsKhDxGWSoXe0mwgW5qdYcsBWKhFp4Er
         51nvn1RqZTvvmEIlPeRncZu0oCYBqgHqXkiFnGqD7gnBi7OU16E1F22sQmfQX9jrcLFV
         fRtXeBLNUDI83IPGWuhPkoS8ffHoY4FUCuuucgML9zAyRbJlGSHWsmmNj6VDL5dRlVBP
         4LHYU4dOLBwzM/40JAcCUa0lLGZFUrCECvuDJmffJeYpk30C1cMK2eo+SDqs4dush6JT
         /83w==
X-Gm-Message-State: ANoB5pnZoDB7JnQSNArSAh+vnfdSzCVp/lw1dpSaDimm+mkvq1sb7FLn
        ODbGd+7LV2HJ613rXWVg5g==
X-Google-Smtp-Source: AA0mqf6WbHyU80jh6PG+LSVYs/y0lHLnjypS7n9Y9eosd0RtRk164gljYbPgsreec7CEo46yAzDTyQ==
X-Received: by 2002:a05:6602:234b:b0:6db:6299:1144 with SMTP id r11-20020a056602234b00b006db62991144mr4006765iot.212.1669216047991;
        Wed, 23 Nov 2022 07:07:27 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o11-20020a0566022e0b00b006c5247c8f81sm6467667iow.48.2022.11.23.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:07:27 -0800 (PST)
Received: (nullmailer pid 2005413 invoked by uid 1000);
        Wed, 23 Nov 2022 15:07:21 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        devicetree@vger.kernel.org, x86@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        andriy.shevchenko@linux.intel.com,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>
In-Reply-To: <20221123100850.22969-2-rtanwar@maxlinear.com>
References: <20221123100850.22969-1-rtanwar@maxlinear.com>
 <20221123100850.22969-2-rtanwar@maxlinear.com>
Message-Id: <166921592754.2001958.13714917297755911303.robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: x86: apic: Convert Intel's APIC
 bindings to YAML schema
Date:   Wed, 23 Nov 2022 09:07:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 18:08:47 +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> Addditionally, add description which was missing in text file and
> add few more required standard properties which were also missing
> in text file.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../intel,ce4100-ioapic.txt                   | 26 --------
>  .../intel,ce4100-ioapic.yaml                  | 62 +++++++++++++++++++
>  .../intel,ce4100-lapic.yaml                   | 49 +++++++++++++++
>  3 files changed, 111 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.example.dtb: interrupt-controller@fec00000: '#address-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221123100850.22969-2-rtanwar@maxlinear.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16962C287
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiKPP32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKPP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:29:23 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF313F1B;
        Wed, 16 Nov 2022 07:29:22 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id q83so18829784oib.10;
        Wed, 16 Nov 2022 07:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iW/ybSGmTCskTFR64A0b0L70Ao9zf2GvBC3xQZ80pys=;
        b=wq8FczOT3fAOQGhE1N8Q0w2Dym7T2oSE5bzCvuD55znMUR+FY+7jwcqSIBaIVPIHnr
         3bTVIQoDzr1kaKLfc6KiOQ5YXnSx0VLJV6F9iJpp3V/rrO4EEOgIQSnJ95DwRaCGi8QX
         29P1Q5VuimDDakG/PE6k1E+lkPW/G9cvIilNfarutvEwd+GombCil9WLMe/O6dp2TCx/
         fHVfTx6eoqnUDCTJ8k6Y5ZhjnijRdEzSBOpn90sjFYrgM2c38KU5IGYAFPIBADQR5WZR
         Rrl17gBhSH+V72SKrg7BV5rF8Z38TsUk7Vj+yU0QSTPJsUVQAHtTjvqBhVHWDuZXnXPy
         2WqA==
X-Gm-Message-State: ANoB5pmEETVVwjV4KqZqg/0qtCwxicoXNUHUk9821X7tSPABORP7lx61
        WNuq41dREF0etyVDVVGgpQ==
X-Google-Smtp-Source: AA0mqf62YVrOxytQa+a7xX5Izc1s4Dv3ieKb4mPE1NfKggBAwx1b7iUvlvCslVVQ1IKWk+8lfEr/Yg==
X-Received: by 2002:a05:6808:23ca:b0:359:bf56:504f with SMTP id bq10-20020a05680823ca00b00359bf56504fmr1838071oib.139.1668612561657;
        Wed, 16 Nov 2022 07:29:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v4-20020acade04000000b00359ba124b07sm6127286oig.36.2022.11.16.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:29:21 -0800 (PST)
Received: (nullmailer pid 4083485 invoked by uid 1000);
        Wed, 16 Nov 2022 15:29:23 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com,
        dirk.brandewie@gmail.com, bp@alien8.de, tglx@linutronix.de,
        devicetree@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        devicetree-discuss@lists.ozlabs.org, linux-lgm-soc@maxlinear.com,
        bigeasy@linutronix.de, x86@kernel.org, mingo@redhat.com,
        sodaville@linutronix.de, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
In-Reply-To:  =?utf-8?q?=3C5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c=2E166858?=
 =?utf-8?q?9253=2Egit=2Ertanwar=40maxlinear=2Ecom=3E?=
References: <cover.1668589253.git.rtanwar@maxlinear.com>  =?utf-8?q?=3C5ba79?=
 =?utf-8?q?63fbd82a859ffd99c6d8edb4d717fce0e6c=2E1668589253=2Egit=2Ertanwar?=
 =?utf-8?q?=40maxlinear=2Ecom=3E?=
Message-Id: <166861224872.4037672.9128953354385138473.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related
 binding schemas
Date:   Wed, 16 Nov 2022 09:29:23 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2022 18:41:02 +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> 
> Also, update more info and newly introduced optional property for
> lapic to choose legacy PIC or virtual wire compatibility interrupt
> delivery mode.
> 
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../intel,ce4100-ioapic.txt                   | 26 --------
>  .../intel,ce4100-ioapic.yaml                  | 62 ++++++++++++++++++
>  .../intel,ce4100-lapic.yaml                   | 63 +++++++++++++++++++
>  3 files changed, 125 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml: properties:compatible: [{'const': 'intel,ce4100-lapic'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml: properties:compatible: [{'const': 'intel,ce4100-ioapic'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.example.dtb:0:0: /example-0/interrupt-controller@fee00000: failed to match any schema with compatible: ['intel,ce4100-lapic']
Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.example.dtb:0:0: /example-0/interrupt-controller@fec00000: failed to match any schema with compatible: ['intel,ce4100-ioapic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


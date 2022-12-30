Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6E659A89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiL3Qef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3Qec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:34:32 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B4FDF;
        Fri, 30 Dec 2022 08:34:31 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id n63so11335704iod.7;
        Fri, 30 Dec 2022 08:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p0lVTJW+o2MV1Wr+rp1DHYDL0BIjyZC98wPp6+2qLBY=;
        b=Blv0c2NOZ4OhnqrDgn0Y9E55t2meW1oNIAwnyodpAkCjIvVwngE1F1mPzDQRRAn5ze
         FXI665GGAt476RIyI2hqw00bimH3NPhAOADGBfL/dtYLeLUUsbz+9VMt46Nc0wC/0/Db
         RTkc/QSRs6pX23UgHqpH6Avi6HB2RyNaJu/mKSmH1K9IwQK54FSWeBuv6f1K5VlZR6FX
         +KVbmQGhNq1khEQxjgFg0YvvdARcRWaubw7qLQlRb+d9595cL/NiNXw3wJMeTvLnsIMH
         PWLekwBMCg6W/QKmz0JDxGeFpWJrmf2MOADDer/qeP5BKF4Ji2cQYlm5s6k5zgCVjgXU
         +TcQ==
X-Gm-Message-State: AFqh2kr4EjfKzX9luQmTnY52rq9aTKL8gv9L06WtPbihCKlZmuJh8raW
        /suBz9bB/MMHS0IVOA7WPQt2TWZCnA==
X-Google-Smtp-Source: AMrXdXtmmwEiDuX/16L//5BcoPYSJ1o3moPc/QYb+10ZKGI08/ULjxqkJC1zOa3EBVcJCs6vhnYQfg==
X-Received: by 2002:a5d:928e:0:b0:6e0:7dd:59ac with SMTP id s14-20020a5d928e000000b006e007dd59acmr22689251iom.14.1672418071006;
        Fri, 30 Dec 2022 08:34:31 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x6-20020a056602160600b006e00556dc9esm7676832iow.16.2022.12.30.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:34:30 -0800 (PST)
Received: (nullmailer pid 1935050 invoked by uid 1000);
        Fri, 30 Dec 2022 16:34:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        jh0801.jung@samsung.com, sc.suh@samsung.com,
        taehyun.cho@samsung.com, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        eomji.oh@samsung.com, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org
In-Reply-To: <1672307866-25839-4-git-send-email-dh10.jung@samsung.com>
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>        
 =?utf-8?q?=3CCGME20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a=40e?=
 =?utf-8?q?pcas2p1=2Esamsung=2Ecom=3E?=
 <1672307866-25839-4-git-send-email-dh10.jung@samsung.com>
Message-Id: <167241769120.1925686.13640146638423143826.robh@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] dt-bindings: usb: snps,dwc3: add generic-xhci as child
Date:   Fri, 30 Dec 2022 10:34:28 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 18:57:46 +0900, Daehwan Jung wrote:
> Currently, dwc3 invokes just xhci platform driver(generic-xhci) without
> DT schema even though xhci works as child of dwc3. It makes sense to add
> xhci as child of dwc3 with DT schema. It also supports to use another
> compatible in xhci platform driver.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.example.dtb: usb@4a200000: #size-cells:0:0: 0 was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1672307866-25839-4-git-send-email-dh10.jung@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


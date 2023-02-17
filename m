Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5545369B1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBQR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:29:57 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6137096B;
        Fri, 17 Feb 2023 09:29:56 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id t7-20020a4aa3c7000000b0051fdea932cfso164404ool.10;
        Fri, 17 Feb 2023 09:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cZG/lvA9tHCJNSrutCVZnf9tIcLiTCzsCmLKnb7VUI=;
        b=rJHN8bomaNFOa93TcLGgeYFF3w8A/Qvds0WqjBdEoe17i2xLzbcmGPRR0RMkEJePrJ
         6Cqr3c+XB92rsFyYzZktt1KscRCoMp4aIqXq4a8yV+vRGlWnS4oa5RwaJkZXKiR+fyNn
         KjMICPDejMFiyRGxeLBrCrqqKTX4pW16C1EGLB0Kn3lfH8of8wTrZtoWvhnF4YQrgk5k
         Lgs0pub0dLYwjPPC+RsrtVX2iLytmT7aNOnnhSyo3K2fC8rEnjGbM3Ol5ULMHbmUXqEg
         lkMViSVrCMxcMyLM5TrBPY50J6Pb19B2Yd735ZWiUedWJzTaqKKo9n7Wqof2LJ957F2r
         h9SA==
X-Gm-Message-State: AO0yUKWTX7OR6lMCq+dWOCnVb3/gw2xnCACk8DDNq2dIuEta5Z0ksn4p
        EvwccvVxVWMlCxiKydlS7R5hwauArw==
X-Google-Smtp-Source: AK7set/EdstLaLZEYSXWiHGnx7oJStKC8g4Jep5CDhUCUnquIC+8EYWRddTvrCdn4J8lqfd6zWKJOw==
X-Received: by 2002:a4a:978c:0:b0:51f:e2ab:5535 with SMTP id w12-20020a4a978c000000b0051fe2ab5535mr2565996ooi.0.1676654995544;
        Fri, 17 Feb 2023 09:29:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g19-20020a4a8953000000b00500c1100651sm2034737ooi.45.2023.02.17.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:29:55 -0800 (PST)
Received: (nullmailer pid 1221642 invoked by uid 1000);
        Fri, 17 Feb 2023 17:29:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Angelo Compagnucci <angelo@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230217161038.3130053-3-angelo@amarulasolutions.com>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
 <20230217161038.3130053-3-angelo@amarulasolutions.com>
Message-Id: <167665404021.1204417.13145202246528387672.robh@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: misc: servo-pwm: Add new bindings
 for servo-pwm
Date:   Fri, 17 Feb 2023 11:29:54 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2023 17:10:37 +0100, Angelo Compagnucci wrote:
> This binding describes the binding for controlling servo motors through
> pwm.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
> v2:
> * Converted old txt to yaml
> v3:
> * Fixed errors rised by make dt_binding_check
> 
>  .../devicetree/bindings/misc/servo-pwm.yaml   | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/misc/servo-pwm.example.dts:19.24-25.11: Warning (unit_address_vs_reg): /example-0/servo@0: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230217161038.3130053-3-angelo@amarulasolutions.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


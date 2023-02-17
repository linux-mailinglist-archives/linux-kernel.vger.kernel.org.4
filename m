Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3A69ACE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBQNr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBQNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:47:56 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C41E394;
        Fri, 17 Feb 2023 05:47:08 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id j3so272030oig.10;
        Fri, 17 Feb 2023 05:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ll8Isr+ZQ5RTN0lxyEq78i/SRcydT0DelmTMS9mE0Q0=;
        b=mf0kjSWWivbhgOgFUiixZ4W3DuB9yNCzBhPWp/nDX42ZxcOPAu4RGMNnWkHl7Azbia
         QoTM9cFy1rcB8cer7+FJulToVCAIzza+ap2ujywZlaFanFc86SrLhRdrdgE0sOQZwNVj
         QshBA9dHUPtE/+NebK2m/9g1DkKUVkDxLg0tyEyRaGW2/wtRPD/tqk8CqYNJ6skzEJst
         g0wnwF1+a38zwTnS6bDdUdobeM01njyx4VD/FEMQYMWuiMoKCl0kRjsdJqWTpHFCDO5k
         /1BcO2gQDL6K2bi8U/JRYLR8xurYqmWeX3ARRZ4b4L5FzfQ1KvIBslFJYmk5CydWlxyK
         4fTQ==
X-Gm-Message-State: AO0yUKVa1yINfRFTmB1xwxvHl9+k1UXlbs//HKDF7/LVzEjzl3ynV3O6
        p6tEi8UcVXqI229eyVDndQ==
X-Google-Smtp-Source: AK7set/7ra3cC64KBGTHRmgqZjgzQ5r/BmLrcdpf3i2v7IFIDWgBmLnbArZOiIa7rczADFQMR8z/aA==
X-Received: by 2002:a05:6808:86:b0:37f:978d:45bf with SMTP id s6-20020a056808008600b0037f978d45bfmr2247435oic.41.1676641621779;
        Fri, 17 Feb 2023 05:47:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020aca3306000000b0037adc5702d4sm1741963oiz.38.2023.02.17.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:47:01 -0800 (PST)
Received: (nullmailer pid 658534 invoked by uid 1000);
        Fri, 17 Feb 2023 13:47:00 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org
In-Reply-To: <20230217093128.8344-1-mike.looijmans@topic.nl>
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
Message-Id: <167664119704.650159.16760653306114793445.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add driver for TI ADS1100
 and ADS1000
Date:   Fri, 17 Feb 2023 07:47:00 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2023 10:31:27 +0100, Mike Looijmans wrote:
> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../bindings/iio/adc/ti,ads1100.yaml          | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1100.example.dtb: adc@49: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230217093128.8344-1-mike.looijmans@topic.nl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


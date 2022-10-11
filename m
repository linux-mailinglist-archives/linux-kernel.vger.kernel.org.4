Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEE5FAA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKBwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKBwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:52:14 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352687A75B;
        Mon, 10 Oct 2022 18:52:13 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-132af5e5543so14340299fac.8;
        Mon, 10 Oct 2022 18:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq410igO39M0BJxeIyPF6hfpJsIwNwEM8SdNrsIFsmk=;
        b=2SqVRZTxaIpvcaZOOSnFxw+TrMM+vMp/jX2EOFS1k2ANvlWgd8qxhdEgVXN7Map1w2
         ZKmlCQ23FONYdYc/lykM8ZhIpe6gNzOTQ7KA00u1+L7Fcnm644vvu8QLwFeB8AzQswCV
         meIc6P3utjWJF4Nvqud3zjHxKn6iZoAMZXIyujxp/di7uql/0mKsvUpxaOmHAZ85gAdd
         CMsnYBR6X02gWVCZRGissdkEaOY9zWSXP7f6fiJLV/N9sSh4JLnroYNDIYKmkJfg1Yts
         7KDqyXQXb5ck+CbQ7hVqBhpq6P4Gfob0NTFN5qZPRexwbU9A9uq0+mkW9nHseqJsLh4A
         v48Q==
X-Gm-Message-State: ACrzQf02a2AprC9axRQaDitFRLy2H9KODvN0taB2VQ3Kzziu+XwICPrl
        kU6EYCmIuBqgMiPYrIjB6g==
X-Google-Smtp-Source: AMsMyM4fRMe2BihsOa+5T3mi/tfE98R09b32rSZsgQe6r+HdvrMdQVa+aFGGh5w8lnw8hT+j7zFptQ==
X-Received: by 2002:a05:6870:1716:b0:135:7980:9b73 with SMTP id h22-20020a056870171600b0013579809b73mr10359763oae.99.1665453132378;
        Mon, 10 Oct 2022 18:52:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020aca6706000000b00353fe4fb4casm4934301oix.48.2022.10.10.18.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:52:11 -0700 (PDT)
Received: (nullmailer pid 1703336 invoked by uid 1000);
        Tue, 11 Oct 2022 01:52:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>
In-Reply-To: <20221010203046.3673663-3-Naresh.Solanki@9elements.com>
References: <20221010203046.3673663-1-Naresh.Solanki@9elements.com> <20221010203046.3673663-3-Naresh.Solanki@9elements.com>
Message-Id: <166545307592.1702161.8054686650835218810.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: Add binding for max6639
Date:   Mon, 10 Oct 2022 20:52:12 -0500
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

On Mon, 10 Oct 2022 22:30:45 +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Add Devicetree binding documentation for Maxim MAX6639 temperature
> monitor with PWM fan-speed controller.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/hwmon/fan-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/maxim,max6639.example.dtb: max6639@10: fan@0: False schema does not allow {'reg': [[0]], 'pulses-per-revolution': [[2]], 'max-rpm': [[4000]], 'pwm-frequency': [[25000]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/maxim,max6639.example.dtb: max6639@10: fan@1: False schema does not allow {'reg': [[1]], 'pulses-per-revolution': [[2]], 'max-rpm': [[32000]], 'pwm-frequency': [[25000]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


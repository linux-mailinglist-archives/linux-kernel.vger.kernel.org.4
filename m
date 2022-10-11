Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C224C5FAA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJKBwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJKBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:52:13 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522EB30564;
        Mon, 10 Oct 2022 18:52:12 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-132fb4fd495so14326650fac.12;
        Mon, 10 Oct 2022 18:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7j7UNwVzR+wCkPX8CqmHB9AO91wcR2v4GG/919pc7w=;
        b=me65RaZYQwyQ+fyjTcfLY7Xxd9sea3iehiOr9QJta+xpzgPoPXzqiVyaNgiNlB2uP1
         vkqgHa08qzsnNo3nzeIL2VPs3AtI7oAJ+QjCeh76RV8EndsIZXi1WikSqYQBQMv2TP9b
         HdvCoLHhHtHs24gCU/AP1B1kzN5a4zl25kUZ9RPS0juKYvZiYfp7IQaPUmSYhBGdsV6i
         ennbHN4EWGnkBQAFO4NUP+or+G1Ii9GozAUrtEFdUxqyg285ZG81OTRy8mTgZf4Zh6Io
         OwVBUzQTYJFwbTovXCXA9YldotTjPshAixfNiw/24EOFQwA0aC2jgR/4F31FjRSsGSBR
         4WPA==
X-Gm-Message-State: ACrzQf3CKewAfpe4+9yq05c5mtv2oA8gVIdL329j+Un0e/nEieL0V8ou
        ymOmSjBAfZmhgtvjxKKqiw==
X-Google-Smtp-Source: AMsMyM5lb/Csad8MM6YtoD+EDz3MSi48/SR9ljKeS9lLQsE303QL2X/yqvmjogRia+SaxxrcBSEf+g==
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id l18-20020a056870205200b0013207b22fe6mr11864394oad.98.1665453131143;
        Mon, 10 Oct 2022 18:52:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q125-20020aca4383000000b00353f41440dasm4921298oia.56.2022.10.10.18.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:52:10 -0700 (PDT)
Received: (nullmailer pid 1703333 invoked by uid 1000);
        Tue, 11 Oct 2022 01:52:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20221010203046.3673663-2-Naresh.Solanki@9elements.com>
References: <20221010203046.3673663-1-Naresh.Solanki@9elements.com> <20221010203046.3673663-2-Naresh.Solanki@9elements.com>
Message-Id: <166545307481.1702115.16827034654525066056.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Date:   Mon, 10 Oct 2022 20:52:12 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 22:30:44 +0200, Naresh Solanki wrote:
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       allOf:
>         - $ref: fan-common.yaml#
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/hwmon/fan-common.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/fan-common.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Documentation/devicetree/bindings/hwmon/fan-common.example.dtb:0:0: /example-0/i2c/fan-controller@30: failed to match any schema with compatible: ['maxim,max6639']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


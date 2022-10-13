Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94D5FD2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJMBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJMBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:50:16 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA183F0E;
        Wed, 12 Oct 2022 18:50:11 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so423079oom.1;
        Wed, 12 Oct 2022 18:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frhcxqlr4xu4fAiP6OzjXHuMjjt3FaUtEdB7oOk4NPs=;
        b=UXLgTJPeCfT2qPYLr0U7so1M0C19I0oe/GgwCOAawq5HyQlSYy0d+rgCRspqzaq9Mx
         XlvZmMA1773W0q0m6LrJl0r6zMndBAsnBEc1sSPsX3kfAi0mSGx6LOnj9/4umrkKsPEB
         KSokN9CTOwuoxo3m47biXFtesVjOsZIfrjuoUabIzEdMJqf0lBzBLa8Pg8pMhgxezrel
         wrDZJRSW7//z8GHEt1d1wrP5WWT85basQN9m/g47Oc4y+8HaI39bV7B9Ijul0PzsdNlU
         w3GBTQQ4Quo/vRUIylmxn1bhfx2ZbEwb7E7io9JrzZQXh4/AGUwgiNIsAYIflzEfRxut
         gygw==
X-Gm-Message-State: ACrzQf2CF+Lvg9U6dr74zsqbwK8wH6nRC1oEv9dQwr1/AAXPQjGNLI5+
        mNe4Qhe3nTQd3Nu8SfNsRixnhQrK8w==
X-Google-Smtp-Source: AMsMyM6UHpju3T23qh158uoMzBGLcPrhVhvbAsXzclJ7MZlEpabglzXuQGFcewlgp7OQi6ZppirEjg==
X-Received: by 2002:a4a:b806:0:b0:480:9f83:5783 with SMTP id g6-20020a4ab806000000b004809f835783mr194113oop.55.1665625809403;
        Wed, 12 Oct 2022 18:50:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o77-20020a4a2c50000000b00425678b9c4bsm1629278ooo.0.2022.10.12.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 18:50:09 -0700 (PDT)
Received: (nullmailer pid 3091989 invoked by uid 1000);
        Thu, 13 Oct 2022 01:50:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Roland Stigge <stigge@antcom.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20221012205736.1231514-3-Naresh.Solanki@9elements.com>
References: <20221012205736.1231514-1-Naresh.Solanki@9elements.com> <20221012205736.1231514-3-Naresh.Solanki@9elements.com>
Message-Id: <166562578885.3091453.640872394649622876.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: hwmon: Add binding for max6639
Date:   Wed, 12 Oct 2022 20:50:10 -0500
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

On Wed, 12 Oct 2022 22:57:35 +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Add Devicetree binding documentation for Maxim MAX6639 temperature
> monitor with PWM fan-speed controller.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/maxim,max6639.example.dts:22.29-39.13: Warning (i2c_bus_reg): /example-0/i2c/fan-controller@2e: I2C bus unit address format error, expected "10"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


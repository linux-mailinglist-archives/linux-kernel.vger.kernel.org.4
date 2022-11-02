Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27761578E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKBC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKBC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:26:46 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2262B101F;
        Tue,  1 Nov 2022 19:26:46 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id t62so7079356oib.12;
        Tue, 01 Nov 2022 19:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z7wgwmcMN0aOSvjSNMK3d1DT5tRxcKf3IKzFgi4PqZ0=;
        b=7VBxN8Dw6jg7F3r54V1zy95e0qGJvED6/qCFhg8inmSZ0xOxDWa6+h22oXu8OnOsKq
         6/8oD80cXiDpyKQr6caUAICollDFifL4RVg0fQAKmGb40J5QQVYzPJQG8NyokpZZX2t9
         BB6PAdnrI0FKBVEBtY7Xk0/TRCySaN2WnfqbwD2PvuQqly3YqclwLQu2IxWpxRp2g0qr
         OXs75WbpzjfECgmwqtB4lw5/9iCgPCIdXQkh7wQl68Afk40xx6x1yuxOlN2/W1L2A0RZ
         W7TyK7O/PWP+A9sMmuZIh75FpVjcj4CQthi1rFR176RijfSqMP+eRX4wMNVJFyoHfhcY
         7jgg==
X-Gm-Message-State: ACrzQf29H3wCioKv8G3Ev2pIL5nB7EmZM89L/3BcGbLrs/A4DHuBpaU1
        N3P4hjtV6IC1iiLkwXrAAg==
X-Google-Smtp-Source: AMsMyM66naeyVSMuS948l2kqige7YFKNS3NgC3RA6WWltBUsU1e6Wab27jahJacjUOwAGymZvQVz6w==
X-Received: by 2002:a05:6808:2391:b0:35a:2d2d:59d9 with SMTP id bp17-20020a056808239100b0035a2d2d59d9mr3150517oib.121.1667356005350;
        Tue, 01 Nov 2022 19:26:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n17-20020a05680803b100b00354978180d8sm4094920oie.22.2022.11.01.19.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:26:44 -0700 (PDT)
Received: (nullmailer pid 2640481 invoked by uid 1000);
        Wed, 02 Nov 2022 02:26:46 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-kernel@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Lee Jones <lee@kernel.org>
In-Reply-To: <20221101165344.3455723-2-Naresh.Solanki@9elements.com>
References: <20221101165344.3455723-1-Naresh.Solanki@9elements.com>
 <20221101165344.3455723-2-Naresh.Solanki@9elements.com>
Message-Id: <166735596163.2638605.204510355280686379.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Tue, 01 Nov 2022 21:26:46 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 17:53:43 +0100, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/max5970.example.dts:21.22-34.19: Warning (i2c_bus_reg): /example-0/i2c/leds: missing or empty reg property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/max5970.example.dtb: regulator@3a: 'vss2-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/max5970.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE25BB489
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIPWxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPWxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:53:38 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFABC10D;
        Fri, 16 Sep 2022 15:53:36 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12c8312131fso3974640fac.4;
        Fri, 16 Sep 2022 15:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=esVyfGwiNU/W2/oClr2x5nVN8v9wr5aFpz9yVX+8K0c=;
        b=EKq+TeQMfML7mI13Fnf/VYs3O0jZuSI7LaFKLNmTmZJ/G4HV0VkMtJK6AZntihdCxT
         5VT+kt7m5HV47H8i3xIWqr8UcIcqKpn7KklC/g61MwGZ1PHN4XseA4UBZw/XocQ0gmz1
         ubyGd5N+BVIF/7SYheaq/2sj9wiRFEdVhd07VuOxYN4uBZHqJlu0FlyyHyxyswUntjez
         Wrz0kWNULmbsigkd1AQXJFzbMCNKA7a1ZfKCLdp+xZ16E3Xm4h/cA4TMeuXzMzTQ9i7J
         SBh7/RVJ/5v3sDnap+g/ImAWLTwsWv14sOV/vupQCg5YiKIEfwAiWocx4SMX0Ej6Nbfy
         xcAg==
X-Gm-Message-State: ACgBeo0mWcB15WjX2CZs14Vj20ef4mRXLnQZ6N8ERzMKnhFXdrNrv+7F
        NQoylOwcX6k/4bvX3wdgcw==
X-Google-Smtp-Source: AA6agR7VrDPtFltWAcfvkoIjOZ/yfdPNqdtrdFc4egAI41zpVQDtSdZFGmtByi6/j6yuBBZwbLgnlg==
X-Received: by 2002:a05:6870:600e:b0:115:8100:1947 with SMTP id t14-20020a056870600e00b0011581001947mr9661734oaa.134.1663368816011;
        Fri, 16 Sep 2022 15:53:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y10-20020a056870418a00b001275f056133sm3772876oac.51.2022.09.16.15.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:53:35 -0700 (PDT)
Received: (nullmailer pid 1477693 invoked by uid 1000);
        Fri, 16 Sep 2022 22:53:34 -0000
From:   robh@kernel.org
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220916153057.601045-1-robh@kernel.org>
References: <20220916153057.601045-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: input: Convert hid-over-i2c to DT schema
Date:   Fri, 16 Sep 2022 17:53:34 -0500
Message-Id: <1663368814.848050.1477692.nullmailer@robh.at.kernel.org>
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

On Fri, 16 Sep 2022 10:30:56 -0500, Rob Herring wrote:
> Convert the hid-over-i2c binding to DT schema format. The supplies should
> probably be specific to a specific device, but it seems they are already
> in use otherwise. 'wakeup-source' is added as it was not explicitly
> documented.
> 
> There's a few warnings for undocumented properties 'vcc-supply' and
> 'reset-gpios'. Those remain as they probably should have a specific
> compatible as well.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/input/hid-over-i2c.txt           | 46 -----------
>  .../bindings/input/hid-over-i2c.yaml          | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.txt
>  create mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/hid-over-i2c.example.dts:23.13-26: Warning (reg_format): /example-0/hid@2c:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/input/hid-over-i2c.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/hid-over-i2c.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/hid-over-i2c.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/hid-over-i2c.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/hid-over-i2c.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


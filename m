Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EB686F91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBAUKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:10:13 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBFD7A4B1;
        Wed,  1 Feb 2023 12:10:12 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id o66so16715777oia.6;
        Wed, 01 Feb 2023 12:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=thv61RGE52PGRvsnVozB8FKirAqwTf3FwZG6EZOwRLI=;
        b=CWxE/LmDyagbi1vzR278n8pEDwCGsAOEJ6j4jeq0AOTsBhtB8Pgnk1+ls02s4Llg9P
         zYnycPprD931eKhrlbxrC8bsvRB8YvDoth9qURx6Vt5VnTn2GAKwe8MKtSXINIqnGsx3
         ZP6t5YFB7ibceV0tlCZAtQfMQFKELuGWajXRcBfwJl7KhNBj6kJo0LUVbLicZ7x9lwtX
         1WBaQjGUru3LYBet6jklhDYZh/BLif4ScPwOkdw9n1u8uniD+kNKQuj1e6Y1DTY8wTVp
         PpJLuydRt/IpchJka0t702f2gwJIhsiLTwH20Rn2ZFlN+dmP208+SsZN3bwis6nHrekF
         gMeg==
X-Gm-Message-State: AO0yUKVmZWY0Nt11RhkTJfnZs9BixgSicIbBVyYUEXghwa0rii9cukbf
        1Bk8nzwiWcRgfbF80j7cFg==
X-Google-Smtp-Source: AK7set9pEQ8YxfQ5+TXI2j14YoEUsCqPxiSU97fv0Dnk34onmDzBb6axbRhsy4mrUsnDj8yjYENVWg==
X-Received: by 2002:aca:1905:0:b0:36e:fe3f:a02 with SMTP id l5-20020aca1905000000b0036efe3f0a02mr1683334oii.19.1675282211365;
        Wed, 01 Feb 2023 12:10:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a05680814c800b003785a948b27sm3423288oiw.16.2023.02.01.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:10:10 -0800 (PST)
Received: (nullmailer pid 100238 invoked by uid 1000);
        Wed, 01 Feb 2023 20:10:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org
In-Reply-To: <20230201143431.863784-2-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
 <20230201143431.863784-2-frieder@fris.de>
Message-Id: <167527873911.37677.14204981120737397534.robh@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: rtc: Move RV3028 to separate binding
 file
Date:   Wed, 01 Feb 2023 14:10:10 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Feb 2023 15:34:23 +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The RV3028 driver uses properties that are not covered by the
> trivial-rtc bindings. Use custom bindings for it.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../bindings/rtc/microcrystal,rv3028.yaml     | 56 +++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>  2 files changed, 56 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/rtc/microcrystal,rv3028.example.dts:23.20-29.15: Warning (i2c_bus_reg): /example-0/i2c/rtc@51: I2C bus unit address format error, expected "52"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230201143431.863784-2-frieder@fris.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


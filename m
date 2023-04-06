Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF66D9F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbjDFSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbjDFSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:14:53 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA99273F;
        Thu,  6 Apr 2023 11:14:51 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id q27so28956279oiw.0;
        Thu, 06 Apr 2023 11:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804891; x=1683396891;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciheXCKZB+vgZz82wUWU/ASz9wUqYhZng+toBs3m01A=;
        b=cjxYxwmB+hIIrqneWl9q/8t6N59LaKjyiKb5Vz9TO6QoIsSpT1YToMKnt28nd4BjNJ
         sdjJ8PoHNz8Kgi84H+VBFKmao6Hwph+RSRHfqOYd5UWGd00jknKefqs1rR3P8kYwuQcm
         wq+6DEr5qbKDTL/usd2bUoodBy8FqF54LCTkqSSWDgKi5G9baDGp5/x7wF4OAdAzQUw3
         mqq24swXJJWt4rBIyoqvrfW3oyucOn+lic3G0YJCjSsCcwdCgCNwy1XtPOidk9B2d/Ny
         UX1Y2dd2Nv/GjsYF/b59SRsxFpnlUn4QmpQbZtMYttgeEOPXenk5W1KkQFsnudnhoJpa
         qKnQ==
X-Gm-Message-State: AAQBX9e/iwbncU+kc1AkEUB60gPrElUCQ96JzgwFWeB9OwxY76XiVtVw
        z/3RZN8Q0B90X+EtL2ZTSA==
X-Google-Smtp-Source: AKy350aEFt4zLegKYvaQUdooApbcJACcQq8zs9llpCRpnRawOQGuLML2ErFu+4/vgMloACGhrIYGXA==
X-Received: by 2002:aca:130e:0:b0:384:10b9:c627 with SMTP id e14-20020aca130e000000b0038410b9c627mr5620929oii.56.1680804889511;
        Thu, 06 Apr 2023 11:14:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s83-20020acac256000000b00383eaea5e88sm701248oif.38.2023.04.06.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:14:49 -0700 (PDT)
Received: (nullmailer pid 3681581 invoked by uid 1000);
        Thu, 06 Apr 2023 18:14:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg.Schwendimann@infineon.com,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Marek Vasut <marex@denx.de>
In-Reply-To: <20230406164331.6557-2-daniel.matyas@analog.com>
References: <20230406164331.6557-1-daniel.matyas@analog.com>
 <20230406164331.6557-2-daniel.matyas@analog.com>
Message-Id: <168080484662.3671846.16209817137563591362.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add MAX31827
Date:   Thu, 06 Apr 2023 13:14:48 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 19:43:26 +0300, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 48 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +
>  MAINTAINERS                                   |  7 +++
>  3 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/adi,max31827.yaml:48:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.example.dtb: max31827@42: 'vref-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/trivial-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230406164331.6557-2-daniel.matyas@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


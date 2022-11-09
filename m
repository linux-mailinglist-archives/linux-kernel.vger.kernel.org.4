Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A32623572
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiKIVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKIVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:09:16 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CF2EF7B;
        Wed,  9 Nov 2022 13:09:15 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id n186so20198644oih.7;
        Wed, 09 Nov 2022 13:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JK7iAPYbPLR42yscRzAFOhzDf8fswRFehByP99Ej2k=;
        b=y5SV25GR49P6R7ccN4tJXHqU+6N7aRY75TcaLmogTKb8x1a/3SRAsy0A1zw+zTaZYU
         VWJUhguj9win0bOsyrQaxkNKFFX1+MYFOwBt3Qt+6Fpx0832C9pIENxcllLjpQ6KYeFf
         HPF1rJf8q3xc95WEUnVszEXis86kqHw6uad9rF5kwuIl+DCp+XCjXX2GbixFfolQNDCh
         4d/X9goOMMWYq+fmZ6f7KX2HyFFBiV2/SCH1Qon6m/hy0sqpK4/fxn8oo+3dispND+WP
         CmfK7b8h2OiK3a5m+rrqIleF2ia2vG0ZlwAc08VtXX0Txm7HDnxsJRxOK71A+5HBOn1f
         D8JQ==
X-Gm-Message-State: ACrzQf2nY08N30WP9qxNcCIBT4j1o/ALgbzkDDdUVPeQULUvQB3tDgWN
        QhxV9psjLYOHR6FaPWeaQA/q+KiYJw==
X-Google-Smtp-Source: AMsMyM4226V1B9Bim9hiyYeb6rDAaHwH3K5mNu+jN4Zyeeyhhcguqx9bi8mkRs06U2LeKMBT4m+sHA==
X-Received: by 2002:a05:6808:f8f:b0:35a:6eed:42f with SMTP id o15-20020a0568080f8f00b0035a6eed042fmr12756467oiw.192.1668028154584;
        Wed, 09 Nov 2022 13:09:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o30-20020a056870911e00b0012779ba00fesm6657392oae.2.2022.11.09.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:09:14 -0800 (PST)
Received: (nullmailer pid 2868048 invoked by uid 1000);
        Wed, 09 Nov 2022 21:09:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linus.walleij@linaro.org,
        patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, maz@kernel.org, broonie@kernel.org,
        lee@kernel.org
In-Reply-To: <20221109165331.29332-5-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-5-rf@opensource.cirrus.com>
Message-Id: <166802788390.2833223.7991217464686925936.robh@kernel.org>
Subject: Re: [PATCH 04/12] dt-bindings: pinctrl: Add Cirrus Logic CS48L31/32/33
Date:   Wed, 09 Nov 2022 15:09:10 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Nov 2022 16:53:23 +0000, Richard Fitzgerald wrote:
> Codecs in this family have multiple digital I/O functions for audio,
> DSP subsystem, GPIO and various special functions. All muxable pins
> are selectable as either a GPIO or one of the available alternate
> functions.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/pinctrl/cirrus,cs48l32.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml:14:1: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.example.dts'
Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml:14:1: could not find expected ':'
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml:14:1: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml: Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


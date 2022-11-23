Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F96362D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbiKWPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiKWPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:07:26 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13382286DE;
        Wed, 23 Nov 2022 07:07:24 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id n188so13334363iof.8;
        Wed, 23 Nov 2022 07:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mEKRRENqRMYufrIxQe5nh4pku7YdsEXR7GLENp5qxds=;
        b=7HYCzPeRz6R67eBGjx8AK+E+VUMgd5IrFWPHPLhDVlqjIKFF0TwZq+jy1XH/YHyOFI
         /s04lzpFRnkRoEtNS87RN8G5N4hNtyrabYQhs0onSjQjkP2bcRFHmgS3W2sW2BQqRRuT
         jL1ofvoFknurGJwpKg5GpcGDsZjvfjY19wlOfCZQsZ1DEgljA+evs+T/sieyuH7IlYPI
         n99DmNd1stgEUbQy32tAbyNssioQpSQpO8A9phBN+V3yON1Kvxywia0D+a1OL759V9bS
         N1OXIXAOaIH70LeJPdqZKjTTHfIzSfOo5rCo9Nb+6PbfQ1pqqeAmWVqS1PxDPSnVksbu
         ZRJA==
X-Gm-Message-State: ANoB5pkSeGRO8yvB1kKu1MpvPzmzDflMW7JPk/qZQFODoJjSJrRwzDWE
        g7uJMn4bd/YqDR9TMdR2Lg==
X-Google-Smtp-Source: AA0mqf5WEOGwgDMNRRrW1Nl5ZZQrwr9oGk58/ul6P+DcjJ/FKrD+KR+qn5EypzZ/kztelu0r7NW1nA==
X-Received: by 2002:a5e:8302:0:b0:6de:4dce:37ef with SMTP id x2-20020a5e8302000000b006de4dce37efmr4093910iom.68.1669216043222;
        Wed, 23 Nov 2022 07:07:23 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u28-20020a02cbdc000000b003757ab96c08sm6561820jaq.67.2022.11.23.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:07:22 -0800 (PST)
Received: (nullmailer pid 2005408 invoked by uid 1000);
        Wed, 23 Nov 2022 15:07:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        lee@kernel.org, linux-doc@vger.kernel.org, jdelvare@suse.com,
        linux-pwm@vger.kernel.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, corbet@lwn.net,
        andrew@aj.id.au, joel@jms.id.au
In-Reply-To: <20221123061635.32025-2-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
Message-Id: <166921592541.2001852.8427859391374590200.robh@kernel.org>
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Date:   Wed, 23 Nov 2022 09:07:21 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 14:16:31 +0800, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: pwm-tach@1e610000: pwm: False schema does not allow {'compatible': ['aspeed,ast2600-pwm'], '#pwm-cells': [[3]], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: pwm-tach@1e610000: tach: False schema does not allow {'compatible': ['aspeed,ast2600-tach'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb:0:0: /example-0/pwm-tach@1e610000/pwm: failed to match any schema with compatible: ['aspeed,ast2600-pwm']
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb:0:0: /example-0/pwm-tach@1e610000/tach: failed to match any schema with compatible: ['aspeed,ast2600-tach']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221123061635.32025-2-billy_tsai@aspeedtech.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8C5F5EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJFCS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:18:56 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C961709;
        Wed,  5 Oct 2022 19:18:51 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so533783oom.1;
        Wed, 05 Oct 2022 19:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CjOHz9oWYcg9j871qa8fgBrgohC+V8g1MiOqW5JKL4=;
        b=QMY8LIlvroa77BX8iVZh5DWLYIL8Cnobx4LF328ZqDNpRzh6uuex6MMEwO+gCbxoT5
         2ga6zFZEdx0WaLQdbRKOsg8uwzebsJGuDRP1w27tR2Hm7WLkmVmG8oYeCZN7VtkiHTEy
         NMc8QpvduF3lZPUbJFQQmW3nHtSxrvOupzQwicdgH6rgPW3Tt+qDp8KAMjdYWM98usFY
         Iq9SBfRvUYhkvhbj/CkfLT7NYBHISrM8XoShCxNBkCZUstnb4ZPzq+0t4OStFpzmwlif
         lPxhxz2GdyOHPAbVYN6KA9+CEa2x+qA8i6ClYMzXGGWAXMSfWJGf08vkYE0T4nTvp4nX
         jggg==
X-Gm-Message-State: ACrzQf31lcwER/loxoclB9J56VmENRsjTEswV8bjfv48wY2bW1WvruHT
        fqizLyAHHB/2BZWM/5GOBg==
X-Google-Smtp-Source: AMsMyM5uVMRVN7xJ46xSsumbmxIkl0s7flg0Lvaa2E980Hm7Lu9bkz9PeuyNAu1PsdGrjbVkTVQZtA==
X-Received: by 2002:a05:6830:43ab:b0:658:2908:d909 with SMTP id s43-20020a05683043ab00b006582908d909mr924905otv.294.1665022730925;
        Wed, 05 Oct 2022 19:18:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h204-20020aca3ad5000000b0034fd36e95bfsm5104265oia.31.2022.10.05.19.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:18:50 -0700 (PDT)
Received: (nullmailer pid 565673 invoked by uid 1000);
        Thu, 06 Oct 2022 02:18:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, andersson@kernel.org, gregkh@linuxfoundation.org,
        saravanak@google.com, mani@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        hemantk@codeaurora.org, devicetree@vger.kernel.org,
        Michael.Srba@seznam.cz, robh+dt@kernel.org,
        jeffrey.l.hugo@gmail.com
In-Reply-To: <20221005145746.172138-1-m.zatovic1@gmail.com>
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
Message-Id: <166502256455.562200.10051593235085988854.robh@kernel.org>
Subject: Re: [RFCv2 PATCH 1/4] dt-bindings: bus: add Wiegand bus dt documentation
Date:   Wed, 05 Oct 2022 21:18:50 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 16:57:43 +0200, Martin Zaťovič wrote:
> This patch documents the devicetree entry for enabling Wiegand
> bus driver. The drivers that will use Wiegand bus driver shall
> create a sub-node of the documented node.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
> Hello again,
> 
> this is the second round of RFC patches in an attempt to add Wiegand
> driver to linux kernel. Thank you for all the issues you have pointed
> out in the first round. I have tried to fix all of them and I have
> also implemented a Wiegand bus driver, that is now used by the GPIO
> driver itself - as suggested by Linus.
> 
> Any advice you have for me regarding the patches will be appreciated!
> 
> With regards,
> Martin Zaťovič
> ---
>  .../devicetree/bindings/bus/wiegand.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/wiegand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/wiegand.example.dtb: wiegand: 'wiegand-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/wiegand.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/wiegand.example.dtb: wiegand: wiegand-gpio: {'compatible': ['wiegand,wiegand-gpio'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]], 'data-hi-gpios': [[4294967295, 7, 6]], 'data-lo-gpios': [[4294967295, 6, 6]]} is not of type 'array'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/gpio/gpio-consumer.yaml
Documentation/devicetree/bindings/bus/wiegand.example.dtb:0:0: /example-0/wiegand/wiegand-gpio: failed to match any schema with compatible: ['wiegand,wiegand-gpio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


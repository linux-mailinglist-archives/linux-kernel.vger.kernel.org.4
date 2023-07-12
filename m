Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E027507F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjGLMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjGLMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:16:49 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9F4173C;
        Wed, 12 Jul 2023 05:16:42 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7835e5fa459so237485539f.2;
        Wed, 12 Jul 2023 05:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164202; x=1691756202;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRfuEf8QvPMdA6+TuyHkkBUYH2h9XWzRNhgHoDqrdDk=;
        b=USBixVWepPjrRE4rMcZ73maneDArQ0YIoGi6rNAd3c7iCEOYSLxxKjuVZyJ7kGnK4b
         R3feBmisyrp0ofCPnfVnHGdUXff08tn7vjxsV/YJkWuzW/VO7zKPr3x7OUsrwCfTYa4w
         DvWN3ZmHAthnqE8Z1gTx49KqaPZnzHsrmz3ILmOoLa77MJh1anqfK7yc3F61+/u5NV+7
         RGDM9ZJc1mRrHvv/8j7kYJf36IsaAo5buU8WWjmVpRhRDJ8AI3j1YhQS15xaGHpG+sEb
         zHt0r/rSicbUz6wzojHz93XPgmJ0XqAsLDKL+gthvSOvO5NrchVG5mwzWBYkG5hpF7X7
         va3A==
X-Gm-Message-State: ABy/qLaiEwiYaBd+5gubOKMnR2BhOk6yqchFJD2FCfaWyxQHnXSqY5iL
        PqfnZrv9to6+zPlY2SojwA==
X-Google-Smtp-Source: APBJJlHq/CeB5FNhXo+hvT0Ni2TOesVAeCW0bTRMn/zJugXXm3vQ2S8xupO8XpJFxby9VWQyKB/OUQ==
X-Received: by 2002:a5d:8894:0:b0:760:e308:107e with SMTP id d20-20020a5d8894000000b00760e308107emr17856368ioo.0.1689164201781;
        Wed, 12 Jul 2023 05:16:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dm26-20020a0566023b9a00b0077a1d1029fcsm1308179iob.28.2023.07.12.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:16:41 -0700 (PDT)
Received: (nullmailer pid 4079137 invoked by uid 1000);
        Wed, 12 Jul 2023 12:16:39 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
 <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
Message-Id: <168916419973.4079096.16108131261602732302.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: gnss: u-blox: add "reset-gpios"
 binding
Date:   Wed, 12 Jul 2023 06:16:39 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2023 13:37:30 +0200, Wolfram Sang wrote:
> Needed to enable this chip on a Renesas KingFisher board. Description
> copied over from the Mediatek driver which already supports it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/gnss/u-blox,neo-6m.example.dts:23.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/gnss/u-blox,neo-6m.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230712113731.3306-3-wsa+renesas@sang-engineering.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAF67CBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjAZNVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjAZNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:21:08 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666015C8C;
        Thu, 26 Jan 2023 05:21:06 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so761238otk.13;
        Thu, 26 Jan 2023 05:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sz002uYQx7aQhD0B5gohM0NDHRbcmYnasPC9rqjmz5M=;
        b=kgEHLRQ4o0faOl1kSDSbKmg9PdGa8yrHE3grxinWpU9EYFtuoqune15nFhRUnnWGZ3
         QszEZNtieqWeB35ZBr9Dj4Jws7CfEddu+7TMsKfTBFkSWMIbBabzZZTpTo9HRsxZ+gsx
         tAnvnYXwbHNPDXLdv5MEArmm2ZT9rPZSB35DmAwPrFkKGijNL6JXVaNqCYT0tTE9q30w
         kKGlvtLRBEFw7DzWMaQk2Ur0ohQtTYX0CK7zkAEVAxVTHUEjAVpONnYO0cuSZXi0TuTY
         /l0hsDZ+yThXP8RmbBqw21xLvaRS3/i+aqPb6Pr6y26nT9VWsq4S0UEhsuEEjPhiU2GQ
         +5lg==
X-Gm-Message-State: AFqh2kqlhBxAgS2DWsz71WwYRompAez46IIlp0uSEXxZHuvQelSRgh00
        5UDdFi9FnJtYxgghJJl4Z+dgRC77uw==
X-Google-Smtp-Source: AMrXdXsLf+Rwe5Nz3iPI8O+/n6gSYE4xtLJAe7CrujKz0yCcKoK7JqtuNqV5sK3LB9AeY04h4SM5+Q==
X-Received: by 2002:a9d:62d0:0:b0:684:de61:77c9 with SMTP id z16-20020a9d62d0000000b00684de6177c9mr18270353otk.30.1674739265840;
        Thu, 26 Jan 2023 05:21:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a4ade4f000000b004fb9a65daf1sm494456oot.43.2023.01.26.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:21:05 -0800 (PST)
Received: (nullmailer pid 1204337 invoked by uid 1000);
        Thu, 26 Jan 2023 13:21:04 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manuel Traut <manuel.traut@mt.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230126091825.220646-2-manuel.traut@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
 <20230126091825.220646-2-manuel.traut@mt.com>
Message-Id: <167473911077.1198926.3684337586701842889.robh@kernel.org>
Subject: Re: [PATCH v8 1/5] dt-bindings: input: pwm-beeper: Convert txt
 bindings to yaml
Date:   Thu, 26 Jan 2023 07:21:04 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 10:18:21 +0100, Manuel Traut wrote:
> Converts txt binding to new YAML format.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/pwm-beeper.example.dtb: /example-0/amplifier: failed to match any schema with compatible: ['fixed-regulator']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230126091825.220646-2-manuel.traut@mt.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


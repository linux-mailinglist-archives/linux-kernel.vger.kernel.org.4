Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF506D4550
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjDCNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:10:32 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404010D7;
        Mon,  3 Apr 2023 06:10:32 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-17aeb49429eso30693504fac.6;
        Mon, 03 Apr 2023 06:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527431;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IrRmGeYtiu3xtbliPCyKu4FAZ3mtENLqOftnzuC5Jdw=;
        b=vnypm3OrQ2P/swy6F3zybjZKphAShHg/u4LvLTPMkoeHLx/VAfd/hl4SSB+ex/UnNM
         WM0x2g9njlC87eJe1zl1COrirQw2znRJRY9sy6/d9qqD7G1L6NN4oj5LjT0Z6kgWrTTa
         MmGoC6B0YYM9Unc4mKwm4Md45gMRGNoKy0rjY40/ag8++fYChAwpKrmBn+1ZN12e1eAY
         qmoPoqHVUx7tTwnAKoe2hDS7zFbporIFECqFrKXc6ju0bH5zM4O4b/UQtROhWV+6/Hgb
         5tXamxdJqb2hSopmgX/Ell9YJE7ve0YnnFQGCneyrJYI8pll8WAQIvx7Np6YAimBguxZ
         8IHA==
X-Gm-Message-State: AAQBX9cueeIQE28J4UBh4FnWqBbOk1aTM0uRBB70l23LxF9Ru+W+S65U
        OWf3YPMNrkP2A7gwNvPGBA==
X-Google-Smtp-Source: AKy350aZVRkmLa4wyx+gLu+VCz3ZeBf2aFA4AM7r4FJgzTTuOAhMIsfP3thR0EVcoMElNZ0YyW07mw==
X-Received: by 2002:a05:6870:1608:b0:17e:9798:6e34 with SMTP id b8-20020a056870160800b0017e97986e34mr21332218oae.32.1680527431226;
        Mon, 03 Apr 2023 06:10:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b2-20020a9d6b82000000b006a32eb9e0dfsm2059598otq.67.2023.04.03.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:30 -0700 (PDT)
Received: (nullmailer pid 522005 invoked by uid 1000);
        Mon, 03 Apr 2023 13:10:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Om Parikh <hack3r-0m@proton.me>
Cc:     linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        daniel.baluta@nxp.com
In-Reply-To: <20230403004138.326482-1-hack3r-0m@proton.me>
References: <20230403004138.326482-1-hack3r-0m@proton.me>
Message-Id: <168052512144.461913.16353516589500469297.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to
 DT schema
Date:   Mon, 03 Apr 2023 08:10:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 00:42:35 +0000, Om Parikh wrote:
> this patch replaces the txt file and adds YAML bindings file
> adhering to the json-schema for alphascale-asm9260. It is a
> demo patch for potential further contributions to the GSOC
> project.
> 
> (see: https://wiki.linuxfoundation.org/gsoc/2023-gsoc-device-tree-bindings)
> 
> Signed-off-by: Om Parikh <hack3r-0m@proton.me>
> ---
>  .../watchdog/alphascale,asm9260-wdt.yaml      | 76 +++++++++++++++++++
>  .../bindings/watchdog/alphascale-asm9260.txt  | 35 ---------
>  2 files changed, 76 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.example.dtb: /example-0/watchdog@80048000: failed to match any schema with compatible: ['alphascale,asm9260-wdt']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403004138.326482-1-hack3r-0m@proton.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


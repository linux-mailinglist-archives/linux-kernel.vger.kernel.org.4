Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68EE6524D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiLTQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLTQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:41:00 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159432180;
        Tue, 20 Dec 2022 08:41:00 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id e205so11005757oif.11;
        Tue, 20 Dec 2022 08:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0w2sRCRPvQHg3D+hGvPgtDMOkkeCDypssnO1QesCLFQ=;
        b=OHTPm6d52fwa6VNB8emM9tlCzxD+Ptw+cPfxhuD+4xWDOU9O8676pnxyJFuPRTIcuZ
         hnc+k4KdqiulBfSEWxOiobnXJdD7u81rtOAlVMgiE8G4CDsmOLHodblIT++ONnCZk1Iq
         NKjwIFkfUUJIzgeNSwvLll0wK64LUUNuMqXUC4vX+HS9hZ/R2NdhYvh8Swjf/AgywoF8
         bffc9zKP5cmOm35hdEVbjVyyGcy7TSZtYNuzBGTFMFgBRuxXd3X9aCkuCiE9SIEmMYeK
         NHsEpMf2H0I6Y/2f/I1aYIl7zD5tTiaiHuGRTkjQzxJHZ9cnnUtbvnbUgwrEoXWYW7y8
         q6Tg==
X-Gm-Message-State: AFqh2krlSWVEe2TtjIdYX29UxTtubgFyAa0SaehZB2hhRh/MhmdtcolH
        V/MXtWNS6CwtRftAnvyPbQ==
X-Google-Smtp-Source: AMrXdXvI0L4X9GlyzF5h1oF9MQgmVyU11KU3Ks5KVOj5afvnzhQIasZN3965nKoPWy46eoLjaOYQ6Q==
X-Received: by 2002:a05:6808:2799:b0:360:bc5d:2ed2 with SMTP id es25-20020a056808279900b00360bc5d2ed2mr6859804oib.53.1671554459154;
        Tue, 20 Dec 2022 08:40:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w20-20020a056830281400b0066e968701f8sm5853196otu.27.2022.12.20.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:40:58 -0800 (PST)
Received: (nullmailer pid 709600 invoked by uid 1000);
        Tue, 20 Dec 2022 16:40:56 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     axboe@kernel.dk, sunilmut@microsoft.com, jasowang@redhat.com,
        will@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rvmanjumce@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        mst@redhat.com, Kwame Adwere <kwame.adwere@nxp.com>,
        ashish.deshpande@nxp.com, arnd@arndb.d, gregkh@linuxfoundation.org,
        mikelley@microsoft.com, javier@javigon.com, mb@lightnvm.io,
        devicetree@vger.kernel.org, ckeepax@opensource.cirrus.com,
        bjorn.andersson@linaro.org
In-Reply-To: <20221220154747.2372597-2-manjunatha.venkatesh@nxp.com>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
 <20221220154747.2372597-2-manjunatha.venkatesh@nxp.com>
Message-Id: <167155421014.690186.2937416148656776999.robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: uwb: Device tree information for Nxp
 SR1XX SOCs
Date:   Tue, 20 Dec 2022 10:40:56 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 21:17:46 +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Link: https://lore.kernel.org/r/425858dc-59fe-2311-61ae-3b6dc77a2576@nxp.com
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Signed-off-by: Kwame Adwere <kwame.adwere@nxp.com>
> ---
> Changes since v5:
>   - Moved ioctl command definitions into header file.
>   - Version 5 patch review comments addressed.
>   - Corporate lawyer sign-off updated.
> 
>  .../bindings/uwb/nxp,uwb-sr1xx.yaml           | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml:8:8: [warning] too many spaces after colon (colons)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.example.dts:31.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221220154747.2372597-2-manjunatha.venkatesh@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


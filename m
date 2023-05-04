Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F876F6D84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjEDOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEDOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:08:59 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48483FA;
        Thu,  4 May 2023 07:08:58 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6a5ecdb455bso179837a34.0;
        Thu, 04 May 2023 07:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209337; x=1685801337;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4BsB7IxrXVXmNYO1j3WJ+IPUPOrgpIbkHF8q9BeoOI=;
        b=ZJzy2ZcUJO8gdlWn/ah5d4e/A5BJhoCZJF4X4M1xo2h7Zi04QALDdnZoRoEEQ99h28
         a6PEL1RCLzjTKG4gzZARbRnVJk7wwiAAEaPDNPCrjznXFHNibHUhNEj2uyRsDvnqgdf/
         Lw3/Q8TSKpJai2WscE5/0D3ikCS/XoJEFCw7u2TlLhh4vqlDk2HldzRV77sNlKKk11IZ
         eTgHiiK+0kbjtoWR9+hQbNfCK1D0i2yN10txSmJvsU5x5XOjDTjehgbFegYkqKylvKTA
         G6wifedkglM/5KsFJJIUy/1Q0eEoGRWeyr4PR8zprRyvaz8T/okw6O/Puw4iOh0mpXNY
         2HZw==
X-Gm-Message-State: AC+VfDz6CbxG+9Tr21SDQmdL7B5Wqoq0ETioqCAJX4D2T/hhL6QXFocH
        OgbEDyMBW1gip0pFYy1/5Q==
X-Google-Smtp-Source: ACHHUZ57ukJ0vp7R0DDQ/A8z6xUrkVeFjfIgj5dXR/eJFkyi353MfIQxyQi4VEjjBehNRTJmgJmXAg==
X-Received: by 2002:a9d:480a:0:b0:6a5:e9ad:3990 with SMTP id c10-20020a9d480a000000b006a5e9ad3990mr12863709otf.26.1683209337546;
        Thu, 04 May 2023 07:08:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6311000000b006864b5f4650sm1720966otk.46.2023.05.04.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 07:08:56 -0700 (PDT)
Received: (nullmailer pid 1721980 invoked by uid 1000);
        Thu, 04 May 2023 14:08:55 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     jun.li@nxp.com, Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, andreas@fatal.se,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de>
Message-Id: <168320933573.1721948.14807819257456373317.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: gpio-sbu-mux: add support for
 ss-data lanes mux
Date:   Thu, 04 May 2023 09:08:55 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 04 May 2023 15:46:50 +0200, Marco Felsch wrote:
> This adds the support for GPIO based USB-C SS data lane muxing.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++++---
>  1 file changed, 71 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dts:96.47-98.27: ERROR (duplicate_label): /example-1/tcpm/connector/ports/port@0/endpoint: Duplicate label 'tcpm_hs_out' on /example-1/tcpm/connector/ports/port@0/endpoint and /example-0/tcpm/connector/ports/port@0/endpoint
Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dts:103.47-105.27: ERROR (duplicate_label): /example-1/tcpm/connector/ports/port@1/endpoint: Duplicate label 'tcpm_ss_out' on /example-1/tcpm/connector/ports/port@1/endpoint and /example-0/tcpm/connector/ports/port@1/endpoint
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/usb/gpio-sbu-mux.example.dtb] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-1-3889b1b2050c@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


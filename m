Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E7648A33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLIVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLIVow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:44:52 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3AB6DA7;
        Fri,  9 Dec 2022 13:44:52 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id m204so5736441oib.6;
        Fri, 09 Dec 2022 13:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd9e73YWcyDbpy8iNaJn59EprL8nmhryJLwX1qEN9Eo=;
        b=CXCKb7c6n07d3BD1L0eaueFcqK7GSrJCrcxUfquT5+CB2NVXW/EZ01CHgkb+qipqFv
         xVk0kINV+ElLCAVXNXb7AWbvBOKOmiUUa5eEe4OYmA4cdSneUfF1ZjSR5xaW6Evstxvk
         rC2cu4n7INjFOEXQj0tonEcO+pCqVhYOiyhtIacQ2kvxUH++29mHFUcJSY5qlWlYzEVf
         vZbI3Bkd+t6FdCtEaOzbq0A69t/l93Us+6nFqnjpvj2gchyvkb7+TSl+3UcEbJtkfLRF
         tu4QwWOOrtBkuEsH9hba5z1TrKqfWbhExcxQlDv5pdCfDQHXdc/8lNc3zuvG257NuXNb
         i0pw==
X-Gm-Message-State: ANoB5pmdwDQP2OUFKstRnaVsYIVFc6RTU30lfVcRf7skpQZGmaLPoz4a
        itXBZk9rzbwe21WpiUp2jw==
X-Google-Smtp-Source: AA0mqf4zxCpKeyR01HFGIasFt7sfhYOSMetLDwOipuBLFYhevP/VhTMYOe44Q7JQXfvLVLr+yQUR+A==
X-Received: by 2002:a54:438d:0:b0:35e:1ca6:ff6d with SMTP id u13-20020a54438d000000b0035e1ca6ff6dmr3103306oiv.5.1670622291324;
        Fri, 09 Dec 2022 13:44:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b25-20020aca1b19000000b00342eade43d4sm923502oib.13.2022.12.09.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:44:50 -0800 (PST)
Received: (nullmailer pid 3899706 invoked by uid 1000);
        Fri, 09 Dec 2022 21:44:50 -0000
Date:   Fri, 9 Dec 2022 15:44:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: adi,adau7002: Convert to DT schema
Message-ID: <167062228971.3899662.7192332013668197294.robh@kernel.org>
References: <20221209175947.335319-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209175947.335319-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Dec 2022 18:59:46 +0100, Krzysztof Kozlowski wrote:
> Convert the Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
> bindings to DT schema.  During the conversion, add properties already
> used by DTS (sc7180-trogdor-coachz.dts) and Linux driver:
> 1. wakeup-delay-ms,
> 2. sound-dai-cells (via referencing dai-common.yaml).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/adi,adau7002.txt           | 19 ---------
>  .../bindings/sound/adi,adau7002.yaml          | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7A6613C05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiJaRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJaRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:17:59 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B5C12D21;
        Mon, 31 Oct 2022 10:17:54 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id g10so13426847oif.10;
        Mon, 31 Oct 2022 10:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pOvyjw1Chc1Qo3mwyQQ5nSHExlsUwet1RU0yznC5TE=;
        b=qtok1QkASuKYkBZcuHxPIExREvb20ggT+gYFxZtraL/ULjL3eUrOhYa8PCfZVfuB/S
         5Dheo0oqzOUnRATcwuD9pCwxbcjAoci2YhNi2wkBotszt8/GXyDESEIgtkLwf2419IxE
         PvQfWyNGl2u0oZCvuB5MkEXvYSvU0yB0UrHwrEeAeOkT9MJ+PNlPphyK02bNGFqZflHy
         6OuOkbFVYR5E3tF13WRxU4HAdVSmZWLvte+jQYYKHEhYlB74Ez2ahlwVv1csM/VRq/FO
         KO/XmKurnt7hqoBp+OF9JfL4HUJ/+fO0m5iyLk/E9s06D217B+WbqxMVzrnh79w2ogft
         QNkQ==
X-Gm-Message-State: ACrzQf2ApQ+iUgeJqU7T00YjPjYSIAYXF/UiVRyYYwUT60TwOUk/viF8
        4mgwUrwjHTR4ECT4NabkMmUmGPKX9g==
X-Google-Smtp-Source: AMsMyM4hwSJ/t/sMgz8pe9Mn/V17zTjGPM4dJIHLWsN4XqhLFE8N5tkSwNmUpwHLALXTF9rtwNPhfQ==
X-Received: by 2002:a05:6808:1992:b0:359:d863:e870 with SMTP id bj18-20020a056808199200b00359d863e870mr6990457oib.289.1667236674184;
        Mon, 31 Oct 2022 10:17:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a4adbc9000000b004768f725b7csm2567227oou.23.2022.10.31.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:17:53 -0700 (PDT)
Received: (nullmailer pid 3025675 invoked by uid 1000);
        Mon, 31 Oct 2022 17:17:55 -0000
Date:   Mon, 31 Oct 2022 12:17:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz, shengjiu.wang@gmail.com, nicoleotsuka@gmail.com,
        festevam@gmail.com, linuxppc-dev@lists.ozlabs.org,
        krzysztof.kozlowski+dt@linaro.org, Xiubo.Lee@gmail.com
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl,micfil: Add compatible string
 for i.MX93 platform
Message-ID: <166723667417.3025615.2589955186893152938.robh@kernel.org>
References: <20221028082750.991822-1-chancel.liu@nxp.com>
 <20221028082750.991822-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028082750.991822-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Oct 2022 16:27:48 +0800, Chancel Liu wrote:
> Add compatible string "fsl,imx93-micfil" for i.MX93 platform
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,micfil.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

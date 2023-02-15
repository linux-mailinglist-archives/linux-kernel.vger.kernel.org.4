Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961C698324
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBOSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:20:10 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C33D0A1;
        Wed, 15 Feb 2023 10:19:57 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-16e353ce458so6423918fac.9;
        Wed, 15 Feb 2023 10:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSDUg6NQIibdbv3wDqfo2BcnxDD37Ka22watDQXijJM=;
        b=dn+5jVNHWr2ocHsnd3t1bTOAxCCZBkTjBQkFfLLb5Ta0Gnmo3h1UEbojjdythm+93O
         2bMuWxvBLKwl33kRIX4N1yPxTRwJcCfOASb8P6l5vSnsBreLT7xtKYxpU2g06HZrWtXf
         REyxSOai9MlrZ2jizx4wJIRTn+x9s9+H8IgGSyieDIgzIsdJ4gjQybHAIvmSbG+E10Xm
         ypGTPVsRDB9YXtCcw6pgT8zUh6YOy4gpX2oDNItsR/5oaPwEbOnfTE6/vCMqNXOs1XEY
         JNb1Gq8KsaCghaDR9eZ19Fb9O7Wo959DDIaBb52Sr94wEIM/YXyfPenOBcBTHf4TuGe3
         iA2w==
X-Gm-Message-State: AO0yUKVRNws8mg5Too7WCj+aY/p7jRkD+xXP9SxCOEANOAwU49P4WB0G
        AL/IQwOrz5lf/R3HxNlSCmjsf6cP4A==
X-Google-Smtp-Source: AK7set/L64JKgN5PihFLGHnEGWoTUN3qTY0Q+4fBO2elsFvwQWb5Vw2Gcqo36AXexl9Ym/ZuXffnog==
X-Received: by 2002:a05:6870:4690:b0:16e:11fd:8d4 with SMTP id a16-20020a056870469000b0016e11fd08d4mr1793863oap.19.1676485196754;
        Wed, 15 Feb 2023 10:19:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a056870e60100b00163b85ef1bfsm7210031oag.35.2023.02.15.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:19:56 -0800 (PST)
Received: (nullmailer pid 362592 invoked by uid 1000);
        Wed, 15 Feb 2023 18:19:55 -0000
Date:   Wed, 15 Feb 2023 12:19:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/1] dt-bindings: Fix multi pattern support in
 DT_SCHEMA_FILES
Message-ID: <167648519401.362523.18033222242101591722.robh@kernel.org>
References: <20230209193735.795288-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209193735.795288-1-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Feb 2023 21:37:35 +0200, Cristian Ciocaltea wrote:
> DT_SCHEMA_FILES used to allow specifying a space separated list of file
> paths, but the introduction of partial matches support broke this
> feature:
> 
> $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
> [...]
>   LINT    Documentation/devicetree/bindings
> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [...]
>                 [-v]
>                 [FILE_OR_DIR ...]
> yamllint: error: one of the arguments FILE_OR_DIR - is required
> [...]
> 
> Restore the lost functionality by preparing a grep filter that is able
> to handle multiple search patterns.
> 
> Additionally, as suggested by Rob, use ':' instead of ' ' as the
> patterns separator char. Hence, the command above becomes:
> 
> $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml:path/to/schema2.yaml"
> 
> Fixes: 309d955985ee ("dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
>  - Use ':' instead of ' ' as the patterns separator char, per Rob's review
>  - Drop empty line between Fixes and Signed-off-by tags
> 
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


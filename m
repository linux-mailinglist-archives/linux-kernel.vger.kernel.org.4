Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A573670B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjAQWJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAQWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:08:07 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD23D911;
        Tue, 17 Jan 2023 12:23:39 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so8799461otf.8;
        Tue, 17 Jan 2023 12:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJGfJjVZYc/66/mbjIyBiEpogYyo22lwKH5yEocCOfs=;
        b=gcPXewYuxEV8is8Pja6mngK+rmLxc3RCopQmp27nf5JWLIDR9Ft5IYpvRHNb7ZtLgy
         do/scSeWnl1i7viJHDn9NccHz9hwasQ9Bo7Ku0ym+A513zfbD91bqhHIGPJ0rB3Ah6Ut
         U+zf0fL9II+ehu6NA6BZ1URyvijQOcsUlXHnOuZDwIBg1sGknSdT//J5TZmNFr5O7wvI
         +ra8jeXqlS4p2QKdoWzNFxxJWWq8PGnecKGKJAJ/jNhvHHKkoGv7v/h1eJ1sWyl72e4c
         A80Vs5AQnfqPr/I7A2gG+nqhtxNK+2t8+gih25TOj/ihYQCpaTfeSasOUKB2rZ8h2EK9
         YcXA==
X-Gm-Message-State: AFqh2kp+NMPjb/mak3GB/emNNrvj46dGSPMaEs+feT49Rby97fq84SWu
        z64JB6AtTiMCkQcrHUsF/g==
X-Google-Smtp-Source: AMrXdXtrtMdthMi3WcbT2+KHvHkH22ask+SpyijR4WuOxDKY7bn2nv2wDl5pydtTKRPFzdumN9/Y9g==
X-Received: by 2002:a9d:3e2:0:b0:682:65f3:c437 with SMTP id f89-20020a9d03e2000000b0068265f3c437mr13384664otf.22.1673987018555;
        Tue, 17 Jan 2023 12:23:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d5e88000000b00684c9c77754sm1593341otl.69.2023.01.17.12.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:23:38 -0800 (PST)
Received: (nullmailer pid 3646579 invoked by uid 1000);
        Tue, 17 Jan 2023 20:23:37 -0000
Date:   Tue, 17 Jan 2023 14:23:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz.abbas@arm.com>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alsa-devel@alsa-project.org, Deepak.Pandey@arm.com,
        Anurag.Koul@arm.com, kuninori.morimoto.gx@renesas.com
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Message-ID: <167398701684.3646521.11165836455939789490.robh@kernel.org>
References: <20230117061808.18422-1-faiz.abbas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117061808.18422-1-faiz.abbas@arm.com>
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


On Tue, 17 Jan 2023 11:48:08 +0530, Faiz Abbas wrote:
> The simple card driver already has support for a simple-audio-card,plat
> property but its not reflected in the documentation. Add documentation
> for this plat property.
> 
> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
> ---
> Changes since v1:
> 1. Updated commit message to indicate the property already exists
> 2. Removed redundant example
> 3. Fixed formatting issue found by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> 
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

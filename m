Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21AF6B1195
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCHTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCHTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:00:46 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770794A41;
        Wed,  8 Mar 2023 11:00:41 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-176d1a112bfso10931887fac.5;
        Wed, 08 Mar 2023 11:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hl+hU+TNeZjuxSABhEdZd1KZhSZC+nINd4XLp7+aIo=;
        b=cLjpXMUDlx5B551UrGlSWIrOUZsMCkgEdD43wzmMndCplVnxTnL+9PV9HiQ4u/SsaK
         PjmCY71GrjvkEKZapkCTwW+ZaHL9/1J2aueBn9VIwJWwB0Bp1UNPK+GA+6RjUK3lSJdX
         fPseLxBNFm/yKkJJVEb2vNLA5Dtg/fd7e1/OggyH4ioz/sBI3+I2ZT28x8xGB3JYH2R2
         wfuRNUCDzY5yH6STaCujVWw7Y6C9KQFYMokgTcsWqdNbaHgWgtxyPPYv3D7O1f4h8VQZ
         bGpoSQQuh82msVrxnPreVIX1TIY7IX0h28ngWghsrZfweU/Oe4tlxDqM3OHL7Wz8kyVa
         jr2w==
X-Gm-Message-State: AO0yUKVEStRKtz3pg1q7Otq7ZPSYBJ35PXMWfvzMOn/tZXEUKf92tJvT
        PxhV7LVXLLeZ0UQow5I4Eg==
X-Google-Smtp-Source: AK7set+Pcb5lu+k9cusuDmhFqFSm2qqL8crxqGgPEG8SBLpmeTJq4QEP/ex4Xsfkf2GRJlK2aZikaw==
X-Received: by 2002:a05:6871:28b:b0:172:3d66:6868 with SMTP id i11-20020a056871028b00b001723d666868mr11397673oae.15.1678302040624;
        Wed, 08 Mar 2023 11:00:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f5-20020a056870d30500b001724742cfcesm6425572oag.38.2023.03.08.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:00:40 -0800 (PST)
Received: (nullmailer pid 3601310 invoked by uid 1000);
        Wed, 08 Mar 2023 19:00:39 -0000
Date:   Wed, 8 Mar 2023 13:00:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     alyssa.rosenzweig@collabora.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        airlied@gmail.com, steven.price@arm.com
Subject: Re: [PATCH v4 02/12] dt-bindings: gpu: mali-bifrost: Set
 power-domains maxItems to 5
Message-ID: <167830203908.3601252.4440777459062565810.robh@kernel.org>
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
 <20230228102704.708150-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228102704.708150-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023 11:26:54 +0100, AngeloGioacchino Del Regno wrote:
> In preparation for adding (and fixing) power-domain-names and MediaTek
> MT8192 bindings, allow up to five items for power-domains.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


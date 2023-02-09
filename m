Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC149691021
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBISNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBISNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:13:37 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F7717168;
        Thu,  9 Feb 2023 10:13:34 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso810502otq.0;
        Thu, 09 Feb 2023 10:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w2uvC7tKfN7ZfSyrpjhie/I8cEOrFcZDWMac10H+4k=;
        b=seYwqlrP3Sah/ywQc/IZi5JF7V6C+kse8Sie4XRZIvEEVswOI5V6q+zbbXkBOzsEf9
         JrbgM+cL38/uYUsd0diMbvlkRvuXTE9GwRRt0qVQSlmCgiH5Ng4snDALrIToNUM+j8Ru
         +Owy1pjXp4/fk7Iyd4S8+zLBx1RkGKDBU9CXFz1jPoDQvPoUh18jrkeLocwVQ/q5Ym02
         6OCZO6h1WgwA6xmCsKU8Qbb7NMWcplNWKOCe40toS/arL8jZistKvDeLiP+XkWoLpTuo
         dQJpAPtcrzJR0xUJZOiL6nAP3gE8c91IGOcEbGQn5Q66Jlgt4GteZpRRDSGDnq1XQmHn
         DNHw==
X-Gm-Message-State: AO0yUKUno0ZsQQY6e6SKwFMgPx6DsvwyU88oi4U4l2igAMRFbSq5Do/1
        OQ85S2SuQQ3QYCTXSaGh8A==
X-Google-Smtp-Source: AK7set9geq4xni8+uYB8qGbMxQ7pUXj7wYLAoWyWFhJL4jxzTcF08XJ50z6U9Ah/fWoX6ss5tjhjwg==
X-Received: by 2002:a05:6830:39e4:b0:68d:81ce:a8c1 with SMTP id bt36-20020a05683039e400b0068d81cea8c1mr6701035otb.13.1675966413640;
        Thu, 09 Feb 2023 10:13:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a9d7b51000000b0068bdfa56717sm985127oto.36.2023.02.09.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:13:33 -0800 (PST)
Received: (nullmailer pid 586379 invoked by uid 1000);
        Thu, 09 Feb 2023 18:13:32 -0000
Date:   Thu, 9 Feb 2023 12:13:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        tomeu.vizoso@collabora.com, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        robh+dt@kernel.org, airlied@gmail.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/9] dt-bindings: gpu: mali-bifrost: Allow up to 5 power
 domains for MT8192
Message-ID: <167596641142.586319.10372403582007442030.robh@kernel.org>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
 <20230208103709.116896-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208103709.116896-3-angelogioacchino.delregno@collabora.com>
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


On Wed, 08 Feb 2023 11:37:02 +0100, AngeloGioacchino Del Regno wrote:
> MediaTek MT8192 (and similar) needs five power domains for the
> Mali GPU and no sram-supply: change the binding to allow so.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


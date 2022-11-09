Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABED622C08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKIM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKIM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:59:48 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF6295;
        Wed,  9 Nov 2022 04:59:47 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id n186so18687690oih.7;
        Wed, 09 Nov 2022 04:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0VppounFMRmePyPeHi33cQizYD+aDENhZWeL17O+aE=;
        b=kvpZptq6MxHnn9ycKwK7uIDptXony2+rPGeDFJpwSMs29EZwOm4ZnPvT0uCq91HvFh
         2y1uxDfZJhOndkeR4ynMajKSNqe6d/a6mvHMsbNvC+RuIfoL+D7LNqLQl97IJq3wkk2m
         5fYBUI8/jqJPuJeuQwTriwbNkaPgUoCs+VIjmeQYa4Qk9XkwW58i5sJy8PcyRwzm0UU7
         GhM4DpZaHGo/4fgom1k9STsSIjmobSjEDT8yJL6Ult6PyDFkE1qPUckqM32WSKjghURt
         BxVMJrZej5wFkiRXnJqvSIzzHIQFEwwufoM/SNXRwXr0VGsL4Qqb1HwNdkA6zh3c49jI
         p2Tw==
X-Gm-Message-State: ACrzQf1t3Wy5ZDrRRK/ApN4lIbckksdVluLMkdHWS52ZNhkU3N+qVRMx
        8r4KXGikLlIIGOEk5CXBlbLKSca1VQ==
X-Google-Smtp-Source: AMsMyM5gyWDXXx0xL8V7eSdlHkp9OkNYW+18J94S4lnodTZ/Z1306cK+ESsuHCc2ctfUyDtDDVU+3Q==
X-Received: by 2002:aca:3944:0:b0:351:22fe:6cc9 with SMTP id g65-20020aca3944000000b0035122fe6cc9mr33227237oia.292.1667998786745;
        Wed, 09 Nov 2022 04:59:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a22-20020a9d4716000000b0066c41be56e7sm5182382otf.55.2022.11.09.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 04:59:46 -0800 (PST)
Received: (nullmailer pid 1538566 invoked by uid 1000);
        Wed, 09 Nov 2022 12:59:47 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-media@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Steve Cho <stevecho@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221109073529.26765-2-yunfei.dong@mediatek.com>
References: <20221109073529.26765-1-yunfei.dong@mediatek.com>
 <20221109073529.26765-2-yunfei.dong@mediatek.com>
Message-Id: <166799859988.1535647.9867651548903188009.robh@kernel.org>
Subject: Re: [PATCH 2/3] media: dt-bindings: media: mediatek: vcodec: Change
 the max reg value to 2
Date:   Wed, 09 Nov 2022 06:59:47 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Nov 2022 15:35:28 +0800, Yunfei Dong wrote:
> Need to add racing control register base in device node for mt8195 support
> inner racing mode. Changing the max reg value from 1 to 2.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.example.dtb: video-codec@16000000: reg: [[0, 369098752, 0, 4096]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B466A2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAMTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjAMTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:18:16 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC3869C6;
        Fri, 13 Jan 2023 11:18:14 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id m23-20020a4abc97000000b004bfe105c580so5786823oop.4;
        Fri, 13 Jan 2023 11:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B70jAnXcMDlhhFo6pygi7wm6qqiPd8cSnbuhQtDGWGM=;
        b=yZny548BLmEVY4iw4giybnaCvAulGVX//Z1PC+eYhGSJTNmTBxsXXgaZWwQYqFMxg7
         L0NtLeR7iEv1yuXPrPKLs3yB6yRjXLabvJxQhkzIE7VopY9cGk7Lr25+AcnqxbzW5NET
         2iLAYoe5K78eQ7frC5U1cgdWfQ7l/8A2DrDdM/8qvk3cEzCI22JBnaIl6oW+cImFHvta
         xSvahv+XOmOALDqKm0UMsrjQZg04EQaGLeMMUuOkG+nTvQC9HEsr2QHRwtKqRpoNF6Lv
         7XuxTGEe/xO1xO0GP4YGxRFCG3qlY2VirFhs7Bl2BtoeuyZgLd74/OM7ISFNtMHZgcr/
         4BYA==
X-Gm-Message-State: AFqh2kqnKQOQQ3+hHyZzf82MJi7pyQCojPE5QWWl99typbOsH2ui6E3G
        CnZvvF6YBkoLk3PBNiCS1Q==
X-Google-Smtp-Source: AMrXdXukJHRMoqZxa1jYf9MRBpcU3E+hcrJeeafUboM+qJLEIF0oaVFK9ocAmkIX+lr/RAHkjYQj+w==
X-Received: by 2002:a4a:2c97:0:b0:4f2:6b72:6f75 with SMTP id o145-20020a4a2c97000000b004f26b726f75mr3770772ooo.7.1673637494125;
        Fri, 13 Jan 2023 11:18:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a4ac696000000b0049bfbf7c5a8sm10035924ooq.38.2023.01.13.11.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:18:13 -0800 (PST)
Received: (nullmailer pid 2763911 invoked by uid 1000);
        Fri, 13 Jan 2023 19:18:12 -0000
Date:   Fri, 13 Jan 2023 13:18:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@chromium.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 8/9] dt-bindings: display: mediatek: Fix the fallback for
 mediatek,mt8186-disp-ccorr
Message-ID: <167363749222.2763683.4659795598968970100.robh@kernel.org>
References: <20230111123711.32020-1-allen-kh.cheng@mediatek.com>
 <20230111123711.32020-9-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111123711.32020-9-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 20:37:10 +0800, Allen-KH Cheng wrote:
> The mt8186-disp-ccorr is not fully compatible with the mt8183-disp-ccorr
> implementation. It causes a crash when system resumes if it binds to the
> device.
> 
> We should use mt8192-disp-ccorr as fallback of mt8186-disp-ccorr.
> 
> Fixes: 8a26ea19d4dc ("dt-bindings: display: mediatek: add MT8186 SoC binding")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

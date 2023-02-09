Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95168FD64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjBICyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjBICws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:52:48 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E7BB9F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:50:30 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id o1so185745ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYIk4P2p6gp1gkykneVTXGgTOGI8BQeMJrJn0G8vBFQ=;
        b=HtmNzDuqZVPNnKVKdiDx+Z3cYsXnlZoWJEZPqX81nlx4s12FG5mKWN7Iz8QgRroITS
         uI/SE/a6wLxuTbZ2XqIIRFA0hAyZXeC//DLKyZBwhoYviw0jixTfnpdaGsaTmcSOV3n6
         NcyRBoPWk0t+FdFXhhVMlviUuItG+Tvvb8OQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYIk4P2p6gp1gkykneVTXGgTOGI8BQeMJrJn0G8vBFQ=;
        b=CPZZ4VmTgYabS8F5flXVFcwPkE9q4FXn6HEeLw1hyNjTZPLDC9iB//oUtvyXWEV5Z0
         xgh3js6Sa7RWDFzKVt+ZWmkbMQECWBICy6cISv9SYOIN2JP6d5DFxIieRkuzcRm8p/kH
         WX4NMbJooIcGbwUw4Iow5jHD+YEC+effii36KFw2E9AtByDGcul5U5PbCdDhBo3vuFXP
         VIGDLbf2rh/BYZ3sFY0lKmaVQckQMdMegHVyLvyVeI+hCTfz0EUd7dyYgnL98uwJEqj+
         jtL6a4GYRmq02tPQ+zbDnBjtdQvVis9vCe2b/ILeDMvaz1JbE2lIkN3dNvlUQ57H5QQ4
         NCIQ==
X-Gm-Message-State: AO0yUKVVg+WAJJXgqVv534WzBE0dMh4APlnl2tfGXqpQEA+2PrzlMNrw
        VOVfSQNklBXnDPyKL7hYblu31TSEvPZsTbTln5TPgQ==
X-Google-Smtp-Source: AK7set+bvKsydzGygJFYL5iQOvjw3Jv58rqgkJyZjXTUoGYryQCk+flVM83OAnzthJ9iLUo6Kt6Ev143YXLr6ftrCik=
X-Received: by 2002:a02:cc37:0:b0:3a9:6b85:41ed with SMTP id
 o23-20020a02cc37000000b003a96b8541edmr6496673jap.57.1675911029590; Wed, 08
 Feb 2023 18:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com> <20230208103709.116896-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230208103709.116896-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Feb 2023 10:50:18 +0800
Message-ID: <CAGXv+5Gm=Onu2RK+skLgN4Kzo9yP1n5Zb48oQNkQ019838QeEQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: gpu: mali-bifrost: Don't allow
 sram-supply by default
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, tomeu.vizoso@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, steven.price@arm.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 6:37 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The sram-supply is MediaTek-specific, it is and will ever be used
> only for the mediatek,mt8183-mali compatible due to the addition of
> the mediatek-regulator-coupler driver: change the binding to add
> this supply when mediatek,mt8183-mali is present as a compatible
> instead of disabling it when not present.
>
> This is done in preparation for adding new bindings for other
> MediaTek SoCs, such as MT8192 and others.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 78964c140b46..69212f3b1328 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -57,8 +57,6 @@ properties:
>
>    mali-supply: true
>
> -  sram-supply: true
> -

Have you tried actually validating the device trees against this?
Based on my previous tests this gives out errors.

The reason is that each conditional is a separate sub-schema, and the
validator is run against each schema and sub-schema separately, instead
of collapsing matching schemas and sub-schemas together and validating
once. So we'll get a validation error on sram-supply not being a valid
property when validating current mt8183 against the base schema.

We have a similar issue with power-domain-names, for which I'll send
a patch to fix. See the following for the fix:

    http://git.kernel.org/wens/c/d1adb38ab2ad0442755607c2bcc726cc17cce2c7

and the following for what I did for MT8192 on top of the previous patch:

    http://git.kernel.org/wens/c/049bd164884398d7e5f72c710da6aaa9a95bc10a


Regards
ChenYu

>    operating-points-v2: true
>
>    power-domains:
> @@ -157,6 +155,7 @@ allOf:
>              - const: core0
>              - const: core1
>              - const: core2
> +        sram-supply: true
>
>        required:
>          - sram-supply
> @@ -166,7 +165,6 @@ allOf:
>        properties:
>          power-domains:
>            maxItems: 1
> -        sram-supply: false
>    - if:
>        properties:
>          compatible:
> --
> 2.39.1
>

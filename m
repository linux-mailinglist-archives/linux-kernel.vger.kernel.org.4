Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2A72A43C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjFIURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFIURh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01AB9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B474365BC2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A8C433A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 20:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686341856;
        bh=2AytHjJpiLx9uJpuLA/dLSMZ6eIK/qLJJjC/k8GtoD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M0oh0i0ZlwciNbgUrzrX6EVwi8yqcNMMPWzMOfbtb1vCUsgg6/O4YE4TeiOfpy7H6
         A0my2TmbXYEN0zXdbFSI4+4pXxnIoDDh0tWR0/HVrSEQx0hnAihKjPlfmrGU7DQQV3
         O4q0v/1exyBWMpRXsFcakR8pQn+NLDgJHQogOwvQE5CCnBEXdRvqYkldzKNQwl+yHQ
         6OWkhttssmFoK5aiUTjFHMpE5dd2/LqLG1HxXoCARSXrPkGMaVzEhbelKAmx3sll/Y
         4UeyybThmPlG0YO6UGFlkuWKUbI/cNwP0rM5BOEujV6L1LmsmBxfG4PjlWluyAGwZA
         ccOtKqMs6UXdA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so2674037e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:17:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDwSWmdaC6RdVxS/4GFgWWrEDUzf53tuQqtRSXPaQNJ7J6YLYoi9
        w/aquDPrMmlumpd8ss12ow9VHFPsHVVyIrUGvg==
X-Google-Smtp-Source: ACHHUZ7I16ey/UB+RHcYPsq+ueUfC+xN7ewj0Gfr9rzp8seo+MFfIT6+6NreRfxW9wdkBIyhdhnCZxfxL7JFnV6mFoE=
X-Received: by 2002:a05:6512:521:b0:4f4:c6ab:f11b with SMTP id
 o1-20020a056512052100b004f4c6abf11bmr1744227lfc.39.1686341853975; Fri, 09 Jun
 2023 13:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230410232647.1561308-1-robh@kernel.org>
In-Reply-To: <20230410232647.1561308-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Jun 2023 14:17:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLeAvEVa8h3qywqESkqGG1O+9QWqA7fc1EJeDGkmAV7Fw@mail.gmail.com>
Message-ID: <CAL_JsqLeAvEVa8h3qywqESkqGG1O+9QWqA7fc1EJeDGkmAV7Fw@mail.gmail.com>
Subject: Re: [PATCH] drm: etnaviv: Replace of_platform.h with explicit includes
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 5:26=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Etnaviv doesn't use anything from of_platform.h, but depends on
> of.h, of_device.h, and platform_device.h which are all implicitly
> included, but that is going to be removed soon.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Ping!

>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 44ca803237a5..c68e83ed5a23 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -6,7 +6,9 @@
>  #include <linux/component.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>
>  #include <drm/drm_debugfs.h>
> --
> 2.39.2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1E621116
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiKHMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiKHMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:41:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39AD50F36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:41:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z18so22250679edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sojKUSuREfykk+D9JSHzONYCemfTYMKELjFcEAjqmzM=;
        b=Ij1vlYWVBhi07yZxug2R/KBT6Xnn6j654mq1kNgaxwRQZPUFYN8hPagGk8bQvML0yx
         AQh+vN+RefHi34G29jho/RLWpHhTtqwAc0s4G+flwSdidGe3FylEQyXxqvcNFaeCXy7/
         5PvTNjWXfkWSJYfXmTNSOdDiW5J+sfrlbkwsIf7qG+9XJNkB/RK+biq06fw1kO2sLUFN
         HBPGIhsFt24gr5uZg1wgOAKBc4caltkMdBGQQuASjYYr5czSYhj6L1Y6vR8GaKBCwNtD
         JxWdn0zNR74QhMaRP1t0GkEroAxGvWCJ2+SSL8VLTalIRrXsfFToNXdq7dhPhh3jsiz3
         9NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sojKUSuREfykk+D9JSHzONYCemfTYMKELjFcEAjqmzM=;
        b=PP7GaKXay0dPjL99m9c2UCpBRSMc0tKeHtzoUKVbMKlTtp4r/mM6UBf4JfNAccMK+f
         Y6mz/jBi3GHa9MoHTXV1Fz7r4QHErKKv+V9zrygGnDtOBsz5hf/tRFncf937fhaxjCuw
         1PM9nacHnSp6xLdX6Prk48ELlqxeEl3fqrvCNHTTxEzl/Af15A6HlH6ldFV5FGcaCloo
         STALOfnkg/17LYYfxHCTnn/w2iIMon1jd+lNaVPDm7Z6zTNlE39Pq8KKxBhuXemRWy0q
         8AIa94kebPqT3Q+VvR+JITMxb1ruTeIU7yIdtJ0d7Z10YJAxMwcrR7QH7TEmuPm9iZry
         OwIA==
X-Gm-Message-State: ACrzQf08iCjrGxKJVtdeCx5qBJyLHfldD2O+JeSWO7QYLsU0iY3AOe3Y
        N+KpOP4k0d+XD0WOSk5edOYdQxc8tDewZbiTE6Of9Q==
X-Google-Smtp-Source: AMsMyM5++w/HC8dqvK3AOVDcYoLuwnOWlFEzIff3hS5lWQZQDZ5KliH/yNuRAN+/P8Avgd2LUby4DCGzivt5clij6LE=
X-Received: by 2002:a05:6402:c07:b0:461:87ab:78aa with SMTP id
 co7-20020a0564020c0700b0046187ab78aamr56337494edb.258.1667911275482; Tue, 08
 Nov 2022 04:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20221104063652.82789-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221104063652.82789-1-jiapeng.chong@linux.alibaba.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 8 Nov 2022 12:40:59 +0000
Message-ID: <CAPY8ntC534yqrTLESGJ6BC68cg_=8wWYXZT44_ZBg1n5CzSEzw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sii9234: Remove the unused function sii9234_mode_valid()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        jonas@kwiboo.se, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        Laurent.pinchart@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 06:37, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function sii9234_mode_valid() is defined in the sii9234.c file, but
> not called elsewhere, so remove this unused function.

Did you mean bridge_to_sii9234() rather than sii9234_mode_valid() here?

sii9234_mode_valid() is referenced in sii9234_bridge_funcs, and it's
bridge_to_sii9234 that you've actually removed.

  Dave

> drivers/gpu/drm/bridge/sii9234.c:870:31: warning: unused function 'bridge_to_sii9234'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2735
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/sii9234.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> index 5b3061d4b5c3..62b6bc8ca7af 100644
> --- a/drivers/gpu/drm/bridge/sii9234.c
> +++ b/drivers/gpu/drm/bridge/sii9234.c
> @@ -867,11 +867,6 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>         return 0;
>  }
>
> -static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
> -{
> -       return container_of(bridge, struct sii9234, bridge);
> -}
> -
>  static enum drm_mode_status sii9234_mode_valid(struct drm_bridge *bridge,
>                                          const struct drm_display_info *info,
>                                          const struct drm_display_mode *mode)
> --
> 2.20.1.7.g153144c
>

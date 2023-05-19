Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB96708CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjESA3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjESA3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:29:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47E10D2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:29:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so213370a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456155; x=1687048155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr3i+0Z+ZK4Cpnq2h97UEX/Scj/M44+Ofcjn0kFKHFs=;
        b=mPAnsbEXf1UYEqdXdn4+wpQQw+xZDdHa0dyi7WxOJXtBiNOaPxQb43QbrVIRmc7CIp
         9oPX1lW/Ct+jJb+mKvDH3oMvlChYRxz9uyZ8DWNRH5EmVpvQv7dh7pRngmyXRCd4Ciu+
         9CSylPc+9x+T6uzAdkP/JRGg8aKC/iRzBxvHCtdM1PKBc/QdP7wkMwhBbEizGwxRKC8+
         qUDsHWXOD9pXbP4khaGr1xfA7FqdVBi5ZbgLwSFC3+Y7hfL8UEBOd7KIOxgGipwdkEyC
         e8T+H6lBHZFHg6ATlhwdTEp4tDnI2GuMgZWIGpFzeXAhZSLZ6/lzwTdbOZHJzVgFGpHL
         n1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456155; x=1687048155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pr3i+0Z+ZK4Cpnq2h97UEX/Scj/M44+Ofcjn0kFKHFs=;
        b=S4g440efAwwzxwY934GGa4YLQHPJ2DUTuY0u0jhTP4Rcf/tKV9b2poTQtGs9hA92t0
         Aphi2Ros2WfAk18gmr6eWq1o/QNk4+d88CrB73OGkd0HeLoB0RZO1W/z8wiluX/btH9c
         YxEpvl+Dp2UfxYnCd7m/FeQAfpq6j5cangTBlMZNtJT8QgMYdcLWQP5xNWZQ5MLUR3SX
         45EBItpfc+QkpIvPwvGVZlV6Ob9M3HtdpjUpoZX9UdXtLGiFB2iz7p5KVOHbQnHilm6C
         PbecqP3GhkSoEF1xt62YC0+/agCmSMVUPWv5G6ynqRF8YgIgS/Gc74V1WkWzeY1SKU9s
         UNMg==
X-Gm-Message-State: AC+VfDx4tI7VzweojWGCR4b4+zCp0By8xGRVbVwKHnequrANoqLDBm5N
        pvuC7JRZRNiuZj/UnPcr6KjfxywgFHZZmxvFNU8=
X-Google-Smtp-Source: ACHHUZ70Qai1vCCNiurb0hcuikboFL3KM/5UVQJk243hXkVtRUDJMd+9BM+dS1BQR4BddBatuTpGzxu0SlVHa6oEvhI=
X-Received: by 2002:a17:90b:4c45:b0:250:9af3:4f89 with SMTP id
 np5-20020a17090b4c4500b002509af34f89mr469279pjb.4.1684456154724; Thu, 18 May
 2023 17:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com>
In-Reply-To: <20230518230626.404068-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 18 May 2023 21:29:03 -0300
Message-ID: <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Thu, May 18, 2023 at 8:06=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> This series fixes the blanking pack size and the PMS calculation.  It the=
n
> adds support to allows the DSIM to dynamically DPHY clocks, and support
> non-burst mode while allowing the removal of the hard-coded clock values
> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> burst-clock device tree entry when burst-mode isn't supported by connecte=
d
> devices like an HDMI brige.  In that event, the HS clock is set to the
> value requested by the bridge chip.
>
> This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should
> work on i.MX8M Mini as well. Marek Szyprowski has tested it on various
> Exynos boards.
>
> Adam Ford (5):
>   drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>   drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>   drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
>   drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>   drm: bridge: samsung-dsim: Support non-burst mode
>
> Lucas Stach (1):
>   drm: bridge: samsung-dsim: fix blanking packet size calculation
>
>  drivers/gpu/drm/bridge/Kconfig        |   1 +
>  drivers/gpu/drm/bridge/samsung-dsim.c | 142 +++++++++++++++++++++-----
>  include/drm/bridge/samsung-dsim.h     |   4 +
>  3 files changed, 124 insertions(+), 23 deletions(-)
>
> V7:  Move messages indicating the optional device tree items are going
>      to be automatically read elsewhere was move to dev_dbg instead of
>      dev_info.  Cleaned up some of the comments to be a bit more clear.
>      Eliminated a double variable assignement accidentally introduced
>      in V6 when some of the items were moved from patch 6 to patch 5.

It seems you missed addressing one previous comment from Lucas:

"Same as with the earlier patch, this needs to be documented in the DT
binding by moving "samsung,burst-clock-frequency" to be a optional
property."

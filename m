Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638125F77AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJGLwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJGLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:52:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCEB7ECB;
        Fri,  7 Oct 2022 04:52:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e129so4443110pgc.9;
        Fri, 07 Oct 2022 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=US3Gb047SY8Dq4+eZYrFm7pCYLCCqm5ow/t9m2ICNWQ=;
        b=SAknEYDrNdrqAMzs7OhKIzQZfKbR2T+lY36/60vHTGYv9PIKFpzA+Acn/I0djXEHbu
         mKkq6CPFcqt50Zn5OHGXU16oDhZ+rNajeqCypfD0nrbOBln5h/b66KWQkMf7npSYmX4Y
         1gUUluiiQ1fA7d7gb6HQ2Y7q4FVGhRfGYtImTAuIZplJEGCFkdslARV8OcKTCqwDb+ii
         C2bnc6dZ1qAQ3EvHEE9Rri62nx1t0FOKxXAwf90irjfNYuDsA4ehy19894ohiCTC6xj/
         hYnWGTDXxBYjo1B3YOGm2zYpWUH0cdYOJRwpKOSjoCQ9Wrzq3MamEO7wed/d8x/q8BaJ
         Dtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=US3Gb047SY8Dq4+eZYrFm7pCYLCCqm5ow/t9m2ICNWQ=;
        b=zZS8RyP62QUBkXo+DOigxEEa0BjKmUc4tVfWfDdmexxp/03QiPOoQ7xF8484TJNq+O
         j5r5/nPia/XKS9hPj8NrkvJNetFaMu73oIrmsapIv10zb205nXRxHpFjaH2/VXwY9CjV
         1aA6bok/gWMBGuVulzd6bEc/MJl3/uXnTtniLkoxN2Lw42ez+K25nyAtzPp8s+4QRlaU
         OhCtDfPwmawIl03D7c8J4lTilK8xW1GvzfoPQC2shzu9OOO4dkQ9FT3iKvr4ZZoALzZz
         xJKlu/IfJiuubuLeMAqecwebpyBNexiCzwo8P1PLv9fWXu+yxz3yIgDG12Up88hZfvU0
         4HUQ==
X-Gm-Message-State: ACrzQf2w8DLY6Y5WaLRb7zxBIsadnI5A4WnVA+DYVFkD+Sb4ls03+Ieg
        ZbPhrMxRE/nQz9D+SAWOZnw1FvN6OpQES6NEdFc=
X-Google-Smtp-Source: AMsMyM5bKM2n6T9R0fdy+E1igkb+3XmtmmLUSaAs2cCs5UN+499nLVCEvgNIqFTs88aNq59nky0o/a3tEdudon8s7+4=
X-Received: by 2002:a62:144b:0:b0:562:38de:9a0e with SMTP id
 72-20020a62144b000000b0056238de9a0emr4845862pfu.78.1665143520248; Fri, 07 Oct
 2022 04:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221007111442.51481-1-a5b6@riseup.net> <20221007111442.51481-2-a5b6@riseup.net>
In-Reply-To: <20221007111442.51481-2-a5b6@riseup.net>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Oct 2022 08:51:45 -0300
Message-ID: <CAOMZO5C3PgvV6uoOZ_2iO8=QpE6bHzquo-hxNV4QgX6EmpcUGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: gpu: drm: add driver for samsung
 s6e3fc2x01 cmd mode panel
To:     Nia Espera <a5b6@riseup.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nia,

On Fri, Oct 7, 2022 at 8:16 AM Nia Espera <a5b6@riseup.net> wrote:

> +static int samsung_s6e3fc2x01_prepare(struct drm_panel *panel)
> +{
> +       struct samsung_s6e3fc2x01 *ctx = to_samsung_s6e3fc2x01(panel);
> +       struct device *dev = &ctx->dsi->dev;
> +       int ret;
> +
> +       if (ctx->prepared)
> +               return 0;
> +
> +       ret = regulator_enable(ctx->supply);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to enable regulator: %d\n", ret);
> +               return ret;
> +       }
> +
> +       samsung_s6e3fc2x01_reset(ctx);
> +
> +       ret = samsung_s6e3fc2x01_on(ctx);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +               gpiod_set_value_cansleep(ctx->reset_gpio, 1);

You should also call regulator_disable() here in the case of failure.

> +static int samsung_s6e3fc2x01_unprepare(struct drm_panel *panel)
> +{
> +       struct samsung_s6e3fc2x01 *ctx = to_samsung_s6e3fc2x01(panel);
> +       struct device *dev = &ctx->dsi->dev;
> +       int ret;
> +
> +       if (!ctx->prepared)
> +               return 0;
> +
> +       ret = samsung_s6e3fc2x01_off(ctx);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +       gpiod_set_value_cansleep(ctx->reset_gpio, 1);

regulator_disable() should be called here as well.

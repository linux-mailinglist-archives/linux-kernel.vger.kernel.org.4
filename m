Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B41746E38
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGDKEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGDKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:04:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E7D1B7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:04:03 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a37909a64eso3419518b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688465042; x=1691057042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyN9i3wvysLM+j6RUAYLzRo9XvTiCcAXlgbjR2Ukx2I=;
        b=wLm+KL0foI0/oMrkfPvAAa0z9rsQdRECsEfDYsKEjhlZxZpZ9iXLciAv9O87Kn+rq7
         nCd1p5rBu7r3ynD5pszdtiCAjEnS9NbvodH7r0r2OxNwXiHrDT29apUt7+RdwOHhT1xO
         EhBTvD6y0rwivO6I8+pS1uPtKeAWMvrp+tPg+WGQeQhNGdHiHrkQzjZrxxSXxH8FvaGm
         oRNt200rjN6qP8HXfIv0HhkxOV5eBjXI/9PiW4Qg3EEbc/C2HUoxbcDJpD4qHYkHvsBt
         roK/fybQ4a5ZMdL/reXZ3LzfaL6n8TI9116GpnzOQE+FIHoSnNXV06a3UVbH4ZxYQIpN
         DxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688465042; x=1691057042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyN9i3wvysLM+j6RUAYLzRo9XvTiCcAXlgbjR2Ukx2I=;
        b=EVrxZAhUI0RTblqokbmwnswfYT2eFLT1jnIAsIqwzVj/cHD1HIYAopxSz2k2Jw/DFa
         gpI95W37yIDYpeXWjQqvjs9UMjcuRnVKDwA5RpwVjhe6bVQUgIgVyIj+rfxUqAqEsGlB
         Z9JBiLTsgE52DA23jkH+iLh1YhVTu4PbpJCtUcY3pNZxy0EyMFymiZeYGeBeRRb5dVjy
         MBDx2tSWOUgDjSASAkR+o4PvHIL6yf2OFy3c0xb8r67a3ksFRBKeRXkN9X49Jk7NcApx
         bvx0yoxf5Nyqz5UKIqgZCDKrE/3+Vg5DeEHq6sazgzmKhycG0MRVgN+yxZoTwxchg9Iq
         QpDw==
X-Gm-Message-State: AC+VfDzxERU6KYQBWewTZusCnyCMDGZzrLJDttYOz/ppZNsm1DcREQCW
        dbwErydBHXEWT30hqJaZv7YytKry8YeOBRSbxgz1dg==
X-Google-Smtp-Source: ACHHUZ5PQi1Nbhy8IvULeR3lHQvsbtTMPOfn+ZJWTsoNLXnZmUNT78ygBOqqsrH9+ahJRacPsgEpY6NbpLtD2JkCT8Q=
X-Received: by 2002:a05:6808:14c6:b0:3a3:69a5:c10e with SMTP id
 f6-20020a05680814c600b003a369a5c10emr14233039oiw.38.1688465042514; Tue, 04
 Jul 2023 03:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Tue, 4 Jul 2023 18:03:51 +0800
Message-ID: <CAHwB_N+F_PQaRb+BvLmJwUSsbeCCqF3rWcLYuY_9ktrFGK5_7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Linus Walleij

On Mon, Jul 3, 2023 at 9:21=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> This is two patches fixing things I would normally complain about
> in reviews, but alas I missed this one, so I go in and fix it up
> myself.
>
> Discovering that a completely unrelated driver has been merged
> into this panel driver I had to bite the bullet and break it out.
> I am pretty suspicious of the other recently added panel as well.

Do you think the starry,himax83102-j02 panel needs to break it out? Thanks.

>
> I am surprised that contributors from manufacturers do not seem
> to have datasheets for the display controllers embedded in the
> panels of their products. Can you take a second look?

Sorry, this panel datasheet is not open source, I can't share this datashee=
t.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Rebase on drm-misc-next
> - Convert the two newly added Starry panels as well.
> - Break out the obvious ILI9882t-based panel into its own driver.
> - Link to v2: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v2-=
0-457d7ece4590@linaro.org
>
> Changes in v2:
> - Fix a missed static keyword
> - Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v1-=
0-8ac378405fb7@linaro.org
>
> ---
> Linus Walleij (4):
>       drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
>       drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
>       drm/panel: ili9882t: Break out as separate driver
>       drm/panel: ili9882t: Break out function for switching page
>
>  drivers/gpu/drm/panel/Kconfig                  |    9 +
>  drivers/gpu/drm/panel/Makefile                 |    1 +
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 3037 ++++++++++--------=
------
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  759 ++++++
>  4 files changed, 2067 insertions(+), 1739 deletions(-)
> ---
> base-commit: 14806c6415820b1c4bc317655c40784d050a2edb
> change-id: 20230615-fix-boe-tv101wum-nl6-6aa3fab22b44
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>

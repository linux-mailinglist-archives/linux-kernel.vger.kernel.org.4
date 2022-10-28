Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BA61152C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1OvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJ1Ou7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:50:59 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D615B336
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:50:57 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id v81so2568498vkv.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zOID64GFGQlYpCHZMs7nWayk+V8o2JCGll+6RVa/N4=;
        b=cB+23NrCWp+PyUNkL/wCY3P9G0881jURNEjtLcwC5HOSLtFmwJl1MjTS4vHWp5G1uO
         1zcJJFJ78zZHz2HgdKmQPHOs/JIr/K4kbaizu65SSlaYZGOuhv+RgSDunjKCXldE2afm
         bXhIC0U3mMEQx6ttDWgcsNeIvwBgMqKlm9XmeXj3QByOb+Pj1iQ3OM9pqZoflZuU1RId
         WyCno/R/xUsfPhEoJiDAOUCWgaSBRk0aevXbaHo5adQ2XlfZvxlNq/ebaVjl9i7duUWC
         hJRdZIvuJa/k+JLFM7Vv11aDEiDsg0S5d+/in3+N6qHjWJX5tyk206ma289ZzStF0iue
         kB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zOID64GFGQlYpCHZMs7nWayk+V8o2JCGll+6RVa/N4=;
        b=MzUF6RW5HeoHSBd2I1LXNZeal0evy4PmeKaJN2J//oGSyp8XmpUTf1UdbNfUraEuPu
         dM3ws8cmeO86YLRIwXg6XqkJsqTBWhYficFnOQ1L31T7m3q5GIB+kKABiGdwhWvWSuVc
         15a+zan8hbi/C2Z3bGXJHri5uF/W7ms0nSU0XglViCvjetWC0UBgoUFaEzxyxSsUDjC6
         qv/YUGt9h4kHIWfOBb215EZpvWLz/7BBTTVGhFqe5rpekL3wupw7avNrRZMCEbWe4quR
         mQ2hxTsJgdP146uoHpna6htNvRvdyqo41UGFzGez0pOb1qKsWvs4jTw6xINx1zReGy0r
         azTQ==
X-Gm-Message-State: ACrzQf3D6yrrfkjLuIB09qRchhpG0e9sD0rma08yjTH81YmdOy6wN2fZ
        jBq0nCVKBHLHOt9UvouFL69Rx8/tnSi5dF2u3HxNGStC1Jk=
X-Google-Smtp-Source: AMsMyM4NACzN632Fn5kG2qR7oEC61FU/SyLeiScTFpdSRFg1RoJbT32nPnKZjbCFNkbTWchJmUSSlTXPHUu9ItMJG1U=
X-Received: by 2002:a1f:2455:0:b0:3b7:88a4:c121 with SMTP id
 k82-20020a1f2455000000b003b788a4c121mr11692851vkk.1.1666968656796; Fri, 28
 Oct 2022 07:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <Y1tlgUVWLBRSIt5U@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
In-Reply-To: <Y1tlgUVWLBRSIt5U@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 28 Oct 2022 16:50:45 +0200
Message-ID: <CAMRc=MePwL4tobT+srWVDbJ=1Jt3zDMryP_Wgip9vuOFdtxypw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change myself to a maintainer
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matt.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 7:16 AM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> After some off-list discussion with Marek Vasut and Geert Uytterhoeven
> and finally a kx022a driver related discussion with Joe Perches
> https://lore.kernel.org/lkml/92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com/
> it seems that my status as a reviewer has been wrong. I do look after
> the ROHM/Kionix drivers I've authored and currently I am also paid to do
> so as is reflected by the 'S: Supported'. According to Joe, the reviewer
> entry in MAINTAINERS do not indicate such level of support and having a
> reviewer supporting an IC is a contradiction.
>
> Switch undersigned from a reviewer to a maintainer for IC drivers I am
> taking care of.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Applied, thanks!

Bartosz

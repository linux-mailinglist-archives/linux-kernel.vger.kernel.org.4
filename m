Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874373133E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjFOJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbjFOJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:11:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA7119;
        Thu, 15 Jun 2023 02:11:04 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62de85dd962so24272536d6.0;
        Thu, 15 Jun 2023 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686820262; x=1689412262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNteFUMG147OS3F5BgxkDPUNMVGTpgJpe9t7GN7PzjE=;
        b=jRNqhGxZtltVFI9nLYVaPJGDzIrCf+HMXB/p2NEnni76H4Zujmr6gVM07cVW/AytEq
         Ato9uUa8UgNPfZkKD9yJu3/wWvq+pzBZC9jQ5WPfqXzQfjErFb5SxVXCYxynMoSWyW6a
         empI41p5t+ynrHHLSnLm9nvOrGVXLlR5PViWEnmBWL7hTWxYceNXRMmFAGxTdz7gIqox
         n33xWxtU/1sejIAdW3NvBU2XO6I/3QYzG2Tm0sFwk8aqzyIUTW0CZCyVTdev54nkS4Ln
         9Oi1XbZxAdBB5UnGJ1Xt4AxfWlYq6hg16BbOXAEpbFYQVVhnHvaaXi4dM9lS5LJ+vP+B
         b2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686820262; x=1689412262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNteFUMG147OS3F5BgxkDPUNMVGTpgJpe9t7GN7PzjE=;
        b=C5o7F8TsUoMBjn6BvCWq+tabj7bxH3C+tINcZ5QmHqfRTiJiXlnD7aR8T6BBv8dB+W
         x79CE5NfVnIPskukod7MFeEii3lQK3crP0xALq7QNKAHYlKfnyYUiZh2lreVD42xRVgF
         8RlON5or1peXTfsyscC1MYcv0ssYO4R9pJPsWVuO0DoU241m3YCKvbFosEK4imtVK4ql
         VLaUrUUUO3RIAfR6xphaunCSJwYeDvqOwtj/8ZfFdnPFZoUYVoqXWpZEStAfdO8sOHkN
         PhCynfYLpYfL1vASiCKQBu50N9qLQbkbgUjpPHorZGP6Q1/F0RyBUfkHwAK1zAdDyPhY
         OY6g==
X-Gm-Message-State: AC+VfDwSK5SprE/3aKy9r8NOvl/VNygjzdzvsVCfFD/iYEPyXS4B9v8w
        CdYXAERenviADeog6cA6X7sXMCIiEqPZxyMNiETYC+pYLME=
X-Google-Smtp-Source: ACHHUZ6lmxA+bhKpAGl3hrH2CTN9vuyhP2Vxr5rgT+8GP7FZxUqMNPnH26camjpK2uPJhgFdtzDLLiRyNrmmThzeHHk=
X-Received: by 2002:a05:6214:1c4a:b0:62d:f48c:cee7 with SMTP id
 if10-20020a0562141c4a00b0062df48ccee7mr8978518qvb.64.1686820262529; Thu, 15
 Jun 2023 02:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 12:10:26 +0300
Message-ID: <CAHp75VfVF3giovZ=qA423rZNEP_m2bpD_dmBvdGp2UrueKOs4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] gpio: aggregator: Incorporate gpio-delay functionality
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

On Thu, Jun 15, 2023 at 2:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The newly appeared gpio-delay module enables external signal delay lines
> that may be connected to the GPIOs. But at the same time it copies the
> GPIO forwarder functionality. Besides that the approach does not scale.
> If we would have another external component, we would need yet another
> driver. That's why I think, and seems others support me, better to
> enable such a functionality inside GPIO aggregator driver.
>
> Patch 1 is a cleanup that may be applied independently on the decision
> about the rest.
>
> Please, test and comment!

Alexander, I have slightly changed the code, can you test this and
give your formal Tested-by tag?

--=20
With Best Regards,
Andy Shevchenko

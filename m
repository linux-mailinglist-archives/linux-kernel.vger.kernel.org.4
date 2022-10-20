Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECAA605EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJTLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJTLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:35:55 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5421DC4C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:51 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id y20so8751972uao.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yczvh5KScTc8RrLozuguoN/8j/AVQlreRiuboV5KOCw=;
        b=O4WERg+YJCIrgjRPnAEEIxXJllPdLyeBVwEey22TErLBjbX8HSSvm0CAA4KWj7Y6ml
         jQ40MSp/m0gDLFIiwyr0mHxzy3tObTjtnuszfopPKejU00Un6Uwaz09SdNej/royvqit
         B0Pbg/PG5PcRk6AWXddROrK4fDBq3tXmM+mNKEDRQt97IJzHfj7pV6NEWKwUnjisLiye
         SUKVl08xxrbpzh5LAdhqbruC517hU1BtOGrsxrbSGnUnqZ3vTMz1iaN/dnvWWyeh3dDE
         3wSc9pY4woU/N8HYRgqCcx2d9itqhJ8GzTd5CqS5Fv3h8SMnOUsFQwpEI/mqm0gCgR7U
         R5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yczvh5KScTc8RrLozuguoN/8j/AVQlreRiuboV5KOCw=;
        b=jzxe+7cL+Cxxul51DJCk+7UESV3kXvFgd82w6chlJEpwubcrgKDa1+qH9dr2BnsD0T
         KlyRy98zpG/rSjcG5rs9WBaruYAQ77YU4ipG5yYGmY/twzwXrZfOmc7t9mfjggE2xchi
         II/3NRuUxWTLuOT0K7HKY8G1g/ucIf9ogTDAIe+nCtWx/K5ebkXPU1Qcy2pH8zdZtW24
         xfNLmz0ArY5qBZ9rIFLaOZRWzAOD9tJH+G64QKenBKFzMVuSl1dlq2ctvdZi9xfj3izD
         p/K1M1hib5GjAF0ztJs1wXm8ZwdloUz5Oq0QyYpQPdjk71IDKaF1CQ75wqXaC8ElfLSj
         Gu9A==
X-Gm-Message-State: ACrzQf3/py1aX1fF6lB1Ab1CSZEWFARihVnp6f5xk4bb+e7QqnuRvkNA
        NSS/nDPz+oLBHVa4OvF1AQmv7AQbvc/KKA6JmOkmnQ==
X-Google-Smtp-Source: AMsMyM4CzNc7KZVGHt1Vr5Lxy5f/w1REpmrF8jJsz7PQxxnM0dZj6UBtKNY2A/9IDR10w7hsVrpFyDhrf/LDHTrAhWQ=
X-Received: by 2002:a67:ab46:0:b0:3a7:d2b6:121b with SMTP id
 k6-20020a67ab46000000b003a7d2b6121bmr6237885vsh.16.1666265750441; Thu, 20 Oct
 2022 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-11-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-11-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:35:39 +0200
Message-ID: <CAMRc=Metst=V=QK3-uhuEFVBJNv9H75=YZoNmjSr9yOiWZ5oxQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] mfd: remove davinci voicecodec driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:37 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The ASoC davinci voicecodec support is no longer used after
> the removal of the dm3xx SoC platform, so the MFD driver is never
> selected.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

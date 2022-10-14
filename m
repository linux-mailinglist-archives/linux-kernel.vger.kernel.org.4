Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694C5FEB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJNJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJNJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:28:35 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A121C7D4C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:28:27 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id w185so1980517vkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMKephT0DO36b58uiumO9iVQmJHAbKITY1Dq80O5li0=;
        b=hJ3wlaBR1rmsjyX6U3m2vET/5mRwyv6ddsDpTpVYugRoBeDvlX/p+VXFVnDEq+goeA
         H220fsvoQR02ho5MrVXrF5VUB2nJUDf+7vEXVl+NO6Ih718lxLNDS8hsbq4J2vLk42Fj
         A0XmR+JkhkQLxWuTlDSyAxMDy3njZoJ2bpjt8YpYjjUqDwFaftZu7y8qbuq3QicLw7jU
         G1sUdlF0czC9iOy504QpnMUYFfAoqri9ny8xQfpNNVWtI5ljIwZqRsXSGVsYNemDpBst
         +8bjLix7If5sLgDodiruYPHTstQeVRXouC5nRwpaInX6U9MGlC8ZJEZkSQNujnsTFxA8
         dOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMKephT0DO36b58uiumO9iVQmJHAbKITY1Dq80O5li0=;
        b=TpvjWlw10nm12YuSuCNg4b65+xpJoB0WTUaS6t/Ah9dcjpkc2+SrVzmaI4EZSpnnDZ
         yVJktM1R71cHG2CxiGSglZstrvIXTZhOejThdHn1TGTXqg0qiAktFlveFnbCPSAymkjC
         biRjjW0P3d44pDaVjozADm8sKZHEAIzYuj9QmHAaTkW5jSZzokhi/Frsew9+Gfyf95P1
         NedRxwpggC/E4imR7/nCgHrFYjMs6F+oj7yZGg2/UEMAxY2igBglfbZ2U0cpyJ2tqN+9
         CiW2+KW3xn5DLrHNoKsA9soHq32KeepF7v7Bd/xaAlQkF3cBL+TVggk59k82pzKKynt+
         Js8Q==
X-Gm-Message-State: ACrzQf3pJWyKsfeVQhaJMqxMKY42g7l47XO0WRO3uiEuuqhupEVF37KV
        CPW/SN0j9GNRoLlLalUowg0AiELGEngjeehPFafMiQ==
X-Google-Smtp-Source: AMsMyM51FP2p+iGF6rMOAh0E6lwlo48EM4GPcGJK+taDJA7BV+nQsXvedDxZnWyvtZJJhInF2liOhopGMZyt+xnp0tU=
X-Received: by 2002:a05:6122:4f8:b0:3ae:21f7:28da with SMTP id
 s24-20020a05612204f800b003ae21f728damr2011503vkf.33.1665739705609; Fri, 14
 Oct 2022 02:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221013001842.1893243-1-sashal@kernel.org> <20221013001842.1893243-22-sashal@kernel.org>
In-Reply-To: <20221013001842.1893243-22-sashal@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Oct 2022 11:28:14 +0200
Message-ID: <CAMRc=Md25wNapmU4ZxNfTPAOgCpSkW6Z7Oen6NFKj-kURaupAQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.19 22/63] gpiolib: of: make Freescale SPI quirk
 similar to all others
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 2:19 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> [ Upstream commit 984914ec4f4bfa9ee8f067b06293bc12bef20137 ]
>
> There is no need for of_find_spi_cs_gpio() to be different from other
> quirks: the only variant of property actually used in DTS is "gpios"
> (plural) so we can use of_get_named_gpiod_flags() instead of recursing
> into of_find_gpio() again.
>
> This will allow us consolidate quirk handling down the road.
>

Sasha,

This is not a fix, it's code refactoring. Definitely not stable material.

Bartosz

PS Same for the rest of the backports of the three patches I commented on.

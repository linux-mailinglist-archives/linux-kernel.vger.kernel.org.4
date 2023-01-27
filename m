Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F467E61E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjA0NIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjA0NIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:08:46 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBC69B34
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:07:58 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-50aa54cc7c0so38368537b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdu1C0c7ug45RTnt1Y2qniaRqHs2y86RFzxPAy1N9cg=;
        b=eRdp6axAXyrkh2KuWov+sP7FyCSokebXDA03xRDEGE8U8a+rjGDoaHFs55ckqbJRmI
         6MOTOFz8uEMET5lxJRQ+LI5v5U2s/543duOPg+JrtpYu6mvB1VAgntN6hhofF1/Rjwjf
         j8psz0SinsAqQGt3vyi5cj0I6hsX4FmCa2/zN8jQynflqd5x2quy4r/2elGeEOE1fNZ7
         DAq+6GZ184EbXsVLDGkD9OgQTtxP6eDpbsRAlUca4C1YtJfvvwQ0qb5pLkAg/KsEJ5LW
         2ntHX3OwgBvhLOfZ057g20rkyqe0XeJUmmUGQ6x9ieSpN7jWgFGGr6hUzgVbrPohv4la
         JeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdu1C0c7ug45RTnt1Y2qniaRqHs2y86RFzxPAy1N9cg=;
        b=bAfsqbbji2tGoHb/x4dBfk766pTkrL32TCCje+YJYiI/yAYfrkLSIrL5+67up1MJe1
         qA6CCrqKiPycgniiVTUH2eNP+Nx4OnZMZ/Kpjupjx8iPDhBUMrVhc0y+uvIr7S78eO+K
         MIge+7Js09GoAbbf0O4w+qcJcbDY0Bm3VATynEIm2QSdNbRPTcfApr3A24ROtaCoAWxu
         MeD3p61zLn4p8BGxnzApT2TsRud303QEVtUai9H8SVvFiYumOhYXShgUWsYD3mYusbgI
         afu6H9k2TCxIx9lUsEVXXYBRT+xkyQPvsBDZw8oghDFTDxOCgM6wzzSg/pi5KAMapNH4
         D+yg==
X-Gm-Message-State: AFqh2kqY9TRL8hs87pNUBrV484FunMOAZpMXtwk+5gb0TWSPS1F7Djcr
        NFzYgvEH0vrafUNOnHdTCnpDOnYI+OX2o4/iroakTQ==
X-Google-Smtp-Source: AMrXdXvImmqfQ5AbBkRtAb6U9BcACOl29UHRmnncwx70TliuzwWsd3Me4V8fE3lSOLz5s8sk6Ng31uayVQq0HjHXDD4=
X-Received: by 2002:a81:6842:0:b0:4ff:e4bc:b56f with SMTP id
 d63-20020a816842000000b004ffe4bcb56fmr3625076ywc.488.1674824859835; Fri, 27
 Jan 2023 05:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20230126132801.2042371-1-arnd@kernel.org> <20230126132801.2042371-4-arnd@kernel.org>
In-Reply-To: <20230126132801.2042371-4-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:07:28 +0100
Message-ID: <CACRpkdbt4+BzLcf3aOe_cfGzNTPtnzc34hE8GSGFa4-anzu9nA@mail.gmail.com>
Subject: Re: [PATCH 3/8] gpiolib: remove asm-generic/gpio.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The asm-generic/gpio.h file is now always included when
> using gpiolib, so just move its contents into linux/gpio.h
> with a few minor simplifications.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

After fixing the nits pointed out by Andy:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I'm very happy to see this go, maybe you can send a pull request
to Bartosz with these patches and also pull the same to the arch
tree if need be?

Yours,
Linus Walleij

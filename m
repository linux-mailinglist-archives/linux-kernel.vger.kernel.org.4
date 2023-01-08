Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C523661962
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjAHUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:37:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC5B7C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:37:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 188so6868617ybi.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nz+hlf5DjKki6fN3fwUsggCKBpRE3RxIvk1swq4t900=;
        b=GlW2isI4+LOC5BcTuYKuZIaz4MKCFiajUsiU92m0Q9Fd4urPHv2cGKTAGYqF1N9A5h
         HRm/IzlYf067w3QuAEhRbD6dg9Oc5yXXbJo4vDFm2Q0bWyxX5mPNp0Du3sdRI4nJbojn
         hBZB21MINIRxFcU71kcMBA8jiDkbeG/yKaDFBY8kXsTd2sgELwaNSUGLzuVEHO/uCyaM
         /dB791sszJqgCq/Kuyp152jYngVPucHSvLpi+GYbgaT/2hgNMYixjpLWdIjrUr+tyZJ9
         Eh+cL9hL/uB7bbtqF2n7krVw39KLCkOm/JkjqWIFFF8cIKk1YOog+umDHguT8Zi/aAlU
         T1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nz+hlf5DjKki6fN3fwUsggCKBpRE3RxIvk1swq4t900=;
        b=099MUWbzlsu80bkkNHcFLWSg3SdpROGaO2Ooxj1xfRfL/koxGRkI8WpK1kXbLcMkrC
         G8y36x+50iYRURed5zHgxnfdpZKz0s1araA4zEqlcrlLGA0DJlTYwI+lFW2nnAMKxZoz
         RZCEuQkMjjR2cUCeWVvJhv+lx2YT6jh6ILmh6Kd9UvhKCHgJ3QjPy276umSZLJ1phLq/
         C+ndeZR9iYnBuZlOaKaRyAwPuvCSFi/phjmOLmcvCo5Qgjs6WjepWFUeAPs138ok2pgO
         U16ONWI3UjstPvjK6VMJN5TF+jIF0pHHxRuMpWOTKHjSsSSjj2gWq18yXjCLD2PK8js0
         VrEQ==
X-Gm-Message-State: AFqh2kq6CitPjufAF5eet8mKEp2f7Ic5LInUTB+bao7/ljSCmvB/WLMC
        QqZAMqKw8ZoHzKFpGqOrTUcGfdsuZSFeW8oAquV0hA==
X-Google-Smtp-Source: AMrXdXu4F12qzvmONeIxn4+t+Y7drEbmQryPsYTflFez6dY38booTX+wa6Dr/IRIW8S8yo04E9mblh3a9WJrsBlIOKU=
X-Received: by 2002:a25:8e83:0:b0:703:8ada:5e0a with SMTP id
 q3-20020a258e83000000b007038ada5e0amr7021633ybl.210.1673210219491; Sun, 08
 Jan 2023 12:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20230105134622.254560-1-arnd@kernel.org> <20230105134622.254560-2-arnd@kernel.org>
 <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
 <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
 <764e558e-0604-4326-a50e-a39578b58612@app.fastmail.com> <8bec242f6f69c87f99309ed5c20e2f0be2b533c7.camel@linuxfoundation.org>
 <0690759c-8e74-429e-a3f9-c20aaac9c92f@app.fastmail.com> <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
In-Reply-To: <CALT56yN9aBn+s5rFB1yBdhGtYa6t=c0JeNmy0T=ckh3bNPgh2Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Jan 2023 21:36:48 +0100
Message-ID: <CACRpkdYGg1nbGhe-+XSr1fWyC5zOSOf0m2RAGxdXaw+xk3XdPg@mail.gmail.com>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>, Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>,
        Linus Walleij <linusw@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 11:06 AM Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:

> I suspect that the platforms might need to be rebootstrapped from the
> ground up. This sounds like a fun project for the next Connect demo :D

When I converted Integrator, Gemini and IXP4xx to device tree I essentially
bootstrapped them from the ground up beginning with irqchip, timer and
UART and moved up the foodchain from there, so yes :)

It's a lot of work but also a lot of fun!

Yours,
Linus Walleij

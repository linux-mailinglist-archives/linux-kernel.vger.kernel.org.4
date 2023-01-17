Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9066E69D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAQTLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjAQTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:08:30 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2690D37F1B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:22:29 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 123so1981439ybv.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KF9AKpkAxWwg0xVgeRn/67i1A0RE9KBlodHuzQUHQSM=;
        b=Z3Wf5ASEIqE+DbBueGhMdvcGSU78P7HzIzeIRVYpVetAQK9S2qlzCqDxmm6Sdo/mqm
         wsZrEEGnOHLpxgo4TDBlO+MQo8deLeY6q+lahvr3js2+SOyRTLqx3bP8cw6tUVfKTMNS
         5IrMe2xp5rH6dm80aDWwF8ITg6o8m7wbinw/NSufZz036Vp4sCD/GC2LfrGKMK65CGu7
         5oKWFP/iSHTcgtO0VKXn7hxIfVmmgQz2YKPFLJhzLShmDGvuZ7WTeJP4l/LIuKHBkTNv
         VEnjIMFtxRzmmJmM74jfRrcoNxhT704tgqQ3P4tiPBjqdfRvbr8/KFyFhBbLiuFi8+Xs
         04zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KF9AKpkAxWwg0xVgeRn/67i1A0RE9KBlodHuzQUHQSM=;
        b=7tPNl556TcLZQXsUS8NZR4v+RZqSNwRZUk3FqlAmFwxvkSTvfSs5YPHuP3N7q+f3cP
         GnP/k51r7jjOOoQXmKj8/75FmVMeM6l/+n296gipTEJGGFtmXB2e88RALFBzTfTlM4vH
         zSq0YhjhVCj64nvFXBlIpDaTkpSK+T03u+Td9nvsuFkin2T2xz0/IupxvlkDQ3yUXLrt
         yD1WSiaUkoEoJqI11WhBnIlMqfRUEwMuilOGfks8ZQqGaein2fs0BnwYMIeWPIIHR4y6
         V8aypqoe/LjQIdMNYZzMrvHwa/fh8zGCKkjbKWPXkljxzdP22paq1E8BVNyVPpYLgEzg
         JL4A==
X-Gm-Message-State: AFqh2krTZ6T5mwwLCPi4sc6WpiNWsMNlYx0RRQT7TqyhjeVrxxlcKL2k
        f9colsuLoBUgydtECn/TLjARHu/l8LhHxMDcaxlgkA==
X-Google-Smtp-Source: AMrXdXuVvfBU1pokGNSB0GCsBkhaY6r0NoMYg/hddhXgCQjhW42vfSWTZ97vcrTxcZ6HVXwM/Y3X2ljULdgzLR4TiH8=
X-Received: by 2002:a5b:38b:0:b0:7ca:9b40:72a7 with SMTP id
 k11-20020a5b038b000000b007ca9b4072a7mr587266ybp.130.1673979748355; Tue, 17
 Jan 2023 10:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20230117165522.2104380-1-arnd@kernel.org>
In-Reply-To: <20230117165522.2104380-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 19:22:16 +0100
Message-ID: <CACRpkdb0rA8DmiGj79f6+6qOCChUuQrYzmQ+Yjk6BxeBzjM4_A@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: visionox: add backlight dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:55 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added driver uses the backlight subsystem but is missing the
> corresponding Kconfig dependency:
>
> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-visionox-vtdr6130.o: in function `visionox_vtdr6130_probe':
> panel-visionox-vtdr6130.c:(.text+0xdee): undefined reference to `devm_backlight_device_register'
>
> Fixes: 65dc9360f741 ("drm: panel: Add Himax HX8394 panel controller driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied, thanks for fixing this!

Yours,
Linus Walleij

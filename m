Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A126756EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjATOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjATOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:19:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FC12591;
        Fri, 20 Jan 2023 06:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E2F0B82837;
        Fri, 20 Jan 2023 14:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C58C433D2;
        Fri, 20 Jan 2023 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674224299;
        bh=0EFlWgRLxVNkH0D5+K2CCNLnfAooxQdTXCQg9UomTuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiaEKsSgiJZRbz7IKmOLtFRffZaQY4N6z/wjKf5yz+GEGkQjSDICZpoCCcYKk/qLP
         nUCeXBwXPwvyJOaQR+AKhv/QeKIe7CLRN41e5ZSJYMzqT/uHubQum0UB7AYMm5XiZr
         e8X6v6ScvdAzYvAut1sYbLR4QjHeIVc0BE9FTAQvxkK0OggUn3/Gm/Wq226R47d0Ou
         RCSGoN/357G+odIg8wBmEHFlxJc9fr7EYOKrbsTjS9GvYgbZbLSwfeO374/FcLfwVr
         fkFSy7/SdtvmfQCMOEtuFxy6Vt1SqnUlQDRBfXT+djifdJawncA98CuJTf/QgZTqkO
         oVqLICJMrEltw==
Date:   Fri, 20 Jan 2023 14:18:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Marek Vasut <marex@denx.de>,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 19/27] mfd: remove ucb1400 support
Message-ID: <Y8qio/hwsP6+EG29@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-20-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-20-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ucb1400 MFD driver and its gpio and touchscreen child
> drivers were only used on a few PXA machines that were unused
> for a while and are now removed.
> 
> Removing these leaves the AC97 support as ALSA specific,
> no other drivers are now connected through this interface.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/Kconfig                   |   7 -
>  drivers/gpio/Makefile                  |   1 -
>  drivers/gpio/gpio-ucb1400.c            |  85 -----
>  drivers/input/touchscreen/Kconfig      |  16 -
>  drivers/input/touchscreen/Makefile     |   1 -
>  drivers/input/touchscreen/ucb1400_ts.c | 458 -------------------------
>  drivers/mfd/Kconfig                    |  11 -
>  drivers/mfd/Makefile                   |   1 -
>  drivers/mfd/ucb1400_core.c             | 158 ---------
>  include/linux/ucb1400.h                | 160 ---------
>  sound/Kconfig                          |   1 -
>  sound/pci/ac97/ac97_codec.c            |   1 -
>  sound/pci/ac97/ac97_patch.c            |  40 ---

Happy to take this with the relevant Acks.

I assume an immutable branch is necessary.

-- 
Lee Jones [李琼斯]

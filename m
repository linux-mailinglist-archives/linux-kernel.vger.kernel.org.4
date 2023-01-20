Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A582E675641
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjATOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjATOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:00:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926AC13F5;
        Fri, 20 Jan 2023 06:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A78061F73;
        Fri, 20 Jan 2023 14:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF2C433A0;
        Fri, 20 Jan 2023 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674223238;
        bh=ORrJE8vOco1eLw2jztPBELhptUUuXdkDMpLsQBHBOiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P726KZlsuKXFXkFmDMRZtbhZTqgBevjzH5e1y1uThnsNMEjOmjRa1tHauvJgQX9Es
         zV5b7lwXSFeztnsXwpZpC8oC2iW6Tb3N9sO33NMmgjtZETct3I+l/mjmGgqsr+piku
         KbzA36OZFQzwGtIQ9AkvMEFiTq+Fa5HkqjbgYvwqKOyH85thDsAmwx4hlt43fEU1ik
         rEG6ujm3PPniijsgEdTI9FNZejcSUjzSyOO40vWT78K6+Jh2mn1LBzJeRCN6NIibOx
         IkJM/cCUOY+RDFRVN1k01ybr1tREBxougZ7juPfDGTJ2aBowBfO/+ULeEDHryTo7Im
         j/KoxZulm3HtQ==
Date:   Fri, 20 Jan 2023 14:00:32 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 09/27] backlight: remove pxa tosa support
Message-ID: <Y8qegC966dxF7cE7@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-10-arnd@kernel.org>
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
> The PXA tosa machine was removed, so this backlight driver is no
> longer needed.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/backlight/Kconfig    |  14 --
>  drivers/video/backlight/Makefile   |   2 -
>  drivers/video/backlight/tosa_bl.c  | 172 -----------------
>  drivers/video/backlight/tosa_bl.h  |   8 -
>  drivers/video/backlight/tosa_lcd.c | 284 -----------------------------
>  5 files changed, 480 deletions(-)
>  delete mode 100644 drivers/video/backlight/tosa_bl.c
>  delete mode 100644 drivers/video/backlight/tosa_bl.h
>  delete mode 100644 drivers/video/backlight/tosa_lcd.c

Applied, thanks

-- 
Lee Jones [李琼斯]

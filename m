Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A549745556
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGCGQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGCGQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F7B6;
        Sun,  2 Jul 2023 23:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F8060C5D;
        Mon,  3 Jul 2023 06:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5377C433C9;
        Mon,  3 Jul 2023 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688364977;
        bh=8iby7AbCF9UWP65IdF9RbSVrQ14JOfsYIuXL0MfM8Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KOUuBLgip3qcxF+EfRwDVVYUwV0m/+HSMAtVW/Q8kEKIVVgbH4e1uTn1f9yUPd8KO
         RrG4ABQtMs2/nAkNgC/A1nN0UeofcH2n7sV4hhlcniXsh016PmdsfbJ7kY5A7PFqLS
         UwvGc0nrXX5KGkeSMgmZBStk5mH7ov3T8uLx7aPLX+FynAu0SN6wzXvoLwAzl0s9Q7
         BVV+U4dtv9bxS1BLSy9TGRofyFDSQuIRC2GDG8nXb86OmLH5CaCe2YUUCYo9dXYVKY
         NIlID3jiDSZZlw6K31RpmUPpeJ84gOYDenFv6+2vW2p8HMa8dsEWG/QSkeDiRetiyh
         7TZypdiFjjvEA==
Date:   Mon, 3 Jul 2023 08:16:10 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        David Lin <CTLIN0@nuvoton.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Antti Palosaari <crope@iki.fi>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 3/4] lib/math/int_log: Replace LGPL-2.1-or-later
 boilerplate with SPDX identifier
Message-ID: <20230703081610.5ffea861@sal.lan>
In-Reply-To: <20230619172019.21457-4-andriy.shevchenko@linux.intel.com>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
        <20230619172019.21457-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 19 Jun 2023 20:20:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:

> Replace license boilerplate in udftime.c with SPDX identifier for
> LGPL-2.1-or-later.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  include/linux/int_log.h | 11 +----------
>  lib/math/int_log.c      | 11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/int_log.h b/include/linux/int_log.h
> index 332306202464..0a6f58c38b61 100644
> --- a/include/linux/int_log.h
> +++ b/include/linux/int_log.h
> @@ -1,17 +1,8 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
>  /*
>   * Provides fixed-point logarithm operations.
>   *
>   * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
> - *
> - * This library is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU Lesser General Public License as
> - * published by the Free Software Foundation; either version 2.1 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU Lesser General Public License for more details.
>   */
>  
>  #ifndef __LINUX_INT_LOG_H
> diff --git a/lib/math/int_log.c b/lib/math/int_log.c
> index ea98fc0b3fe2..8f9da3a2ad39 100644
> --- a/lib/math/int_log.c
> +++ b/lib/math/int_log.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
>  /*
>   * Provides fixed-point logarithm operations.
>   *
>   * Copyright (C) 2006 Christoph Pfister (christophpfister@gmail.com)
> - *
> - * This library is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU Lesser General Public License as
> - * published by the Free Software Foundation; either version 2.1 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU Lesser General Public License for more details.
>   */
>  
>  #include <linux/bitops.h>

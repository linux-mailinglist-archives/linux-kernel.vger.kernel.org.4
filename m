Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196946757D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjATO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjATO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:56:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B8457EA;
        Fri, 20 Jan 2023 06:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33AB661F95;
        Fri, 20 Jan 2023 14:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F32C433EF;
        Fri, 20 Jan 2023 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674226559;
        bh=ti3K7wN2sWdsBBDNKXsbX0ixPhWFqQduYlYW1ZLSFUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1exy9x+NaJZTExFQCuwNeBuo5OMzRcGiKEL90izrXLlXnVbn+pGSbhfMpy/QzXBb
         5JOnxDO3LGmUVAWY7YMKfx3edTZqMxgIvA9aC9YoHxngE1cyztRGVng9Vqc+IbcMXW
         QyKsw/1X9R4iU8y66It5n1bNX+cEOV8gi6/KLbUoEq6F7XeCCsSLI5o6/lAm1LWZiY
         BV5ijhVcav1dc6J4ZeJZNd+6vAP4+R9QwxUzB4pAKVxrJeRQI+eO8ehG5A2Fe4nt1B
         Zmf8EC/qWSlVkDgg392t33bGhbVwuxBOTrdg0H5Ur0vIlBz8FypA0tYCZwiZst6Jho
         x7W++QRvYeung==
Date:   Fri, 20 Jan 2023 14:55:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 18/27] mfd: remove toshiba tmio drivers
Message-ID: <Y8qreZLyTiDQLOB5@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-19-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-19-arnd@kernel.org>
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
> Four separate mfd drivers are in the "tmio" family, and all of
> them were used in now-removed PXA machines (eseries, tosa, and
> hx4700), so the mfd drivers and all its children can be removed
> as well.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig          |   38 --
>  drivers/mfd/Makefile         |    4 -
>  drivers/mfd/asic3.c          | 1071 ----------------------------------
>  drivers/mfd/t7l66xb.c        |  427 --------------
>  drivers/mfd/tc6387xb.c       |  228 --------
>  drivers/mfd/tc6393xb.c       |  907 ----------------------------
>  drivers/mfd/tmio_core.c      |   70 ---
>  include/linux/mfd/asic3.h    |  313 ----------
>  include/linux/mfd/t7l66xb.h  |   29 -
>  include/linux/mfd/tc6387xb.h |   19 -
>  include/linux/mfd/tc6393xb.h |   53 --
>  include/linux/mfd/tmio.h     |    5 -
>  12 files changed, 3164 deletions(-)
>  delete mode 100644 drivers/mfd/asic3.c
>  delete mode 100644 drivers/mfd/t7l66xb.c
>  delete mode 100644 drivers/mfd/tc6387xb.c
>  delete mode 100644 drivers/mfd/tc6393xb.c
>  delete mode 100644 drivers/mfd/tmio_core.c
>  delete mode 100644 include/linux/mfd/asic3.h
>  delete mode 100644 include/linux/mfd/t7l66xb.h
>  delete mode 100644 include/linux/mfd/tc6387xb.h
>  delete mode 100644 include/linux/mfd/tc6393xb.h

Applied, thanks

-- 
Lee Jones [李琼斯]

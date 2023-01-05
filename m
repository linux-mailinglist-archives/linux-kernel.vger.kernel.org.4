Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182C65EF76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjAEO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjAEOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:55:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0690E50;
        Thu,  5 Jan 2023 06:55:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69705B81AD5;
        Thu,  5 Jan 2023 14:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB428C433F2;
        Thu,  5 Jan 2023 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672930543;
        bh=6E2z5jE9PI8KALhgurvIsj36BhYmPG/weebyj7gcV3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxm+wXcnl+V4ElLhvVgvKNXxe42QsgB+hBNfJXiLzPji9BHYLGrNjeJJgllahwE3P
         +xBddu3dm360Pgbt8V/HxkroF4WKsRH5krB1H7Vjhin0Y/WtwGm5dzGMp4poHoRYdK
         xJsxo3KSchVPmRYoZW1jCdvs0TyRgqtnEddU3zFc=
Date:   Thu, 5 Jan 2023 15:55:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 03/27] ARM: pxa: remove unused pxa3xx-ulpi
Message-ID: <Y7bk7LV3JY0JPxli@kroah.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-4-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:45:58PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This was only used by the cm-x300 board, which is now gone.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/Makefile                    |   2 +-
>  arch/arm/mach-pxa/devices.c                   |  28 --
>  arch/arm/mach-pxa/devices.h                   |   1 -
>  arch/arm/mach-pxa/pxa3xx-ulpi.c               | 385 ------------------
>  arch/arm/mach-pxa/regs-u2d.h                  | 199 ---------
>  drivers/usb/host/ohci-pxa27x.c                |   9 -
>  include/linux/platform_data/usb-pxa3xx-ulpi.h |  32 --
>  7 files changed, 1 insertion(+), 655 deletions(-)
>  delete mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
>  delete mode 100644 arch/arm/mach-pxa/regs-u2d.h
>  delete mode 100644 include/linux/platform_data/usb-pxa3xx-ulpi.h


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

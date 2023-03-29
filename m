Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBE6CD370
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC2Hjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjC2Hj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CB2114;
        Wed, 29 Mar 2023 00:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACB861AEC;
        Wed, 29 Mar 2023 07:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD9C433D2;
        Wed, 29 Mar 2023 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680075564;
        bh=edy+QyqyJlv1bffU7gSQfZhq5Rdu7UqPovVDnvhDTXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrZsM/8b5bk8znF3kU1vp+w9wR5+urmf0dpl9D6xqdMLik3tQkHYR4LTdywl3NXNH
         3+p2zTXtEVAaVAVEr0QfSUT8knB2GIthBgNoExVmi3vU9GWii6vx5Iuu+yL/9LxUwC
         Nbb31Yv0So0Iw/xkn31w1RGcqOMiO0KtIpArtXHo=
Date:   Wed, 29 Mar 2023 09:39:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: move config USB_USS720 to usb's misc Kconfig
Message-ID: <ZCPrKaIcsoj3Vvcs@kroah.com>
References: <20230329071724.11082-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329071724.11082-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:17:24AM +0200, Lukas Bulwahn wrote:
> The USS720 parport driver source code is in drivers/usb/misc/, the
> corresponding config is defined in drivers/usb/Kconfig. Some digging in the
> kernel's history revealed no good reason why it needs to be defined in
> USB's top-level Kconfig file, and why the config for the USS720 parport
> driver should be the first in the list of USB port drivers, while all other
> configs for drivers in drivers/usb/misc are in the USB Miscellaneous driver
> configuration file.

It is that way because this was one of the first USB drivers we had, and
we only had one Kconfig file at the time and no misc/ subdir in the usb
directory.

So it's just inertia, that's all.

Your change looks great to me, want to resend it without the RFC so that
I can apply it?

thanks,

greg k-h

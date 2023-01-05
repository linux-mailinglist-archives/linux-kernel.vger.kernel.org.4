Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E456565EF74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjAEO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjAEOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AF5C1C9;
        Thu,  5 Jan 2023 06:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5681761AC9;
        Thu,  5 Jan 2023 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079FBC433D2;
        Thu,  5 Jan 2023 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672930533;
        bh=PiohE8EWfPhRz3Cbkv4O4/ZBL+QbVS0+cbrVBoLIte0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/davLiiqvqeHscXHFJMtRafuHS44Q3AJqcL9Upqt9phcHoyklbi+ELN+SKABMJY4
         PO3UP9J3vZOlzaQYFWAbUChM6uV+1ZlQUs/RsiVeaPfnWnaTwXcCYFe9+dGFhc38hb
         bUdpZLuhig+GGKR3lKMn5vLN6i0O9BK/Pj2f081U=
Date:   Thu, 5 Jan 2023 15:55:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 25/27] usb: remove ohci-tmio driver
Message-ID: <Y7bk4ktgGFUpxQLo@kroah.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-26-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-26-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:46:20PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The TMIO MFD driver is getting removed, so its OHCI portion is not
> used any more either.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/host/ohci-hcd.c  |  18 --
>  drivers/usb/host/ohci-tmio.c | 364 -----------------------------------
>  2 files changed, 382 deletions(-)
>  delete mode 100644 drivers/usb/host/ohci-tmio.c

I can take this through the USB tree, otherwise feel free to take it and
add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

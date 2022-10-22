Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D41608ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJVJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiJVJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:06:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221662DE474
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:20:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A23C6B82E07
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F02C433D7;
        Sat, 22 Oct 2022 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426593;
        bh=mNeH4WeyGSHFqhdspyYlVFsq2U3x4IUacITdhdMQuFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZCzN1MsxYG+IXMPEnNJfz9yQWpdNlVxsAU5hYH/xBroM9khylrnoyVvSumlCO0Q3
         kUNrTdKby5Qls0yYBb4HaQF+v9h5GjsoIDePTw2NQpgBRapje56MKOurWM9PnYKteM
         jCabtobW5vPkKtyNu4vy02+S1YAJhegwpWh0I4KY=
Date:   Sat, 22 Oct 2022 09:58:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: remove commented debug printk messages
Message-ID: <Y1OikehVJv/teZ9e@kroah.com>
References: <Y1H5tJXjMZqiB6rh@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1H5tJXjMZqiB6rh@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 07:15:24AM +0530, Deepak R Varma wrote:
> printk messages are added for program flow tracing and are left
> commented. These commented log messages should be removed as they
> are no more useful for program execution.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/wlan-ng/p80211netdev.c | 22 ----------------------
>  1 file changed, 22 deletions(-)

I recieved 3 different copies of this patch, and do not know which one
to take at all.

So please resend this as a v2 patch, only once, and I will be glad to
review it.

thanks,

greg k-h

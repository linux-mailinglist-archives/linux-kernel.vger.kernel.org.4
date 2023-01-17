Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2066E19D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjAQPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAQPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072A83E611;
        Tue, 17 Jan 2023 07:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A59CAB81647;
        Tue, 17 Jan 2023 15:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F316EC433EF;
        Tue, 17 Jan 2023 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673967878;
        bh=vH6a/+waEeOiKjAfeYS2En9sK3fEsc6uDm4zk1+vIMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3b+5UVF8mZ4x4wkcjtk/kdhYNNyyNhZUBnNM4L+0oPP8+qmAmd98FOSNdldqmJso
         smVxa2RSdiuWyDUhh1U+k95U0Fj1+3jTb7Elo05OMpWP7L4FPoqcv+yfiE38EZ8Oen
         shzOnX75TkWnNIjMC5yZp9oVODUs3ixh89yZhyo8=
Date:   Tue, 17 Jan 2023 16:04:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: remove obnoxious warning messages
Message-ID: <Y8a5A/6cuiPWdyDl@kroah.com>
References: <20221209172853.2138941-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209172853.2138941-1-alvin@pqrs.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 06:28:53PM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> There is really no need for the driver to unconditionally emit warnings
> like this on every usage:
> 
> [    6.967283] using random self ethernet address
> [    6.967294] using random host ethernet address
> 
> Since this is normal behaviour, just remove the messages altogether.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/usb/gadget/function/u_ether.c | 2 --
>  1 file changed, 2 deletions(-)

Please see the thread at:
	https://lore.kernel.org/r/20230116155545.101391-1-jonathanh@nvidia.com

for more details.

This should use dev_warn() or better yet, just dev_dbg().

thanks,

greg k-h

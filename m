Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB169F1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjBVJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjBVJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:37:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514A39B9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2000B612D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C110C4339E;
        Wed, 22 Feb 2023 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677058420;
        bh=C2Oqvd8tqn65eQLYX2+RWOra6KjIQXNIxUhwjNbCx6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vgq7mer+5Gm+tz3XN3qS8LU76XdDQ6lI71errV5xSeDaXSh4tIZCtoLLv8qv6DhlV
         CUj7seCJdd9XYvNebvlFtAZMQkBRAkf+ed757oQaqNFWt5AmfuuuNTABC3bbu7xpgK
         MVJqAuJ1SQuR2qvDrHwbt/Yob1J2PNPAJBmqJi1U=
Date:   Wed, 22 Feb 2023 10:33:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] char: pcmcia: remove all the drivers
Message-ID: <Y/XhcXKd7imdWqzj@kroah.com>
References: <20230222092302.6348-1-jirislaby@kernel.org>
 <20230222092302.6348-2-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222092302.6348-2-jirislaby@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:23:02AM +0100, Jiri Slaby (SUSE) wrote:
> These char PCMCIA drivers are buggy[1] and receive only minimal care. It
> was concluded[2], that we should try to remove most pcmcia drivers
> completely. Let's start with these char broken one.
> 
> Note that I also removed a UAPI header: include/uapi/linux/cm4000_cs.h.
> I found only coccinelle tests mentioning some ioctl constants from that
> file. But they are not actually used. Anyway, should someone complain,
> we may reintroduce the header (or its parts).
> 
> [1] https://lore.kernel.org/all/f41c2765-80e0-48bc-b1e4-8cfd3230fd4a@www.fastmail.com/
> [2] https://lore.kernel.org/all/c5b39544-a4fb-4796-a046-0b9be9853787@app.fastmail.com/
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: "Hyunwoo Kim" <imv4bel@gmail.com>
> Cc: Harald Welte <laforge@gnumonks.org>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Nice!  I'll queue this up in my tree after 6.3-rc1 is out if no one
objects by then.

thanks,

greg k-h

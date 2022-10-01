Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219185F1DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJAQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJAQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEBC1C13A;
        Sat,  1 Oct 2022 09:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ED90B80757;
        Sat,  1 Oct 2022 16:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C7CC433C1;
        Sat,  1 Oct 2022 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664642231;
        bh=+3DTme+sPlwf3zVCixT4SIB4MJY3EouGY8rzOjQN/Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0YFtJS3ENtAdxKqTcKVauCr6w1pMdNSWnbFI5TZ/ZFZrC65Wakp8AvdBfj812swO
         n5kDgLyXkTunT81gQvOqBTMq6MVgPQra3USNkNdP7vjA9BVyJM6AB9C+Ua3BFouDAQ
         ekKHbqzV61Mx7EqY2mPqhOgSjWH4vO/cQzCikpZE=
Date:   Sat, 1 Oct 2022 18:37:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.0-rc8
Message-ID: <YzhstEub/m3VvxB9@kroah.com>
References: <Yzf2H3iLp2g01Gsw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzf2H3iLp2g01Gsw@hovoldconsulting.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 10:11:11AM +0200, Johan Hovold wrote:
> Hi Greg,
> 
> Here's one more modem device id for 6.0-final or, if you prefer, 6.1-rc1.
> 
> Johan
> 
> 
> The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:
> 
>   Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.0-rc8

I'll queue this up for 6.1-rc1, thanks.

greg k-h

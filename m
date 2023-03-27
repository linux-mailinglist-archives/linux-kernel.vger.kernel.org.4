Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097446CAB17
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjC0QxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjC0Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8C5B99;
        Mon, 27 Mar 2023 09:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292B7613F8;
        Mon, 27 Mar 2023 16:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3039CC433D2;
        Mon, 27 Mar 2023 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679935942;
        bh=yHBV5heJyDsi77Xx8GbkWncOOQukyp/9pvZsnV5tOGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeqmR9deIZ0Tu5mAk37o8p6fn7Xp9smww/+qCDzJxPqkoAA0oElX3oUKNHujxYs4F
         CPr5CRCT054wfq3+mGc9+C7ASTu7szNxCf1EohYYYJSTBn8dXNqkI5xczP70tkoPvD
         +0tjD+Y7JOXUPwj3PrzxG6DpDBH4jI/9MqSDDePM=
Date:   Mon, 27 Mar 2023 18:52:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yaroslav Furman <yaro330@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] uas: Add US_FL_NO_REPORT_OPCODES for JMicron
 JMS583Gen 2
Message-ID: <ZCHJw9eNPrYduLz4@kroah.com>
References: <ZA12pMgwA/8CguYd@kroah.com>
 <20230327135423.607033-1-Yaroslav.Furman@verifone.com>
 <20230327135423.607033-2-Yaroslav.Furman@verifone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327135423.607033-2-Yaroslav.Furman@verifone.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:54:23PM +0300, Yaroslav Furman wrote:
> From: Yaroslav Furman <yaro330@gmail.com>
> 
> Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
> let's avoid them.
> 
> Signed-off-by: Yaroslav Furman <yaro330@gmail.com>
> 
> ---
> 
> V3: Moved the code in the appropriate place, after the 0x0578 device,
> as pointed out by Alan Stern
> ---
>  drivers/usb/storage/unusual_uas.h | 7 +++++++
>  1 file changed, 7 insertions(+)

I'm confused, this is already in 6.3-rc4, right?

thanks,

greg k-h

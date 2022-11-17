Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61AC62E674
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiKQVJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiKQVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:09:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E761005D;
        Thu, 17 Nov 2022 13:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9584361E76;
        Thu, 17 Nov 2022 21:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1255C433D6;
        Thu, 17 Nov 2022 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668719309;
        bh=HYS9XYfwOlhjzRSnx323mT7QdkoJmUme8EZAv392/H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZQXChmNt4PzZ/4eVwmyyX7mfZRL2T0Esdhbo6eE3+oUqhqCw+C2pOiDTGwVqYO+Z
         7AaOmb82L7xZj1vAD6AZZkqqH0xFTdirm5qUOyKqDaBjllGzXnerFRkyalkUkiFMFC
         aksBgsnZUJALSLllmgle5Jecs+ILhWFQ+4fIDq94=
Date:   Thu, 17 Nov 2022 22:07:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.1-rc6
Message-ID: <Y3aiqDVXybMnLp8u@kroah.com>
References: <Y3YdxR2djUf0ibBC@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3YdxR2djUf0ibBC@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:40:53PM +0100, Johan Hovold wrote:
> The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:
> 
>   Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.1-rc6

Pulled and pushed out, thanks.

greg k-h

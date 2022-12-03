Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20924641578
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLCJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLCJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D7F03C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B190A60B1F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 09:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDA6C433D6;
        Sat,  3 Dec 2022 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670061272;
        bh=pLQ2L/Mrp0INf18KqUJ2KgcKihWNSnkL8VXdiqPXo5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlijKiKKIAfXTmZnj219NPka5vbb+z4wrmEy16+0ndxhosUpEHPfsOcYmHAYtYbyj
         ITroSYHBf/a7xpRjnnUFjGtFYohA/JIv9ul2TQ6FdrQXlWA3585Xpt+FC7dHTm5Kyj
         NmiP8LrMWnHWhMNs+GQj1AVT7rkzV3VmXs19/KyU=
Date:   Sat, 3 Dec 2022 10:54:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.2
Message-ID: <Y4sc1NXmKKnl8rSv@kroah.com>
References: <2d54b0bb-9252-a4be-7de5-a5b1bf7f2c37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d54b0bb-9252-a4be-7de5-a5b1bf7f2c37@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 03:17:00PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.2. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> I'm sorry for late pull request. If possible, could you apply this pull request?
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:
> 
>   Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.2

The key you have used to sign this has expired, I get this warning when
pulling:

# gpg: Good signature from "Chanwoo Choi (Personal) <cwchoi00@gmail.com>" [expired]
# gpg:                 aka "Chanwoo Choi <cw00.choi@samsung.com>" [expired]
# gpg:                 aka "Chanwoo Choi <chanwoo@kernel.org>" [expired]
# gpg: Note: This key has expired!

I'll take this now, but please update your key in the kernel.org gpg
keyring.

thanks,

greg k-h

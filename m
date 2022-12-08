Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED796472D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLHP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiLHP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:26:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC859875;
        Thu,  8 Dec 2022 07:26:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F7E61F84;
        Thu,  8 Dec 2022 15:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8F7C433D6;
        Thu,  8 Dec 2022 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670513197;
        bh=zH3WU8XIjSCEfm2YuNkP7lPrim2Sf1++0TNYgDrknMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxKKoPWg5ET5J8CcZs5qI7CkUbBSi0B0Apc9LxwP96xNctox2dplTsppdIMdwuunK
         B0exlYWSjSzpV5CNC40Dbw8TUYVn0XNZhKsrswNirpbjv3+3QMKP1mCdw6UerBcXHD
         72zUhV1jkuWoMUzrtanWCmphvkp4/Qgvsxe/XNc8=
Date:   Thu, 8 Dec 2022 16:26:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.2-rc1
Message-ID: <Y5ICIoF/gCcW2t+W@kroah.com>
References: <Y5HzA49I6EB1IlNr@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5HzA49I6EB1IlNr@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 03:21:55PM +0100, Johan Hovold wrote:
> The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:
> 
>   Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.2-rc1
> 

Pulled and pushed out, thanks.

greg k-h

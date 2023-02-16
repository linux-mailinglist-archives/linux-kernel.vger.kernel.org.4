Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30284699769
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBPO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBPO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:29:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49337497F0;
        Thu, 16 Feb 2023 06:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91A26115B;
        Thu, 16 Feb 2023 14:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA32C433D2;
        Thu, 16 Feb 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676557743;
        bh=/S8TEoZbYZLsh3LORAGmO3MM5If4gSgkNd7LdA2jAe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwoxpMkkdLcMoAxUiXSBMXsuhPiPkmyZ08qsv/mId8KhcRzt2GWM8T0cbXBaSKRug
         o9fEgbVfIE1hOOVrutU+lY8HI5HjjQBVuloS1EHf/V5EMhlUuxPjPnrCKb5t7Bkr+i
         cpD45Bgl5wA53yMMoMuQZIOitX8eCDIvUP1xzjek=
Date:   Thu, 16 Feb 2023 15:29:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.3-rc1
Message-ID: <Y+49rMtNQPXDH4cm@kroah.com>
References: <Y+43p6kp0kJN/slK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+43p6kp0kJN/slK@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:03:19PM +0100, Johan Hovold wrote:
> The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:
> 
>   Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.3-rc1

Pulled and pushed out, thanks.

greg k-h

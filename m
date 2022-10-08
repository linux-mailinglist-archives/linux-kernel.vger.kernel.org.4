Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D745F85EE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJHPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJHPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC154D271;
        Sat,  8 Oct 2022 08:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 889F3B80B8E;
        Sat,  8 Oct 2022 15:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B039C433D6;
        Sat,  8 Oct 2022 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665243806;
        bh=sDbtbSBEwlPcqKBCDGmCUP5vci73/2jmERn/cTwYIVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0iLdtjrPzaxRhvIhuQWhMsEnmR7QXzm4+YYyj0+e+8LGnxc/Q41CY0oRfsrkatqwt
         fFiEfyJyVDNFuw8HTYQwve0vNKcFlO9t6AzdFSLQqC8xtyZ2VXXgYgXaVXH+hC6brt
         hE5R2yBlSoSOjS1UWL5SdvZpx0AXj53AQHk9tSJU=
Date:   Sat, 8 Oct 2022 17:44:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     justinpopo6@gmail.com
Cc:     alcooperx@gmail.com, balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        f.fainelli@gmail.com
Subject: Re: [PATCH] usb: bdc: change state when port disconnected
Message-ID: <Y0Gax8SUoq59hdoF@kroah.com>
References: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 12:13:55PM -0700, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> When port is connected and then disconnected, the state stays as
> configured. Which is incorrect as the port is no longer configured,
> but in a not attached state.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_udc.c | 1 +
>  1 file changed, 1 insertion(+)

What commit id does this fix?  Should it go to older kernels?  If so,
how far back?

thanks,

greg k-h

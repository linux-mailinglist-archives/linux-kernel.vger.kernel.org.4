Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D51608C86
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJVLWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJVLWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926D31363;
        Sat, 22 Oct 2022 03:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F62260BE9;
        Sat, 22 Oct 2022 10:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C56C433C1;
        Sat, 22 Oct 2022 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666435934;
        bh=LHcXHiycfeGH4pS60pzEWUHjeot59PdVoCs895HZv6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls7hRvIuj1gQJ5ozqagr6o6ev7VC3u7cz3f0S50tw0XDM/DBSwtpi8mkPtLYjA38U
         34YmD8QV33+pD69n3JsCx4F87PIfIg4U3DtGRfVzug0sggCw/kEN8hUaj4LrJZsYGV
         yg/WsKNlPXZG7YalH21/M5QkNAv4gfI+UtqMc1JQ=
Date:   Sat, 22 Oct 2022 12:52:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     justinpopo6@gmail.com, alcooperx@gmail.com, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
Subject: Re: [PATCH] usb: bdc: change state when port disconnected
Message-ID: <Y1PLW2t7X9DHVd7I@kroah.com>
References: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
 <Y0Gax8SUoq59hdoF@kroah.com>
 <f0706380-94f9-ed7d-1033-8da51aab6b01@gmail.com>
 <81528485-fa80-55ab-16ce-84de520f5262@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81528485-fa80-55ab-16ce-84de520f5262@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:05:42PM -0700, Florian Fainelli wrote:
> On 10/10/22 07:58, Florian Fainelli wrote:
> > 
> > 
> > On 10/8/2022 8:44 AM, Greg KH wrote:
> > > On Wed, Oct 05, 2022 at 12:13:55PM -0700, justinpopo6@gmail.com wrote:
> > > > From: Justin Chen <justinpopo6@gmail.com>
> > > > 
> > > > When port is connected and then disconnected, the state stays as
> > > > configured. Which is incorrect as the port is no longer configured,
> > > > but in a not attached state.
> > > > 
> > > > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > > > ---
> > > >   drivers/usb/gadget/udc/bdc/bdc_udc.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > 
> > > What commit id does this fix?  Should it go to older kernels?  If so,
> > > how far back?
> > 
> > This would be:
> > 
> > Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0
> > device controller IP BDC")
> > 
> > that issue was present since the driver was included in Linux with the
> > commit above, we did not really consider it to be a serious enough bug,
> > but I suppose it would not hurt to affix the said Fixes tag.
> 
> Greg, are you picking up the patch as-is, or do you need Justin to resusbmit
> with the Fixes: tag added?

Now merged, thanks.

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45857682BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAaLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjAaLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:51:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619D5FE6;
        Tue, 31 Jan 2023 03:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95374614BB;
        Tue, 31 Jan 2023 11:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9E9C433AF;
        Tue, 31 Jan 2023 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675165875;
        bh=wOrERF5X5WEzWRIC0mThKgFJ6snvf78JNjJijHRaCCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZE9U5TsAQP9zhwXWCH0H3VP7fhzly0OK10EmV8z40Wauno6uy7y0WRB+N2Nw91no4
         OWQFMEnkZb9j4gLMrw8mmmWp7N86PmanrpDUFgu4+C48owW6+ZIygs/sVuWEIFaQr/
         4iqMbuzvzpxJcIUGVPJLy9fp5+K2ydaTM5jo6da8=
Date:   Tue, 31 Jan 2023 12:51:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: add doc to struct usb_composite_dev
Message-ID: <Y9kAryJ6Y2lQyKZK@kroah.com>
References: <Y86cy1AM4w5ju5A4@kroah.com>
 <Y9FmWVF+J08V4RbP@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9FmWVF+J08V4RbP@jo-einhundert>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:26:49PM +0100, Jó Ágila Bitsch wrote:
> Added documentation to the new struct members:
> * bcd_webusb_version
> * b_webusb_vendor_code
> * landing_page
> * use_webusb
> to avoid warnings in the build of htmldocs
> 
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>

You forgot a Reported-by: tag?

Also didn't cc: the linux-usb mailing list?

please fix up and send v2.

thanks,

greg k-h

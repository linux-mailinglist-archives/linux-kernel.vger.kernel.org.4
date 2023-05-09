Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4C6FBD56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjEICjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjEICjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B39025
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C695562AD5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D46C433EF;
        Tue,  9 May 2023 02:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683599989;
        bh=EUaU81xWJx9WG0nay9EqYTRkER2XdBgXE7vJ7tWle2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORfpTfCofdGii5ANlEoU0s2sNsqmALyuMGsXW5P7OLQ/nn3OJE5kgU8iAOqI+5aPL
         jDUzPu44GhgD0l10EFmT+cOrlHtVmBZdIqoavieUMVa1Nv7Ve+e6wCjrufnxqpwZsg
         0/+WxQDZErKr+bnDfCsqeUm8Fo7KrM8qNBOIVngQ=
Date:   Tue, 9 May 2023 04:39:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Seo <james@equiv.tech>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: device.h: add some missing kerneldocs
Message-ID: <2023050929-referable-exponent-d4a1@gregkh>
References: <20230508154849.1946589-1-james@equiv.tech>
 <ZFkftcxqQRblDgzX@equiv.tech>
 <0a75a41e-6458-8f7a-67cd-89eb05eb822f@infradead.org>
 <ZFmnGGzcTPdrvJrn@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmnGGzcTPdrvJrn@equiv.tech>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 06:51:20PM -0700, James Seo wrote:
> On Mon, May 08, 2023 at 11:55:47AM -0700, Randy Dunlap wrote:
> > On 5/8/23 09:13, James Seo wrote:
> >> On Mon, May 08, 2023 at 08:48:50AM -0700, James Seo wrote:
> >>> Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
> >>> which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
> >>> not #defined, and is aliased to DEVICE_ATTR() otherwise).
> >>>
> >>> Signed-off-by: James Seo <james@equiv.tech>
> >>> ---
> >> 
> >> I just noticed that there shouldn't be a "not" before "#defined" in the
> >> last line of the commit message. Apologies.
> >> 
> > 
> > Other than that (above), LGTM.
> > 
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > -- 
> > ~Randy
> 
> Thanks for the review!
> 
> Just to be clear, that line should read "defined, and is aliased to..."
> as commit messages can't have lines that begin with '#'.

Please fix that up and send a new version please.

thanks,

greg k-h

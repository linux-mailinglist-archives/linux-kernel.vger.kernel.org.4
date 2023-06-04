Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A29721564
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFDHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:55:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8EB3;
        Sun,  4 Jun 2023 00:55:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126166129043.28.openmobile.ne.jp [126.166.129.43])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 141802CF;
        Sun,  4 Jun 2023 09:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685865281;
        bh=xt00KtUczUl17VBnLWNqDHDGohytnuLgvkDs6o9FWZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTwhp6mltUxHP5iYLLeizrhqjSSw04iJWEdVBK91ol8Tn6jaWPxzfVFBZ/WcDDEnt
         fvcckOeZsp/t94pwWOpJk7/0bkewPzKANXGMIWVcy59hezc52SmR/l95H2ONomOVH6
         USDTBxzAji7IafCKhbHB265FUdWXjLUoc8fHh7es=
Date:   Sun, 4 Jun 2023 10:55:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Avichal Rakesh <arakesh@google.com>, dan.scally@ideasonboard.com,
        thinh.nguyen@synopsys.com, etalvala@google.com,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: uvc: clean up comments and styling in
 video_pump
Message-ID: <20230604075504.GQ26944@pendragon.ideasonboard.com>
References: <20230602211602.3b7rfa252wliiszp@synopsys.com>
 <20230602220455.313801-1-arakesh@google.com>
 <2023060434-reveler-twice-d92e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023060434-reveler-twice-d92e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Jun 04, 2023 at 09:43:40AM +0200, Greg KH wrote:
> On Fri, Jun 02, 2023 at 03:04:55PM -0700, Avichal Rakesh wrote:
> > This patch elaborates on some of the edge cases handled by
> > video_pump around setting no_interrupt flag, and brings the
> > code style in line with rest of the file.
> 
> When you say "and" that usually means it should be a separate patch.
> 
> But I really don't see what coding style changes you made here, what was
> it?
> 
> I can't see any logical changes made here, am I missing them?  Or is
> this all just a style-cleanup patch?

It's all style cleanup (variable declaration ordering), typo fixes, and
naming and documentation improvement, yes. I reviewed Avichal's original
patch when coming back from holidays, neither of us realizing that you
had merged it already. He sent a v2 and got told to rebase it on top of
your tree.  That's what v3 is, just handling the review comments.

I generally ask for patches to be split with one change per patch, but
given the small changes bundled here, and the fact that all of this just
incorporates the review comments, I think it would be a bit overkill.

-- 
Regards,

Laurent Pinchart

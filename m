Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9262181C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiKHPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiKHPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:24:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379381B1ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4E3EB81B24
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A8C433D6;
        Tue,  8 Nov 2022 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667921039;
        bh=pGa3kMUhkeVYwx9VwwV88DIO73kHEJXQzYlqd3eNCWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqqXD6bl/qT/EVqpBmio0doghGB5OK9tbBW/A7HChDqmGOYH6IKaA8KE83eCVz64r
         k1RNKpbnhuhqOEeELuDi0wLvZKXa+qIJ1On9oB5wcxynbNo/CAzsEOiIrAQCccCloB
         4y3L+gVgJRiGcxdfRIIffgf2ZscnkfOkITo6eol8=
Date:   Tue, 8 Nov 2022 16:23:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] staging: rtl8192e: rename tables in r8192e_hwimg.c
Message-ID: <Y2p0jDSZXAsjQl2U@kroah.com>
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
 <01eb4d9cb22be5f76aa39eedd406577cdfd9f486.1667723306.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01eb4d9cb22be5f76aa39eedd406577cdfd9f486.1667723306.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 07:31:16PM +1100, Jacob Bai wrote:
> fix camel case issue.
> 
> Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

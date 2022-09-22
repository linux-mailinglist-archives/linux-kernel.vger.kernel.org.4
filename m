Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD45E5D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIVIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:23:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE8B07C7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8125B834F9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D46C433D6;
        Thu, 22 Sep 2022 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663835020;
        bh=8ydo7zEbF37NQc6ihzhC1IDYRnbM59UIfra3K6Ko6rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlR/zQVtQAtCMDvL1Lqw9H+TmPRnhJo+vrN43lkgErTuS23lJZcxNYuF4wn364HAJ
         s7mXXd6D7g62rAGSjNt0sjaYzvOmGDynXZEJB6r5+mMs3MFwDZnJxzILJCEwX+oLf7
         AK5WJhCukS/UKtxgmQ/Hs64+DBqlKwfTlpVXo6A8=
Date:   Thu, 22 Sep 2022 10:23:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anjandev Momi <anjan@momi.ca>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4 v2] Staging: rtl8192e: fix coding style issues
Message-ID: <YywbiMrkZa3ELJlb@kroah.com>
References: <20220922075922.20523-1-anjan@momi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922075922.20523-1-anjan@momi.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:59:19AM -0400, Anjandev Momi wrote:
> This patch series fixes various checkpatch.pl issues: removes unnecessary
> parentheses, removes multiple blank lines, aligns multiple line function calls
> to open paranthesis, and adds a blank line after function declaration.
> 
> Anjandev Momi (4):
>   Staging: rtl8192e: remove unnecessary parentheses
>   Staging: rtl8192e: remove multiple blank lines
>   Staging: rtl8192e: make alignment match open parenthesis
>   Staging: rtl8192e: add blank line after function declaration
> 
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> -- 
> 2.36.2
> 


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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

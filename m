Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796526DBA6A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDHL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjDHL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA73AF3E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A56860F30
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 11:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456E3C433D2;
        Sat,  8 Apr 2023 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680953363;
        bh=3hCUEw4+sq86IrKsrawaMlZ/p+hC7wvYN9WX4oBCENs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zty+tYDanBiDXGRzHxC0jelAYSRHyLIyaHWQs6SIIuIhblUf6u24ZpRowl/HM4CN9
         xURvUPcdeJeCgE+iNpxnlJqwU2Uj/vYbLtDG7ot0IL+OIEqjkfv25nd3NwQY/i1gzH
         SHG8lao4dg5ZakDy2EGpCPQhI3024xorut+dd744=
Date:   Sat, 8 Apr 2023 13:29:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for enums
Message-ID: <2023040806-revise-tiptoeing-81a3@gregkh>
References: <20230407130543.GA32964@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407130543.GA32964@koolguy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 03:05:43PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning for enums in drivers/staging/octeon/octeon-stubs.h:
> cvmx_helper_interface_mode_t,
> cvmx_spi_mode_t,
> cvmx_pow_wait_t,
> cvmx_pko_lock_t,
> cvmx_pko_status_t
> 
> Change typedef cvmx_helper_interface_mode_t to
> enum cvmx_helper_interface_mode in ethernet.c
> 
> Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
> ---
>  drivers/staging/octeon/ethernet.c     |  2 +-
>  drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++++------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
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
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E26BE1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCQHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:37:36 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99395591CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zyt1cfw0jYCCk9h4gwhTQKl7e2xx/66T6CVpLRuvcDQ=;
  b=XoYZKsvA7xdaR+qNoowkvAMiYnJ3UNtqu2dJ8KyBd/F9UObeH3YTEoN7
   6Dl9flD4+HZ0P7Fm4EIhe7xwwgRmK45KEQVXdF+XyTHWCMbdM71xh8bq0
   M35q2qceBnvCODC8J/2ochsodSdIfMDxDeaSxnqUUedJzJu8cJ4ZWXjZd
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97686576"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:37:33 +0100
Date:   Fri, 17 Mar 2023 08:37:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
cc:     drv@mailo.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v4] Staging: octeon: Fix line ending with '('
In-Reply-To: <20230317071352.GA83845@sumitra.com>
Message-ID: <5b46f3a3-d12-299b-7223-df46ce90166c@inria.fr>
References: <20230317052455.GA83442@sumitra.com> <alpine.DEB.2.22.394.2303170700270.3105@hadrien> <20230317071352.GA83845@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2023, Sumitra Sharma wrote:

> On Fri, Mar 17, 2023 at 07:03:08AM +0100, Julia Lawall wrote:
> >
> >
> > On Thu, 16 Mar 2023, Sumitra Sharma wrote:
> >
> > > Since the coding style limited the code to 80 columns per line which caused
> > > splitting the function header into two lines resulted in the first line
> > > ending with a '('. This caused the checkpatch error.
> >
> > The first sentence is still not really grammatical.  Something like:
> >
> > The coding style used to limit lines to 80 characters, which led to
> > splitting this function header into multiple lines, and ending thie first
> > line with a (.
> >
> > For checkpatch, is it an error or a warning?
> >
>
> HI julia,
>
> Yes, you are correct, I did the mistake its not the error but a check.
>
> How about this...
>
> ###
> The coding style used to limit lines to 80 characters, which led to splitting
> this function header into multiple lines and ending the first line with a '('.
> This split causes a check reported by the checkpatch.
>
> Place the function parameters immediately after '(' in a single line to
> align the function header.
> ###

Looks better.

thanks,
julia

>
>
> Thank you for your reviews.
>
> Regards,
> Sumitra
>
> > julia
> >
> > >
> > > Place the function parameters immediately after '(' in a single
> > > line to align the function header.
> > >
> > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > ---
> > > v2: Change patch subject and description
> > >
> > > v3: Change patch description, noted by Deepak R Varma
> > > <drv@mailo.com>
> > >
> > > v4: Correct grammartical mistakes, noted by Julia Lawall
> > > <julia.lawall@inria.fr>
> > >
> > >
> > >
> > >  drivers/staging/octeon/octeon-stubs.h | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > > index 7a02e59e283f..3e7b92cd2e35 100644
> > > --- a/drivers/staging/octeon/octeon-stubs.h
> > > +++ b/drivers/staging/octeon/octeon-stubs.h
> > > @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> > >  						  int32_t value)
> > >  { }
> > >
> > > -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> > > -	int interface,
> > > -	int port)
> > > +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
> > >  {
> > >  	union cvmx_gmxx_rxx_rx_inbnd r;
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > >
>

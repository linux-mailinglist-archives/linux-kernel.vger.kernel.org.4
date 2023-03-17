Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F46BE0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCQGDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQGDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:03:18 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703D1A954
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fZE3ggHJNsZfkLW7wCYCJRh4/54CE8SDzqVvpVQdM3Y=;
  b=LJkeq2I14MVqryaYlY9CP1yklyuvm1sNFGGWjoCPZ8B+xGbKuhjBYq3j
   Cd4hfMPd55R7NL7i/tOD4IvN2kn1BXSz+d5uwPfo7VUpD6umCl3qOhkVn
   1VMxk8QUioEnQedMiZc7uzTskt/KKIsfK9Jf4iTlJ8mkGl1g+STDsNkOc
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="97675621"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:03:08 +0100
Date:   Fri, 17 Mar 2023 07:03:08 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumitra Sharma <sumitraartsy@gmail.com>
cc:     drv@mailo.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v4] Staging: octeon: Fix line ending with '('
In-Reply-To: <20230317052455.GA83442@sumitra.com>
Message-ID: <alpine.DEB.2.22.394.2303170700270.3105@hadrien>
References: <20230317052455.GA83442@sumitra.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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



On Thu, 16 Mar 2023, Sumitra Sharma wrote:

> Since the coding style limited the code to 80 columns per line which caused
> splitting the function header into two lines resulted in the first line
> ending with a '('. This caused the checkpatch error.

The first sentence is still not really grammatical.  Something like:

The coding style used to limit lines to 80 characters, which led to
splitting this function header into multiple lines, and ending thie first
line with a (.

For checkpatch, is it an error or a warning?

julia

>
> Place the function parameters immediately after '(' in a single
> line to align the function header.
>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
> v2: Change patch subject and description
>
> v3: Change patch description, noted by Deepak R Varma
> <drv@mailo.com>
>
> v4: Correct grammartical mistakes, noted by Julia Lawall
> <julia.lawall@inria.fr>
>
>
>
>  drivers/staging/octeon/octeon-stubs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 7a02e59e283f..3e7b92cd2e35 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
>  						  int32_t value)
>  { }
>
> -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> -	int interface,
> -	int port)
> +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
>  {
>  	union cvmx_gmxx_rxx_rx_inbnd r;
>
> --
> 2.25.1
>
>
>

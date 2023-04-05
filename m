Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7266D76AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbjDEISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbjDEISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:18:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C71BEA;
        Wed,  5 Apr 2023 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682731; x=1712218731;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mQQPj6i078SAwQLMyeQrAvgZg4bOovjLPAaM+2lUrCI=;
  b=LC5/VB3LTGh/x/x1I9cSyNBu/9umO/j+XYhE9WPyJBrKe5aeyt4kGhcR
   B5TniE6vXx9WtR0qDBczhnd9DE6l2Dmit4bvAqKoX6LFoXxhcD7v5EGo+
   DVhbAwKXnr1b8E6mqFLkCZoMaKgW7Tn/d/4KHMioJfR6UAVpC9gd3MLYS
   nMm3vO2WQzPq3poZatIuVCO2kz/WfZ7E/0xEDzqjOu8MGGQ+wp4Ff9HHY
   Q5UEenxLnCfoDXvMvvKHNrGEmE4Jncu8fgzQAWTRZbIWOuuOYwBfl7gQl
   g2AbVn/5kTxiozb3ZFqHCnu9L24o/bgH0eYTkG8QYCdEMH9rVMFOO6jtS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330998154"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="330998154"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755934318"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="755934318"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:18:49 -0700
Date:   Wed, 5 Apr 2023 11:18:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] tty: n_gsm: add missing description to gsm_config
In-Reply-To: <20230405054730.3850-3-daniel.starke@siemens.com>
Message-ID: <9d7289fe-7a3-2cfe-b023-a892528044e4@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-3-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, all available structure fields in gsmmux.h except those
> for gsm_config are commented.
> 
> Fix this by adding appropriate comments to the not commented fields.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  include/uapi/linux/gsmmux.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 33ee7b857c52..422a52e184b3 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -8,17 +8,17 @@
>  
>  struct gsm_config
>  {
> -	unsigned int adaption;
> -	unsigned int encapsulation;
> -	unsigned int initiator;
> -	unsigned int t1;
> -	unsigned int t2;
> -	unsigned int t3;
> -	unsigned int n2;
> -	unsigned int mru;
> -	unsigned int mtu;
> -	unsigned int k;
> -	unsigned int i;
> +	unsigned int adaption;	/* Convergence layer type */
> +	unsigned int encapsulation; /* Framing (0 = basic option, 1 = advanced option) */
> +	unsigned int initiator;	/* Initiator or responder */
> +	unsigned int t1;	/* Acknowledgment timer */
> +	unsigned int t2;	/* Response timer for multiplexer control channel */
> +	unsigned int t3;	/* Response timer for wake-up procedure */
> +	unsigned int n2;	/* Maximum number of retransmissions */
> +	unsigned int mru;	/* Maximum incoming frame payload size */
> +	unsigned int mtu;	/* Maximum outgoing frame payload size */

I'm used to "payload" referring in networking context to "useful" part of 
the frame but MTU/MRU probably includes headers too? Maybe just say "frame 
size"?

> +	unsigned int k;		/* Window size */
> +	unsigned int i;		/* Frame type (1 = UIH, 2 = UI) */
>  	unsigned int unused[8];	/* Can not be used */
>  };
>  
> 

-- 
 i.


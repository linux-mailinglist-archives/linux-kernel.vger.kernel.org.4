Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF526DA521
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbjDFV7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbjDFV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:58:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D808B456
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680818315; x=1712354315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kdKSu0Ilf3scrWldP6tXEaPIfWisiYg96qJ2ydXFqLQ=;
  b=iPnK82++uVYH8Qszv8redkWJaTMx5yRRmnXyMJkpIhTW6xuX+1eKF1eW
   HqdnH95MS4I3E+JT6j5VPP0vLKWyPEApLsr0oOqCIoypJXe9NI50uiWU3
   azbGmubUZK+A6a7pmMbMvCPbrZVDYOu50IROtdCsDqsQPpvNESi7ECcf9
   Yxk1yI2v6ylWxBoOuwE5XQvYgx2d35cPLCCMjPWPEtaMEsvc3TD/Fi51Q
   jYlNMA5Y5uRJU46H+8IzNIUQAUE2pJYYao3nGkZLMkA31qsxoVun+bo59
   P0a9VU8N8M3OIFbHEAfkNDPzi31hbyv77xG0n7oKjiQ3qybpOJP42Adqq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="405667971"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405667971"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 14:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="664652583"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="664652583"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.219.12])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 14:58:34 -0700
Date:   Thu, 6 Apr 2023 14:58:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for
 cvmx_fau_op_size
Message-ID: <ZC9AieBk+Z9Sgn/b@aschofie-mobl2>
References: <20230405181841.GA6820@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405181841.GA6820@koolguy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:18:41PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning: do not add new typedefs in
> drivers/staging/octeon/octeon-stubs.h:216
> 
> Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 3e7b92cd2e35..9f269626b862 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
>  	CVMX_FAU_OP_SIZE_64 = 3
>  };
>  
> -typedef enum {
> +enum cvmx_spi_mode {
>  	CVMX_SPI_MODE_UNKNOWN = 0,
>  	CVMX_SPI_MODE_TX_HALFPLEX = 1,
>  	CVMX_SPI_MODE_RX_HALFPLEX = 2,
>  	CVMX_SPI_MODE_DUPLEX = 3
> -} cvmx_spi_mode_t;
> +};

Commit msg says typedef cvmx_fau_op_size was removed, not this one.

>  
>  typedef enum {
>  	CVMX_HELPER_INTERFACE_MODE_DISABLED,
> @@ -1362,7 +1362,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
>  }
>  
>  static inline int cvmx_spi_restart_interface(int interface,
> -					cvmx_spi_mode_t mode, int timeout)
> +					enum cvmx_spi_mode mode, int timeout)
>  {
>  	return 0;
>  }
> -- 
> 2.25.1
> 

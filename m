Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311326DA262
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjDFUMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjDFUMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:12:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E4CE69
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680811948; x=1712347948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lnZfiEm0t47fXTNeAj48dJNb8xnqyOJMjzTZLqVN6Iw=;
  b=FZFZtelsLzSyOMMdGb0K+vuQ4/RnloZuiWb79lugpLFy8WeNtNKsD+rK
   ESOIe8UpC/nntCm15g8Qrr+NHGWlV9FA7QFxOved84TsWXha258Zf+Mg0
   4nXQpVucYVtGTTq+rgKAb28/4M+3UbN/mJZwVcS8DeWv5rdytA5lwjtZV
   TG04HV4+qEkpXXrZMgcyGqiqgjWPMW7+9Qu4jJEgN1uUcDo6t2q6BUz8y
   BS9GYRjLUZGxedVkZf2lVvGotVAAPzkY3rw2mCqei2Pm/0lZadJizUlpj
   DJk7oMzgj/1nfkJCuV5xNsoohqzuKsekE83opyClnfIOOKw03Z2ZR090g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407955363"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407955363"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861528525"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861528525"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.219.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:12:24 -0700
Date:   Thu, 6 Apr 2023 13:12:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for
 cvmx_fau_op_size
Message-ID: <ZC8nphkEYdrMvRg2@aschofie-mobl2>
References: <20230405181841.GA6820@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405181841.GA6820@koolguy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:18:41PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning: do not add new typedefs in
> drivers/staging/octeon/octeon-stubs.h:216

There are a few more of these 'typedef enum' is this file.
I believe it would be OK to bundle the changes together in one patch.
Perhaps you are going to come back with additional patches. 

There appears to be an inconsistent style with how the enums are
actually enumerated in this file.  cvmx_pow_wait_t is esp odd.

Alison

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

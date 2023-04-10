Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C396DC9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDJRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDJRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:07:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83A1FC3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681146437; x=1712682437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XA+xPMbSaSeMbe/zeukVKgHgF9UxfEMsFmYINUq+nCE=;
  b=FjEEka5Uq7ShiizoG6wRCyQQXaNasOv/CrlQr7ZfRJ1CJ5hf5xlaDdEq
   wvd1XYYElCxwkWziZmKKlBbGHI3Cy/JOEaCs+boOMvb2eU7XnbsROMsgd
   6w+GcyadvLHzCS0Z5OrAnUGg49CbwNEhOBWF1cHdQtbeNUaIJWWiElqsU
   Mevbtlzl7jnDhu2HkJPWxpwPfGFn+ZJpMdITTujoHbjI7mcTE6xTW82OE
   GTDkzl3KM2CWIWuEbaAjVAin0j8mVX97borIyLfPJp0z9qo9lEiJLYHbe
   UR+oLWLvwcq6H837A2kSAc3vxJb6I78XRjOUCgFhwRojy6GbVqGt5HXQp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340893984"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="340893984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 10:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638516862"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638516862"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.230.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 10:07:16 -0700
Date:   Mon, 10 Apr 2023 10:07:14 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for enums in
 octeon-stubs
Message-ID: <ZDRCQuXMxGwVA5Ei@aschofie-mobl2>
References: <20230410150852.GA57989@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410150852.GA57989@koolguy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 05:08:52PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:

Hi Dalvin-Ehinoma,

I recognize this as a revision of an earlier patch. It needs to be
labeled [PATCH v2] in your subject line and a changelog included.

How to revise and resend patches:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://kernelnewbies.org/PatchPhilosophy

Checkpatch is emitting this warning:
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#56:
Fix checkpatch.pl warning for enums in drivers/staging/octeon/octeon-stubs.h:

Alison

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
>  drivers/staging/octeon/octeon-stubs.h | 39 +++++++++++++--------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 9eee28f2940c..023b107e077a 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
>  
>  	num_interfaces = cvmx_helper_get_number_of_interfaces();
>  	for (interface = 0; interface < num_interfaces; interface++) {
> -		cvmx_helper_interface_mode_t imode =
> +		enum cvmx_helper_interface_mode imode =
>  		    cvmx_helper_interface_get_mode(interface);
>  		int num_ports = cvmx_helper_ports_on_interface(interface);
>  		int port;
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 3e7b92cd2e35..58708a7f727a 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
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
> -typedef enum {
> +enum cvmx_helper_interface_mode {
>  	CVMX_HELPER_INTERFACE_MODE_DISABLED,
>  	CVMX_HELPER_INTERFACE_MODE_RGMII,
>  	CVMX_HELPER_INTERFACE_MODE_GMII,
> @@ -231,20 +231,20 @@ typedef enum {
>  	CVMX_HELPER_INTERFACE_MODE_PICMG,
>  	CVMX_HELPER_INTERFACE_MODE_NPI,
>  	CVMX_HELPER_INTERFACE_MODE_LOOP,
> -} cvmx_helper_interface_mode_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pow_wait {
>  	CVMX_POW_WAIT = 1,
>  	CVMX_POW_NO_WAIT = 0,
> -} cvmx_pow_wait_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pko_lock {
>  	CVMX_PKO_LOCK_NONE = 0,
>  	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
>  	CVMX_PKO_LOCK_CMD_QUEUE = 2,
> -} cvmx_pko_lock_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pko_status {
>  	CVMX_PKO_SUCCESS,
>  	CVMX_PKO_INVALID_PORT,
>  	CVMX_PKO_INVALID_QUEUE,
> @@ -252,7 +252,7 @@ typedef enum {
>  	CVMX_PKO_NO_MEMORY,
>  	CVMX_PKO_PORT_ALREADY_SETUP,
>  	CVMX_PKO_CMD_QUEUE_INIT_ERROR
> -} cvmx_pko_status_t;
> +};
>  
>  enum cvmx_pow_tag_type {
>  	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
> @@ -1265,8 +1265,7 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
>  					    cvmx_pko_port_status_t *status)
>  { }
>  
> -static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
> -								   interface)
> +static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int interface)
>  {
>  	return 0;
>  }
> @@ -1342,11 +1341,11 @@ static inline unsigned int cvmx_get_core_num(void)
>  }
>  
>  static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
> -						       cvmx_pow_wait_t wait)
> +						       enum cvmx_pow_wait wait)
>  { }
>  
>  static inline void cvmx_pow_work_request_async(int scr_addr,
> -					       cvmx_pow_wait_t wait)
> +					       enum cvmx_pow_wait wait)
>  { }
>  
>  static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
> @@ -1356,13 +1355,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
>  	return wqe;
>  }
>  
> -static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
> +static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
>  {
>  	return (void *)(unsigned long)wait;
>  }
>  
>  static inline int cvmx_spi_restart_interface(int interface,
> -					cvmx_spi_mode_t mode, int timeout)
> +				       enum cvmx_spi_mode mode, int timeout)
>  {
>  	return 0;
>  }
> @@ -1381,12 +1380,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
>  }
>  
>  static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
> -						cvmx_pko_lock_t use_locking)
> +						enum cvmx_pko_lock use_locking)
>  { }
>  
> -static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> -		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> -		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> +static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
> +		    uint64_t queue, union cvmx_pko_command_word0 pko_command,
> +		    union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
>  {
>  	return 0;
>  }
> -- 
> 2.25.1
> 

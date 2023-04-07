Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616B6DB114
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDGREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGREW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:04:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749086B8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887060; x=1712423060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+n0pZ7vw6ifdwNLSUmWbA6Iwy+yVZIyKp1B2kL5N+TM=;
  b=PX2vrf3tXe9R+iVOhr0lDhiYwxmeARaOv5DklxyWg9svLUg63Ko5cTao
   nPON8cHj1cYch5klD2UsKFa1T4wyvUKHc7HVOaZXJD6Oj+u2BHyLrnfwk
   kezKeqBsk59EXx6LmGhNqCg7yCU4PaVx00TSjkDf0etiNT9eIyHl34Scf
   s8HJTKMhWM8Gv+9/IuTtKsNV1xkVBkrC0FuXQCyPrhvoIEDqqMkP2EJVE
   m2IC/WYuIuqaXNEn8Z+UbZ6TyG3shWeks+611nuaS6wHb9OJOaKbXMabm
   ymxAjYHpktf81HamCpcPeumJ6la0KyvJ3cIazuZyl1n3s1UbGu8Ot++jM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="323399840"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="323399840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681085981"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681085981"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.207.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:04:19 -0700
Date:   Fri, 7 Apr 2023 10:04:17 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for enums
Message-ID: <ZDBNEdpV0VcqMbPY@aschofie-mobl2>
References: <20230407130543.GA32964@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407130543.GA32964@koolguy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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
> index 3e7b92cd2e35..3d613dc725e8 100644
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
> @@ -1257,15 +1257,17 @@ static inline int octeon_is_simulation(void)
>  	return 1;
>  }
>  
> -static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
> +static inline void cvmx_pip_get_port_status(uint64_t port_num,
> +					    uint64_t clear,
>  					    cvmx_pip_port_status_t *status)
>  { }
>  
> -static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
> +static inline void cvmx_pko_get_port_status(uint64_t port_num,
> +					    uint64_t clear,
>  					    cvmx_pko_port_status_t *status)
>  { }
>  
> -static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
> +static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
>  								   interface)
>  {
>  	return 0;
> @@ -1342,11 +1344,11 @@ static inline unsigned int cvmx_get_core_num(void)
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
> @@ -1356,13 +1358,14 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
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
> +					     enum cvmx_spi_mode mode,
> +					     int timeout)
>  {
>  	return 0;
>  }
> @@ -1380,13 +1383,16 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
>  	return r;
>  }
>  
> -static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
> -						cvmx_pko_lock_t use_locking)
> +static inline void cvmx_pko_send_packet_prepare(uint64_t port,
> +						uint64_t queue,
> +						enum cvmx_pko_lock use_locking)
>  { }
>  
> -static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> -		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> -		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> +static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
> +							    uint64_t queue,
> +							    union cvmx_pko_command_word0 pko_command,
> +							    union cvmx_buf_ptr packet,
> +							    enum cvmx_pko_lock use_locking)

This introduces a new checkpatch WARNING -
WARNING: line length of 101 exceeds 100 columns
#158: FILE: drivers/staging/octeon/octeon-stubs.h:1395:

What happens if you leave the alignment as is, and only make the 'enum'
related changes? 

You can send another patch in the future to address the alignment
CHECK's. That follows the one type of change per patch guideline.

Alison

>  {
>  	return 0;
>  }
> -- 
> 2.25.1
> 

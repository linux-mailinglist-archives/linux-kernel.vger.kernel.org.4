Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3256C819C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjCXPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjCXPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:41:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968A2201F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679672493; x=1711208493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OstU8LE34yvquXnPkkLldI/Jk6/9+ifZ6noCd0IJf8g=;
  b=FgT7iIg6rTBSZp1IMacZyLoILec1s3nfmgk2MSM0O/jrps6AnT3tijO8
   RVrosbQ5F8TDsVEQQf0CprunjkHyvLTMjjv28fzroWTxHn5K0PCYLkVKo
   gMLNZGdWEyTo26YghQSvACBEeIYT0tBw5ehZ2bet8YCvfCYG9nr7ukR5S
   vw8Do328H1VnpM68JQGDH/WQkLR4s53hqBGvm7PcxFejuSFeMl+FQe4tH
   oJg+XSeVqhfsDO4naoLue3gKUWeEvXkXS6uMsB5+gQawParUqAcg+PsyY
   VmFEzLzQ4Kolg4nJAEHLdQ3BwJ5VKRmLR0S901r+hhSmt8MZyIUUymO6L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339831769"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="339831769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="1012290296"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="1012290296"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.66])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:41:13 -0700
Date:   Fri, 24 Mar 2023 08:41:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: rtl8192e: remove extra blank lines
Message-ID: <ZB3ElynSQl98E6rf@aschofie-mobl2>
References: <cover.1679598576.git.kamrankhadijadj@gmail.com>
 <43d5864fc42e51089a0a0626278204bac8313eb0.1679598576.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d5864fc42e51089a0a0626278204bac8313eb0.1679598576.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:19:59AM +0500, Khadija Kamran wrote:
> Remove extra blank lines as reported by checkpatch.pl
> 
> "CHECK: Please don't use multiple blank lines"

Commit log needs to say why you did it, why this patch need to be
merged. Checkpatch itself doesn't satisfy the why requirement.

When we do these white space cleanups, the why is typically
"to adhere to the Linux kernel coding-style."

If you are doing a particular checkpatch cleanup and are not
sure what to write, check your predecessors.

$ git log --oneline | grep "multiple blank lines"

That'll give you many instances. Reference a few, some poor ones
sneak through.

Alison

> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_rx.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index c394c21beefb..c6114d99829b 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -154,7 +154,6 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
>  	return skb;
>  }
>  
> -
>  /* Called only as a tasklet (software IRQ) */
>  static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
>  					   struct rtllib_hdr_4addr *hdr)
> @@ -318,7 +317,6 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
>  	return res;
>  }
>  
> -
>  /* Called only as a tasklet (software IRQ), by rtllib_rx */
>  static inline int
>  rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
> @@ -355,7 +353,6 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
>  	return 0;
>  }
>  
> -
>  /* this function is stolen from ipw2200 driver*/
>  #define IEEE_PACKET_RETRY_TIME (5*HZ)
>  static int is_duplicate_packet(struct rtllib_device *ieee,
> @@ -887,7 +884,6 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
>  	return rxb->nr_subframes;
>  }
>  
> -
>  static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
>  				   struct sk_buff *skb,
>  				   struct rtllib_rx_stats *rx_stats)
> @@ -1569,7 +1565,6 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
>  	return 0;
>  }
>  
> -
>  /* Parse a QoS parameter element */
>  static int rtllib_read_qos_param_element(
>  			struct rtllib_qos_parameter_info *element_param,
> @@ -1599,7 +1594,6 @@ static int rtllib_read_qos_info_element(
>  	return rtllib_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
>  }
>  
> -
>  /* Write QoS parameters from the ac parameters. */
>  static int rtllib_qos_convert_ac_to_parameters(struct rtllib_qos_parameter_info *param_elm,
>  					       struct rtllib_qos_data *qos_data)
> @@ -1843,7 +1837,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
>  		}
>  	}
>  
> -
>  	if (*tmp_htinfo_len == 0) {
>  		if (info_element->len >= 4 &&
>  		    info_element->data[0] == 0x00 &&
> @@ -1932,7 +1925,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
>  	    info_element->data[2] == 0x96)
>  		network->cisco_cap_exist = true;
>  
> -
>  	if (info_element->len >= 3 &&
>  	    info_element->data[0] == 0x00 &&
>  	    info_element->data[1] == 0x0a &&
> @@ -2142,13 +2134,11 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
>  
>  			network->dtim_data = RTLLIB_DTIM_VALID;
>  
> -
>  			if (info_element->data[2] & 1)
>  				network->dtim_data |= RTLLIB_DTIM_MBCAST;
>  
>  			offset = (info_element->data[2] >> 1)*2;
>  
> -
>  			if (ieee->assoc_id < 8*offset ||
>  			    ieee->assoc_id > 8*(offset + info_element->len - 3))
>  				break;
> @@ -2203,7 +2193,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
>  						 &tmp_htcap_len);
>  			break;
>  
> -
>  		case MFIE_TYPE_HT_INFO:
>  			netdev_dbg(ieee->dev, "MFIE_TYPE_HT_INFO: %d bytes\n",
>  				   info_element->len);
> @@ -2392,7 +2381,6 @@ static inline int is_same_network(struct rtllib_network *src,
>  		(dst->capability & WLAN_CAPABILITY_ESS)));
>  }
>  
> -
>  static inline void update_network(struct rtllib_device *ieee,
>  				  struct rtllib_network *dst,
>  				  struct rtllib_network *src)
> @@ -2580,7 +2568,6 @@ static inline void rtllib_process_probe_response(
>  		goto free_network;
>  	}
>  
> -
>  	if (!rtllib_legal_channel(ieee, network->channel))
>  		goto free_network;
>  
> -- 
> 2.34.1
> 
> 

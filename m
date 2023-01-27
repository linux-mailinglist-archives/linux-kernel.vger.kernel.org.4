Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8D67E90A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjA0PLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjA0PL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:11:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748E83264
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674832280; x=1706368280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Qey/3+nl3IXDZHieplT0D25KwY/FfN6nfpktH3Orw4=;
  b=hsVxLmFkstjKsKJ4OnA9UAzXygpPtd+CQtHm/DkFmLtHCx4TMowYTEDM
   Gm6YWHxg9TdKdSxqvI8wuhPS69KuGQzkVA/JrPuOgktcWTcVDA8rMEnkG
   GN9wZWEH29gltzC0EnehQGzsiBsSZAONLKHSl1bSUoiAOLi7crTSEZnrl
   GnMhxxmGmIlEI6kIGlIjQpgtABkmpCvhisn+by/j6C9/dYBEowiRCdUCU
   jaDU5xfgq8Sqgyupb9hYcOUGjoQzMF2D4GzEdDU5/YLH6i+GxjnboLi12
   Jg+ElMdMGGZCyvtnhwdYeB/UX6hb2WjJfKxLQeqbJN0bnsYNiio/tsEkH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413328029"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="413328029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:11:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="805847955"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="805847955"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Jan 2023 07:11:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 27 Jan 2023 17:11:15 +0200
Date:   Fri, 27 Jan 2023 17:11:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_typec_vdm: Add Attention
 support
Message-ID: <Y9Ppk6OLAKqSHmhh@kuha.fi.intel.com>
References: <20230126205620.3714994-1-pmalani@chromium.org>
 <20230126205620.3714994-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126205620.3714994-2-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:55:46PM +0000, Prashant Malani wrote:
> Add support to retrieve VDM attention messages and forward them to the
> appropriate alt mode driver.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c  |  8 +++++
>  drivers/platform/chrome/cros_typec_vdm.c | 40 ++++++++++++++++++++++++
>  drivers/platform/chrome/cros_typec_vdm.h |  1 +
>  3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 1abb471840d5..71f5d7d8e055 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1015,6 +1015,14 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  		if (ret < 0)
>  			dev_warn(typec->dev, "Failed VDM Reply event clear, port: %d\n", port_num);
>  	}
> +
> +	if (resp.events & PD_STATUS_EVENT_VDM_ATTENTION) {
> +		cros_typec_handle_vdm_attention(typec, port_num);
> +		ret = cros_typec_send_clear_event(typec, port_num, PD_STATUS_EVENT_VDM_ATTENTION);
> +		if (ret < 0)
> +			dev_warn(typec->dev, "Failed VDM Attenetion event clear, port: %d\n",
> +				 port_num);
> +	}
>  }
>  
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> diff --git a/drivers/platform/chrome/cros_typec_vdm.c b/drivers/platform/chrome/cros_typec_vdm.c
> index 06f4a55999c5..20515ee0a20e 100644
> --- a/drivers/platform/chrome/cros_typec_vdm.c
> +++ b/drivers/platform/chrome/cros_typec_vdm.c
> @@ -13,6 +13,46 @@
>  #include "cros_ec_typec.h"
>  #include "cros_typec_vdm.h"
>  
> +/*
> + * Retrieves pending VDM attention messages from the EC and forwards them to the altmode driver
> + * based on SVID.
> + */
> +void cros_typec_handle_vdm_attention(struct cros_typec_data *typec, int port_num)
> +{
> +	struct ec_response_typec_vdm_response resp;
> +	struct ec_params_typec_vdm_response req = {
> +		.port = port_num,
> +	};
> +	struct typec_altmode *amode;
> +	u16 svid;
> +	u32 hdr;
> +	int ret;
> +
> +	do {
> +		ret = cros_ec_cmd(typec->ec, 0, EC_CMD_TYPEC_VDM_RESPONSE, &req,
> +				sizeof(req), &resp, sizeof(resp));
> +		if (ret < 0) {
> +			dev_warn(typec->dev, "Failed VDM response fetch, port: %d\n", port_num);
> +			return;
> +		}
> +
> +		hdr = resp.vdm_response[0];
> +		svid = PD_VDO_VID(hdr);
> +		dev_dbg(typec->dev, "Received VDM Attention header: %x, port: %d\n", hdr, port_num);
> +
> +		amode = typec_match_altmode(typec->ports[port_num]->port_altmode,
> +					    CROS_EC_ALTMODE_MAX, svid, PD_VDO_OPOS(hdr));
> +		if (!amode) {
> +			dev_err(typec->dev,
> +				"Received VDM for unregistered altmode (SVID:%x), port: %d\n",
> +				svid, port_num);
> +			return;
> +		}
> +
> +		typec_altmode_attention(amode, resp.vdm_attention[1]);
> +	} while (resp.vdm_attention_left);
> +}
> +
>  /*
>   * Retrieves a VDM response from the EC and forwards it to the altmode driver based on SVID.
>   */
> diff --git a/drivers/platform/chrome/cros_typec_vdm.h b/drivers/platform/chrome/cros_typec_vdm.h
> index 003587525554..95a6a75d32b6 100644
> --- a/drivers/platform/chrome/cros_typec_vdm.h
> +++ b/drivers/platform/chrome/cros_typec_vdm.h
> @@ -7,6 +7,7 @@
>  
>  extern struct typec_altmode_ops port_amode_ops;
>  
> +void cros_typec_handle_vdm_attention(struct cros_typec_data *typec, int port_num);
>  void cros_typec_handle_vdm_response(struct cros_typec_data *typec, int port_num);
>  
>  #endif /*  __CROS_TYPEC_VDM__ */
> -- 
> 2.39.1.456.gfc5497dd1b-goog

-- 
heikki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964D4679615
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjAXLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXLDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:03:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280762ED51;
        Tue, 24 Jan 2023 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674558211; x=1706094211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxJs1M4hhFR8n/DFGlylWfMejS/rRmJVImjEKFfogMQ=;
  b=MIjDeyBfo4mgGZt5Kiy+ApGz9MCgNETcWvIPnIStPeymdQfIYbr1jLXb
   L/f38bz0kjf58sY4e13Bri7tPXGKKrTslDZw4PDPbE08Gr7rSwxvP5Gy+
   Mpb37IbHVzbSeJj1t4vD0mEIPv78T0RzwWUG5ItlH4uKOO3E3lM38GUsA
   QHDQWmYMHnqTqwgbRBQAIC0SeTI4BEIFzFUpxVMVkRUsJBW47xKejEtVW
   CDig+7WJ1iyp0L84kCT6nDNAi7cMC1jFPWM8ArIzUyPVqsIazF3U5YTKj
   nuG0BE1G51zdhjy/Z0m7006nIjAX+6L4gkaMEXoOqfyb9CMn9EkRES58i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306624338"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306624338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 03:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804549483"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804549483"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 03:03:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jan 2023 13:03:27 +0200
Date:   Tue, 24 Jan 2023 13:03:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, gregkh@linuxfoundation.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] usb: typec: tcpm: Remove altmode active state
 updates
Message-ID: <Y8+6/2t/0rIvH9xE@kuha.fi.intel.com>
References: <20230120205827.740900-1-pmalani@chromium.org>
 <20230120205827.740900-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120205827.740900-2-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:58:28PM +0000, Prashant Malani wrote:
> Since the "active" state for partner altmodes is now being taken care of
> by the altmode driver itself (specifically, DisplayPort altmode), we
> no longer need to do so from the port driver. So remove the calls to
> typec_altmode_update_active() from TCPM.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Patch first introduced in v2.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 904c7b4ce2f0..0f5a9d4db105 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1693,14 +1693,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_ENTER_MODE:
> -			if (adev && pdev) {
> -				typec_altmode_update_active(pdev, true);
> +			if (adev && pdev)
>  				*adev_action = ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL;
> -			}
>  			return 0;
>  		case CMD_EXIT_MODE:
>  			if (adev && pdev) {
> -				typec_altmode_update_active(pdev, false);
>  				/* Back to USB Operation */
>  				*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
>  				return 0;
> -- 
> 2.39.0.246.g2a6d74b583-goog

-- 
heikki

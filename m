Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B2727B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjFHJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFHJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:36:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28B1730
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686216982; x=1717752982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYd/0mKAxYgi+DtdTdHaJ5Xya+xD28SSU1Pm+jP8lpk=;
  b=Fzw6AJz9dXFaqxDqF9fFyFzwZwzb+KYoYbsR8c23Aq92IbEZv3ZpwwAe
   sn+HPACHqQOel2APvmAktmXnntxNo4r2XYhks2e0tcWS/1wY3kNmC5285
   v9vEC70HE0qFcJhcMnv0rI9Sqj6pyJmUL5hzNFz8mkq3R9Va5H4ThyzVW
   e79PzQas5eC3luCd3x6NV9tDk6Ya9E4fkpSJtj5+ngN9CqD9MtT9RnIMZ
   QjHY8uR+Ko4n+qRsR63ZfsG/8IJRzXnyiompKfzzGj5axO6m88/5h107k
   QcNDRO2+xwg93wF+f8EijnQ4GqJukidWomrUXLaj34GBjqeZvw7zfi35S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356116266"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="356116266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="713051554"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="713051554"
Received: from operepel-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.58.149])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:36:17 -0700
Date:   Thu, 8 Jun 2023 11:36:06 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Wang Jianzheng <wangjianzheng@vivo.com>
Cc:     Artur Weber <aweber.kernel@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/panel: s6d7aa0: remove the unneeded variable in
 s6d7aa0_lock
Message-ID: <ZIGhBvFlHwVmKJG4@ashyti-mobl2.lan>
References: <20230608033446.18412-1-wangjianzheng@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608033446.18412-1-wangjianzheng@vivo.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianzheng,

On Thu, Jun 08, 2023 at 11:34:46AM +0800, Wang Jianzheng wrote:
> Remove unneeded variable and directly return 0.
> 
> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> index 102e1fc7ee38..fec0d014fd0e 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> @@ -66,7 +66,6 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>  static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)

actually this function can completely made void.

>  {
>  	struct mipi_dsi_device *dsi = ctx->dsi;
> -	int ret = 0;
>  
>  	if (lock) {
>  		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
> @@ -80,7 +79,7 @@ static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
>  			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
>  	}
>  
> -	return ret;
> +	return 0;

Anyway the patch is fine:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi

>  }
>  
>  static int s6d7aa0_on(struct s6d7aa0 *ctx)
> -- 
> 2.39.0

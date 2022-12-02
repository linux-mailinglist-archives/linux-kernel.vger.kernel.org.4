Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1B640014
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiLBF6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLBF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:58:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBF97B547;
        Thu,  1 Dec 2022 21:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669960709; x=1701496709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=audFEApOL83xtIfPbQKaBtMKi0ouqF4JjvRbwDzVEcM=;
  b=lakZyOxRUFM125cyIUc1995ZQl8ykBNH+uJ+ynIJlokj4t7wF7S7wxVI
   6NrWfI9Jewce9XR6XxBAY729l71gbY3rtwSNn/aiUUg3Lg0Ss/coJijlE
   OlFZ/o+geZu0QEGPm1p4kIfRn5a3iX8cxjM7bjNlX2UeVrOcF92P2FgpJ
   7Ct4qvF9iEYBryrju3muQujxws+GORycSOSNXQzUP4Q30lOqRTeKLTg4W
   r3oGlQCq1TjYdZosQlwcOP51hTqukATc0iGvQyuju+Rfckkz6zBrhlNk0
   JxPKy9HXTk2nscYpOWAoPVGXG9to5vJH9wOQSmE9WASnBH/ZuScgnKrZT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314581990"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314581990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 21:58:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="751129577"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="751129577"
Received: from msaglam-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 21:58:27 -0800
Message-ID: <5928e753-59bf-69a3-34d2-cac439853701@intel.com>
Date:   Fri, 2 Dec 2022 07:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH linux-next v2] mmc: sdhci: Remove unneeded semicolon
To:     zhang.songyi@zte.com.cn
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202212021031575255977@zte.com.cn>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202212021031575255977@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 04:31, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> The semicolon after the "}" is unneeded.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42aaeabcad22..8413180a1039 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
>  	case MMC_TIMING_UHS_DDR50:
>  	case MMC_TIMING_MMC_DDR52:
>  		return true;
> -	};
> +	}
>  	return false;
>  }
> 


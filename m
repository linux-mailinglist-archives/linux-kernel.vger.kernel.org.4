Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D480622C93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKINi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKINi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:38:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE04233A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668001137; x=1699537137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ig2AAvmJ4d5/ScWgFInIfDGDvmUqTlDzptDrlLKqlNo=;
  b=bQJeEnJf01tYWdC0trRE9059QDp3qt+ps0VQaCPgJkszGueBJ88saVR2
   4uIJHQ+tJ3lApI6/b9qLT6EXzqG1V5xgR/RUJWS0OrLB+1xXS+80Vei+V
   mowtcvkkU5k1+/XqL3XAaVQT1GSOcpKOqWf/5YkAfwe5bMi+eSI3zG5nz
   SVbf/QNw9juoj3euKoot4MQ3IOvA+hhmoJFfhLak51okCqco52vwmQNIT
   tUXnVsYH59RWFNOmbAiGJ15aY4XOQg6ERWZWgjoNWNbvi8aaPGIkLxEvX
   RRXtExWBKh22AWim3AOiDoAOxrrvrCTz48/rxnoXmDZl87kdoIsRAfRya
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290693255"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="290693255"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:38:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700358654"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="700358654"
Received: from bsdoyle-mobl1.amr.corp.intel.com (HELO [10.252.0.23]) ([10.252.0.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:38:55 -0800
Message-ID: <94717ffd-11b0-7242-b145-baff9035092a@linux.intel.com>
Date:   Wed, 9 Nov 2022 15:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH linux-next v2] ASoC: SOF: remove duplicated included
 sof-audio.h
To:     yang.yang29@zte.com.cn, pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
References: <202211092130548796460@zte.com.cn>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <202211092130548796460@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 15:30, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The sof-audio.h is included more than once.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> ---
> change for v2
>  - add maintainers and the alsa-devel mailing list in CC.  
> ---
> 
>  sound/soc/sof/amd/acp-common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
> index 27b95187356e..348e70dfe2a5 100644
> --- a/sound/soc/sof/amd/acp-common.c
> +++ b/sound/soc/sof/amd/acp-common.c
> @@ -13,7 +13,6 @@
>  #include "../sof-priv.h"
>  #include "../sof-audio.h"
>  #include "../ops.h"
> -#include "../sof-audio.h"
>  #include "acp.h"
>  #include "acp-dsp-offset.h"
> 

-- 
Péter

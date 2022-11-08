Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC59D62182D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiKHP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKHP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:26:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4B1B1ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667921170; x=1699457170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2sNOy9ulPORYB52wRvqD0fPlkyq4EYoVkq0/22yT/SM=;
  b=MPtEhowioTpNuwpMo6kBdQYNpfXfAx3apk2Dv6J2FdC2RLWprHlnFcDX
   y5oLyFDgxwyMKzV4A2+jLG8VwXBagBb3FvmXyNTrW7U7rkjzXLfm3yhEr
   mo7FSoPIjUMegwldP+PFy6fDI09Wbib2feqkc2IZDIuoZpUsanM8t0l55
   ks62C7Y9ObPKM0d7pp5MeBgGa6rJv8HUM91rnxiRDI/Ny58bzLXI1hAdl
   jx4gTprsq9RalzYOA2O4EOdR/KV9QFp8iAU1ERjPESPURp0fbKFAPKzDP
   nntaFaJaDSPekrrEXx9hYeXQEwfBa2gSj9ArhKYGqZQfJaNWt7MABa5KC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337449522"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="337449522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 07:21:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811274538"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="811274538"
Received: from aavneri-mobl1.amr.corp.intel.com (HELO [10.212.24.169]) ([10.212.24.169])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 07:21:15 -0800
Message-ID: <7996e8b5-9783-29c3-0027-f7bf933d75a0@linux.intel.com>
Date:   Tue, 8 Nov 2022 09:21:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH linux-next] ASoC: SOF: remove duplicated included
 sof-audio.h
Content-Language: en-US
To:     yang.yang29@zte.com.cn, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        linux-kernel@vger.kernel.org, xu.panda668@gmail.com
References: <202211081931524521356@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202211081931524521356@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You need to CC: maintainers and the alsa-devel mailing list in a v2

On 11/8/22 05:31, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The sof-audio.h is included more than once.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
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

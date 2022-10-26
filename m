Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C460E35C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiJZObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiJZOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:31:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B36AFFFAE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666794688; x=1698330688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j/+TzUZKjPg6AiDdPdUrU7skNxekli5IAwJzr55tM8E=;
  b=U/YbAfcTJ3V+LVDgemolQd/YN52D7omGXqEOySFrN8uiKWcdN7nPpMxH
   qUHM1M1Us55Su4I5xyWVfpgBOHqpadwSkNKEjcloDSCHbr5EGWx5Xq8Zy
   aP4KX2q7c+Oy/de/gx9nqvJ7lpnh1TKaRLqcSlDF/lXXZBN4mPMRR0RyF
   uOypXIhXerMgNLI4NInqRcw2OlrhPBBxFuDcnovF1OHiozclASlSpzYWx
   HYrjWD9yrPQALtTpoz61AiTJ9hmQcOroHoloKQk7J/guoWC2tBzVHj0qG
   ax7Hvrnmze5Y7jlcv/qtCrhcb/2xXQLSeZmDE0xRUMxwnCN4kysl/lt2N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="307952647"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="307952647"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 07:31:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="609972132"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="609972132"
Received: from chaosong-mobl.ccr.corp.intel.com (HELO [10.255.29.191]) ([10.255.29.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 07:31:24 -0700
Message-ID: <69fa20ca-da52-b85f-ffcc-66a533471568@linux.intel.com>
Date:   Wed, 26 Oct 2022 22:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] ASoC: sun50i-dmic: avoid unused variable warning for
 sun50i_dmic_of_match
Content-Language: en-US
To:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
From:   Chao Song <chao.song@linux.intel.com>
In-Reply-To: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/2022 3:44 PM, Ban Tao wrote:
> In configurations with CONFIG_OF=n, we get a harmless build warning:
>
> sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
> 'sun50i_dmic_of_match' [-Wunused-const-variable]
>
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
> v1->v2:Add "Acked-by" tag.
> ---
>   sound/soc/sunxi/sun50i-dmic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> index 86cff5a..62509cb 100644
> --- a/sound/soc/sunxi/sun50i-dmic.c
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -391,7 +391,7 @@ static const struct dev_pm_ops sun50i_dmic_pm = {
>   static struct platform_driver sun50i_dmic_driver = {
>   	.driver         = {
>   		.name   = "sun50i-dmic",
> -		.of_match_table = of_match_ptr(sun50i_dmic_of_match),
> +		.of_match_table = sun50i_dmic_of_match,
I don't think this is the right direction (remove the of_match_ptr) to 
fix the issue.

of_match_ptr(of_table) returns of_table if CONFIG_OF=y, and returns NULL 
if CONFIG_OF=n.

So guard  the definition of sun50i_dmic_of_match with `#ifdef CONFIG_OF` 
should be better.

Many other drivers do it this way.

>   		.pm     = &sun50i_dmic_pm,
>   	},
>   	.probe          = sun50i_dmic_probe,

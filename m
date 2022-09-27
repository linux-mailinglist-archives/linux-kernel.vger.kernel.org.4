Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134575EBBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiI0Hgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiI0HgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:36:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83323491C6;
        Tue, 27 Sep 2022 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664264165; x=1695800165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nWRhK5+WAsVRbdRrm7e6YA/MoeAuFkRulWcszj149yU=;
  b=Asnb0cl4o5+6rXrOuTvHK+fNCUAytw6ie47d6Imos5Cc3ThcozkFQwrO
   0cbTtsSYMMUwLMneAXPiBc9OkLLs9cJGr04Ux21roBVLEoDuVRjJwUfbl
   JrNEgFfIYl6iiEocHV4a+gCENMgyX4HWNsh/FX50a2Z6q9pRp4SD6PH0E
   NnnHk21Gy4v4sO9YPlb/91mgxtT2zCXKa8/R6L7gDbkge5scnQl6sK3Cv
   nRwB53xQe+lRweYLXIx5Vjg/TlkF0jQ96HkAwJj3HV7o4aGJw2LJphoqv
   ZBIL7DFXEUAb5jYV1NCHnuVAEpB94NY7VUSIVCAcnpg0HQ12lZnZTH/hx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302728047"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302728047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:35:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572558720"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="572558720"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.206]) ([10.99.249.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:35:43 -0700
Message-ID: <4d7caa50-9271-b062-2e0d-ad200b8a95f7@linux.intel.com>
Date:   Tue, 27 Sep 2022 09:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH][next] ASoC: Intel: Skylake: Replace zero-length arrays
 with DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YzIuiUul2CwPlkKh@work>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <YzIuiUul2CwPlkKh@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2022 12:58 AM, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/226
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   sound/soc/intel/skylake/skl-topology.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> index a5bccf2fcd88..017ac0ef324d 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -233,8 +233,8 @@ struct skl_uuid_inst_map {
>   struct skl_kpb_params {
>   	u32 num_modules;
>   	union {
> -		struct skl_mod_inst_map map[0];
> -		struct skl_uuid_inst_map map_uuid[0];
> +		DECLARE_FLEX_ARRAY(struct skl_mod_inst_map, map);
> +		DECLARE_FLEX_ARRAY(struct skl_uuid_inst_map, map_uuid);
>   	} u;
>   };
>   

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

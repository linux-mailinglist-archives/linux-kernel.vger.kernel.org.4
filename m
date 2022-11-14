Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229036284D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiKNQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiKNQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:16:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5964CA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442599; x=1699978599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kiwQ0EsjaVIc5nx8UNug8Up0eAjXuQJy1+lUnlUIbdA=;
  b=eUhfqKStdPwNr7pNjCRH2D6DJKBoysExQs46D433AzF2gE77JAgqbdsw
   hVl1GGRgtwcQXMiQJQ9/jrlgh/A0fY+tukns/yFfBgeLWCrnn4ZUQVFPB
   lCPHLvb+DShy7n14ZU3HZlejcGgXJe6Ggrv1JBooT4tbjYT6rytoQ1Jxy
   Nf7HiWOo04XKL8MVsi+3IhAs3OTNeIbv39b4Qb8XWrTvYOKwQOueypHsv
   AiK2ZLUUi6bneIcvR35XnaCi2uP2xoB5fkpfppItouOsA/M+izGNySxlU
   6qkF1TK9UdcwSyJULwXLgwXjTcZVjN3vBpecAw7KhwS6gvkBWoajeuRaA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295373422"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295373422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638542546"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638542546"
Received: from scewbso01.amr.corp.intel.com (HELO [10.212.76.77]) ([10.212.76.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:37 -0800
Message-ID: <20d36e6d-0c4b-f903-8940-841ac1b65d98@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:11:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 0/2] Adds the combination of headset codec ALC5682I-VD
 + amp rt1019p
Content-Language: en-US
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, alsa-devel@alsa-project.org
References: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221108042716.2930255-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 22:27, Ajye Huang wrote:
> v1:
> - machine driver: 
>   - Adds the combination of headset codec ALC5682I-VD + amp rt1019p.
>   - Remove the duplicate code in machine driver.
> 
> Ajye Huang (2):
>   ASoC: Intel: sof_rt5682: add support for ALC5682I-VD with amp rt1019p
>   ASoC: Intel: sof rt5682: remove the duplicate codes

Nice catch on the second patch, this sort of duplicates are hard to
detect in code reviews.

For the series:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> 
>  sound/soc/intel/boards/sof_rt5682.c               | 7 +------
>  sound/soc/intel/common/soc-acpi-intel-adl-match.c | 4 ++--
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 

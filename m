Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC974FF14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGLGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGLGMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:12:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4E10C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689142357; x=1720678357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyE8FtpA7Cf8fI7s84srw3XrfxvX7kXYQ6nxfvjdchA=;
  b=iQJ7n0TeGrr9zxpggfSmqGj1LXNu+5uI5Y7osJbZfsItBl4If/KB75AT
   H2LNkRx+03ywpWsnx2IHmAnQGtz7jIkJ1m7mThtLrdayDH6Hl15G7pK2R
   YyYcdWOeI93Kjn0IvL0DcqcCJGIPN0yuc/1yS+CZNJ3QbTlgNc8CEjahi
   m62uTidLMF3jukuKZsD14jSyKw/x+OdWSsx2qtrUC5zV2DHQ/20Cx0z6Z
   3owgcEoym/RN08w13X2BiAY4h2wgKB/WKuZLkC2WwnWGVm5VYWCnsD7d6
   RffSZo4gq4HLYH7ReVecYWvZkKOfnb4j2VE2U+sc1Dus/fmxNeLpHjG7L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344412596"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="344412596"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715439705"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="715439705"
Received: from hoermank-mobl.ger.corp.intel.com (HELO [10.252.42.188]) ([10.252.42.188])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:12:32 -0700
Message-ID: <2e9a5d5b-f637-1f9a-b500-03f9c151dc26@linux.intel.com>
Date:   Wed, 12 Jul 2023 08:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Yong Zhi <yong.zhi@intel.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gongjun Song <gongjun.song@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
References: <20230712100855.272467-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230712100855.272467-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +	{
> +		.id = "10EC5650",
> +		.drv_name = "jsl_rt5650",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rt5650_spk,
> +		.sof_tplg_filename = "sof-jsl-rt5650-dual.tplg",

what does 'dual' mean in this context? it's not something we've used
before so a comment would be needed IMHO.

two DAIs, two codecs?

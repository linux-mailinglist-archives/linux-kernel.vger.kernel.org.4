Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F126FDAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJJnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:43:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6AA3A88
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683711808; x=1715247808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vneA6Bzg5q3YdvaBP1cqZUP2nVUoSSSgg5zP6JZKWOo=;
  b=G5IPJZNvxnYzb0ROGiUgpQPbZFidmo7lnvA9zMGL02tTCXkMlYEQRMyI
   qq75y7gBVuWsrsSiKLdRDg2v5XhFwW4mPVWwJ8flsK98ieDxJZ5MCEOmn
   5tegqtygrZH43/StviWw2Rk7OK6ZhrCg9Gyg00Z5Tj8AvKk50G7R7knok
   PdszrlH576Xf990kZrqWsZ78TbwZ+7y2c2XZmVwtJpi4jYavdxZ9YzVTy
   g8ru16gpzumGIg7ng8T10xuThFC1d/bXEAwY2S+KtVfrFXiEpmuoTOvmu
   LzAKsnWaGYreiUOPTWqH/hEwVNR2kdhtX4TuM54ovTQ8isc3pFfN8sWOU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="329793435"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="329793435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 02:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843444436"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="843444436"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2023 02:43:24 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwgM0-000374-08;
        Wed, 10 May 2023 09:43:24 +0000
Date:   Wed, 10 May 2023 17:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz,
        tiwai@suse.com, oswald.buddenhagen@gmx.de, axboe@kernel.dk,
        42.hyeyoo@gmail.com, surenb@google.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Message-ID: <202305101732.PILWtd0A-lkp@intel.com>
References: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.4-rc1 next-20230510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/ALSA-PCM-Fix-codestyle-issues-in-pcm_native-c/20230510-152814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230510072726.435247-1-ivan.orlov0322%40gmail.com
patch subject: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
config: csky-randconfig-r004-20230509 (https://download.01.org/0day-ci/archive/20230510/202305101732.PILWtd0A-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6099cbeae29e29487828a858f8b0e866bec90ab1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ivan-Orlov/ALSA-PCM-Fix-codestyle-issues-in-pcm_native-c/20230510-152814
        git checkout 6099cbeae29e29487828a858f8b0e866bec90ab1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash sound/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305101732.PILWtd0A-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/core/pcm_native.c: In function 'snd_pcm_hw_params_choose':
>> sound/core/pcm_native.c:660:94: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     660 |                         trace_hw_mask_param(pcm, *v, 0, &old_mask, hw_param_mask(params, *v));
         |                                                                                              ^


vim +/if +660 sound/core/pcm_native.c

   607	
   608	/**
   609	 * snd_pcm_hw_params_choose - choose a configuration defined by @params
   610	 * @pcm: PCM instance
   611	 * @params: the hw_params instance
   612	 *
   613	 * Choose one configuration from configuration space defined by @params.
   614	 * The configuration chosen is that obtained fixing in this order:
   615	 * first access, first format, first subformat, min channels,
   616	 * min rate, min period time, max buffer size, min tick time
   617	 *
   618	 * Return: Zero if successful, or a negative error code on failure.
   619	 */
   620	static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
   621					    struct snd_pcm_hw_params *params)
   622	{
   623		static const int vars[] = {
   624			SNDRV_PCM_HW_PARAM_ACCESS,
   625			SNDRV_PCM_HW_PARAM_FORMAT,
   626			SNDRV_PCM_HW_PARAM_SUBFORMAT,
   627			SNDRV_PCM_HW_PARAM_CHANNELS,
   628			SNDRV_PCM_HW_PARAM_RATE,
   629			SNDRV_PCM_HW_PARAM_PERIOD_TIME,
   630			SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
   631			SNDRV_PCM_HW_PARAM_TICK_TIME,
   632			-1
   633		};
   634		const int *v;
   635		struct snd_mask old_mask __maybe_unused;
   636		struct snd_interval old_interval __maybe_unused;
   637		int changed;
   638	
   639		for (v = vars; *v != -1; v++) {
   640			/* Keep old parameter to trace. */
   641			if (trace_hw_mask_param_enabled()) {
   642				if (hw_is_mask(*v))
   643					old_mask = *hw_param_mask(params, *v);
   644			}
   645			if (trace_hw_interval_param_enabled()) {
   646				if (hw_is_interval(*v))
   647					old_interval = *hw_param_interval(params, *v);
   648			}
   649			if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
   650				changed = snd_pcm_hw_param_first(pcm, params, *v, NULL);
   651			else
   652				changed = snd_pcm_hw_param_last(pcm, params, *v, NULL);
   653			if (changed < 0)
   654				return changed;
   655			if (changed == 0)
   656				continue;
   657	
   658			/* Trace the changed parameter. */
   659			if (hw_is_mask(*v))
 > 660				trace_hw_mask_param(pcm, *v, 0, &old_mask, hw_param_mask(params, *v));
   661			if (hw_is_interval(*v)) {
   662				trace_hw_interval_param(pcm, *v, 0, &old_interval,
   663							hw_param_interval(params, *v));
   664			}
   665		}
   666	
   667		return 0;
   668	}
   669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

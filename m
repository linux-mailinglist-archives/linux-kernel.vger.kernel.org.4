Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA886F9A34
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEGQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 12:48:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77DE3C22
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683478117; x=1715014117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dsbo0UCqPyAX/ztHoW26Vj2EcL905wcNM7CMUDm8wGs=;
  b=E4BMh9qQ3TFalprTpzof59BxE3mt4ZQundo5rANBhIvk7yv/GljiZQ3p
   hEsv4Fwk6nzDSAWre2ys06mafhFJhiu8z49Bjg3iqN2Vf7Jxe98tCtq4H
   5PNiKKJ6qtr8gr1gzJp03BqlQjKCdnxvsnUqxOefMcbjkSmDiWP/OAMTT
   /sAqfHicMInk2dSzGcTPCyMboTly0vYiz3t5mGyGBsOhMRa6z+0C0/F12
   e7AiUTXAQ2eJcgc3k5SkuAHNH6K5s3d0Nd3SLmpzkFdTS6z5Y/rPerOaj
   h30CccwysLPzSxDj7zJvZkZCioTSkHcgL2oRuEFMVosk0+wcHsi5LKp5S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329121655"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="329121655"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 09:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="763114525"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="763114525"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 May 2023 09:48:35 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvhYp-0000o2-17;
        Sun, 07 May 2023 16:48:35 +0000
Date:   Mon, 8 May 2023 00:47:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     jack1989s@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Federico Di Lembo <jack1989s@gmail.com>
Subject: Re: [PATCH] Sound:last.c: fix code syle trailing white space -
 modify printk()->netdev_dbg() - Possible unnecessary KERN_INFO removed
Message-ID: <202305080037.fiQIAfoP-lkp@intel.com>
References: <20230507130021.48112-1-jack1989s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507130021.48112-1-jack1989s@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.3 next-20230505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jack1989s-gmail-com/Sound-last-c-fix-code-syle-trailing-white-space-modify-printk-netdev_dbg-Possible-unnecessary-KERN_INFO-removed/20230507-210152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230507130021.48112-1-jack1989s%40gmail.com
patch subject: [PATCH] Sound:last.c: fix code syle trailing white space - modify printk()->netdev_dbg() - Possible unnecessary KERN_INFO removed
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230508/202305080037.fiQIAfoP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/467a3e6b911964a967ad7ce544c4426e4d95b14f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review jack1989s-gmail-com/Sound-last-c-fix-code-syle-trailing-white-space-modify-printk-netdev_dbg-Possible-unnecessary-KERN_INFO-removed/20230507-210152
        git checkout 467a3e6b911964a967ad7ce544c4426e4d95b14f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305080037.fiQIAfoP-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/last.c: In function 'alsa_sound_last_init':
>> sound/last.c:15:9: error: implicit declaration of function 'netdev_dbg'; did you mean 'dev_dbg'? [-Werror=implicit-function-declaration]
      15 |         netdev_dbg("ALSA device list:\n");
         |         ^~~~~~~~~~
         |         dev_dbg
   cc1: some warnings being treated as errors


vim +15 sound/last.c

     9	
    10	static int __init alsa_sound_last_init(void)
    11	{
    12		struct snd_card *card;
    13		int idx, ok = 0;
    14	
  > 15		netdev_dbg("ALSA device list:\n");
    16		for (idx = 0; idx < SNDRV_CARDS; idx++) {
    17			card = snd_card_ref(idx);
    18			if (card) {
    19				netdev_dbg("  #%i: %s\n", idx, card->longname);
    20				snd_card_unref(card);
    21				ok++;
    22			}
    23		}
    24		if (ok == 0)
    25			netdev_dbg("  No soundcards found.\n");
    26		return 0;
    27	}
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

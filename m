Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E5741F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjF2FKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjF2FKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:10:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FC12705
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688015417; x=1719551417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1w13wxMhmgyEqQ3zXRYot0vWgqK5T6m4b5oZrcwXfQE=;
  b=QZa40wZLT5yGdVgU5UXb5n3Hy6lXHCCWWHVFE+k/wtqKoBc5OG8FUkwi
   cfIAuv8gtkug1XKZJ+rvvqX4OLuomih8pMyYpVp2ttL3AL+kXBqBc8bLB
   7I6BKDIfuOyUhABlAmbbtbqqVdYaylJrF4/KzvIwYu44yS6OIoRVDPdmt
   d8dKktS5KODWkUjeN1NkJ5PWLN+2nQf0pOosMZEyW3luiby4hIKU/PXbf
   QvNP27/dJ/b4tsGIGFlB9OJK3GzOOHMy3S5A0eDa8cxMkNS3jpvaJew/J
   8PK14j3sxE9Kjsp4dKY3PGxJvyinKYgDsph346apa8tbX2IVBKgdNA4jP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342362844"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="342362844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 22:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="694496365"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="694496365"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2023 22:10:11 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEjv0-000DqL-1F;
        Thu, 29 Jun 2023 05:10:10 +0000
Date:   Thu, 29 Jun 2023 13:09:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     dengxiang <dengxiang@nfschina.com>, tiwai@suse.com,
        yangyingliang@huawei.com, perex@perex.cz
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        dengxiang@nfschina.com
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for Unis  H3C Desktop B760
 & Q760
Message-ID: <202306291229.5w2tIZjA-lkp@intel.com>
References: <20230629030016.10185-1-dengxiang@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629030016.10185-1-dengxiang@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dengxiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.4 next-20230628]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dengxiang/ALSA-hda-realtek-Add-quirks-for-Unis-H3C-Desktop-B760-Q760/20230629-110147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230629030016.10185-1-dengxiang%40nfschina.com
patch subject: [PATCH] ALSA: hda/realtek: Add quirks for Unis  H3C Desktop B760 & Q760
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230629/202306291229.5w2tIZjA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291229.5w2tIZjA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291229.5w2tIZjA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/hda/patch_realtek.c: In function 'alc897_fixup_unis_h3c_x500s':
>> sound/pci/hda/patch_realtek.c:11212:26: warning: unused variable 'spec' [-Wunused-variable]
   11212 |         struct alc_spec *spec = codec->spec;
         |                          ^~~~


vim +/spec +11212 sound/pci/hda/patch_realtek.c

 11208	
 11209	static void alc897_fixup_unis_h3c_x500s(struct hda_codec *codec,
 11210						  const struct hda_fixup *fix, int action)
 11211	{
 11212		struct alc_spec *spec = codec->spec;
 11213	
 11214		if (action != HDA_FIXUP_ACT_PRE_PROBE)
 11215			return;
 11216	
 11217		snd_hda_add_verbs(codec, alc897_unis_h3c_x500s_eapd_verbs);
 11218	}
 11219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

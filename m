Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DAC5E6BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiIVTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiIVTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:40:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E3286E4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663875638; x=1695411638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JunN4WbueJ9djEVR5pFI6okEVu09INkC/lpUJ3x/coA=;
  b=F6vio8yNGTYnUmOa+B1UCfwIep/bZWg4slURU99gtI9nqsbTTPDy/jmE
   J0LNHZOf/Js37N05zR7a5h8U6p97fEoAqiHgkSqFEieIy7Ek4/s+dnGLc
   gdema6c3d/H6qdGLMR6ZF3HgF/k+Zmygan0x2HhI7lqMDrHY6hRSpqJWf
   Vc891Y2yIqbmIrf+rWUwG/4wYtkEqyZ2XicLLTvZoF6twMi4T1og/U5jb
   MJDoLyIgW2Gy2NBlrTNw6z9f+HF/ZPA7V5VtYYii2NkErWIpkKIPbI5YE
   iCrnEVWfXIMhCdTi8JF5CyHxeIPDy6vN7WgYYZvVdWARgPtpk2x7OZzvg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299131168"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299131168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="653122659"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Sep 2022 12:40:37 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obS3o-0004u0-1g;
        Thu, 22 Sep 2022 19:40:36 +0000
Date:   Fri, 23 Sep 2022 03:39:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 19/24]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:303:28: error: implicit
 declaration of function 'FIELD_PREP'
Message-ID: <202209230324.VnV6AURl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   8fe952efd56f64dd30d19c236a6b9c0a6a05c1b7
commit: a73027a50c83d9c2549c65a7715ad926f0fde2b1 [19/24] hid: Add Apple DockChannel HID transport driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220923/202209230324.VnV6AURl-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a73027a50c83d9c2549c65a7715ad926f0fde2b1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout a73027a50c83d9c2549c65a7715ad926f0fde2b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/hid/dockchannel-hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_cmd':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:303:28: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     303 |         iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
         |                            ^~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from drivers/hid/dockchannel-hid/dockchannel-hid.c:10:
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ready':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:569:37: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:569:17: note: in expansion of macro 'dev_err'
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:569:70: note: format string is defined here
     569 |                 dev_err(dchid->dev, "Bad length for ready message: %ld\n", length);
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long int
         |                                                                    %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_packet_work':
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:825:20: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     825 |         int type = FIELD_GET(FLAGS_GROUP, shdr->flags);
         |                    ^~~~~~~~~
         |                    FOLL_GET
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:37: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:17: note: in expansion of macro 'dev_err'
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:68: note: format string is defined here
     829 |                 dev_err(dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long int
         |                                                                  %d
   drivers/hid/dockchannel-hid/dockchannel-hid.c: In function 'dchid_handle_ack':
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:44: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'unsigned int' [-Wformat=]
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:17: note: in expansion of macro 'dev_err'
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                 ^~~~~~~
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:75: note: format string is defined here
     855 |                 dev_err(iface->dchid->dev, "Bad sub header length (%d > %ld)\n",
         |                                                                         ~~^
         |                                                                           |
         |                                                                           long int
         |                                                                         %d
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +303 drivers/hid/dockchannel-hid/dockchannel-hid.c

   292	
   293	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   294			     void *data, size_t size, void *resp_buf, size_t resp_size)
   295	{
   296		int ret;
   297		int report_id = *(u8*)data;
   298	
   299		mutex_lock(&iface->out_mutex);
   300	
   301		WARN_ON(iface->out_report != -1);
   302		iface->out_report = report_id;
 > 303		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   304		iface->resp_buf = resp_buf;
   305		iface->resp_size = resp_size;
   306		reinit_completion(&iface->out_complete);
   307	
   308		ret = dchid_send(iface, iface->out_flags, data, size);
   309		if (ret < 0)
   310			goto done;
   311	
   312		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   313			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   314				report_id, iface->index, iface->name);
   315			ret = -ETIMEDOUT;
   316			goto done;
   317		}
   318	
   319		ret = iface->resp_size;
   320		if (iface->retcode) {
   321			dev_err(iface->dchid->dev,
   322				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   323				report_id, iface->index, iface->name, iface->retcode);
   324			ret = -EIO;
   325		}
   326	
   327	done:
   328		iface->tx_seq++;
   329		iface->out_report = -1;
   330		iface->out_flags = 0;
   331		iface->resp_buf = NULL;
   332		iface->resp_size = 0;
   333		mutex_unlock(&iface->out_mutex);
   334		return ret;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

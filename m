Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00EB5B430C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIIX0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:26:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1BE72E2;
        Fri,  9 Sep 2022 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662765977; x=1694301977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4hwGH0pU6mpaM2OsQ0RAEaOxEzoLrvVkvHORBX2fMc=;
  b=Tq4VuaoTqMseb11BYoAfLq/KQiHTyU98tnbBuDTKoYxQs8RamBHIPC6X
   UPXZFPEHf5Pa5BFxkoDlI3q02PwDncWRpu+w9XRgE9Zbog+QdAMB8krWB
   atgbLgyzzsKKAOEZuL2FcHTP8GdloW7kO5YvT4+JH9cmWZivR9akvnxNq
   Qwh5ELHkSdTVyOfltZdp3USIiK1R3/BVHiqI3UNvTUjlLtXJy8yKOTACB
   OdlCvwV4AFxt9dSC18s+jFiuVyzYp72+uZf3Zk+XLJtwtXZ3jhSoyDzcw
   pauO+tdoICjM32xd4USbwgNHIpl9ks6rcZoPgBYtVPpqbgYRlo0nmY1G7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298389574"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298389574"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="683808816"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2022 16:26:14 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWnO1-0001rD-1N;
        Fri, 09 Sep 2022 23:26:13 +0000
Date:   Sat, 10 Sep 2022 07:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH 3/5] media: stm32-dcmipp: STM32 DCMIPP camera interface
 driver
Message-ID: <202209100741.2q2uPfCJ-lkp@intel.com>
References: <20220909165959.5899-4-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909165959.5899-4-hugues.fruchet@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

I love your patch! Yet something to improve:

[auto build test ERROR on atorgue-stm32/stm32-next]
[also build test ERROR on media-tree/master sailus-media-tree/streams linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugues-Fruchet/Add-support-for-DCMIPP-camera-interface-of-STMicroelectronics-STM32-SoC-series/20220910-010413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220910/202209100741.2q2uPfCJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/27ecbfe1ec56d46466cf305ba5f44de8e5a676f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hugues-Fruchet/Add-support-for-DCMIPP-camera-interface-of-STMicroelectronics-STM32-SoC-series/20220910-010413
        git checkout 27ecbfe1ec56d46466cf305ba5f44de8e5a676f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:27:
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h:120:41: error: field 'bus' has incomplete type
     120 |         struct v4l2_fwnode_bus_parallel bus;
         |                                         ^~~
   drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c: In function 'dcmipp_comp_unbind':
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:225:9: error: implicit declaration of function 'v4l2_async_notifier_unregister'; did you mean 'v4l2_async_nf_unregister'? [-Werror=implicit-function-declaration]
     225 |         v4l2_async_notifier_unregister(&dcmipp->notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_unregister
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:226:9: error: implicit declaration of function 'v4l2_async_notifier_cleanup'; did you mean 'v4l2_async_nf_cleanup'? [-Werror=implicit-function-declaration]
     226 |         v4l2_async_notifier_cleanup(&dcmipp->notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_cleanup
   drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c: In function 'dcmipp_graph_init':
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:465:9: error: implicit declaration of function 'v4l2_async_notifier_init'; did you mean 'v4l2_async_nf_init'? [-Werror=implicit-function-declaration]
     465 |         v4l2_async_notifier_init(&dcmipp->notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_init
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:467:15: error: implicit declaration of function 'v4l2_async_notifier_add_fwnode_remote_subdev'; did you mean 'v4l2_async_nf_add_fwnode_remote'? [-Werror=implicit-function-declaration]
     467 |         asd = v4l2_async_notifier_add_fwnode_remote_subdev
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_async_nf_add_fwnode_remote
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:469:18: error: expected expression before 'struct'
     469 |                  struct v4l2_async_subdev);
         |                  ^~~~~~
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:480:15: error: implicit declaration of function 'v4l2_async_notifier_register'; did you mean 'v4l2_async_nf_register'? [-Werror=implicit-function-declaration]
     480 |         ret = v4l2_async_notifier_register(&dcmipp->v4l2_dev, &dcmipp->notifier);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_async_nf_register
   cc1: some warnings being treated as errors
--
   In file included from drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c:14:
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h:120:41: error: field 'bus' has incomplete type
     120 |         struct v4l2_fwnode_bus_parallel bus;
         |                                         ^~~
--
   In file included from drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c:24:
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h:120:41: error: field 'bus' has incomplete type
     120 |         struct v4l2_fwnode_bus_parallel bus;
         |                                         ^~~
   drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c: In function 'dcmipp_pipeline_s_stream':
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c:460:23: error: implicit declaration of function 'media_entity_remote_pad'; did you mean 'media_entity_remove_links'? [-Werror=implicit-function-declaration]
     460 |                 pad = media_entity_remote_pad(pad);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
         |                       media_entity_remove_links
>> drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c:460:21: warning: assignment to 'struct media_pad *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     460 |                 pad = media_entity_remote_pad(pad);
         |                     ^
   cc1: some warnings being treated as errors


vim +/bus +120 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h

    92	
    93	/**
    94	 * struct dcmipp_ent_device - core struct that represents a node in the topology
    95	 *
    96	 * @ent:		the pointer to struct media_entity for the node
    97	 * @pads:		the list of pads of the node
    98	 * @process_frame:	callback send a frame to that node
    99	 * @vdev_get_format:	callback that returns the current format a pad, used
   100	 *			only when is_media_entity_v4l2_video_device(ent) returns
   101	 *			true
   102	 *
   103	 * Each node of the topology must create a dcmipp_ent_device struct. Depending on
   104	 * the node it will be of an instance of v4l2_subdev or video_device struct
   105	 * where both contains a struct media_entity.
   106	 * Those structures should embedded the dcmipp_ent_device struct through
   107	 * v4l2_set_subdevdata() and video_set_drvdata() respectivaly, allowing the
   108	 * dcmipp_ent_device struct to be retrieved from the corresponding struct
   109	 * media_entity
   110	 */
   111	struct dcmipp_ent_device {
   112		struct media_entity *ent;
   113		struct media_pad *pads;
   114		void * (*process_frame)(struct dcmipp_ent_device *ved,
   115					const void *frame);
   116		void (*vdev_get_format)(struct dcmipp_ent_device *ved,
   117					struct v4l2_pix_format *fmt);
   118	
   119		/* Parallel input device */
 > 120		struct v4l2_fwnode_bus_parallel	bus;
   121		enum v4l2_mbus_type		bus_type;
   122		irq_handler_t handler;
   123		irqreturn_t handler_ret;
   124		irq_handler_t thread_fn;
   125	};
   126	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

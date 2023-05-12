Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8C700E26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjELRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjELRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:54:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C287ED2;
        Fri, 12 May 2023 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683914096; x=1715450096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLCsGs+3Z9nE6N7JKCXE/0NerOE+D5BL5BJhMpo79zk=;
  b=WyoR+0JTBuVsZgY8zxOQE/pFUvApHx+tP5K+gJWlqyrpG6PTnpOMfQ4N
   OqllCB5kSuDKxsRoOb4Gv/PQpE3Pe8CfHvHt2nBUu+vIwRCF0ytSKwMtt
   z+83UH2MZWwWx0loO78aZrPy1+5zrXAgXqUgpZveGCnrjAXOtdJRtGa/9
   kaGqrq4y6cCW/v+1mQzz7AVh5l+1UoZBuQljTbjM1JX95Tc5Xqt3VupBy
   v3rHYf0dGscPb1nJvzxjCpmowgOX1Kjxoz+rwY5V9MqHTvTFC/6KIj9/j
   g8MRiGnq/dXoVPYxWYkbjTdJ2zdNTa4bZZeY6cLhUd1AWT/oAgJM4x+1Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378990138"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378990138"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="703254820"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="703254820"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2023 10:54:53 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxWyi-00050w-0m;
        Fri, 12 May 2023 17:54:52 +0000
Date:   Sat, 13 May 2023 01:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>,
        linux-media@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, sakari.ailus@iki.fi,
        laurent.pinchart@ideasonboard.com, evgeni.raikhel@intel.com,
        demisrael@gmail.com, sakari.ailus@intel.com
Subject: Re: [PATCH v2] media: uapi: v4l: Intel metadata format update
Message-ID: <202305130121.0QxAqCO3-lkp@intel.com>
References: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16ddf4fdb83f30899e575b218e524f6346a9f50.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on sailus-media-tree/streams linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Perchanov/media-uapi-v4l-Intel-metadata-format-update/20230509-162624
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/e16ddf4fdb83f30899e575b218e524f6346a9f50.camel%40intel.com
patch subject: [PATCH v2] media: uapi: v4l: Intel metadata format update
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/9380782b719cdcafc3d26c5166e52cdcbae8fca7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Perchanov/media-uapi-v4l-Intel-metadata-format-update/20230509-162624
        git checkout 9380782b719cdcafc3d26c5166e52cdcbae8fca7
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130121.0QxAqCO3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst:37: WARNING: "flat-table" widths do not match the number of columns in table (3).

vim +37 Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst

94fa831e3b359f2 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Mauro Carvalho Chehab 2019-03-29   35  
94fa831e3b359f2 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Mauro Carvalho Chehab 2019-03-29   36  
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  @37  .. flat-table:: D4xx metadata
94fa831e3b359f2 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Mauro Carvalho Chehab 2019-03-29   38      :widths: 1 2
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   39      :header-rows:  1
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   40      :stub-columns: 0
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   41  
94fa831e3b359f2 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Mauro Carvalho Chehab 2019-03-29   42      * - **Field**
94fa831e3b359f2 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Mauro Carvalho Chehab 2019-03-29   43        - **Description**
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   44      * - :cspan:`1` *Depth Control*
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   45      * - __u32 ID
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   46        - 0x80000000
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   47      * - __u32 Size
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09   48        - Size in bytes (currently 60)
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   49      * - __u32 Version
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   50        - Version of this structure. The documentation herein corresponds to
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   51          version xxx. The version number will be incremented when new fields are
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   52          added.
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   53      * - __u32 Flags
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   54        - A bitmask of flags: see [2_] below
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   55      * - __u32 Gain
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   56        - Gain value in internal units, same as the V4L2_CID_GAIN control, used to
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   57  	capture the frame
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   58      * - __u32 Exposure
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   59        - Exposure time (in microseconds) used to capture the frame
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   60      * - __u32 Laser power
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   61        - Power of the laser LED 0-360, used for depth measurement
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   62      * - __u32 AE mode
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   63        - 0: manual; 1: automatic exposure
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   64      * - __u32 Exposure priority
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   65        - Exposure priority value: 0 - constant frame rate
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   66      * - __u32 AE ROI left
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   67        - Left border of the AE Region of Interest (all ROI values are in pixels
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   68  	and lie between 0 and maximum width or height respectively)
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   69      * - __u32 AE ROI right
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   70        - Right border of the AE Region of Interest
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   71      * - __u32 AE ROI top
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   72        - Top border of the AE Region of Interest
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   73      * - __u32 AE ROI bottom
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   74        - Bottom border of the AE Region of Interest
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   75      * - __u32 Preset
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   76        - Preset selector value, default: 0, unless changed by the user
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09   77      * - __u8 Emitter mode
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   78        - 0: off, 1: on
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09   79      * - __u8 RFU byte
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09   80      * - __u16 LED Power
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09   81        - Led power value 0-360 (F416 SKU)
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   82      * - :cspan:`1` *Capture Timing*
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   83      * - __u32 ID
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   84        - 0x80000001
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   85      * - __u32 Size
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   86        - Size in bytes (currently 40)
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   87      * - __u32 Version
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   88        - Version of this structure. The documentation herein corresponds to
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   89          version xxx. The version number will be incremented when new fields are
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   90          added.
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   91      * - __u32 Flags
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   92        - A bitmask of flags: see [3_] below
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   93      * - __u32 Frame counter
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   94        - Monotonically increasing counter
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   95      * - __u32 Optical time
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   96        - Time in microseconds from the beginning of a frame till its middle
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   97      * - __u32 Readout time
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   98        - Time, used to read out a frame in microseconds
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03   99      * - __u32 Exposure time
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  100        - Frame exposure time in microseconds
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  101      * - __u32 Frame interval
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  102        - In microseconds = 1000000 / framerate
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  103      * - __u32 Pipe latency
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  104        - Time in microseconds from start of frame to data in USB buffer
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  105      * - :cspan:`1` *Configuration*
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  106      * - __u32 ID
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  107        - 0x80000002
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  108      * - __u32 Size
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  109        - Size in bytes (currently 40)
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  110      * - __u32 Version
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  111        - Version of this structure. The documentation herein corresponds to
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  112          version xxx. The version number will be incremented when new fields are
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  113          added.
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  114      * - __u32 Flags
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  115        - A bitmask of flags: see [4_] below
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  116      * - __u8 Hardware type
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  117        - Camera hardware version [5_]
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  118      * - __u8 SKU ID
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  119        - Camera hardware configuration [6_]
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  120      * - __u32 Cookie
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  121        - Internal synchronisation
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  122      * - __u16 Format
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  123        - Image format code [7_]
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  124      * - __u16 Width
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  125        - Width in pixels
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  126      * - __u16 Height
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  127        - Height in pixels
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  128      * - __u16 Framerate
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  129        - Requested frame rate per second
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  130      * - __u16 Trigger
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  131        - Byte 0: bit 0: depth and RGB are synchronised, bit 1: external trigger
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  132      * - __u16 Calibration count
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  133      * - __u8 GPIO input data
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  134        - GPIO readout
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  135        - Supported from FW 5.12.7.0
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  136      * - __u32 Sub-preset info
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  137        - Sub-preset choice information
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  138      * - __u8 reserved
9380782b719cdca Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst Dmitry Perchanov      2023-05-09  139        - RFU byte.
6ea0d588d35b55e Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst          Guennadi Liakhovetski 2018-08-03  140  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

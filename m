Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B086BE70D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCQKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:42:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F2B53E4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:42:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7foUJ015333;
        Fri, 17 Mar 2023 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=KKA0KiB1b7sWikqUS2H+de2M8bIODACLff8UqwwIRKI=;
 b=QEPeAY4bjHDR8f8q/I3SzD8amteUtM1B3ocVkO24bWFQh0Z8oUqN8gWYimJxHzGjNRaB
 DuUJ7Twuid1w+yLki2ivqdb1rGHrmZCoK7Ynr9BdJmNqWg3V0o1xDcyzfmHHim6r/+NR
 BPYOqoUjne6gyKF6BOvVbXEAsCXpv8hrLltG7saBPkltoaHVACk/tf4aRagzzO0210us
 9SDXo17Ay/9n7n+Oh4sM93/2PYKPZNOEW1xpbxXeym6rZbm7RKpi+NOFHQ10bhNhVZel
 /2qv/X6OEnjCAUWLKtjMs3vkVhWDeeHBaF+K5e2Fh+6N4k/2b0UHtNQe11+KwMnx0Z2y Mg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pbs3b9wuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 05:41:01 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 17 Mar
 2023 05:40:58 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 17 Mar 2023 05:40:58 -0500
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9815D45;
        Fri, 17 Mar 2023 10:40:58 +0000 (UTC)
Message-ID: <2f983fe6-8c43-be16-758b-098ea461836b@opensource.cirrus.com>
Date:   Fri, 17 Mar 2023 10:40:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 8/8] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
To:     kernel test robot <lkp@intel.com>,
        Richard Fitzgerald via Alsa-devel 
        <alsa-devel@alsa-project.org>, <broonie@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <167872265923.26.336497278776737619@mailman-core.alsa-project.org>
 <202303170422.ZYpOtc4P-lkp@intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <202303170422.ZYpOtc4P-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OePiBmjLWfhCxasIpBWCnONiYz13bGq6
X-Proofpoint-ORIG-GUID: OePiBmjLWfhCxasIpBWCnONiYz13bGq6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 20:15, kernel test robot wrote:
> Hi Richard,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on linus/master v6.3-rc2 next-20230316]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald-via-Alsa-devel/ASoC-wm_adsp-Use-no_core_startstop-to-prevent-creating-preload-control/20230313-235605
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> patch link:    https://lore.kernel.org/r/167872265923.26.336497278776737619%40mailman-core.alsa-project.org
> patch subject: [PATCH v2 8/8] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
> config: s390-randconfig-r044-20230313 (https://download.01.org/0day-ci/archive/20230317/202303170422.ZYpOtc4P-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install s390 cross compiling tool for clang build
>          # apt-get install binutils-s390x-linux-gnu
>          # https://github.com/intel-lab-lkp/linux/commit/5856c94d659f9c9963f5c37762cf201e1f1765e9
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Richard-Fitzgerald-via-Alsa-devel/ASoC-wm_adsp-Use-no_core_startstop-to-prevent-creating-preload-control/20230313-235605
>          git checkout 5856c94d659f9c9963f5c37762cf201e1f1765e9
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303170422.ZYpOtc4P-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_dsp_work':
>>> sound/soc/codecs/cs35l56.c:887: undefined reference to `sdw_write_no_pm'
>>> s390x-linux-ld: sound/soc/codecs/cs35l56.c:888: undefined reference to `sdw_read_no_pm'
>>> s390x-linux-ld: sound/soc/codecs/cs35l56.c:889: undefined reference to `sdw_write_no_pm'
>     s390x-linux-ld: sound/soc/codecs/cs35l56.c:953: undefined reference to `sdw_write_no_pm'
>     s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_sdw_dai_hw_params':
>>> sound/soc/codecs/cs35l56.c:710: undefined reference to `sdw_stream_add_slave'
>     s390x-linux-ld: sound/soc/codecs/cs35l56.o: in function `cs35l56_sdw_dai_hw_free':
>>> sound/soc/codecs/cs35l56.c:729: undefined reference to `sdw_stream_remove_slave'
> 

I don't understand what's happened here.
include/linux/soundwire/sdw.h provides inline dummy versions of these
functions if !IS_ENABLED(CONFIG_SOUNDWIRE) so how can they be
undefined reference?

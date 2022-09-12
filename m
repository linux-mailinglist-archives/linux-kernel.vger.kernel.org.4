Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE5C5B615A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiILS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:56:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751592494F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663008989; x=1694544989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPX0hqdFp+3hsXagRVQTRdyFYy2xjdoClk4neGEAuVM=;
  b=csepc+2oFF8ziHYNMkeFAqh6jWRuRTPEMTa+HZh0CytspbMAbJ25XPIS
   7axRmPvbTLM3Ok1bNmvWjWttSLSIeKKWa7oSmFJv5rz14fWl7+WXbLHNm
   LeIafhCFc/ADitIV8Wtdz/OKnYwn9jge6ha3yHFOIXmPNrqMQrXdNsoPa
   kQY6qWfy7Lsz3ToOGAFLMJsXgNZGDnKgUkoUy3r8UIwYmxdcjpuPhWHLh
   xkEvhLh+Rh00aKDOMtKxAbCaR47K8ux0aruXlNpcRQZCmkh1uqAAoI5ei
   gmGmYNHjJWo9aEFpnjYfGWiCMdw9AVMkkucRKeL+c10qqeIyAWERKeKVS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324181721"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324181721"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 11:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="649371272"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 11:56:25 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXobY-0002kl-3A;
        Mon, 12 Sep 2022 18:56:24 +0000
Date:   Tue, 13 Sep 2022 02:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com, sv@linux.ibm.com
Subject: Re: [PATCH v3 11/16] objtool: Add --mnop as an option to --mcount
Message-ID: <202209130240.GpGMxW7T-lkp@intel.com>
References: <20220912082020.226755-12-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082020.226755-12-sv@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathvika,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/topic/ppc-kvm]
[also build test ERROR on linus/master v6.0-rc5]
[cannot apply to powerpc/next masahiroy-kbuild/for-next next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220912-163023
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/ppc-kvm
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220913/202209130240.GpGMxW7T-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ca5e2b42c0d4438ba93623579b6860b98f3598f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sathvika-Vasireddy/objtool-Enable-and-implement-mcount-option-on-powerpc/20220912-163023
        git checkout ca5e2b42c0d4438ba93623579b6860b98f3598f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: error: '-mnop-mcount' is not implemented for '-fPIC'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

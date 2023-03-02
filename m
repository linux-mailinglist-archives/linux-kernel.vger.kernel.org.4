Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235826A837C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCBN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:26:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A518B1F;
        Thu,  2 Mar 2023 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677763579; x=1709299579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzKZOO3pMAqixUGQg3dAVwPRKWwUHbpqsY29JJ0g2mY=;
  b=CzqzGO4iJzyySqK8AbNxoMOgsqGgkGm7nLbf5JM1wTg6f+Quw4y7tHdh
   fDUwSqYmfhHuA5Hsr1AvCxiNesml69rPxH4u4DZdwjVvhjwKtlUXRBXQt
   g8RgdoQGLRPklZ0JFuxvYoWnx9Z7SxmLU/SO87y1M6f3CSoUmSkqK2l2g
   zqcgLHigTz8wbBRG5RkdjIYKRJ2AiDefUpXw6+8JVJw9w6ncZgV2ZwoXF
   alWjcbdt+MCyBh56s0wpRwsykpi1i0L1G9sgsvwPaa+r4Z0Dw0ZeC0pRz
   Jy30kRhS8iP7eYpv+UCE2VhdAhouBL2v56yjI71iqRL2J+noLtk5mY09s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332200106"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="332200106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 05:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674952833"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="674952833"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2023 05:26:14 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXiwo-0000UZ-0P;
        Thu, 02 Mar 2023 13:26:14 +0000
Date:   Thu, 2 Mar 2023 21:26:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
        stefan@agner.ch, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 7/9] dt-bindings: crypto: drop fsl-sec4 txt binding
Message-ID: <202303022114.lkxW64dk-lkp@intel.com>
References: <20230301015702.3388458-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301015702.3388458-8-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master shawnguo/for-next linus/master v6.2 next-20230302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/ARM-dts-vfxxx-drop-the-number-after-jr/20230301-095526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20230301015702.3388458-8-peng.fan%40oss.nxp.com
patch subject: [PATCH 7/9] dt-bindings: crypto: drop fsl-sec4 txt binding
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/be7a2d4765563d62ace0128d9497c0fbef9ffd1b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/ARM-dts-vfxxx-drop-the-number-after-jr/20230301-095526
        git checkout be7a2d4765563d62ace0128d9497c0fbef9ffd1b
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303022114.lkxW64dk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/input/snvs-pwrkey.txt references a file that doesn't exist: Documentation/devicetree/bindings/crypto/fsl-sec4.txt
>> Warning: Documentation/devicetree/bindings/rtc/snvs-rtc.txt references a file that doesn't exist: Documentation/devicetree/bindings/crypto/fsl-sec4.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/crypto/fsl-sec4.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

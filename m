Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72C6F8D52
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEFA6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjEFA6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:58:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F34EDC;
        Fri,  5 May 2023 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683334715; x=1714870715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r87jZ01NzXbmHM71uAgrdFKbngx499poUh8cLmNlhlM=;
  b=h3qvA/KTPzg8uGjPihj44fqeMbltTylVMfItpOYroQVCn4NLXNt1mqZI
   Km7UNZ8kp9oZlOAbCBFLUAfX9FBqgn6ROyK5yfc0Uexs+b+b6ZhjFvwjN
   dOAD9CHeeCjXIqTgOi+6vHlyqjVj8SurMaQ5QK7E3WYj8oK1jwik9LghL
   TNqT2kksw8KG/GGT9csN406xFD5A67y3p+yilLHOXiMOANtmtK2ZVMs45
   3nTATN8lOvxWstBTVg9vF2mIRIJds9QUgsY2Quw7C1Tpf6op2uG+3z+y2
   5Cbk+Gp5eVlszvBP1TQ4ktMIjKpyoeQlHZw95jAl2AnHRzlDqd7lQiDVA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349363942"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="349363942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="872079408"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="872079408"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2023 17:58:33 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv6Fs-00010D-11;
        Sat, 06 May 2023 00:58:32 +0000
Date:   Sat, 6 May 2023 08:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org
Subject: htmldocs: Warning: MAINTAINERS references a file that doesn't exist:
 Documentation/devicetree/bindings/pwm/pwm-apple.yaml
Message-ID: <202305060811.tbCH6oin-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   418d5c98319f67b9ae651babea031b5394425c18
commit: de614ac31955fe20f71021fd5f4a9a811e90028f MAINTAINERS: Add entries for Apple PWM driver
date:   4 weeks ago
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de614ac31955fe20f71021fd5f4a9a811e90028f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout de614ac31955fe20f71021fd5f4a9a811e90028f
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305060811.tbCH6oin-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

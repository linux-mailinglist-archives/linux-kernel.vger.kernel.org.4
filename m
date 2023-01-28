Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644867FB3F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjA1VyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjA1Vx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:53:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCBB766;
        Sat, 28 Jan 2023 13:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674942837; x=1706478837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7JjnrQQWp+kN26DZzJ0mVdFYAjkwO83r09SH1uaPITg=;
  b=G6Gea9v7HSeofpXTuZVp7DPnuafq1KMTvt0Ahj3nqssxwA1T2ZTF+RLB
   o+jriTo6647km6K2scFfiyXdGOnKJLnywi0iKZ5diy0pB7L1KEuM5W784
   TJoaY/nwLlyJlZAIT27F1/kucKVSHPJyYGk6C1PHUU7z7xPKZ/Ae4af+/
   Iw0fxystFqRoExS5qrONoM5jc/zpME5ZtLm8AVv3tteFvTyC4Y4SgXxCz
   s37S6wJ5a4r4pAd+uZaJYLiwoJOnUJ8i+FNY7HCGPtUNpCgYxaE0uFNmc
   7JT9T0H3ui2Q865lrFvD8kEKkUuxm2/WZ6TR8jwyOIUQvdIO0ogMqGIBj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="329467408"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="329467408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 13:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="752368320"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="752368320"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2023 13:53:54 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLt90-00018w-0E;
        Sat, 28 Jan 2023 21:53:54 +0000
Date:   Sun, 29 Jan 2023 05:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
Message-ID: <202301290537.kO9rsBjm-lkp@intel.com>
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230125181840.3007341-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

I love your patch! Perhaps something to improve:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on next-20230127]
[cannot apply to linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Bilbao/docs-sp_SP-Add-process-magic-number-translation/20230128-103013
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230125181840.3007341-1-carlos.bilbao%40amd.com
patch subject: [PATCH] docs/sp_SP: Add process magic-number translation
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/386e4549b53d3e7f381ad80c954a1e783aedf1c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Carlos-Bilbao/docs-sp_SP-Add-process-magic-number-translation/20230128-103013
        git checkout 386e4549b53d3e7f381ad80c954a1e783aedf1c6
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/translations/sp_SP/process/magic-number.rst:16: WARNING: Inline emphasis start-string without end-string.

vim +16 Documentation/translations/sp_SP/process/magic-number.rst

    15	
  > 16	Es una muy buena idea proteger las estructuras de datos del kernel con
    17	números mágicos. Esto le permite verificar en tiempo de ejecución si (a)
    18	una estructura ha sido manipulada, o (b) ha pasado la estructura incorrecta
    19	a una rutina. Esto último es especialmente útil --- particularmente cuando
    20	pasa punteros a estructuras a través de un puntero void *. El código tty,
    21	por ejemplo, hace esto con frecuencia para pasar información específica del
    22	driver y líneas de estructuras específicas de protocolo de un lado al
    23	otro.
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

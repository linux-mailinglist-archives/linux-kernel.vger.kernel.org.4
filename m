Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF66878F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBBJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjBBJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DB449E;
        Thu,  2 Feb 2023 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675330412; x=1706866412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aIiyDgv/qmZGr3jDNkPYzcbCICg4MgEqP2BLjAJlMts=;
  b=QpoIQv+gp7esr1mFlbLmilipLrH1mQY8ByD9BrnCwCWYFP6KCYWff4fe
   Pjx64K8Pp6oYAfMv/+kelzayPXgDSd2lP7vXg22c906Msr4hiY+KDI3bh
   uB1YK69rXR4j4A6UKlUfRGfIhnqrtGC3GDdwGE9L+iD3ueF6UZGihK8Mn
   f/SXE7G0ECXq0LFnaqiWbLuz95FwXn0ZiLlmnLVhxdnFj3cVpyR0YLfyM
   OUCoz3Ql+UIx1V+9Qv0ORF20iCdEGFS/0hSI+X8+H6+kV1R0ooaEtzRA2
   T+thDmmB0Q0da0wNySIPmgYA2yLr58hEIzbfeurEuScXNdqzxCgrMyY1d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308742904"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308742904"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697626494"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="697626494"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2023 01:33:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNVy6-0006O0-0g;
        Thu, 02 Feb 2023 09:33:22 +0000
Date:   Thu, 2 Feb 2023 17:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Kolesa <q66@chimera-linux.org>,
        Chris Mason <chris.mason@fusionio.com>
Subject: Re: [PATCH] Documentation/llvm: add Chimera Linux, Google and Meta
 datacenters
Message-ID: <202302021759.syE8waoZ-lkp@intel.com>
References: <20230201192509.4124319-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201192509.4124319-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I love your patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on masahiroy-kbuild/fixes linus/master v6.2-rc6 next-20230202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/Documentation-llvm-add-Chimera-Linux-Google-and-Meta-datacenters/20230202-032729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20230201192509.4124319-1-ndesaulniers%40google.com
patch subject: [PATCH] Documentation/llvm: add Chimera Linux, Google and Meta datacenters
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/fb73005aa3c6a4052e30f0f0dc2c608bafd8acce
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nick-Desaulniers/Documentation-llvm-add-Chimera-Linux-Google-and-Meta-datacenters/20230202-032729
        git checkout fb73005aa3c6a4052e30f0f0dc2c608bafd8acce
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/kbuild/llvm.rst:13: WARNING: Unknown target name: "chromeos https://www.chromium.org/chromium-os>".

vim +13 Documentation/kbuild/llvm.rst

fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26  12  
fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26 @13  The Linux kernel has always traditionally been compiled with GNU toolchains
fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26  14  such as GCC and binutils. Ongoing work has allowed for `Clang
fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26  15  <https://clang.llvm.org/>`_ and `LLVM <https://llvm.org/>`_ utilities to be
fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26  16  used as viable substitutes. Distributions such as `Android
fcf1b6a35c16ac5 Nick Desaulniers 2020-02-26  17  <https://www.android.com/>`_, `ChromeOS
fb73005aa3c6a40 Nick Desaulniers 2023-02-01  18  https://www.chromium.org/chromium-os>`_, `OpenMandriva
fb73005aa3c6a40 Nick Desaulniers 2023-02-01  19  <https://www.openmandriva.org/>`_, and `Chimera Linux
fb73005aa3c6a40 Nick Desaulniers 2023-02-01  20  <https://chimera-linux.org/>`_ use Clang built kernels. Google's and Meta's
fb73005aa3c6a40 Nick Desaulniers 2023-02-01  21  datacenter fleets also run kernels built with Clang.
fb73005aa3c6a40 Nick Desaulniers 2023-02-01  22  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

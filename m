Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7F67FCEB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjA2Fnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Fnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:43:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174C2195A;
        Sat, 28 Jan 2023 21:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674971031; x=1706507031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vinio+kxoxXPsdw4YnoQVhLOiX+CXO6ImvN6CeFFG5o=;
  b=HDYLca7PoVUBLmDfmH+ZAzpJYhAQmTRxBWqqS93I8NlC69HB/WnaTDa4
   WWnhRdAjRNEqOZtwDWjFgk7Zz3RSxpIKigQp4k4BgBIVStYTT/of2syQs
   beFUME82BzskVZq1Qhs4qeGp5Cmz8uuO6CrYvi2Co+1/VBpoXuqX1KHbj
   nL4KZqyEtcSCiZySPLPJJAgpSxSs/T9RezMtG5pmYF9NE1MqXACTt2Jpv
   QSiLcQuQGagIs2QcyVYkAwebNc897JlzzV279rYMWekafAb5ZUnlsXxkV
   vxUfXboaSA/gbR/euebk/f+dla07GUNA0QsZ24fEtWoCqSfAFnQnPc2b7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="328650978"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="328650978"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 21:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="772065957"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="772065957"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2023 21:43:45 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pM0Tg-0002Uu-2i;
        Sun, 29 Jan 2023 05:43:44 +0000
Date:   Sun, 29 Jan 2023 13:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/4] kbuild: add a script to generate a list of files
 ignored by git
Message-ID: <202301291342.XDm50r44-lkp@intel.com>
References: <20230128173843.765212-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128173843.765212-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on masahiroy-kbuild/fixes linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-deb-pkg-create-source-package-without-cleaning/20230129-014015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20230128173843.765212-1-masahiroy%40kernel.org
patch subject: [PATCH 1/4] kbuild: add a script to generate a list of files ignored by git
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

spdxcheck warnings: (new ones prefixed by >>)
>> scripts/gen-exclude.py: 2:35 Invalid License ID: only

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

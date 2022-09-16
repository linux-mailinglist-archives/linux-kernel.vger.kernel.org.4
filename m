Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130F5BA521
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIPDat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPDap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:30:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A364DB04;
        Thu, 15 Sep 2022 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299044; x=1694835044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W0cfxaJO3/1PDzVFBWy7MMV7m4LDSVvZlQ6U4vLGtjI=;
  b=cvlCfbKXSrC8tkoDYNlcTUzOxNSOvQzvSN0ygot1m3s6Bm9ZTB7IWEWd
   8XlGQhsM+jd2dPK5HklFF/2324KNJfrt7pABms1m4W6ErReBG5bwV/tAP
   6aP1L4ON4J7EfyBmlphncpE5tPsjiGTxYYNNd0rse1eCak72p2CgF7l53
   CNS0whI7iibo9RQtkpwnK75NhCI+Y5BGBHKNoLKCZtzJmjsLNN7bQ1E0f
   rIzBNrJySJYGebDxeWJSLMT0z5QWcuc4Fj9uEZOyNsvmfpF0oHEIkIg95
   WRsx6i05wncEWTvfIIrXK5ppq4razEIDxhUbdLl+gGtJiKZUtYSxa3xim
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325169597"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325169597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="568689707"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2022 20:30:33 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ23k-0001OI-1a;
        Fri, 16 Sep 2022 03:30:32 +0000
Date:   Fri, 16 Sep 2022 11:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, jassisinghbrar@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: mailbox: Convert mtk-gce to DT schema
Message-ID: <202209161109.lJhgeduV-lkp@intel.com>
References: <20220915101716.70225-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915101716.70225-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-mailbox-Convert-mtk-gce-to-DT-schema/20220915-181923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/2bc0d648f46bb6438cd4c7a140a613090ee9c1b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/dt-bindings-mailbox-Convert-mtk-gce-to-DT-schema/20220915-181923
        git checkout 2bc0d648f46bb6438cd4c7a140a613090ee9c1b0
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mailbox/mtk-gce.txt

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

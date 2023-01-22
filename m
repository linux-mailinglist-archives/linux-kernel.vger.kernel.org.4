Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B216676BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 10:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjAVJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 04:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 04:13:49 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4A61F4A7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=svjA26I38xSpWROgZgTzqK8qFOOnyVE0F2WmO8pdwos=;
  b=BNdLI+eW+DeqQS5XcPOHRenuvKymq+vWLSuyAHc+nGOTtdpIrZVlTnD9
   ZqCMxglcOzEy2tyZPAOCJbCzhxLVVngY0tDNNwBNm+tYoEBu1DkbI+7L2
   pA3wpmIMmUFV0rp/GwEjXUrQI7UYcqufFdxU5yey/QRTZgeaEeOrT+mH0
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,237,1669071600"; 
   d="scan'208";a="45694784"
Received: from 186.120.68.85.rev.sfr.net (HELO hadrien) ([85.68.120.186])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 10:13:45 +0100
Date:   Sun, 22 Jan 2023 10:13:44 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     ye.xingchen@zte.com.cn, andrew@lunn.ch
cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: potential dereference of null pointer
 (fwd)
Message-ID: <alpine.DEB.2.22.394.2301221012440.2913@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Sat, 21 Jan 2023 09:37:16 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ARM: mvebu: potential dereference of null pointer

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
In-Reply-To: <202301191051184033370@zte.com.cn>
References: <202301191051184033370@zte.com.cn>
TO: ye.xingchen@zte.com.cn
TO: andrew@lunn.ch
CC: gregory.clement@bootlin.com
CC: sebastian.hesselbarth@gmail.com
CC: linux@armlinux.org.uk
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.2-rc4 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/ARM-mvebu-potential-dereference-of-null-pointer/20230119-105239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/202301191051184033370%40zte.com.cn
patch subject: [PATCH] ARM: mvebu: potential dereference of null pointer
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
config: arm-randconfig-c032-20230119 (https://download.01.org/0day-ci/archive/20230121/202301210926.eZarSBqd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> arch/arm/mach-mvebu/board-v7.c:124:1-25: WARNING: Function "for_each_compatible_node" should have of_node_put() before return around line 129.
   arch/arm/mach-mvebu/board-v7.c:124:1-25: WARNING: Function "for_each_compatible_node" should have of_node_put() before return around line 136.
--
>> arch/arm/mach-mvebu/coherency.c:190:1-25: WARNING: Function "for_each_compatible_node" should have of_node_put() before return around line 195.
   arch/arm/mach-mvebu/coherency.c:190:1-25: WARNING: Function "for_each_compatible_node" should have of_node_put() before return around line 198.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

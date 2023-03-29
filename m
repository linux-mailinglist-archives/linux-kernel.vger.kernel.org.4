Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7546CD1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC2Fnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC2Fns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:43:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F573A8B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680068623; x=1711604623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C1fML/7RisxPvrLe5CofxF3dlUzqz7mxCBghMI/fiik=;
  b=ggocGvsnBNcDss+YPVT1dkocpdh9Z/21wia1N7yTc0hR4XoHVuoc81Q4
   knxC36pgXnSzlZIbOQuLYfR3phiz5rey9Z+altk1uwhOA8vuX8ToOhCP2
   ox/txTrU0VNSuCuTT36ZVJMwmAcyrRMNQSDOIiUFrBDMSBw2deQn7Wmrp
   ZuDnOLya3Q2wweHaXfKN/ALj8K+VX704M5wE9Zvner85EIao8UYYx3nws
   lUSMAdQAn/J4IcT6Xwp4FM2Ktxcwf7lKJV9n6sc4SBo/17WVNeGhOm5WW
   qPDczmF84yT7+CT14/Ji6nsY0hZzoYiL+KNF3EVexNIxyRxBjnD2AH3Ks
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340806863"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="340806863"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 22:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="808073478"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="808073478"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2023 22:43:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phOaw-000JGq-2F;
        Wed, 29 Mar 2023 05:43:38 +0000
Date:   Wed, 29 Mar 2023 13:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 5/5] soc: apple: mailbox: Rename config symbol to
 APPLE_MAILBOX
Message-ID: <202303291348.nYR9dkeW-lkp@intel.com>
References: <20230328-soc-mailbox-v1-5-3953814532fd@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-soc-mailbox-v1-5-3953814532fd@marcan.st>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

I love your patch! Yet something to improve:

[auto build test ERROR on bdfe6de2695c5bccc663a5a7d530f81925d8bc10]

url:    https://github.com/intel-lab-lkp/linux/commits/Hector-Martin/soc-apple-rtkit-Get-rid-of-apple_rtkit_send_message_wait/20230328-211648
base:   bdfe6de2695c5bccc663a5a7d530f81925d8bc10
patch link:    https://lore.kernel.org/r/20230328-soc-mailbox-v1-5-3953814532fd%40marcan.st
patch subject: [PATCH 5/5] soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230329/202303291348.nYR9dkeW-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d0addf95095d935cdd5940101fbf1b1594b08158
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hector-Martin/soc-apple-rtkit-Get-rid-of-apple_rtkit_send_message_wait/20230328-211648
        git checkout d0addf95095d935cdd5940101fbf1b1594b08158
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303291348.nYR9dkeW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/apple/mailbox.c: In function 'apple_mbox_send':
>> drivers/soc/apple/mailbox.c:151:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     151 |         writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg.msg1),
         |                        ^~~~~~~~~~
   drivers/soc/apple/mailbox.c: In function 'apple_mbox_poll_locked':
>> drivers/soc/apple/mailbox.c:188:28: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     188 |                 msg.msg1 = FIELD_GET(
         |                            ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +151 drivers/soc/apple/mailbox.c

8b654b5034baba0 Hector Martin 2023-03-28   95  
8b654b5034baba0 Hector Martin 2023-03-28   96  int apple_mbox_send(struct apple_mbox *mbox, const struct apple_mbox_msg msg,
8b654b5034baba0 Hector Martin 2023-03-28   97  		    bool atomic)
8b654b5034baba0 Hector Martin 2023-03-28   98  {
8b654b5034baba0 Hector Martin 2023-03-28   99  	unsigned long flags;
8b654b5034baba0 Hector Martin 2023-03-28  100  	int ret;
8b654b5034baba0 Hector Martin 2023-03-28  101  	u32 mbox_ctrl;
8b654b5034baba0 Hector Martin 2023-03-28  102  	long t;
8b654b5034baba0 Hector Martin 2023-03-28  103  
8b654b5034baba0 Hector Martin 2023-03-28  104  	spin_lock_irqsave(&mbox->tx_lock, flags);
8b654b5034baba0 Hector Martin 2023-03-28  105  	mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->a2i_control);
8b654b5034baba0 Hector Martin 2023-03-28  106  
8b654b5034baba0 Hector Martin 2023-03-28  107  	while (mbox_ctrl & mbox->hw->control_full) {
8b654b5034baba0 Hector Martin 2023-03-28  108  		if (atomic) {
8b654b5034baba0 Hector Martin 2023-03-28  109  			ret = readl_poll_timeout_atomic(
8b654b5034baba0 Hector Martin 2023-03-28  110  				mbox->regs + mbox->hw->a2i_control, mbox_ctrl,
8b654b5034baba0 Hector Martin 2023-03-28  111  				!(mbox_ctrl & mbox->hw->control_full), 100,
8b654b5034baba0 Hector Martin 2023-03-28  112  				APPLE_MBOX_TX_TIMEOUT * 1000);
8b654b5034baba0 Hector Martin 2023-03-28  113  
8b654b5034baba0 Hector Martin 2023-03-28  114  			if (ret) {
8b654b5034baba0 Hector Martin 2023-03-28  115  				spin_unlock_irqrestore(&mbox->tx_lock, flags);
8b654b5034baba0 Hector Martin 2023-03-28  116  				return ret;
8b654b5034baba0 Hector Martin 2023-03-28  117  			}
8b654b5034baba0 Hector Martin 2023-03-28  118  
8b654b5034baba0 Hector Martin 2023-03-28  119  			break;
8b654b5034baba0 Hector Martin 2023-03-28  120  		}
8b654b5034baba0 Hector Martin 2023-03-28  121  		/*
8b654b5034baba0 Hector Martin 2023-03-28  122  		 * The interrupt is level triggered and will keep firing as long as the
8b654b5034baba0 Hector Martin 2023-03-28  123  		 * FIFO is empty. It will also keep firing if the FIFO was empty
8b654b5034baba0 Hector Martin 2023-03-28  124  		 * at any point in the past until it has been acknowledged at the
8b654b5034baba0 Hector Martin 2023-03-28  125  		 * mailbox level. By acknowledging it here we can ensure that we will
8b654b5034baba0 Hector Martin 2023-03-28  126  		 * only get the interrupt once the FIFO has been cleared again.
8b654b5034baba0 Hector Martin 2023-03-28  127  		 * If the FIFO is already empty before the ack it will fire again
8b654b5034baba0 Hector Martin 2023-03-28  128  		 * immediately after the ack.
8b654b5034baba0 Hector Martin 2023-03-28  129  		 */
8b654b5034baba0 Hector Martin 2023-03-28  130  		if (mbox->hw->has_irq_controls) {
8b654b5034baba0 Hector Martin 2023-03-28  131  			writel_relaxed(mbox->hw->irq_bit_send_empty,
8b654b5034baba0 Hector Martin 2023-03-28  132  				       mbox->regs + mbox->hw->irq_ack);
8b654b5034baba0 Hector Martin 2023-03-28  133  		}
8b654b5034baba0 Hector Martin 2023-03-28  134  		enable_irq(mbox->irq_send_empty);
8b654b5034baba0 Hector Martin 2023-03-28  135  		reinit_completion(&mbox->tx_empty);
8b654b5034baba0 Hector Martin 2023-03-28  136  		spin_unlock_irqrestore(&mbox->tx_lock, flags);
8b654b5034baba0 Hector Martin 2023-03-28  137  
8b654b5034baba0 Hector Martin 2023-03-28  138  		t = wait_for_completion_interruptible_timeout(
8b654b5034baba0 Hector Martin 2023-03-28  139  			&mbox->tx_empty,
8b654b5034baba0 Hector Martin 2023-03-28  140  			msecs_to_jiffies(APPLE_MBOX_TX_TIMEOUT));
8b654b5034baba0 Hector Martin 2023-03-28  141  		if (t < 0)
8b654b5034baba0 Hector Martin 2023-03-28  142  			return t;
8b654b5034baba0 Hector Martin 2023-03-28  143  		else if (t == 0)
8b654b5034baba0 Hector Martin 2023-03-28  144  			return -ETIMEDOUT;
8b654b5034baba0 Hector Martin 2023-03-28  145  
8b654b5034baba0 Hector Martin 2023-03-28  146  		spin_lock_irqsave(&mbox->tx_lock, flags);
8b654b5034baba0 Hector Martin 2023-03-28  147  		mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->a2i_control);
8b654b5034baba0 Hector Martin 2023-03-28  148  	}
8b654b5034baba0 Hector Martin 2023-03-28  149  
8b654b5034baba0 Hector Martin 2023-03-28  150  	writeq_relaxed(msg.msg0, mbox->regs + mbox->hw->a2i_send0);
8b654b5034baba0 Hector Martin 2023-03-28 @151  	writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg.msg1),
8b654b5034baba0 Hector Martin 2023-03-28  152  		       mbox->regs + mbox->hw->a2i_send1);
8b654b5034baba0 Hector Martin 2023-03-28  153  
8b654b5034baba0 Hector Martin 2023-03-28  154  	spin_unlock_irqrestore(&mbox->tx_lock, flags);
8b654b5034baba0 Hector Martin 2023-03-28  155  
8b654b5034baba0 Hector Martin 2023-03-28  156  	return 0;
8b654b5034baba0 Hector Martin 2023-03-28  157  }
8b654b5034baba0 Hector Martin 2023-03-28  158  EXPORT_SYMBOL(apple_mbox_send);
8b654b5034baba0 Hector Martin 2023-03-28  159  
8b654b5034baba0 Hector Martin 2023-03-28  160  static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
8b654b5034baba0 Hector Martin 2023-03-28  161  {
8b654b5034baba0 Hector Martin 2023-03-28  162  	struct apple_mbox *mbox = data;
8b654b5034baba0 Hector Martin 2023-03-28  163  
8b654b5034baba0 Hector Martin 2023-03-28  164  	/*
8b654b5034baba0 Hector Martin 2023-03-28  165  	 * We don't need to acknowledge the interrupt at the mailbox level
8b654b5034baba0 Hector Martin 2023-03-28  166  	 * here even if supported by the hardware. It will keep firing but that
8b654b5034baba0 Hector Martin 2023-03-28  167  	 * doesn't matter since it's disabled at the main interrupt controller.
8b654b5034baba0 Hector Martin 2023-03-28  168  	 * apple_mbox_send will acknowledge it before enabling
8b654b5034baba0 Hector Martin 2023-03-28  169  	 * it at the main controller again.
8b654b5034baba0 Hector Martin 2023-03-28  170  	 */
8b654b5034baba0 Hector Martin 2023-03-28  171  	spin_lock(&mbox->tx_lock);
8b654b5034baba0 Hector Martin 2023-03-28  172  	disable_irq_nosync(mbox->irq_send_empty);
8b654b5034baba0 Hector Martin 2023-03-28  173  	complete(&mbox->tx_empty);
8b654b5034baba0 Hector Martin 2023-03-28  174  	spin_unlock(&mbox->tx_lock);
8b654b5034baba0 Hector Martin 2023-03-28  175  
8b654b5034baba0 Hector Martin 2023-03-28  176  	return IRQ_HANDLED;
8b654b5034baba0 Hector Martin 2023-03-28  177  }
8b654b5034baba0 Hector Martin 2023-03-28  178  
8b654b5034baba0 Hector Martin 2023-03-28  179  static int apple_mbox_poll_locked(struct apple_mbox *mbox)
8b654b5034baba0 Hector Martin 2023-03-28  180  {
8b654b5034baba0 Hector Martin 2023-03-28  181  	struct apple_mbox_msg msg;
8b654b5034baba0 Hector Martin 2023-03-28  182  	int ret = 0;
8b654b5034baba0 Hector Martin 2023-03-28  183  
8b654b5034baba0 Hector Martin 2023-03-28  184  	u32 mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->i2a_control);
8b654b5034baba0 Hector Martin 2023-03-28  185  
8b654b5034baba0 Hector Martin 2023-03-28  186  	while (!(mbox_ctrl & mbox->hw->control_empty)) {
8b654b5034baba0 Hector Martin 2023-03-28  187  		msg.msg0 = readq_relaxed(mbox->regs + mbox->hw->i2a_recv0);
8b654b5034baba0 Hector Martin 2023-03-28 @188  		msg.msg1 = FIELD_GET(
8b654b5034baba0 Hector Martin 2023-03-28  189  			APPLE_MBOX_MSG1_MSG,
8b654b5034baba0 Hector Martin 2023-03-28  190  			readq_relaxed(mbox->regs + mbox->hw->i2a_recv1));
8b654b5034baba0 Hector Martin 2023-03-28  191  
8b654b5034baba0 Hector Martin 2023-03-28  192  		mbox->rx(mbox, msg, mbox->cookie);
8b654b5034baba0 Hector Martin 2023-03-28  193  		ret++;
8b654b5034baba0 Hector Martin 2023-03-28  194  		mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->i2a_control);
8b654b5034baba0 Hector Martin 2023-03-28  195  	}
8b654b5034baba0 Hector Martin 2023-03-28  196  
8b654b5034baba0 Hector Martin 2023-03-28  197  	/*
8b654b5034baba0 Hector Martin 2023-03-28  198  	 * The interrupt will keep firing even if there are no more messages
8b654b5034baba0 Hector Martin 2023-03-28  199  	 * unless we also acknowledge it at the mailbox level here.
8b654b5034baba0 Hector Martin 2023-03-28  200  	 * There's no race if a message comes in between the check in the while
8b654b5034baba0 Hector Martin 2023-03-28  201  	 * loop above and the ack below: If a new messages arrives inbetween
8b654b5034baba0 Hector Martin 2023-03-28  202  	 * those two the interrupt will just fire again immediately after the
8b654b5034baba0 Hector Martin 2023-03-28  203  	 * ack since it's level triggered.
8b654b5034baba0 Hector Martin 2023-03-28  204  	 */
8b654b5034baba0 Hector Martin 2023-03-28  205  	if (mbox->hw->has_irq_controls) {
8b654b5034baba0 Hector Martin 2023-03-28  206  		writel_relaxed(mbox->hw->irq_bit_recv_not_empty,
8b654b5034baba0 Hector Martin 2023-03-28  207  			       mbox->regs + mbox->hw->irq_ack);
8b654b5034baba0 Hector Martin 2023-03-28  208  	}
8b654b5034baba0 Hector Martin 2023-03-28  209  
8b654b5034baba0 Hector Martin 2023-03-28  210  	return ret;
8b654b5034baba0 Hector Martin 2023-03-28  211  }
8b654b5034baba0 Hector Martin 2023-03-28  212  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

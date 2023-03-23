Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC76C7268
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWVjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCWVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:39:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32938EB51;
        Thu, 23 Mar 2023 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679607528; x=1711143528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbZoo6Nx4M16QxR5wA5IqaUYENCf1sS0pRgdIgX11Mk=;
  b=R5OM3Dch61D184eYNZefittdoi0f8an/jGX9qtx9lEHNwzFjHQY8lOXp
   v5Upo4UtcVnTwHTURRSb/cjVSffOkgvuZh6/wNlHhgpPFLkc9atKmZjba
   REPjUm65aDFohfanTxRFuUSEAQmD/6fs48kO3cxGPbJQEcajX69RX0mrH
   wQnY1vamBErQgXCK7pVLMOyL7UJUrbijzbUkCg6MsKmZ83pERjPMoWYIx
   C7Nn6khy6UZp9NhS/M+SKLyMveBgIexNn2tMfKX2bqr98pjW57ifI8o1k
   mqW+JJzoOGIQQjbqIrVW5EBnPzsZsqmpfh1ZPnGqwCfCreU08yNRAe+8W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341190008"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="341190008"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 14:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="675882682"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="675882682"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 14:38:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfSdw-000Ej2-2K;
        Thu, 23 Mar 2023 21:38:44 +0000
Date:   Fri, 24 Mar 2023 05:38:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
Message-ID: <202303240551.fGGqFGmo-lkp@intel.com>
References: <20230323191527.1472695-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323191527.1472695-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 6ccbe33a39523f6d62b22c5ee99c6695993c935e]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
base:   6ccbe33a39523f6d62b22c5ee99c6695993c935e
patch link:    https://lore.kernel.org/r/20230323191527.1472695-4-quic_eberman%40quicinc.com
patch subject: [PATCH v2 3/3] mailbox: pcc: Use mbox_bind_client
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230324/202303240551.fGGqFGmo-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5db6edf9f393224193ab13e82d63e0d7616c74c9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/mailbox-Allow-direct-registration-to-a-channel/20230324-031813
        git checkout 5db6edf9f393224193ab13e82d63e0d7616c74c9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303240551.fGGqFGmo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mailbox/pcc.c: In function 'pcc_mbox_request_channel':
>> drivers/mailbox/pcc.c:285:24: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
     285 |         struct device *dev;
         |                        ^~~
   drivers/mailbox/pcc.c: At top level:
>> drivers/mailbox/pcc.c:355:5: warning: no previous prototype for 'pcc_startup' [-Wmissing-prototypes]
     355 | int pcc_startup(struct mbox_chan *chan)
         |     ^~~~~~~~~~~
>> drivers/mailbox/pcc.c:378:6: warning: no previous prototype for 'pcc_shutdown' [-Wmissing-prototypes]
     378 | void pcc_shutdown(struct mbox_chan *chan)
         |      ^~~~~~~~~~~~


vim +/dev +285 drivers/mailbox/pcc.c

aca314efb177274 hotran             2016-08-15  267  
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  268  /**
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  269   * pcc_mbox_request_channel - PCC clients call this function to
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  270   *		request a pointer to their PCC subspace, from which they
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  271   *		can get the details of communicating with the remote.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  272   * @cl: Pointer to Mailbox client, so we know where to bind the
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  273   *		Channel.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  274   * @subspace_id: The PCC Subspace index as parsed in the PCC client
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  275   *		ACPI package. This is used to lookup the array of PCC
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  276   *		subspaces as parsed by the PCC Mailbox controller.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  277   *
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  278   * Return: Pointer to the PCC Mailbox Channel if successful or ERR_PTR.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  279   */
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  280  struct pcc_mbox_chan *
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  281  pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  282  {
80b2bdde002c521 Sudeep Holla       2021-09-17  283  	struct pcc_chan_info *pchan;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  284  	struct mbox_chan *chan;
ce028702ddbc697 Sudeep Holla       2021-09-17 @285  	struct device *dev;
5db6edf9f393224 Elliot Berman      2023-03-23  286  	int rc;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  287  
ce028702ddbc697 Sudeep Holla       2021-09-17  288  	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  289  		return ERR_PTR(-ENOENT);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  290  
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  291  	pchan = chan_info + subspace_id;
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  292  	chan = pchan->chan.mchan;
d311a28a5853857 Sudip Mukherjee    2015-09-16  293  	if (IS_ERR(chan) || chan->cl) {
960c4056aadcf61 Sudeep Holla       2021-12-09  294  		pr_err("Channel not found for idx: %d\n", subspace_id);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  295  		return ERR_PTR(-EBUSY);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  296  	}
ce028702ddbc697 Sudeep Holla       2021-09-17  297  	dev = chan->mbox->dev;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  298  
5db6edf9f393224 Elliot Berman      2023-03-23  299  	rc = mbox_bind_client(chan, cl);
5db6edf9f393224 Elliot Berman      2023-03-23  300  	if (rc)
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  301  		return ERR_PTR(rc);
aca314efb177274 hotran             2016-08-15  302  
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  303  	return &pchan->chan;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  304  }
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  305  EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  306  
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  307  /**
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  308   * pcc_mbox_free_channel - Clients call this to free their Channel.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  309   *
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  310   * @pchan: Pointer to the PCC mailbox channel as returned by
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  311   *	   pcc_mbox_request_channel()
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  312   */
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  313  void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  314  {
7b6da7fe7bba1cd Sudeep Holla       2021-09-17  315  	struct mbox_chan *chan = pchan->mchan;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  316  
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  317  	if (!chan || !chan->cl)
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  318  		return;
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  319  
5db6edf9f393224 Elliot Berman      2023-03-23  320  	mbox_free_channel(chan);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  321  }
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  322  EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  323  
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  324  /**
33350e6b1833b15 Ashwin Chaugule    2015-01-27  325   * pcc_send_data - Called from Mailbox Controller code. Used
33350e6b1833b15 Ashwin Chaugule    2015-01-27  326   *		here only to ring the channel doorbell. The PCC client
33350e6b1833b15 Ashwin Chaugule    2015-01-27  327   *		specific read/write is done in the client driver in
33350e6b1833b15 Ashwin Chaugule    2015-01-27  328   *		order to maintain atomicity over PCC channel once
33350e6b1833b15 Ashwin Chaugule    2015-01-27  329   *		OS has control over it. See above for flow of operations.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  330   * @chan: Pointer to Mailbox channel over which to send data.
33350e6b1833b15 Ashwin Chaugule    2015-01-27  331   * @data: Client specific data written over channel. Used here
33350e6b1833b15 Ashwin Chaugule    2015-01-27  332   *		only for debug after PCC transaction completes.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  333   *
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  334   * Return: Err if something failed else 0 for success.
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  335   */
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  336  static int pcc_send_data(struct mbox_chan *chan, void *data)
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  337  {
c45ded7e11352d7 Sudeep Holla       2021-09-17  338  	int ret;
bf18123e78f4d13 Sudeep Holla       2021-09-17  339  	struct pcc_chan_info *pchan = chan->con_priv;
8b0f57889843af6 Prakash, Prashanth 2016-02-17  340  
c45ded7e11352d7 Sudeep Holla       2021-09-17  341  	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
c45ded7e11352d7 Sudeep Holla       2021-09-17  342  	if (ret)
c45ded7e11352d7 Sudeep Holla       2021-09-17  343  		return ret;
c45ded7e11352d7 Sudeep Holla       2021-09-17  344  
bf18123e78f4d13 Sudeep Holla       2021-09-17  345  	return pcc_chan_reg_read_modify_write(&pchan->db);
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  346  }
86c22f8c9a3b71d Ashwin Chaugule    2014-11-12  347  
5db6edf9f393224 Elliot Berman      2023-03-23  348  /**
5db6edf9f393224 Elliot Berman      2023-03-23  349   * pcc_startup - Called from Mailbox Controller code. Used here
5db6edf9f393224 Elliot Berman      2023-03-23  350   *		to request the interrupt.
5db6edf9f393224 Elliot Berman      2023-03-23  351   * @chan: Pointer to Mailbox channel to startup.
5db6edf9f393224 Elliot Berman      2023-03-23  352   *
5db6edf9f393224 Elliot Berman      2023-03-23  353   * Return: Err if something failed else 0 for success.
5db6edf9f393224 Elliot Berman      2023-03-23  354   */
5db6edf9f393224 Elliot Berman      2023-03-23 @355  int pcc_startup(struct mbox_chan *chan)
5db6edf9f393224 Elliot Berman      2023-03-23  356  {
5db6edf9f393224 Elliot Berman      2023-03-23  357  	struct pcc_chan_info *pchan = chan->con_priv;
5db6edf9f393224 Elliot Berman      2023-03-23  358  	int rc;
5db6edf9f393224 Elliot Berman      2023-03-23  359  
5db6edf9f393224 Elliot Berman      2023-03-23  360  	if (pchan->plat_irq > 0) {
5db6edf9f393224 Elliot Berman      2023-03-23  361  		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq, 0,
5db6edf9f393224 Elliot Berman      2023-03-23  362  				      MBOX_IRQ_NAME, chan);
5db6edf9f393224 Elliot Berman      2023-03-23  363  		if (unlikely(rc)) {
5db6edf9f393224 Elliot Berman      2023-03-23  364  			dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
5db6edf9f393224 Elliot Berman      2023-03-23  365  				pchan->plat_irq);
5db6edf9f393224 Elliot Berman      2023-03-23  366  			return rc;
5db6edf9f393224 Elliot Berman      2023-03-23  367  		}
5db6edf9f393224 Elliot Berman      2023-03-23  368  	}
5db6edf9f393224 Elliot Berman      2023-03-23  369  
5db6edf9f393224 Elliot Berman      2023-03-23  370  	return 0;
5db6edf9f393224 Elliot Berman      2023-03-23  371  }
5db6edf9f393224 Elliot Berman      2023-03-23  372  
5db6edf9f393224 Elliot Berman      2023-03-23  373  /**
5db6edf9f393224 Elliot Berman      2023-03-23  374   * pcc_shutdown - Called from Mailbox Controller code. Used here
5db6edf9f393224 Elliot Berman      2023-03-23  375   *		to free the interrupt.
5db6edf9f393224 Elliot Berman      2023-03-23  376   * @chan: Pointer to Mailbox channel to shutdown.
5db6edf9f393224 Elliot Berman      2023-03-23  377   */
5db6edf9f393224 Elliot Berman      2023-03-23 @378  void pcc_shutdown(struct mbox_chan *chan)
5db6edf9f393224 Elliot Berman      2023-03-23  379  {
5db6edf9f393224 Elliot Berman      2023-03-23  380  	struct pcc_chan_info *pchan = chan->con_priv;
5db6edf9f393224 Elliot Berman      2023-03-23  381  
5db6edf9f393224 Elliot Berman      2023-03-23  382  	if (pchan->plat_irq > 0)
5db6edf9f393224 Elliot Berman      2023-03-23  383  		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
5db6edf9f393224 Elliot Berman      2023-03-23  384  }
5db6edf9f393224 Elliot Berman      2023-03-23  385  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

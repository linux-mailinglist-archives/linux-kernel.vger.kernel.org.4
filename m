Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5560698B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBPEHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPEH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:07:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C39410A1;
        Wed, 15 Feb 2023 20:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676520444; x=1708056444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0DPAmKW1lXau4Nqj9Zrh051Yjvn+u6y1ltd9lO+L+I=;
  b=cThcMd1vlHmOv0UauaYL0eVU/e5try+ax/Q6Vy6bRneXuVhgeQNG1hwL
   nNtJS7ksiHgbOK1d27Z7gV93+d2PDS0BC0fBnv3umO74/RbUKTIs3eTxh
   jOF+TGu5QNCbB//xygZjxn9BKoVba2+f4rwlOIgHuOjhCfIKDaEsvmLcl
   Sk6XxrT7qXou/7tjARFP8CAzK5ElmWaGaxC3lM15PjoIDlrvXEtSisLML
   B+h/8ZNuGKRP6n1GIHRXY7+FXNZiyuTx08QCWgap4ly3TcO0qIHtW97kx
   bWkHCACUpwds6B1OtbgqHnAejFVlNPtY7WaotT0/RaVtd0xZHRppTp1KX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="315292315"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="315292315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 20:07:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="793882911"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="793882911"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 20:07:15 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSVYA-0009zt-2D;
        Thu, 16 Feb 2023 04:07:14 +0000
Date:   Thu, 16 Feb 2023 12:07:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
Message-ID: <202302161137.mfophRBY-lkp@intel.com>
References: <20230214212316.3309053-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212316.3309053-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
base:   3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
patch link:    https://lore.kernel.org/r/20230214212316.3309053-1-quic_eberman%40quicinc.com
patch subject: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230216/202302161137.mfophRBY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b427188cd418632da7b26f283f5d2c668038186f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
        git checkout b427188cd418632da7b26f283f5d2c668038186f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302161137.mfophRBY-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mailbox/gunyah-msgq.c: In function 'gh_msgq_init':
>> drivers/mailbox/gunyah-msgq.c:180:15: error: implicit declaration of function 'mbox_bind_client' [-Werror=implicit-function-declaration]
     180 |         ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
         |               ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mbox_bind_client +180 drivers/mailbox/gunyah-msgq.c

   110	
   111	/**
   112	 * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
   113	 * @parent: optional, device parent used for the mailbox controller
   114	 * @msgq: Pointer to the gh_msgq to initialize
   115	 * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
   116	 * @tx_ghrsc: optional, the transmission side of the message queue
   117	 * @rx_ghrsc: optional, the receiving side of the message queue
   118	 *
   119	 * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
   120	 * a pair of message queues to facilitate bidirectional communication. When tx_ghrsc is set,
   121	 * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
   122	 * is set, the mbox_client should register an .rx_callback() and the message queue driver will
   123	 * push all available messages upon receiving the RX ready interrupt. The messages should be
   124	 * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
   125	 * after the callback.
   126	 *
   127	 * Returns - 0 on success, negative otherwise
   128	 */
   129	int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
   130			     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc)
   131	{
   132		int ret;
   133	
   134		/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
   135		if ((!tx_ghrsc && !rx_ghrsc) ||
   136		    (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
   137		    (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))
   138			return -EINVAL;
   139	
   140		if (gh_api_version() != GUNYAH_API_V1) {
   141			pr_err("Unrecognized gunyah version: %u. Currently supported: %d\n",
   142				gh_api_version(), GUNYAH_API_V1);
   143			return -EOPNOTSUPP;
   144		}
   145	
   146		if (!gh_api_has_feature(GH_API_FEATURE_MSGQUEUE))
   147			return -EOPNOTSUPP;
   148	
   149		msgq->tx_ghrsc = tx_ghrsc;
   150		msgq->rx_ghrsc = rx_ghrsc;
   151	
   152		msgq->mbox.dev = parent;
   153		msgq->mbox.ops = &gh_msgq_ops;
   154		msgq->mbox.num_chans = 1;
   155		msgq->mbox.txdone_irq = true;
   156		msgq->mbox.chans = kcalloc(msgq->mbox.num_chans, sizeof(*msgq->mbox.chans), GFP_KERNEL);
   157		if (!msgq->mbox.chans)
   158			return -ENOMEM;
   159	
   160		if (msgq->tx_ghrsc) {
   161			ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
   162					msgq);
   163			if (ret)
   164				goto err_chans;
   165		}
   166	
   167		if (msgq->rx_ghrsc) {
   168			ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
   169							IRQF_ONESHOT, "gh_msgq_rx", msgq);
   170			if (ret)
   171				goto err_tx_irq;
   172		}
   173	
   174		tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
   175	
   176		ret = mbox_controller_register(&msgq->mbox);
   177		if (ret)
   178			goto err_rx_irq;
   179	
 > 180		ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
   181		if (ret)
   182			goto err_mbox;
   183	
   184		return 0;
   185	err_mbox:
   186		mbox_controller_unregister(&msgq->mbox);
   187	err_rx_irq:
   188		if (msgq->rx_ghrsc)
   189			free_irq(msgq->rx_ghrsc->irq, msgq);
   190	err_tx_irq:
   191		if (msgq->tx_ghrsc)
   192			free_irq(msgq->tx_ghrsc->irq, msgq);
   193	err_chans:
   194		kfree(msgq->mbox.chans);
   195		return ret;
   196	}
   197	EXPORT_SYMBOL_GPL(gh_msgq_init);
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

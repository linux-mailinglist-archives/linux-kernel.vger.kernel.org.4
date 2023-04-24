Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646616ED325
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDXRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:08:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA659FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682356082; x=1713892082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JnvtNP228v6cgRE/nnReiJdO1qjGMe29v41TlRgvhko=;
  b=Cnp1YxNbki841bdp9QzFyBbATEBpDt1h5T95NgxnQve4x/yKEimswO1n
   a52DAClLR8ySrkkkp+aLt7eABmsqKIdpMKuUIRsox+bTtvHFHOn+5m+1d
   Fz9Be0mm4IO6seAMutvEw9x15lFjNK3ldU5EFvtaAEGEwb5E63eu9Qxns
   uQDukslNgz+YzOGrKNFe+FIbBARhucm2bRj6qC5Yh8j6b27vrFtwKhwv0
   vZvaSvKKRzRcV0dw+b9UdXT7Dw+4VYFfwGrkuy8rXjy+CN62htpOwnvnk
   4spVtIdWeVqXtcKRXX1hCOmWDQKVNG+K8sao9Ng50Sl2ap56K5QEYFg9I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326115633"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326115633"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 10:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867549588"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="867549588"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2023 10:07:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqzfQ-000iZQ-2j;
        Mon, 24 Apr 2023 17:07:56 +0000
Date:   Tue, 25 Apr 2023 01:06:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/interconnect/qcom/icc-rpmh.c:165:28: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202304250022.ZNF62MR9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   457391b0380335d5e9a5babdec90ac53928b23b4
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   10 months ago
config: arm64-randconfig-s051-20230424 (https://download.01.org/0day-ci/archive/20230425/202304250022.ZNF62MR9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/interconnect/qcom/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304250022.ZNF62MR9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/interconnect/qcom/icc-rpmh.c:165:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] unit @@     got unsigned int [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:165:28: sparse:     expected restricted __le32 [usertype] unit
   drivers/interconnect/qcom/icc-rpmh.c:165:28: sparse:     got unsigned int [usertype]
>> drivers/interconnect/qcom/icc-rpmh.c:166:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] width @@     got unsigned short [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:166:29: sparse:     expected restricted __le16 [usertype] width
   drivers/interconnect/qcom/icc-rpmh.c:166:29: sparse:     got unsigned short [usertype]

vim +165 drivers/interconnect/qcom/icc-rpmh.c

6caa3070fd5955 Georgi Djakov 2020-09-03  127  
976daac4a1c581 David Dai     2020-02-28  128  /**
976daac4a1c581 David Dai     2020-02-28  129   * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
976daac4a1c581 David Dai     2020-02-28  130   * @bcm: bcm to be initialized
976daac4a1c581 David Dai     2020-02-28  131   * @dev: associated provider device
976daac4a1c581 David Dai     2020-02-28  132   *
976daac4a1c581 David Dai     2020-02-28  133   * Return: 0 on success, or an error code otherwise
976daac4a1c581 David Dai     2020-02-28  134   */
976daac4a1c581 David Dai     2020-02-28  135  int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
976daac4a1c581 David Dai     2020-02-28  136  {
976daac4a1c581 David Dai     2020-02-28  137  	struct qcom_icc_node *qn;
976daac4a1c581 David Dai     2020-02-28  138  	const struct bcm_db *data;
976daac4a1c581 David Dai     2020-02-28  139  	size_t data_count;
976daac4a1c581 David Dai     2020-02-28  140  	int i;
976daac4a1c581 David Dai     2020-02-28  141  
976daac4a1c581 David Dai     2020-02-28  142  	/* BCM is already initialised*/
976daac4a1c581 David Dai     2020-02-28  143  	if (bcm->addr)
976daac4a1c581 David Dai     2020-02-28  144  		return 0;
976daac4a1c581 David Dai     2020-02-28  145  
976daac4a1c581 David Dai     2020-02-28  146  	bcm->addr = cmd_db_read_addr(bcm->name);
976daac4a1c581 David Dai     2020-02-28  147  	if (!bcm->addr) {
976daac4a1c581 David Dai     2020-02-28  148  		dev_err(dev, "%s could not find RPMh address\n",
976daac4a1c581 David Dai     2020-02-28  149  			bcm->name);
976daac4a1c581 David Dai     2020-02-28  150  		return -EINVAL;
976daac4a1c581 David Dai     2020-02-28  151  	}
976daac4a1c581 David Dai     2020-02-28  152  
976daac4a1c581 David Dai     2020-02-28  153  	data = cmd_db_read_aux_data(bcm->name, &data_count);
976daac4a1c581 David Dai     2020-02-28  154  	if (IS_ERR(data)) {
976daac4a1c581 David Dai     2020-02-28  155  		dev_err(dev, "%s command db read error (%ld)\n",
976daac4a1c581 David Dai     2020-02-28  156  			bcm->name, PTR_ERR(data));
976daac4a1c581 David Dai     2020-02-28  157  		return PTR_ERR(data);
976daac4a1c581 David Dai     2020-02-28  158  	}
976daac4a1c581 David Dai     2020-02-28  159  	if (!data_count) {
976daac4a1c581 David Dai     2020-02-28  160  		dev_err(dev, "%s command db missing or partial aux data\n",
976daac4a1c581 David Dai     2020-02-28  161  			bcm->name);
976daac4a1c581 David Dai     2020-02-28  162  		return -EINVAL;
976daac4a1c581 David Dai     2020-02-28  163  	}
976daac4a1c581 David Dai     2020-02-28  164  
976daac4a1c581 David Dai     2020-02-28 @165  	bcm->aux_data.unit = le32_to_cpu(data->unit);
976daac4a1c581 David Dai     2020-02-28 @166  	bcm->aux_data.width = le16_to_cpu(data->width);
976daac4a1c581 David Dai     2020-02-28  167  	bcm->aux_data.vcd = data->vcd;
976daac4a1c581 David Dai     2020-02-28  168  	bcm->aux_data.reserved = data->reserved;
976daac4a1c581 David Dai     2020-02-28  169  	INIT_LIST_HEAD(&bcm->list);
976daac4a1c581 David Dai     2020-02-28  170  	INIT_LIST_HEAD(&bcm->ws_list);
976daac4a1c581 David Dai     2020-02-28  171  
cb30e0292db258 Mike Tipton   2020-09-03  172  	if (!bcm->vote_scale)
cb30e0292db258 Mike Tipton   2020-09-03  173  		bcm->vote_scale = 1000;
cb30e0292db258 Mike Tipton   2020-09-03  174  
976daac4a1c581 David Dai     2020-02-28  175  	/* Link Qnodes to their respective BCMs */
976daac4a1c581 David Dai     2020-02-28  176  	for (i = 0; i < bcm->num_nodes; i++) {
976daac4a1c581 David Dai     2020-02-28  177  		qn = bcm->nodes[i];
976daac4a1c581 David Dai     2020-02-28  178  		qn->bcms[qn->num_bcms] = bcm;
976daac4a1c581 David Dai     2020-02-28  179  		qn->num_bcms++;
976daac4a1c581 David Dai     2020-02-28  180  	}
976daac4a1c581 David Dai     2020-02-28  181  
976daac4a1c581 David Dai     2020-02-28  182  	return 0;
976daac4a1c581 David Dai     2020-02-28  183  }
976daac4a1c581 David Dai     2020-02-28  184  EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
976daac4a1c581 David Dai     2020-02-28  185  

:::::: The code at line 165 was first introduced by commit
:::::: 976daac4a1c581e5d5fd64047519fd6fcde39738 interconnect: qcom: Consolidate interconnect RPMh support

:::::: TO: David Dai <daidavid1@codeaurora.org>
:::::: CC: Georgi Djakov <georgi.djakov@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

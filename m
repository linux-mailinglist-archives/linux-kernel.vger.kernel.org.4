Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A063AD22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiK1P7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiK1P7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:59:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77546BC03
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669651167; x=1701187167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tnot19TfMygd82zhfeXZ5X6SzN0zsJTww+d9XaXdrzk=;
  b=lxtysloERc/Z/otezPdHiV4cnP2SOgMsdZf/CemP6q64t1dboSeSb1St
   DrUPlLyFNcWtsLr9RPZJ8u+hZZM+mfhuQ/gDb4C6EzmGaWsAD+lCcwlOh
   Vuq4UFSaDg4182UCxdQCyLIqDU8bxUCnMeXug9sJpw799PSk1LZ/R5C99
   ouOMu+eMRM/tLSfY74W6UK5I1fFxitgCacZaZh5NpK3cYWvDWdjM22yTR
   bcmYajXNmefJh8vNEjaMxXvuSC2KqyKLpkc7cNHARjQ+2oUZzC+O4q5cL
   nM6uaqhhgGRgbJUjIxKhA2r5iP9NGJR94OvAe8BPdA7OgDNE9imNufvsb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316700632"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316700632"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643435739"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643435739"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 07:58:47 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozgWt-000881-02;
        Mon, 28 Nov 2022 15:58:47 +0000
Date:   Mon, 28 Nov 2022 23:57:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13:
 sparse: sparse: restricted __be64 degrades to integer
Message-ID: <202211282320.gpKpokRx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1ol+c1N2cQ9LA2f"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1ol+c1N2cQ9LA2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b7b275e60bcd5f89771e865a8239325f86d9927d
commit: 3753af778dd9d0d5199d6a7d01b0ead33135d095 kbuild: fix single directory build
date:   6 weeks ago
config: loongarch-randconfig-s041-20221128
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3753af778dd9d0d5199d6a7d01b0ead33135d095
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3753af778dd9d0d5199d6a7d01b0ead33135d095
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13: sparse: sparse: restricted __be64 degrades to integer

vim +1183 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c

3b20949cb21bac Lior Nahmanson    2022-09-05  1105  
3b20949cb21bac Lior Nahmanson    2022-09-05  1106  static union mlx5e_macsec_rule *
3b20949cb21bac Lior Nahmanson    2022-09-05  1107  macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
e467b283ffd50c Lior Nahmanson    2022-09-05  1108  		      const struct macsec_context *macsec_ctx,
9515978eee0b93 Lior Nahmanson    2022-09-05  1109  		      struct mlx5_macsec_rule_attrs *attrs,
3b20949cb21bac Lior Nahmanson    2022-09-05  1110  		      u32 fs_id)
e467b283ffd50c Lior Nahmanson    2022-09-05  1111  {
3b20949cb21bac Lior Nahmanson    2022-09-05  1112  	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
3b20949cb21bac Lior Nahmanson    2022-09-05  1113  	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
3b20949cb21bac Lior Nahmanson    2022-09-05  1114  	struct net_device *netdev = macsec_fs->netdev;
2e50e9bf328fb7 Nathan Chancellor 2022-09-11  1115  	union mlx5e_macsec_rule *macsec_rule = NULL;
3b20949cb21bac Lior Nahmanson    2022-09-05  1116  	struct mlx5_modify_hdr *modify_hdr = NULL;
3b20949cb21bac Lior Nahmanson    2022-09-05  1117  	struct mlx5_flow_destination dest = {};
3b20949cb21bac Lior Nahmanson    2022-09-05  1118  	struct mlx5e_macsec_tables *rx_tables;
3b20949cb21bac Lior Nahmanson    2022-09-05  1119  	struct mlx5e_macsec_rx_rule *rx_rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1120  	struct mlx5_flow_act flow_act = {};
3b20949cb21bac Lior Nahmanson    2022-09-05  1121  	struct mlx5e_flow_table *ft_crypto;
3b20949cb21bac Lior Nahmanson    2022-09-05  1122  	struct mlx5_flow_handle *rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1123  	struct mlx5_flow_spec *spec;
3b20949cb21bac Lior Nahmanson    2022-09-05  1124  	int err = 0;
e467b283ffd50c Lior Nahmanson    2022-09-05  1125  
3b20949cb21bac Lior Nahmanson    2022-09-05  1126  	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
3b20949cb21bac Lior Nahmanson    2022-09-05  1127  	if (!spec)
e467b283ffd50c Lior Nahmanson    2022-09-05  1128  		return NULL;
3b20949cb21bac Lior Nahmanson    2022-09-05  1129  
3b20949cb21bac Lior Nahmanson    2022-09-05  1130  	err = macsec_fs_rx_ft_get(macsec_fs);
3b20949cb21bac Lior Nahmanson    2022-09-05  1131  	if (err)
3b20949cb21bac Lior Nahmanson    2022-09-05  1132  		goto out_spec;
3b20949cb21bac Lior Nahmanson    2022-09-05  1133  
3b20949cb21bac Lior Nahmanson    2022-09-05  1134  	macsec_rule = kzalloc(sizeof(*macsec_rule), GFP_KERNEL);
3b20949cb21bac Lior Nahmanson    2022-09-05  1135  	if (!macsec_rule) {
3b20949cb21bac Lior Nahmanson    2022-09-05  1136  		macsec_fs_rx_ft_put(macsec_fs);
3b20949cb21bac Lior Nahmanson    2022-09-05  1137  		goto out_spec;
3b20949cb21bac Lior Nahmanson    2022-09-05  1138  	}
3b20949cb21bac Lior Nahmanson    2022-09-05  1139  
3b20949cb21bac Lior Nahmanson    2022-09-05  1140  	rx_rule = &macsec_rule->rx_rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1141  	rx_tables = &rx_fs->tables;
3b20949cb21bac Lior Nahmanson    2022-09-05  1142  	ft_crypto = &rx_tables->ft_crypto;
3b20949cb21bac Lior Nahmanson    2022-09-05  1143  
3b20949cb21bac Lior Nahmanson    2022-09-05  1144  	/* Set bit[31 - 30] macsec marker - 0x01 */
3b20949cb21bac Lior Nahmanson    2022-09-05  1145  	/* Set bit[3-0] fs id */
3b20949cb21bac Lior Nahmanson    2022-09-05  1146  	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
3b20949cb21bac Lior Nahmanson    2022-09-05  1147  	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
3b20949cb21bac Lior Nahmanson    2022-09-05  1148  	MLX5_SET(set_action_in, action, data, fs_id | BIT(30));
3b20949cb21bac Lior Nahmanson    2022-09-05  1149  	MLX5_SET(set_action_in, action, offset, 0);
3b20949cb21bac Lior Nahmanson    2022-09-05  1150  	MLX5_SET(set_action_in, action, length, 32);
3b20949cb21bac Lior Nahmanson    2022-09-05  1151  
3b20949cb21bac Lior Nahmanson    2022-09-05  1152  	modify_hdr = mlx5_modify_header_alloc(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC,
3b20949cb21bac Lior Nahmanson    2022-09-05  1153  					      1, action);
3b20949cb21bac Lior Nahmanson    2022-09-05  1154  	if (IS_ERR(modify_hdr)) {
3b20949cb21bac Lior Nahmanson    2022-09-05  1155  		err = PTR_ERR(modify_hdr);
3b20949cb21bac Lior Nahmanson    2022-09-05  1156  		netdev_err(netdev, "fail to alloc MACsec set modify_header_id err=%d\n", err);
3b20949cb21bac Lior Nahmanson    2022-09-05  1157  		modify_hdr = NULL;
3b20949cb21bac Lior Nahmanson    2022-09-05  1158  		goto err;
3b20949cb21bac Lior Nahmanson    2022-09-05  1159  	}
3b20949cb21bac Lior Nahmanson    2022-09-05  1160  	rx_rule->meta_modhdr = modify_hdr;
3b20949cb21bac Lior Nahmanson    2022-09-05  1161  
3b20949cb21bac Lior Nahmanson    2022-09-05  1162  	/* Rx crypto table with SCI rule */
3b20949cb21bac Lior Nahmanson    2022-09-05  1163  	macsec_fs_rx_setup_fte(spec, &flow_act, attrs, true);
3b20949cb21bac Lior Nahmanson    2022-09-05  1164  
3b20949cb21bac Lior Nahmanson    2022-09-05  1165  	flow_act.modify_hdr = modify_hdr;
3b20949cb21bac Lior Nahmanson    2022-09-05  1166  	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
3b20949cb21bac Lior Nahmanson    2022-09-05  1167  			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
3b20949cb21bac Lior Nahmanson    2022-09-05  1168  			  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
3b20949cb21bac Lior Nahmanson    2022-09-05  1169  
3b20949cb21bac Lior Nahmanson    2022-09-05  1170  	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
3b20949cb21bac Lior Nahmanson    2022-09-05  1171  	dest.ft = rx_tables->ft_check;
3b20949cb21bac Lior Nahmanson    2022-09-05  1172  	rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
3b20949cb21bac Lior Nahmanson    2022-09-05  1173  	if (IS_ERR(rule)) {
3b20949cb21bac Lior Nahmanson    2022-09-05  1174  		err = PTR_ERR(rule);
3b20949cb21bac Lior Nahmanson    2022-09-05  1175  		netdev_err(netdev,
3b20949cb21bac Lior Nahmanson    2022-09-05  1176  			   "Failed to add SA with SCI rule to Rx crypto rule, err=%d\n",
3b20949cb21bac Lior Nahmanson    2022-09-05  1177  			   err);
3b20949cb21bac Lior Nahmanson    2022-09-05  1178  		goto err;
3b20949cb21bac Lior Nahmanson    2022-09-05  1179  	}
3b20949cb21bac Lior Nahmanson    2022-09-05  1180  	rx_rule->rule[0] = rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1181  
3b20949cb21bac Lior Nahmanson    2022-09-05  1182  	/* Rx crypto table without SCI rule */
3b20949cb21bac Lior Nahmanson    2022-09-05 @1183  	if (cpu_to_be64((__force u64)attrs->sci) & ntohs(MACSEC_PORT_ES)) {
3b20949cb21bac Lior Nahmanson    2022-09-05  1184  		memset(spec, 0, sizeof(struct mlx5_flow_spec));
3b20949cb21bac Lior Nahmanson    2022-09-05  1185  		memset(&dest, 0, sizeof(struct mlx5_flow_destination));
3b20949cb21bac Lior Nahmanson    2022-09-05  1186  		memset(&flow_act, 0, sizeof(flow_act));
3b20949cb21bac Lior Nahmanson    2022-09-05  1187  
3b20949cb21bac Lior Nahmanson    2022-09-05  1188  		macsec_fs_rx_setup_fte(spec, &flow_act, attrs, false);
3b20949cb21bac Lior Nahmanson    2022-09-05  1189  
3b20949cb21bac Lior Nahmanson    2022-09-05  1190  		flow_act.modify_hdr = modify_hdr;
3b20949cb21bac Lior Nahmanson    2022-09-05  1191  		flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
3b20949cb21bac Lior Nahmanson    2022-09-05  1192  				  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
3b20949cb21bac Lior Nahmanson    2022-09-05  1193  				  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
3b20949cb21bac Lior Nahmanson    2022-09-05  1194  
3b20949cb21bac Lior Nahmanson    2022-09-05  1195  		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
3b20949cb21bac Lior Nahmanson    2022-09-05  1196  		dest.ft = rx_tables->ft_check;
3b20949cb21bac Lior Nahmanson    2022-09-05  1197  		rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
3b20949cb21bac Lior Nahmanson    2022-09-05  1198  		if (IS_ERR(rule)) {
3b20949cb21bac Lior Nahmanson    2022-09-05  1199  			err = PTR_ERR(rule);
3b20949cb21bac Lior Nahmanson    2022-09-05  1200  			netdev_err(netdev,
3b20949cb21bac Lior Nahmanson    2022-09-05  1201  				   "Failed to add SA without SCI rule to Rx crypto rule, err=%d\n",
3b20949cb21bac Lior Nahmanson    2022-09-05  1202  				   err);
3b20949cb21bac Lior Nahmanson    2022-09-05  1203  			goto err;
3b20949cb21bac Lior Nahmanson    2022-09-05  1204  		}
3b20949cb21bac Lior Nahmanson    2022-09-05  1205  		rx_rule->rule[1] = rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1206  	}
3b20949cb21bac Lior Nahmanson    2022-09-05  1207  
3b20949cb21bac Lior Nahmanson    2022-09-05  1208  	return macsec_rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1209  
3b20949cb21bac Lior Nahmanson    2022-09-05  1210  err:
3b20949cb21bac Lior Nahmanson    2022-09-05  1211  	macsec_fs_rx_del_rule(macsec_fs, rx_rule);
3b20949cb21bac Lior Nahmanson    2022-09-05  1212  	macsec_rule = NULL;
3b20949cb21bac Lior Nahmanson    2022-09-05  1213  out_spec:
3b20949cb21bac Lior Nahmanson    2022-09-05  1214  	kvfree(spec);
3b20949cb21bac Lior Nahmanson    2022-09-05  1215  	return macsec_rule;
3b20949cb21bac Lior Nahmanson    2022-09-05  1216  }
3b20949cb21bac Lior Nahmanson    2022-09-05  1217  

:::::: The code at line 1183 was first introduced by commit
:::::: 3b20949cb21bac26d50cdcc58896802a890cfe15 net/mlx5e: Add MACsec RX steering rules

:::::: TO: Lior Nahmanson <liorna@nvidia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--X1ol+c1N2cQ9LA2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 6.0.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=m
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
# CONFIG_NUMA_BALANCING is not set
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
# CONFIG_BUG is not set
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_LOONGARCH=y
CONFIG_64BIT=y
CONFIG_CPU_HAS_FPU=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_L1_CACHE_SHIFT=6
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MACH_LOONGSON64=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PGTABLE_3LEVEL=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_SCHED_OMIT_FRAME_POINTER=y

#
# Kernel type and options
#
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_4KB_3LEVEL is not set
# CONFIG_4KB_4LEVEL is not set
# CONFIG_16KB_2LEVEL is not set
CONFIG_16KB_3LEVEL=y
# CONFIG_64KB_2LEVEL is not set
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
CONFIG_CMDLINE_BOOTLOADER=y
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
CONFIG_DMI=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SMP=y
# CONFIG_HOTPLUG_CPU is not set
CONFIG_NR_CPUS=64
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_FORCE_MAX_ZONEORDER=12
# CONFIG_SECCOMP is not set
# end of Kernel type and options

CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=12
CONFIG_ARCH_MMAP_RND_BITS_MAX=18

#
# Power management options
#
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_GENERIC_GSI=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=m
# CONFIG_ACPI_TINY_POWER_BUTTON is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_MCFG=y
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HED=m
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_ACPI_WATCHDOG=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_PCC is not set
# CONFIG_PMIC_OPREGION is not set
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=m
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_MSG=y
# CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE is not set
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y
CONFIG_ARM_SCMI_POWER_DOMAIN=m
CONFIG_ARM_SCMI_POWER_CONTROL=m
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT=y
CONFIG_MTK_ADSP_IPC=m
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
# CONFIG_TEE_BNXT_FW is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
# CONFIG_EFI_CAPSULE_LOADER is not set
CONFIG_EFI_TEST=y
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_TIF_NOHZ=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=12
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS_NONE is not set
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_DECOMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_ARCH_BINFMT_ELF_STATE=y
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="842"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA32=y
CONFIG_HMM_MIRROR=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
# CONFIG_UNIX is not set
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=y
# CONFIG_TCP_CONG_HYBLA is not set
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=m
# CONFIG_TCP_CONG_VENO is not set
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=y
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_BBR is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
CONFIG_IP_DCCP_CCID3=y
CONFIG_IP_DCCP_CCID3_DEBUG=y
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_IP_DCCP_TFRC_DEBUG=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_INET_SCTP_DIAG=m
CONFIG_RDS=y
CONFIG_RDS_RDMA=m
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_CRYPTO=y
# CONFIG_TIPC_DIAG is not set
# CONFIG_ATM is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=m
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
# CONFIG_BRIDGE_MRP is not set
CONFIG_BRIDGE_CFM=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
# CONFIG_IPDDP is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
# CONFIG_6LOWPAN_NHC_HOP is not set
# CONFIG_6LOWPAN_NHC_IPV6 is not set
# CONFIG_6LOWPAN_NHC_MOBILITY is not set
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
# CONFIG_6LOWPAN_GHC_UDP is not set
CONFIG_6LOWPAN_GHC_ICMPV6=m
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=m
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=y
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_NSH=m
CONFIG_HSR=m
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
# CONFIG_QRTR_SMD is not set
CONFIG_QRTR_TUN=m
# CONFIG_QRTR_MHI is not set
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_DROP_MONITOR=m
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=m
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
# CONFIG_BT_RFCOMM_TTY is not set
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_CMTP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
CONFIG_BT_SELFTEST=y
CONFIG_BT_SELFTEST_ECDH=y
CONFIG_BT_SELFTEST_SMP=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_MTK=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
CONFIG_BT_HCIBPA10X=m
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
CONFIG_BT_MTKUART=m
# CONFIG_BT_QCOMSMD is not set
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
# CONFIG_CAIF_USB is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_SIM is not set
CONFIG_NFC_PORT100=m
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN533=m
# CONFIG_NFC_PN533_USB is not set
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_I2C=m
# CONFIG_NFC_ST_NCI_I2C is not set
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_NFC_S3FWRN82_UART=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_PCIE_BUS_TUNE_OFF=y
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCIE_XILINX_NWL is not set
CONFIG_PCI_TEGRA=y
# CONFIG_PCIE_RCAR_HOST is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_XILINX_CPM=y
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_VERSATILE is not set
CONFIG_PCIE_ALTERA=m
CONFIG_PCIE_ALTERA_MSI=m
# CONFIG_PCI_HOST_THUNDER_PEM is not set
CONFIG_PCI_HOST_THUNDER_ECAM=y
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
CONFIG_PCI_LOONGSON=y
# CONFIG_PCIE_MT7621 is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCI_EXYNOS=m
# CONFIG_PCI_IMX6 is not set
CONFIG_PCIE_SPEAR13XX=y
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
# CONFIG_PCIE_ARMADA_8K is not set
CONFIG_PCIE_ARTPEC6=y
CONFIG_PCIE_ARTPEC6_HOST=y
CONFIG_PCIE_KEEMBAY=y
CONFIG_PCIE_KEEMBAY_HOST=y
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCI_MESON=y
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
# CONFIG_YENTA_TOSHIBA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
CONFIG_MHI_BUS_PCI_GENERIC=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

#
# EFI (Extensible Firmware Interface) Support
#
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
# CONFIG_GNSS_UBX_SERIAL is not set
# CONFIG_GNSS_USB is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_BCM63XX_PARTS is not set
CONFIG_MTD_BRCM_U_BOOT=m
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_PARSER_IMAGETAG=y
# CONFIG_MTD_PARSER_TRX is not set
CONFIG_MTD_SHARPSL_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_QCOMSMEM_PARTS=m
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
CONFIG_MTD_TS5500=y
CONFIG_MTD_PCI=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SPEAR_SMI=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_SAMSUNG=y
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
CONFIG_MTD_NAND_AMS_DELTA=m
CONFIG_MTD_NAND_SHARPSL=m
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_ATMEL=y
# CONFIG_MTD_NAND_MARVELL is not set
# CONFIG_MTD_NAND_SLC_LPC32XX is not set
CONFIG_MTD_NAND_MLC_LPC32XX=y
CONFIG_MTD_NAND_BRCMNAND=m
CONFIG_MTD_NAND_BRCMNAND_BCM63XX=m
# CONFIG_MTD_NAND_BRCMNAND_BCMA is not set
CONFIG_MTD_NAND_BRCMNAND_BCMBCA=m
CONFIG_MTD_NAND_BRCMNAND_BRCMSTB=m
# CONFIG_MTD_NAND_BRCMNAND_IPROC is not set
CONFIG_MTD_NAND_BCM47XXNFLASH=m
# CONFIG_MTD_NAND_OXNAS is not set
CONFIG_MTD_NAND_FSL_IFC=y
# CONFIG_MTD_NAND_VF610_NFC is not set
# CONFIG_MTD_NAND_SH_FLCTL is not set
CONFIG_MTD_NAND_DAVINCI=y
# CONFIG_MTD_NAND_TXX9NDFMC is not set
CONFIG_MTD_NAND_SUNXI=y
CONFIG_MTD_NAND_HISI504=y
# CONFIG_MTD_NAND_QCOM is not set
CONFIG_MTD_NAND_MTK=m
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_TEGRA=y
CONFIG_MTD_NAND_STM32_FMC2=m
CONFIG_MTD_NAND_MESON=m
# CONFIG_MTD_NAND_GPIO is not set
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
CONFIG_MTD_NAND_INTEL_LGM=m
CONFIG_MTD_NAND_RENESAS=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
CONFIG_MTD_NAND_ECC_MXIC=y
CONFIG_MTD_NAND_ECC_MEDIATEK=m
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=m
CONFIG_HBMC_AM654=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
CONFIG_ZRAM=y
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP_LZ4HC=y
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lz4hc"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=m
# CONFIG_BLK_DEV_RNBD_SERVER is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_RDMA=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_PHANTOM=m
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ATMEL_SSC=y
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
CONFIG_QCOM_COINCELL=m
CONFIG_QCOM_FASTRPC=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=m
CONFIG_PCH_PHUB=y
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
CONFIG_PCI_ENDPOINT_TEST=m
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

# CONFIG_ALTERA_STAPL is not set
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
CONFIG_BCM_VK=y
CONFIG_BCM_VK_TTY=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=m
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
CONFIG_PVPANIC_PCI=m
CONFIG_GP_PCI1XXXX=m
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_BE2ISCSI=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_MVSAS=y
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=y
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=m
# CONFIG_LIBFC is not set
CONFIG_SCSI_SNIC=y
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_QEDI=m
CONFIG_SCSI_EFCT=m
CONFIG_SCSI_DC395x=y
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PMCRAID=m
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACVTAP=m
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=m
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
CONFIG_TUN=m
CONFIG_TAP=m
CONFIG_TUN_VNET_CROSS_LE=y
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=y
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
# CONFIG_CAIF_DRIVERS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ACTIONS=y
CONFIG_OWL_EMAC=m
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=y
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
CONFIG_NET_XGENE=m
# CONFIG_NET_XGENE_V2 is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
# CONFIG_NET_VENDOR_ASIX is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCM4908_ENET is not set
CONFIG_BCMGENET=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
# CONFIG_TIGON3_HWMON is not set
CONFIG_BNX2X=y
# CONFIG_BNX2X_SRIOV is not set
CONFIG_BGMAC=y
CONFIG_BGMAC_PLATFORM=y
CONFIG_SYSTEMPORT=y
CONFIG_BNXT=y
# CONFIG_BNXT_SRIOV is not set
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_BNXT_HWMON is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
# CONFIG_MACB_USE_HWSTAMP is not set
# CONFIG_MACB_PCI is not set
CONFIG_NET_CALXEDA_XGMAC=y
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=m
# CONFIG_THUNDER_NIC_VF is not set
CONFIG_THUNDER_NIC_BGX=m
CONFIG_THUNDER_NIC_RGX=m
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
# CONFIG_CRYPTO_DEV_CHELSIO_TLS is not set
CONFIG_CHELSIO_IPSEC_INLINE=m
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_DAVICOM is not set
CONFIG_DNET=y
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
CONFIG_BE2NET_HWMON=y
# CONFIG_BE2NET_BE2 is not set
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
# CONFIG_NET_VENDOR_ENGLEDER is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_FREESCALE is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HISILICON=y
CONFIG_HIX5HD2_GMAC=y
CONFIG_HISI_FEMAC=y
CONFIG_HIP04_ETH=m
CONFIG_HI13X1_GMAC=y
CONFIG_HNS_MDIO=m
CONFIG_HNS=m
CONFIG_HNS_DSAF=m
CONFIG_HNS_ENET=m
CONFIG_HNS3=m
# CONFIG_HNS3_HCLGE is not set
# CONFIG_HNS3_ENET is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=m
CONFIG_E1000E=m
CONFIG_IGB=y
# CONFIG_IGB_HWMON is not set
# CONFIG_IGBVF is not set
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=y
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=y
# CONFIG_I40EVF is not set
CONFIG_ICE=y
CONFIG_FM10K=m
# CONFIG_IGC is not set
# CONFIG_NET_VENDOR_WANGXUN is not set
# CONFIG_JME is not set
CONFIG_KORINA=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MEDIATEK=y
CONFIG_NET_MEDIATEK_SOC_WED=y
CONFIG_NET_MEDIATEK_SOC=m
# CONFIG_NET_MEDIATEK_STAR_EMAC is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_CORE=y
# CONFIG_MLX4_DEBUG is not set
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
# CONFIG_MLX5_EN_RXNFC is not set
# CONFIG_MLX5_MPFS is not set
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLX5_EN_MACSEC=y
CONFIG_MLX5_EN_IPSEC=y
# CONFIG_MLX5_SF is not set
CONFIG_MLXSW_CORE=y
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=y
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=y
# CONFIG_MLXBF_GIGE is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_DEBUG=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_LPC_ENET=m
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=y
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
# CONFIG_QLCNIC is not set
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
# CONFIG_QED_SRIOV is not set
# CONFIG_QEDE is not set
CONFIG_QED_ISCSI=y
CONFIG_QED_OOO=y
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
# CONFIG_SFC_MCDI_MON is not set
# CONFIG_SFC_SRIOV is not set
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_SFC_SIENA=y
# CONFIG_SFC_SIENA_MTD is not set
# CONFIG_SFC_SIENA_MCDI_MON is not set
# CONFIG_SFC_SIENA_SRIOV is not set
# CONFIG_SFC_SIENA_MCDI_LOGGING is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
CONFIG_STMMAC_SELFTESTS=y
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
CONFIG_DWMAC_LOONGSON=m
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=y
# CONFIG_SUNGEM is not set
CONFIG_CASSINI=m
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SUNPLUS=y
CONFIG_SP7021_EMAC=y
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=y
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_DAVINCI_EMAC=m
CONFIG_TI_DAVINCI_MDIO=m
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_CPSW is not set
# CONFIG_TI_CPTS is not set
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_VIA_VELOCITY is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_QCOM_IPA=m
CONFIG_NET_SB1000=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_SFP=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
CONFIG_ADIN1100_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=y
CONFIG_BCM63XX_PHY=m
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
# CONFIG_LXT_PHY is not set
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=y
CONFIG_MICROSEMI_PHY=m
CONFIG_MOTORCOMM_PHY=y
CONFIG_NATIONAL_PHY=m
CONFIG_NXP_C45_TJA11XX_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
CONFIG_RENESAS_PHY=m
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=m
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
CONFIG_DP83TD510_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PSE_CONTROLLER=y
CONFIG_PSE_REGULATOR=y
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
CONFIG_CAN_AT91=m
CONFIG_CAN_CAN327=m
CONFIG_CAN_FLEXCAN=m
CONFIG_CAN_KVASER_PCIEFD=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_SUN4I=m
# CONFIG_CAN_XILINXCAN is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_CTUCANFD=m
CONFIG_CAN_CTUCANFD_PCI=m
CONFIG_CAN_CTUCANFD_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
# CONFIG_CAN_M_CAN is not set
CONFIG_CAN_PEAK_PCIEFD=m
# CONFIG_CAN_RCAR is not set
CONFIG_CAN_RCAR_CANFD=m
# CONFIG_CAN_SJA1000 is not set
CONFIG_CAN_SOFTING=m

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB=m
CONFIG_CAN_ETAS_ES58X=m
CONFIG_CAN_GS_USB=m
# CONFIG_CAN_KVASER_USB is not set
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
CONFIG_CAN_UCAN=m
# end of CAN USB interfaces

CONFIG_CAN_DEBUG_DEVICES=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_SUN4I=y
CONFIG_MDIO_XGENE=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_I2C=y
CONFIG_MDIO_MVUSB=y
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_MOXART=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_THUNDER=y

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
CONFIG_PCS_ALTERA_TSE=m
# end of PCS device drivers

CONFIG_PLIP=m
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
# CONFIG_USB_KAWETH is not set
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
# CONFIG_USB_NET_AX8817X is not set
# CONFIG_USB_NET_AX88179_178A is not set
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
# CONFIG_USB_NET_DM9601 is not set
CONFIG_USB_NET_SR9700=m
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=m
# CONFIG_USB_NET_SMSC95XX is not set
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
# CONFIG_USB_ARMLINUX is not set
CONFIG_USB_EPSON2888=y
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=m
# CONFIG_USB_NET_CX82310_ETH is not set
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_CDC_PHONET=m
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
CONFIG_USB_NET_AQC111=m
CONFIG_USB_RTL8153_ECM=m
# CONFIG_WLAN is not set
# CONFIG_WAN is not set
# CONFIG_IEEE802154_DRIVERS is not set

#
# Wireless WAN
#
CONFIG_WWAN=m
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=m
# CONFIG_MHI_WWAN_CTRL is not set
CONFIG_MHI_WWAN_MBIM=m
CONFIG_QCOM_BAM_DMUX=m
# CONFIG_RPMSG_WWAN_CTRL is not set
CONFIG_MTK_T7XX=m
# end of Wireless WAN

CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=y
CONFIG_USB4_NET=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
# CONFIG_MISDN is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_BCM2835AUX=m
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_EM=m
CONFIG_SERIAL_8250_IOC3=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_OMAP=m
CONFIG_SERIAL_8250_MT6577=y
CONFIG_SERIAL_8250_UNIPHIER=m
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_8250_PXA=m
CONFIG_SERIAL_8250_TEGRA=m
CONFIG_SERIAL_8250_BCM7271=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=m
CONFIG_SERIAL_ATMEL=y
# CONFIG_SERIAL_ATMEL_CONSOLE is not set
# CONFIG_SERIAL_ATMEL_PDC is not set
# CONFIG_SERIAL_ATMEL_TTYAT is not set
CONFIG_SERIAL_MESON=y
# CONFIG_SERIAL_MESON_CONSOLE is not set
CONFIG_SERIAL_CLPS711X=m
# CONFIG_SERIAL_SAMSUNG is not set
# CONFIG_SERIAL_TEGRA is not set
# CONFIG_SERIAL_TEGRA_TCU is not set
# CONFIG_SERIAL_IMX is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=m
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
CONFIG_SERIAL_JSM=m
CONFIG_SERIAL_MSM=y
CONFIG_SERIAL_MSM_CONSOLE=y
CONFIG_SERIAL_VT8500=y
# CONFIG_SERIAL_VT8500_CONSOLE is not set
CONFIG_SERIAL_OMAP=y
CONFIG_SERIAL_OMAP_CONSOLE=y
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
# CONFIG_SERIAL_MPS2_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
CONFIG_SERIAL_ST_ASC=y
# CONFIG_SERIAL_ST_ASC_CONSOLE is not set
# CONFIG_SERIAL_SPRD is not set
CONFIG_SERIAL_STM32=y
# CONFIG_SERIAL_STM32_CONSOLE is not set
CONFIG_SERIAL_MVEBU_UART=y
# CONFIG_SERIAL_MVEBU_CONSOLE is not set
# CONFIG_SERIAL_OWL is not set
CONFIG_SERIAL_RDA=y
CONFIG_SERIAL_RDA_CONSOLE=y
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# CONFIG_SERIAL_SUNPLUS is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=m
CONFIG_RPMSG_TTY=y
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_IPMI_KCS_BMC=m
CONFIG_ASPEED_KCS_IPMI_BMC=m
CONFIG_NPCM7XX_KCS_IPMI_BMC=m
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=m
# CONFIG_IPMI_KCS_BMC_SERIO is not set
CONFIG_ASPEED_BT_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_BCM2835 is not set
CONFIG_HW_RANDOM_IPROC_RNG200=m
# CONFIG_HW_RANDOM_IXP4XX is not set
# CONFIG_HW_RANDOM_OMAP is not set
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_IMX_RNGC=m
CONFIG_HW_RANDOM_NOMADIK=m
CONFIG_HW_RANDOM_STM32=m
CONFIG_HW_RANDOM_MESON=m
# CONFIG_HW_RANDOM_MTK is not set
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_HW_RANDOM_CN10K=m
CONFIG_APPLICOM=m
# CONFIG_DEVMEM is not set
CONFIG_DEVPORT=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS_I2C=y
CONFIG_TCG_TIS_SYNQUACER=y
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=y
# CONFIG_I2C_HIX5HD2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ASPEED is not set
CONFIG_I2C_AT91=m
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=m
CONFIG_I2C_AXXIA=m
CONFIG_I2C_BCM2835=m
CONFIG_I2C_BCM_IPROC=y
CONFIG_I2C_BCM_KONA=m
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=m
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DIGICOLOR=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=m
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=m
CONFIG_I2C_IMX=y
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_IOP3XX is not set
CONFIG_I2C_JZ4780=y
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=y
# CONFIG_I2C_MXS is not set
CONFIG_I2C_NPCM=m
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_SLAVE=y
CONFIG_I2C_QCOM_CCI=m
CONFIG_I2C_QUP=y
# CONFIG_I2C_RIIC is not set
CONFIG_I2C_RZV2M=m
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_SPRD is not set
# CONFIG_I2C_ST is not set
# CONFIG_I2C_STM32F4 is not set
# CONFIG_I2C_STM32F7 is not set
CONFIG_I2C_SUN6I_P2WI=m
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA_BPMP=y
CONFIG_I2C_UNIPHIER=m
# CONFIG_I2C_UNIPHIER_F is not set
CONFIG_I2C_VERSATILE=m
CONFIG_I2C_WMT=m
CONFIG_I2C_THUNDERX=y
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_CP2615=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PCI1XXXX=y
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
# CONFIG_SPMI_MTK_PMIF is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_PTP_1588_CLOCK_DTE is not set
CONFIG_PTP_1588_CLOCK_QORIQ=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_IDT82P33=y
CONFIG_PTP_1588_CLOCK_IDTCM=m
CONFIG_PTP_1588_CLOCK_OCP=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=m
# CONFIG_PINCTRL_PXA27X is not set
CONFIG_PINCTRL_MSM=m
CONFIG_PINCTRL_QDF2XXX=m
# CONFIG_PINCTRL_SC8180X is not set
CONFIG_PINCTRL_SDM845=m
CONFIG_PINCTRL_SM8350=m
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
CONFIG_PINCTRL_PFC_R8A77950=y
CONFIG_PINCTRL_PFC_R8A77951=y
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
CONFIG_PINCTRL_PFC_R8A7791=y
# CONFIG_PINCTRL_PFC_R8A77965 is not set
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A779F0=y
CONFIG_PINCTRL_PFC_R8A7792=y
# CONFIG_PINCTRL_PFC_R8A77980 is not set
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
CONFIG_PINCTRL_PFC_R8A7742=y
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
CONFIG_PINCTRL_PFC_R8A774E1=y
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
CONFIG_PINCTRL_PFC_SH7203=y
# CONFIG_PINCTRL_PFC_SH7264 is not set
CONFIG_PINCTRL_PFC_SH7269=y
CONFIG_PINCTRL_PFC_SH7720=y
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
CONFIG_PINCTRL_PFC_SH73A0=y
# CONFIG_PINCTRL_PFC_SH7723 is not set
CONFIG_PINCTRL_PFC_SH7724=y
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_ATH79=m
# CONFIG_GPIO_CLPS711X is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_HISI=m
CONFIG_GPIO_IOP=y
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
CONFIG_GPIO_ROCKCHIP=y
CONFIG_GPIO_THUNDERX=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XGENE_SB=m
CONFIG_GPIO_XLP=y
CONFIG_GPIO_AMD_FCH=m
CONFIG_GPIO_IDT3243X=m
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MAX77650=y
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL6040=m
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_MLXBF=y
CONFIG_GPIO_MLXBF2=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=m
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_MXC=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_IP5XXX_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=m
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=m
# CONFIG_CHARGER_MT6360 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_SC2731=y
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_ACER_A500 is not set
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_ARM_SCMI is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_SPARX5=m
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX31760=y
CONFIG_SENSORS_MAX6620=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=m
CONFIG_SENSORS_OCC=m
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
CONFIG_SENSORS_SL28CPLD=y
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC2305=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM8350 is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_K3_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=m
CONFIG_MTK_THERMAL=m

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
CONFIG_BRCMSTB_THERMAL=m
# CONFIG_BCM_NS_THERMAL is not set
CONFIG_BCM_SR_THERMAL=y
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
CONFIG_TI_SOC_THERMAL=m
# CONFIG_TI_THERMAL is not set
# CONFIG_OMAP3_THERMAL is not set
# CONFIG_OMAP4_THERMAL is not set
CONFIG_OMAP5_THERMAL=y
# CONFIG_DRA752_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
# CONFIG_TEGRA_BPMP_THERMAL is not set
CONFIG_TEGRA30_TSENSOR=m
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
CONFIG_QCOM_TSENS=y
# end of Qualcomm thermal drivers

CONFIG_SPRD_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WDAT_WDT=y
CONFIG_WM8350_WATCHDOG=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_SL28CPLD_WATCHDOG=y
CONFIG_ARMADA_37XX_WATCHDOG=y
CONFIG_AT91RM9200_WATCHDOG=y
CONFIG_AT91SAM9X_WATCHDOG=y
CONFIG_SAMA5D4_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_FTWDT010_WATCHDOG is not set
CONFIG_S3C2410_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_EP93XX_WATCHDOG=m
CONFIG_OMAP_WATCHDOG=y
# CONFIG_PNX4008_WATCHDOG is not set
CONFIG_DAVINCI_WATCHDOG=y
CONFIG_K3_RTI_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=m
CONFIG_NPCM7XX_WATCHDOG=m
CONFIG_STMP3XXX_RTC_WATCHDOG=m
CONFIG_TS72XX_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=m
CONFIG_IMX2_WDT=m
CONFIG_IMX7ULP_WDT=y
CONFIG_RETU_WATCHDOG=m
CONFIG_MOXART_WDT=m
# CONFIG_TEGRA_WATCHDOG is not set
CONFIG_QCOM_WDT=y
# CONFIG_MESON_GXBB_WATCHDOG is not set
CONFIG_MESON_WATCHDOG=y
# CONFIG_MEDIATEK_WATCHDOG is not set
CONFIG_DIGICOLOR_WATCHDOG=m
CONFIG_LPC18XX_WATCHDOG=y
CONFIG_RENESAS_WDT=m
# CONFIG_RENESAS_RZAWDT is not set
CONFIG_RENESAS_RZN1WDT=y
# CONFIG_RENESAS_RZG2LWDT is not set
# CONFIG_ASPEED_WATCHDOG is not set
# CONFIG_REALTEK_OTTO_WDT is not set
CONFIG_SPRD_WATCHDOG=y
CONFIG_VISCONTI_WATCHDOG=y
CONFIG_MSC313E_WATCHDOG=m
# CONFIG_APPLE_WATCHDOG is not set
CONFIG_SUNPLUS_WATCHDOG=y
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_I6300ESB_WDT=m
# CONFIG_RDC321X_WDT is not set
CONFIG_BCM47XX_WDT=y
CONFIG_BCM_KONA_WDT=y
CONFIG_BCM_KONA_WDT_DEBUG=y
CONFIG_BCM7038_WDT=m
CONFIG_IMGPDC_WDT=y
CONFIG_MPC5200_WDT=y
CONFIG_MEN_A21_WDT=m
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_HOST_SOC is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_SUN4I_GPADC is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_ATMEL_SMC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_ENE_KB3930=m
# CONFIG_MFD_EXYNOS_LPASS is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=m
CONFIG_MFD_MX25_TSADC=m
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6370=m
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_SY7636A=y
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=y
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=m
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_STM32_LPTIMER=m
# CONFIG_MFD_STM32_TIMERS is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_KHADAS_MCU is not set
CONFIG_MFD_ACER_A500_EC=y
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=m
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=m
# CONFIG_REGULATOR_MT6360 is not set
# CONFIG_REGULATOR_MT6370 is not set
# CONFIG_REGULATOR_PBIAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_RPMH=m
CONFIG_REGULATOR_QCOM_SMD_RPM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RT4801=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5120=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=m
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SC2731 is not set
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STM32_BOOSTER=y
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS68470=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
CONFIG_CEC_PIN_ERROR_INJ=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_MESON_AO=m
CONFIG_CEC_GPIO=m
# CONFIG_CEC_SAMSUNG_S5P is not set
CONFIG_CEC_STI=m
CONFIG_CEC_STM32=m
# CONFIG_CEC_TEGRA is not set
CONFIG_CEC_SECO=m
CONFIG_USB_PULSE8_CEC=y
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_IMX_IPUV3_CORE is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=m
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_KMB_DISPLAY is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_ROCKCHIP=m
CONFIG_ROCKCHIP_VOP=y
# CONFIG_ROCKCHIP_VOP2 is not set
# CONFIG_ROCKCHIP_ANALOGIX_DP is not set
CONFIG_ROCKCHIP_CDN_DP=y
CONFIG_ROCKCHIP_DW_HDMI=y
# CONFIG_ROCKCHIP_DW_MIPI_DSI is not set
# CONFIG_ROCKCHIP_INNO_HDMI is not set
# CONFIG_ROCKCHIP_RGB is not set
# CONFIG_ROCKCHIP_RK3066_HDMI is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_SUN4I=m
CONFIG_DRM_SUN4I_HDMI=m
# CONFIG_DRM_SUN4I_HDMI_CEC is not set
# CONFIG_DRM_SUN4I_BACKEND is not set
CONFIG_DRM_SUN6I_DSI=m
CONFIG_DRM_SUN8I_DW_HDMI=m
# CONFIG_DRM_SUN8I_MIXER is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_MSM=m
CONFIG_DRM_MSM_GPU_STATE=y
# CONFIG_DRM_MSM_GPU_SUDO is not set
CONFIG_DRM_MSM_MDSS=y
CONFIG_DRM_MSM_MDP4=y
CONFIG_DRM_MSM_MDP5=y
# CONFIG_DRM_MSM_DPU is not set
CONFIG_DRM_MSM_DP=y
# CONFIG_DRM_MSM_DSI is not set
CONFIG_DRM_MSM_HDMI=y
CONFIG_DRM_MSM_HDMI_HDCP=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

# CONFIG_DRM_V3D is not set
# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_GM12U320=m
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_DRM_PL111=m
CONFIG_DRM_PANFROST=m
CONFIG_DRM_GUD=m
CONFIG_DRM_SSD130X=m
# CONFIG_DRM_SSD130X_I2C is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
CONFIG_DRM_VIA=m
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CLPS711X is not set
CONFIG_FB_IMX=m
CONFIG_FB_CYBER2000=m
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_UVESA=m
CONFIG_FB_PVR2=m
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_PXA168=m
# CONFIG_FB_W100 is not set
CONFIG_FB_SH_MOBILE_LCDC=m
CONFIG_FB_TMIO=m
# CONFIG_FB_TMIO_ACCELL is not set
CONFIG_FB_S3C=m
# CONFIG_FB_S3C_DEBUG_REGWRITE is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_DA8XX is not set
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
CONFIG_FB_OMAP_LCD_H3=y
CONFIG_MMP_DISP=y
# CONFIG_MMP_DISP_CONTROLLER is not set
CONFIG_MMP_FB=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MT6370=m
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_RAVE_SP is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_XHCI_HISTB=m
CONFIG_USB_XHCI_MTK=m
CONFIG_USB_XHCI_MVEBU=m
CONFIG_USB_XHCI_RCAR=m
# CONFIG_USB_BRCMSTB is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_FSL=m
# CONFIG_USB_EHCI_HCD_NPCM7XX is not set
CONFIG_USB_EHCI_HCD_ORION=m
CONFIG_USB_EHCI_HCD_SPEAR=m
# CONFIG_USB_EHCI_HCD_AT91 is not set
CONFIG_USB_EHCI_SH=y
# CONFIG_USB_EHCI_EXYNOS is not set
CONFIG_USB_EHCI_MV=m
CONFIG_USB_CNS3XXX_EHCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_VUDC is not set
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_CDNS3_TI is not set
CONFIG_USB_CDNS3_IMX=m
CONFIG_USB_CDNSP_PCI=m
CONFIG_USB_CDNSP_GADGET=y
CONFIG_USB_CDNSP_HOST=y
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_UX500 is not set

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_PCI is not set
# CONFIG_USB_DWC3_HAPS is not set
CONFIG_USB_DWC3_KEYSTONE=m
CONFIG_USB_DWC3_QCOM=m
# CONFIG_USB_DWC3_AM62 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=m
# CONFIG_USB_CHIPIDEA_GENERIC is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m
CONFIG_BRCM_USB_PINMAP=y
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_TEGRA_PHY=m
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
# CONFIG_USB_LPC32XX is not set
CONFIG_USB_FOTG210_UDC=m
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_RENESAS_USB3=m
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=m
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
CONFIG_USB_AMD5536UDC=m
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_ASPEED_UDC=m
CONFIG_USB_ASPEED_VHUB=m
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_NCM=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_EEM=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
CONFIG_USB_ETH=m
# CONFIG_USB_ETH_RNDIS is not set
# CONFIG_USB_ETH_EEM is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_GADGET_TARGET=m
CONFIG_USB_G_SERIAL=m
CONFIG_USB_G_PRINTER=m
CONFIG_USB_CDC_COMPOSITE=m
CONFIG_USB_G_NOKIA=m
CONFIG_USB_G_ACM_MS=m
CONFIG_USB_G_MULTI=m
# CONFIG_USB_G_MULTI_RNDIS is not set
CONFIG_USB_G_MULTI_CDC=y
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
CONFIG_USB_G_DBGP_PRINTK=y
# CONFIG_USB_G_DBGP_SERIAL is not set
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
CONFIG_UCSI_STM32G0=m
# CONFIG_TYPEC_TPS6598X is not set
CONFIG_TYPEC_ANX7411=m
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=m
# CONFIG_TYPEC_STUSB160X is not set
CONFIG_TYPEC_QCOM_PMIC=m
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=m
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_MESON_GX=m
CONFIG_MMC_MOXART=m
# CONFIG_MMC_OMAP_HS is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_DAVINCI is not set
# CONFIG_MMC_S3C is not set
CONFIG_MMC_TMIO_CORE=m
CONFIG_MMC_TMIO=m
CONFIG_MMC_SDHI=m
CONFIG_MMC_SDHI_SYS_DMAC=m
CONFIG_MMC_SDHI_INTERNAL_DMAC=m
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_DW is not set
CONFIG_MMC_SH_MMCIF=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_SUNXI=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_BCM2835=m
# CONFIG_MMC_MTK is not set
CONFIG_MMC_OWL=m
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_HPB=y
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_S3C24XX=m
CONFIG_LEDS_COBALT_QUBE=y
CONFIG_LEDS_COBALT_RAQ=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_NS2=m
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_IP30=m
CONFIG_LEDS_ACER_A500=y

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=m

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_CXGB4=m
CONFIG_INFINIBAND_EFA=m
# CONFIG_INFINIBAND_ERDMA is not set
CONFIG_INFINIBAND_HNS=m
CONFIG_INFINIBAND_HNS_HIP08=y
# CONFIG_INFINIBAND_IRDMA is not set
CONFIG_MLX4_INFINIBAND=m
# CONFIG_MLX5_INFINIBAND is not set
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
# CONFIG_RDMA_RXE is not set
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
# CONFIG_INFINIBAND_SRP is not set
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
# CONFIG_INFINIBAND_ISERT is not set
CONFIG_INFINIBAND_RTRS=m
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
CONFIG_INFINIBAND_RTRS_SERVER=m
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_BRCMSTB=m
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8997=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_TPS6586X=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
CONFIG_RTC_DRV_DS17885=y
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_EFI=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_GAMECUBE=m
# CONFIG_RTC_DRV_WM8350 is not set
# CONFIG_RTC_DRV_SC27XX is not set
# CONFIG_RTC_DRV_SPEAR is not set
CONFIG_RTC_DRV_NTXEC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
# CONFIG_RTC_DRV_DAVINCI is not set
CONFIG_RTC_DRV_DIGICOLOR=m
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
CONFIG_RTC_DRV_MESON=y
# CONFIG_RTC_DRV_MESON_VRTC is not set
CONFIG_RTC_DRV_S3C=m
CONFIG_RTC_DRV_EP93XX=m
CONFIG_RTC_DRV_GENERIC=m
CONFIG_RTC_DRV_VT8500=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=m
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_STMP=m
CONFIG_RTC_DRV_LPC32XX=y
CONFIG_RTC_DRV_PM8XXX=m
# CONFIG_RTC_DRV_TEGRA is not set
# CONFIG_RTC_DRV_MOXART is not set
CONFIG_RTC_DRV_MT2712=m
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_MT7622 is not set
CONFIG_RTC_DRV_XGENE=y
CONFIG_RTC_DRV_STM32=y
# CONFIG_RTC_DRV_RTD119X is not set
CONFIG_RTC_DRV_TI_K3=m

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_MSC313=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_DFL=m
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_PMEM=m
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=y
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=y
# CONFIG_COMEDI_NI_LABPC_ISA is not set
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
# CONFIG_COMEDI_MULTIQ3 is not set
# CONFIG_COMEDI_S526 is not set
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
CONFIG_COMEDI_ADDI_APCI_1032=y
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=y
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
CONFIG_COMEDI_ADDI_APCI_16XX=y
CONFIG_COMEDI_ADDI_APCI_2032=y
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=m
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=y
# CONFIG_COMEDI_ADV_PCI1710 is not set
# CONFIG_COMEDI_ADV_PCI1720 is not set
CONFIG_COMEDI_ADV_PCI1723=m
# CONFIG_COMEDI_ADV_PCI1724 is not set
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=y
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=y
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
# CONFIG_COMEDI_DT3000 is not set
# CONFIG_COMEDI_DYNA_PCI10XX is not set
CONFIG_COMEDI_GSC_HPDI=y
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=y
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=y
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=y
# CONFIG_COMEDI_ME_DAQ is not set
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
CONFIG_COMEDI_NI_660X=m
# CONFIG_COMEDI_NI_670X is not set
CONFIG_COMEDI_NI_LABPC_PCI=y
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=y
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=y
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
# CONFIG_COMEDI_TESTS_NI_ROUTES is not set
CONFIG_STAGING=y
CONFIG_RTS5208=m
CONFIG_OCTEON_ETHERNET=y
CONFIG_FB_SM750=m
CONFIG_USB_EMXX=m
CONFIG_STAGING_MEDIA=y
CONFIG_LTE_GDM724X=m
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
# CONFIG_GREYBUS_PWM is not set
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
CONFIG_GREYBUS_ARCHE=y
CONFIG_FIELDBUS_DEV=y
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_GOLDFISH is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=m
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CHROMEOS_PRIVACY_SCREEN=m
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=m
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_APPLE_NCO=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_HI655X=m
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=m
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_TPS68470 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
CONFIG_COMMON_CLK_FSL_SAI=y
# CONFIG_COMMON_CLK_GEMINI is not set
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=m
CONFIG_CLK_LS1028A_PLLDIG=m
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
# CONFIG_CLK_ACTIONS is not set
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
# CONFIG_CLK_BT1_CCU_DIV is not set
# CONFIG_CLK_BT1_CCU_RST is not set
# CONFIG_CLK_BCM2711_DVP is not set
CONFIG_CLK_BCM2835=y
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=m
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=y
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=m
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
CONFIG_STUB_CLK_HI3660=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
CONFIG_CLK_IMX8MN=m
CONFIG_CLK_IMX8MP=m
CONFIG_CLK_IMX8MQ=m
CONFIG_CLK_IMX8ULP=y
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
# CONFIG_INGENIC_CGU_JZ4725B is not set
CONFIG_INGENIC_CGU_JZ4760=y
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
CONFIG_COMMON_CLK_MT2712_JPGDECSYS=y
CONFIG_COMMON_CLK_MT2712_MFGCFG=y
CONFIG_COMMON_CLK_MT2712_MMSYS=y
CONFIG_COMMON_CLK_MT2712_VDECSYS=y
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
# CONFIG_COMMON_CLK_MT6765_AUDIOSYS is not set
CONFIG_COMMON_CLK_MT6765_CAMSYS=y
CONFIG_COMMON_CLK_MT6765_GCESYS=y
# CONFIG_COMMON_CLK_MT6765_MMSYS is not set
CONFIG_COMMON_CLK_MT6765_IMGSYS=y
CONFIG_COMMON_CLK_MT6765_VCODECSYS=y
# CONFIG_COMMON_CLK_MT6765_MFGSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI0BSYS=y
CONFIG_COMMON_CLK_MT6765_MIPI1ASYS=y
CONFIG_COMMON_CLK_MT6765_MIPI1BSYS=y
CONFIG_COMMON_CLK_MT6765_MIPI2ASYS=y
CONFIG_COMMON_CLK_MT6765_MIPI2BSYS=y
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
CONFIG_COMMON_CLK_MT7986_ETHSYS=y
CONFIG_COMMON_CLK_MT8135=y
CONFIG_COMMON_CLK_MT8167=y
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
# CONFIG_COMMON_CLK_MT8167_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
CONFIG_COMMON_CLK_MT8167_MMSYS=y
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
CONFIG_COMMON_CLK_MT8183=y
CONFIG_COMMON_CLK_MT8183_AUDIOSYS=y
CONFIG_COMMON_CLK_MT8183_CAMSYS=y
CONFIG_COMMON_CLK_MT8183_IMGSYS=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE0 is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
# CONFIG_COMMON_CLK_MT8183_IPU_ADL is not set
CONFIG_COMMON_CLK_MT8183_IPU_CONN=y
# CONFIG_COMMON_CLK_MT8183_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8183_MMSYS is not set
CONFIG_COMMON_CLK_MT8183_VDECSYS=y
CONFIG_COMMON_CLK_MT8183_VENCSYS=y
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
# CONFIG_COMMON_CLK_MT8192_CAMSYS is not set
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8192_MMSYS is not set
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
# CONFIG_COMMON_CLK_MT8192_SCP_ADSP is not set
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8195 is not set
CONFIG_COMMON_CLK_MT8365=y
# CONFIG_COMMON_CLK_MT8365_APU is not set
# CONFIG_COMMON_CLK_MT8365_CAM is not set
CONFIG_COMMON_CLK_MT8365_MFG=y
CONFIG_COMMON_CLK_MT8365_MMSYS=y
CONFIG_COMMON_CLK_MT8365_VDEC=m
# CONFIG_COMMON_CLK_MT8365_VENC is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_CLK_MT7621=y
CONFIG_CLK_RENESAS=y
CONFIG_CLK_EMEV2=y
CONFIG_CLK_RZA1=y
# CONFIG_CLK_R7S9210 is not set
# CONFIG_CLK_R8A73A4 is not set
CONFIG_CLK_R8A7740=y
# CONFIG_CLK_R8A7742 is not set
# CONFIG_CLK_R8A7743 is not set
# CONFIG_CLK_R8A7745 is not set
CONFIG_CLK_R8A77470=y
# CONFIG_CLK_R8A774A1 is not set
# CONFIG_CLK_R8A774B1 is not set
CONFIG_CLK_R8A774C0=y
CONFIG_CLK_R8A774E1=y
CONFIG_CLK_R8A7778=y
CONFIG_CLK_R8A7779=y
CONFIG_CLK_R8A7790=y
CONFIG_CLK_R8A7791=y
CONFIG_CLK_R8A7792=y
# CONFIG_CLK_R8A7794 is not set
CONFIG_CLK_R8A7795=y
CONFIG_CLK_R8A77960=y
CONFIG_CLK_R8A77961=y
# CONFIG_CLK_R8A77965 is not set
# CONFIG_CLK_R8A77970 is not set
CONFIG_CLK_R8A77980=y
# CONFIG_CLK_R8A77990 is not set
# CONFIG_CLK_R8A77995 is not set
# CONFIG_CLK_R8A779A0 is not set
# CONFIG_CLK_R8A779F0 is not set
# CONFIG_CLK_R8A779G0 is not set
CONFIG_CLK_R9A06G032=y
CONFIG_CLK_R9A07G043=y
CONFIG_CLK_R9A07G044=y
# CONFIG_CLK_R9A07G054 is not set
CONFIG_CLK_R9A09G011=y
CONFIG_CLK_SH73A0=y
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
CONFIG_CLK_RZG2L=y
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
CONFIG_S5PV210_COMMON_CLK=y
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
CONFIG_EXYNOS_AUDSS_CLK_CON=y
CONFIG_EXYNOS_CLKOUT=m
CONFIG_S3C2410_COMMON_CLK=y
CONFIG_S3C2412_COMMON_CLK=y
CONFIG_S3C2443_COMMON_CLK=y
# CONFIG_TESLA_FSD_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
CONFIG_CLK_INTEL_SOCFPGA64=y
CONFIG_SPRD_COMMON_CLK=y
# CONFIG_SPRD_SC9860_CLK is not set
# CONFIG_SPRD_SC9863A_CLK is not set
CONFIG_SPRD_UMS512_CLK=m
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=m
CONFIG_SUNIV_F1C100S_CCU=m
CONFIG_SUN20I_D1_CCU=m
CONFIG_SUN20I_D1_R_CCU=m
CONFIG_SUN50I_A64_CCU=m
CONFIG_SUN50I_A100_CCU=m
CONFIG_SUN50I_A100_R_CCU=m
CONFIG_SUN50I_H6_CCU=m
CONFIG_SUN50I_H616_CCU=m
CONFIG_SUN50I_H6_R_CCU=m
CONFIG_SUN4I_A10_CCU=m
CONFIG_SUN6I_A31_CCU=m
# CONFIG_SUN6I_RTC_CCU is not set
CONFIG_SUN8I_A23_CCU=m
CONFIG_SUN8I_A33_CCU=m
CONFIG_SUN8I_A83T_CCU=m
CONFIG_SUN8I_H3_CCU=m
CONFIG_SUN8I_V3S_CCU=m
# CONFIG_SUN8I_DE2_CCU is not set
CONFIG_SUN8I_R40_CCU=m
# CONFIG_SUN9I_A80_CCU is not set
CONFIG_SUN8I_R_CCU=m
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
CONFIG_HWSPINLOCK_QCOM=m
# CONFIG_HWSPINLOCK_SPRD is not set
# CONFIG_HWSPINLOCK_STM32 is not set
CONFIG_HWSPINLOCK_SUN6I=y
CONFIG_HSEM_U8500=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
CONFIG_DIGICOLOR_TIMER=y
CONFIG_OMAP_DM_TIMER=y
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
CONFIG_SUN5I_HSTIMER=y
CONFIG_TEGRA_TIMER=y
# CONFIG_TEGRA186_TIMER is not set
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
CONFIG_NSPIRE_TIMER=y
CONFIG_INTEGRATOR_AP_TIMER=y
# CONFIG_CLKSRC_PISTACHIO is not set
CONFIG_CLKSRC_TI_32K=y
CONFIG_CLKSRC_STM32_LP=y
# CONFIG_CLKSRC_MPS2 is not set
# CONFIG_ARC_TIMERS is not set
CONFIG_ARM_TIMER_SP804=y
# CONFIG_ARMV7M_SYSTICK is not set
CONFIG_ATMEL_PIT=y
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
# CONFIG_SPRD_TIMER is not set
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
CONFIG_SH_TIMER_TMU=y
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_POLARFIRE_SOC_MAILBOX=m
# CONFIG_QCOM_APCS_IPC is not set
CONFIG_BCM_PDC_MBOX=y
# CONFIG_STM32_IPCC is not set
CONFIG_MTK_ADSP_MBOX=m
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=m
CONFIG_SPRD_MBOX=y
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
CONFIG_IOMMU_IO_PGTABLE_DART=y
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OMAP_IOMMU=y
# CONFIG_OMAP_IOMMU_DEBUG is not set
CONFIG_ROCKCHIP_IOMMU=y
# CONFIG_SUN50I_IOMMU is not set
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_IPMMU_VMSA is not set
CONFIG_APPLE_DART=y
CONFIG_ARM_SMMU=y
# CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is not set
# CONFIG_S390_CCW_IOMMU is not set
CONFIG_S390_AP_IOMMU=y
CONFIG_MTK_IOMMU=y
CONFIG_QCOM_IOMMU=y
CONFIG_SPRD_IOMMU=m

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=m
CONFIG_MTK_SCP=y
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=y
CONFIG_RCAR_REMOTEPROC=m
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_MTK_SCP=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_QCOM_GLINK_SMEM=m
CONFIG_RPMSG_QCOM_SMD=m
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_RTKIT=y
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
CONFIG_ASPEED_LPC_SNOOP=m
CONFIG_ASPEED_UART_ROUTING=m
CONFIG_ASPEED_P2A_CTRL=m
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=m

#
# Broadcom SoC drivers
#
CONFIG_SOC_BCM63XX=y
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=y
CONFIG_SOC_IMX9=m
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=m
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

# CONFIG_POLARFIRE_SOC_SYS_CTRL is not set

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_GENI_SE is not set
CONFIG_QCOM_GSBI=y
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_PDR_HELPERS=y
CONFIG_QCOM_QMI_HELPERS=y
# CONFIG_QCOM_RPMH is not set
CONFIG_QCOM_SMEM=m
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_SMEM_STATE=y
CONFIG_QCOM_SMP2P=m
CONFIG_QCOM_SMSM=m
# CONFIG_QCOM_SOCINFO is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_STATS is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
CONFIG_QCOM_APR=y
CONFIG_QCOM_ICC_BWMON=m
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
CONFIG_ROCKCHIP_GRF=y
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_CHIPID is not set
# CONFIG_EXYNOS_USI is not set
CONFIG_EXYNOS_PM_DOMAINS=y
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
CONFIG_ARM_IMX_BUS_DEVFREQ=y
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=y
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=m
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_BRCMSTB_DPFE is not set
# CONFIG_BRCMSTB_MEMC is not set
CONFIG_BT1_L2_CTL=y
CONFIG_TI_EMIF=y
CONFIG_FPGA_DFL_EMIF=m
CONFIG_FSL_CORENET_CF=y
CONFIG_FSL_IFC=y
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
CONFIG_RENESAS_RPCIF=m
# CONFIG_STM32_FMC2_EBI is not set
# CONFIG_SAMSUNG_MC is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=m
CONFIG_TEGRA30_EMC=y
CONFIG_TEGRA124_EMC=m
# CONFIG_TEGRA210_EMC is not set
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
CONFIG_NTB_MSI_TEST=y
CONFIG_NTB_TRANSPORT=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
CONFIG_PWM_BCM2835=y
# CONFIG_PWM_BERLIN is not set
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLK is not set
CONFIG_PWM_CLPS711X=y
# CONFIG_PWM_DWC is not set
CONFIG_PWM_EP93XX=m
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
CONFIG_PWM_IMX1=m
CONFIG_PWM_IMX27=y
CONFIG_PWM_IMX_TPM=m
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_JZ4740 is not set
CONFIG_PWM_KEEMBAY=m
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPC18XX_SCT=y
CONFIG_PWM_LPC32XX=y
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_MESON=m
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_NTXEC is not set
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=y
# CONFIG_PWM_RCAR is not set
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=m
CONFIG_PWM_SAMSUNG=y
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPRD is not set
CONFIG_PWM_STM32=m
CONFIG_PWM_STM32_LP=y
CONFIG_PWM_SUN4I=m
CONFIG_PWM_TEGRA=m
CONFIG_PWM_TIECAP=m
CONFIG_PWM_TIEHRPWM=y
CONFIG_PWM_VISCONTI=m
CONFIG_PWM_VT8500=y

#
# IRQ chip support
#
CONFIG_AL_FIC=y
CONFIG_RENESAS_INTC_IRQPIN=y
CONFIG_RENESAS_IRQC=y
CONFIG_RENESAS_RZA1_IRQC=y
# CONFIG_RENESAS_RZG2L_IRQC is not set
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_INGENIC_TCU_IRQ=y
CONFIG_IRQ_UNIPHIER_AIDET=y
CONFIG_MESON_IRQ_GPIO=m
CONFIG_IMX_IRQSTEER=y
CONFIG_IMX_INTMUX=y
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_IRQ_LOONGARCH_CPU=y
CONFIG_LOONGSON_LIOINTC=y
CONFIG_LOONGSON_EIOINTC=y
CONFIG_LOONGSON_HTVEC=y
CONFIG_LOONGSON_PCH_PIC=y
CONFIG_LOONGSON_PCH_MSI=y
CONFIG_LOONGSON_PCH_LPC=y
CONFIG_MST_IRQ=y
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=m
# CONFIG_RESET_ATH79 is not set
CONFIG_RESET_AXS10X=y
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=m
# CONFIG_RESET_BRCMSTB is not set
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=y
# CONFIG_RESET_LANTIQ is not set
CONFIG_RESET_LPC18XX=y
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=m
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=y
CONFIG_RESET_QCOM_PDC=m
CONFIG_RESET_RASPBERRYPI=m
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=m
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=m
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=m
CONFIG_RESET_TN48M_CPLD=m
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_PISTACHIO_USB is not set
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN4I_USB=m
CONFIG_PHY_SUN6I_MIPI_DPHY=y
# CONFIG_PHY_SUN9I_USB is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_NS2_PCIE=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=m
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=y
# CONFIG_PHY_MMP3_HSIC is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=m
# CONFIG_PHY_STIH407_USB is not set
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_DM816X_USB is not set
CONFIG_PHY_AM654_SERDES=m
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
CONFIG_PHY_INTEL_KEEMBAY_USB=m
# CONFIG_PHY_INTEL_LGM_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set
CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_DMA_TEST=m

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
# CONFIG_BTT is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_APPLE_EFUSES is not set
CONFIG_NVMEM_BCM_OCOTP=m
CONFIG_NVMEM_BRCM_NVRAM=m
CONFIG_NVMEM_IMX_IIM=y
CONFIG_NVMEM_IMX_OCOTP=m
# CONFIG_NVMEM_LAN9662_OTPC is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=m
CONFIG_NVMEM_MESON_MX_EFUSE=y
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_MTK_EFUSE is not set
CONFIG_NVMEM_MXS_OCOTP=m
CONFIG_NVMEM_NINTENDO_OTP=m
CONFIG_NVMEM_QCOM_QFPROM=y
CONFIG_NVMEM_RAVE_SP_EEPROM=m
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_ROCKCHIP_EFUSE=m
CONFIG_NVMEM_ROCKCHIP_OTP=y
# CONFIG_NVMEM_SC27XX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=m
# CONFIG_NVMEM_SPMI_SDAM is not set
CONFIG_NVMEM_SPRD_EFUSE=y
# CONFIG_NVMEM_STM32_ROMEM is not set
CONFIG_NVMEM_SUNPLUS_OCOTP=m
CONFIG_NVMEM_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_FPGA_MGR_SOCFPGA=y
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_MGR_ZYNQ_FPGA=y
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
CONFIG_FPGA_MGR_VERSAL_FPGA=y
CONFIG_TEE=m
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=m
CONFIG_INTERCONNECT_IMX8MM=m
CONFIG_INTERCONNECT_IMX8MN=m
# CONFIG_INTERCONNECT_IMX8MQ is not set
CONFIG_INTERCONNECT_IMX8MP=m
CONFIG_INTERCONNECT_QCOM_OSM_L3=m
# CONFIG_INTERCONNECT_SAMSUNG is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=y
CONFIG_PECI=m
CONFIG_PECI_CPU=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=m
CONFIG_EXPORTFS_BLOCK_OPS=y
# CONFIG_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_64BIT_CLUSTER is not set
# CONFIG_NTFS3_LZX_XPRESS is not set
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
# CONFIG_UBIFS_FS_ZLIB is not set
# CONFIG_UBIFS_FS_ZSTD is not set
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=m
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_CRAMFS_MTD=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=m
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
# CONFIG_EROFS_FS_POSIX_ACL is not set
CONFIG_EROFS_FS_SECURITY=y
# CONFIG_EROFS_FS_ZIP is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
CONFIG_CRYPTO_STATS=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
# CONFIG_UBSAN_SHIFT is not set
CONFIG_UBSAN_DIV_ZERO=y
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
CONFIG_UBSAN_ENUM=y
CONFIG_TEST_UBSAN=m
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
CONFIG_NET_NS_REFCNT_TRACKER=y
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_SLAB=y
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_INFO=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_SCF_TORTURE_TEST=y
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# loongarch Debugging
#
CONFIG_UNWINDER_GUESS=y
# CONFIG_UNWINDER_PROLOGUE is not set
# end of loongarch Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_DIV64=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=y
CONFIG_RBTREE_TEST=m
CONFIG_REED_SOLOMON_TEST=y
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=m
# CONFIG_STRING_SELFTEST is not set
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_SIPHASH is not set
CONFIG_TEST_IDA=m
CONFIG_TEST_PARMAN=m
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
CONFIG_TEST_BLACKHOLE_DEV=m
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_TEST_DYNAMIC_DEBUG=y
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_OBJAGG=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_FREE_PAGES=m
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

CONFIG_WARN_MISSING_DOCUMENTS=y
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--X1ol+c1N2cQ9LA2f--

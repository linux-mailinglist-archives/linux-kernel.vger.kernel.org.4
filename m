Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179516C456E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCVIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:55:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523D451F93
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679475332; x=1711011332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+rm26N75H5kN42G3Mb2Br6Ujuqh6hH59qcWsWoYPxY4=;
  b=HZ1HPR/KqNRiZk2UAAK1JEeWiJ/aZ7DJK+g5P8peD6IKJCiDDQOMzCD6
   rwg6FB/O5rwGwFTLMJEdveXj3e0NH6j0fKE6Oqax5m6PtD56ggTjiAFI2
   74+hOvxmW9cmgyNDpGWgxVUHClPd7W7jEn3cv7xXyOfS4VEHY0C4yzSWI
   0K6VS8NHnDi4jZqA8Ei+pr7RijfZMPbrws6Idot/WYQBgk/VqGuYbXS9e
   zGO6wN1ALm71uCId3c3wNGU/kFzKG1ixFAGAH52sZJxc2bBfgRe5lGpjN
   dvayxPx2OghG8DYpdm9Lq+6j5LNS0zI0X/z3792XEajmIsYahvjWRxAyH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340699664"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="340699664"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 01:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="712139447"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="712139447"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2023 01:55:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peuFl-000D6e-1m;
        Wed, 22 Mar 2023 08:55:29 +0000
Date:   Wed, 22 Mar 2023 16:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lior Nahmanson <liorna@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13:
 sparse: sparse: restricted __be64 degrades to integer
Message-ID: <202303221650.fdu0dJdI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a1effab7a3a35a837dd9d2b974a1bc4939df1ad5
commit: 3b20949cb21bac26d50cdcc58896802a890cfe15 net/mlx5e: Add MACsec RX steering rules
date:   7 months ago
config: m68k-randconfig-s031-20230322 (https://download.01.org/0day-ci/archive/20230322/202303221650.fdu0dJdI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b20949cb21bac26d50cdcc58896802a890cfe15
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3b20949cb21bac26d50cdcc58896802a890cfe15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221650.fdu0dJdI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13: sparse: sparse: restricted __be64 degrades to integer

vim +1183 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c

  1105	
  1106	static union mlx5e_macsec_rule *
  1107	macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
  1108			      const struct macsec_context *macsec_ctx,
  1109			      struct mlx5_macsec_rule_attrs *attrs,
  1110			      u32 fs_id)
  1111	{
  1112		u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
  1113		struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
  1114		struct net_device *netdev = macsec_fs->netdev;
  1115		struct mlx5_modify_hdr *modify_hdr = NULL;
  1116		struct mlx5_flow_destination dest = {};
  1117		struct mlx5e_macsec_tables *rx_tables;
  1118		union mlx5e_macsec_rule *macsec_rule;
  1119		struct mlx5e_macsec_rx_rule *rx_rule;
  1120		struct mlx5_flow_act flow_act = {};
  1121		struct mlx5e_flow_table *ft_crypto;
  1122		struct mlx5_flow_handle *rule;
  1123		struct mlx5_flow_spec *spec;
  1124		int err = 0;
  1125	
  1126		spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
  1127		if (!spec)
  1128			return NULL;
  1129	
  1130		err = macsec_fs_rx_ft_get(macsec_fs);
  1131		if (err)
  1132			goto out_spec;
  1133	
  1134		macsec_rule = kzalloc(sizeof(*macsec_rule), GFP_KERNEL);
  1135		if (!macsec_rule) {
  1136			macsec_fs_rx_ft_put(macsec_fs);
  1137			goto out_spec;
  1138		}
  1139	
  1140		rx_rule = &macsec_rule->rx_rule;
  1141		rx_tables = &rx_fs->tables;
  1142		ft_crypto = &rx_tables->ft_crypto;
  1143	
  1144		/* Set bit[31 - 30] macsec marker - 0x01 */
  1145		/* Set bit[3-0] fs id */
  1146		MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
  1147		MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
  1148		MLX5_SET(set_action_in, action, data, fs_id | BIT(30));
  1149		MLX5_SET(set_action_in, action, offset, 0);
  1150		MLX5_SET(set_action_in, action, length, 32);
  1151	
  1152		modify_hdr = mlx5_modify_header_alloc(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC,
  1153						      1, action);
  1154		if (IS_ERR(modify_hdr)) {
  1155			err = PTR_ERR(modify_hdr);
  1156			netdev_err(netdev, "fail to alloc MACsec set modify_header_id err=%d\n", err);
  1157			modify_hdr = NULL;
  1158			goto err;
  1159		}
  1160		rx_rule->meta_modhdr = modify_hdr;
  1161	
  1162		/* Rx crypto table with SCI rule */
  1163		macsec_fs_rx_setup_fte(spec, &flow_act, attrs, true);
  1164	
  1165		flow_act.modify_hdr = modify_hdr;
  1166		flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
  1167				  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
  1168				  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
  1169	
  1170		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
  1171		dest.ft = rx_tables->ft_check;
  1172		rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
  1173		if (IS_ERR(rule)) {
  1174			err = PTR_ERR(rule);
  1175			netdev_err(netdev,
  1176				   "Failed to add SA with SCI rule to Rx crypto rule, err=%d\n",
  1177				   err);
  1178			goto err;
  1179		}
  1180		rx_rule->rule[0] = rule;
  1181	
  1182		/* Rx crypto table without SCI rule */
> 1183		if (cpu_to_be64((__force u64)attrs->sci) & ntohs(MACSEC_PORT_ES)) {
  1184			memset(spec, 0, sizeof(struct mlx5_flow_spec));
  1185			memset(&dest, 0, sizeof(struct mlx5_flow_destination));
  1186			memset(&flow_act, 0, sizeof(flow_act));
  1187	
  1188			macsec_fs_rx_setup_fte(spec, &flow_act, attrs, false);
  1189	
  1190			flow_act.modify_hdr = modify_hdr;
  1191			flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
  1192					  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
  1193					  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
  1194	
  1195			dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
  1196			dest.ft = rx_tables->ft_check;
  1197			rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
  1198			if (IS_ERR(rule)) {
  1199				err = PTR_ERR(rule);
  1200				netdev_err(netdev,
  1201					   "Failed to add SA without SCI rule to Rx crypto rule, err=%d\n",
  1202					   err);
  1203				goto err;
  1204			}
  1205			rx_rule->rule[1] = rule;
  1206		}
  1207	
  1208		return macsec_rule;
  1209	
  1210	err:
  1211		macsec_fs_rx_del_rule(macsec_fs, rx_rule);
  1212		macsec_rule = NULL;
  1213	out_spec:
  1214		kvfree(spec);
  1215		return macsec_rule;
  1216	}
  1217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB973CD90
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 02:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFYAu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 20:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYAu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 20:50:56 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CA10C2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687654248;
        bh=QmEywB996WwlvH/4tyalnOZIXfNp96h4eL4f4e+N89w=;
        h=From:To:Cc:Subject:Date;
        b=G/HMLKhTY7bxZFlFqaHZvY0kSR5t27X2oG3Wxqr6rNZSQQEq6aZyBybBRhXiB9szo
         Wsi7lhJhUeeIC3cFEfxDtfI7BNjTT4wJjmDPIxzsHjYpy5njjDcjMdP7yOnTRIkFAb
         GPQRgzxgZkIlGeOMTz2WMfZk7kKu3aBwpJDUHnKw=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id CADAB20C; Sun, 25 Jun 2023 08:50:45 +0800
X-QQ-mid: xmsmtpt1687654245tz61m5qh6
Message-ID: <tencent_E3643D5F0AA8CCBEF28C6A233A18B808CD0A@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0eln7XLsTnNi8FjsnVObI2UTs/DhdAFaHnM4yUz90DBxJGHgqOxqd+
         yrp9yt09Zn+KM/zSxLSJ6/YFkr2C2Dl7XmtEeGgqIzwKlWZlCoHSxGuwHdyIcb/CchslUlGOCEuY
         guKr+jVUnALFcyALH8/HaNQs9Cs/lldR7m4CUmg1H5UrDECUwJmwfP8XF6/QvItSxK+tkVAMUj1a
         gvvuAmCzVzKc4mXGMvQ5f57A5AIAUUwbJ6Wo7mYbSlSZSgH7XANfIiRH7Wif/SiIZHjkZFT99tHR
         r5GuWvmL/ZAQ2p8CXit0CYDYKcMAFUx3EELM9m4zbF++RSmuJ0sXkfHDP/rlFTQTTEejH99rz6jJ
         7+WHV8Ye/7Y7jkUK+z4n4MXFL6KRvDNsdn+Bw/3GRbhuIWOIaOtSDsJNC02SU3H9MPDmMCsgBbA8
         YXlKN9ezfodBXf34rUoXG8TzUJCsHS8sVfq+YlQD2OdoKisZoNxHw2FlvDlMJMITGq1c//+z/uxO
         PV0PaluqFV8zaOAZ9w8WZIz/HLrFyy6fTMWp63f7H4YbyRTYmPjVs6fjjQZmXz0kXcBpJnD/luGk
         v6m3PyjXTIsinie5cojblrfzLOJzuZiJGbQVBcUq0USgnSwPtdJj7/N00ogvoUA5XueyjyMY981G
         epSg2TejdWdO77CvHXxiuEdX3LKSRnm8X9DFyZe9cIFTx2U4Adr4fZx3HZqIWO1PPKGts+OUYSkc
         iyDn2qqfBdddrEroIO+4BlU3fi3u9uq7NcOAC65/MOBxokubVu+iQayifNgX6/eakbYBGmLtKcPZ
         7/R2R01EkjY14/ZJBadZ7G0L0CN7Bs3ze2pfoSBN3jYqt15yP2S+BSesBxfKxw+UTF1wCrPXXmN1
         k9oOSuA5n4yA8X07izVZOy368j4SW8o5/ymYerDIty/MtaCxxj5Ahfpy9YE6TH57aqoOaURC/C9G
         0N1AXrD3nphhKisHvsjCE1mrqIFPiz
X-QQ-XMRINFO: OISvejVQwePVgzAjzmAtJeBjKpW55oNAGA==
From:   Rong Tao <rtoax@foxmail.com>
To:     martin.petersen@oracle.com
Cc:     rongtao@cestc.cn, Jonathan Corbet <corbet@lwn.net>,
        linux-scsi@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        target-devel@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] docs: target: Remove useless tcm_mod_builder.py
Date:   Sun, 25 Jun 2023 08:50:43 +0800
X-OQ-MSGID: <20230625005044.5247-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

This script is not used and requires additional development to sync with
the SCSI target code.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Remove useless tcm_mod_builder.py
v1: docs: target: Convert tcm_mod_builder.py print syntax to python3
    https://lore.kernel.org/lkml/tencent_F3895D0EA868BCCE8C56221619BC093D660A@qq.com/
---
 Documentation/target/tcm_mod_builder.py | 656 ------------------------
 1 file changed, 656 deletions(-)
 delete mode 100755 Documentation/target/tcm_mod_builder.py

diff --git a/Documentation/target/tcm_mod_builder.py b/Documentation/target/tcm_mod_builder.py
deleted file mode 100755
index 54492aa813b9..000000000000
--- a/Documentation/target/tcm_mod_builder.py
+++ /dev/null
@@ -1,656 +0,0 @@
-#!/usr/bin/env python
-# The TCM v4 multi-protocol fabric module generation script for drivers/target/$NEW_MOD
-#
-# Copyright (c) 2010 Rising Tide Systems
-# Copyright (c) 2010 Linux-iSCSI.org
-#
-# Author: nab@kernel.org
-#
-import os, sys
-import subprocess as sub
-import string
-import re
-import optparse
-
-tcm_dir = ""
-
-fabric_ops = []
-fabric_mod_dir = ""
-fabric_mod_port = ""
-fabric_mod_init_port = ""
-
-def tcm_mod_err(msg):
-	print msg
-	sys.exit(1)
-
-def tcm_mod_create_module_subdir(fabric_mod_dir_var):
-
-	if os.path.isdir(fabric_mod_dir_var) == True:
-		return 1
-
-	print "Creating fabric_mod_dir: " + fabric_mod_dir_var
-	ret = os.mkdir(fabric_mod_dir_var)
-	if ret:
-		tcm_mod_err("Unable to mkdir " + fabric_mod_dir_var)
-
-	return
-
-def tcm_mod_build_FC_include(fabric_mod_dir_var, fabric_mod_name):
-	global fabric_mod_port
-	global fabric_mod_init_port
-	buf = ""
-
-	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
-
-	p = open(f, 'w');
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	buf = "#define " + fabric_mod_name.upper() + "_VERSION	\"v0.1\"\n"
-	buf += "#define " + fabric_mod_name.upper() + "_NAMELEN	32\n"
-	buf += "\n"
-	buf += "struct " + fabric_mod_name + "_tpg {\n"
-	buf += "	/* FC lport target portal group tag for TCM */\n"
-	buf += "	u16 lport_tpgt;\n"
-	buf += "	/* Pointer back to " + fabric_mod_name + "_lport */\n"
-	buf += "	struct " + fabric_mod_name + "_lport *lport;\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_tpg() */\n"
-	buf += "	struct se_portal_group se_tpg;\n"
-	buf += "};\n"
-	buf += "\n"
-	buf += "struct " + fabric_mod_name + "_lport {\n"
-	buf += "	/* Binary World Wide unique Port Name for FC Target Lport */\n"
-	buf += "	u64 lport_wwpn;\n"
-	buf += "	/* ASCII formatted WWPN for FC Target Lport */\n"
-	buf += "	char lport_name[" + fabric_mod_name.upper() + "_NAMELEN];\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_lport() */\n"
-	buf += "	struct se_wwn lport_wwn;\n"
-	buf += "};\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-
-	fabric_mod_port = "lport"
-	fabric_mod_init_port = "nport"
-
-	return
-
-def tcm_mod_build_SAS_include(fabric_mod_dir_var, fabric_mod_name):
-	global fabric_mod_port
-	global fabric_mod_init_port
-	buf = ""
-
-	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
-
-	p = open(f, 'w');
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	buf = "#define " + fabric_mod_name.upper() + "_VERSION  \"v0.1\"\n"
-	buf += "#define " + fabric_mod_name.upper() + "_NAMELEN 32\n"
-	buf += "\n"
-	buf += "struct " + fabric_mod_name + "_tpg {\n"
-	buf += "	/* SAS port target portal group tag for TCM */\n"
-	buf += "	u16 tport_tpgt;\n"
-	buf += "	/* Pointer back to " + fabric_mod_name + "_tport */\n"
-	buf += "	struct " + fabric_mod_name + "_tport *tport;\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_tpg() */\n"
-	buf += "	struct se_portal_group se_tpg;\n"
-	buf += "};\n\n"
-	buf += "struct " + fabric_mod_name + "_tport {\n"
-	buf += "	/* Binary World Wide unique Port Name for SAS Target port */\n"
-	buf += "	u64 tport_wwpn;\n"
-	buf += "	/* ASCII formatted WWPN for SAS Target port */\n"
-	buf += "	char tport_name[" + fabric_mod_name.upper() + "_NAMELEN];\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_tport() */\n"
-	buf += "	struct se_wwn tport_wwn;\n"
-	buf += "};\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-
-	fabric_mod_port = "tport"
-	fabric_mod_init_port = "iport"
-
-	return
-
-def tcm_mod_build_iSCSI_include(fabric_mod_dir_var, fabric_mod_name):
-	global fabric_mod_port
-	global fabric_mod_init_port
-	buf = ""
-
-	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
-
-	p = open(f, 'w');
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	buf = "#define " + fabric_mod_name.upper() + "_VERSION  \"v0.1\"\n"
-	buf += "#define " + fabric_mod_name.upper() + "_NAMELEN 32\n"
-	buf += "\n"
-	buf += "struct " + fabric_mod_name + "_tpg {\n"
-	buf += "	/* iSCSI target portal group tag for TCM */\n"
-	buf += "	u16 tport_tpgt;\n"
-	buf += "	/* Pointer back to " + fabric_mod_name + "_tport */\n"
-	buf += "	struct " + fabric_mod_name + "_tport *tport;\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_tpg() */\n"
-	buf += "	struct se_portal_group se_tpg;\n"
-	buf += "};\n\n"
-	buf += "struct " + fabric_mod_name + "_tport {\n"
-	buf += "	/* ASCII formatted TargetName for IQN */\n"
-	buf += "	char tport_name[" + fabric_mod_name.upper() + "_NAMELEN];\n"
-	buf += "	/* Returned by " + fabric_mod_name + "_make_tport() */\n"
-	buf += "	struct se_wwn tport_wwn;\n"
-	buf += "};\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-
-	fabric_mod_port = "tport"
-	fabric_mod_init_port = "iport"
-
-	return
-
-def tcm_mod_build_base_includes(proto_ident, fabric_mod_dir_val, fabric_mod_name):
-
-	if proto_ident == "FC":
-		tcm_mod_build_FC_include(fabric_mod_dir_val, fabric_mod_name)
-	elif proto_ident == "SAS":
-		tcm_mod_build_SAS_include(fabric_mod_dir_val, fabric_mod_name)
-	elif proto_ident == "iSCSI":
-		tcm_mod_build_iSCSI_include(fabric_mod_dir_val, fabric_mod_name)
-	else:
-		print "Unsupported proto_ident: " + proto_ident
-		sys.exit(1)
-
-	return
-
-def tcm_mod_build_configfs(proto_ident, fabric_mod_dir_var, fabric_mod_name):
-	buf = ""
-
-	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_configfs.c"
-	print "Writing file: " + f
-
-        p = open(f, 'w');
-        if not p:
-                tcm_mod_err("Unable to open file: " + f)
-
-	buf = "#include <linux/module.h>\n"
-	buf += "#include <linux/moduleparam.h>\n"
-	buf += "#include <linux/version.h>\n"
-	buf += "#include <generated/utsrelease.h>\n"
-	buf += "#include <linux/utsname.h>\n"
-	buf += "#include <linux/init.h>\n"
-	buf += "#include <linux/slab.h>\n"
-	buf += "#include <linux/kthread.h>\n"
-	buf += "#include <linux/types.h>\n"
-	buf += "#include <linux/string.h>\n"
-	buf += "#include <linux/configfs.h>\n"
-	buf += "#include <linux/ctype.h>\n"
-	buf += "#include <asm/unaligned.h>\n"
-	buf += "#include <scsi/scsi_proto.h>\n\n"
-	buf += "#include <target/target_core_base.h>\n"
-	buf += "#include <target/target_core_fabric.h>\n"
-	buf += "#include \"" + fabric_mod_name + "_base.h\"\n"
-	buf += "#include \"" + fabric_mod_name + "_fabric.h\"\n\n"
-
-	buf += "static const struct target_core_fabric_ops " + fabric_mod_name + "_ops;\n\n"
-
-	buf += "static struct se_portal_group *" + fabric_mod_name + "_make_tpg(\n"
-	buf += "	struct se_wwn *wwn,\n"
-	buf += "	struct config_group *group,\n"
-	buf += "	const char *name)\n"
-	buf += "{\n"
-	buf += "	struct " + fabric_mod_name + "_" + fabric_mod_port + "*" + fabric_mod_port + " = container_of(wwn,\n"
-	buf += "			struct " + fabric_mod_name + "_" + fabric_mod_port + ", " + fabric_mod_port + "_wwn);\n\n"
-	buf += "	struct " + fabric_mod_name + "_tpg *tpg;\n"
-	buf += "	unsigned long tpgt;\n"
-	buf += "	int ret;\n\n"
-	buf += "	if (strstr(name, \"tpgt_\") != name)\n"
-	buf += "		return ERR_PTR(-EINVAL);\n"
-	buf += "	if (kstrtoul(name + 5, 10, &tpgt) || tpgt > UINT_MAX)\n"
-	buf += "		return ERR_PTR(-EINVAL);\n\n"
-	buf += "	tpg = kzalloc(sizeof(struct " + fabric_mod_name + "_tpg), GFP_KERNEL);\n"
-	buf += "	if (!tpg) {\n"
-	buf += "		printk(KERN_ERR \"Unable to allocate struct " + fabric_mod_name + "_tpg\");\n"
-	buf += "		return ERR_PTR(-ENOMEM);\n"
-	buf += "	}\n"
-	buf += "	tpg->" + fabric_mod_port + " = " + fabric_mod_port + ";\n"
-	buf += "	tpg->" + fabric_mod_port + "_tpgt = tpgt;\n\n"
-
-	if proto_ident == "FC":
-		buf += "	ret = core_tpg_register(wwn, &tpg->se_tpg, SCSI_PROTOCOL_FCP);\n"
-	elif proto_ident == "SAS":
-		buf += "	ret = core_tpg_register(wwn, &tpg->se_tpg, SCSI_PROTOCOL_SAS);\n"
-	elif proto_ident == "iSCSI":
-		buf += "	ret = core_tpg_register(wwn, &tpg->se_tpg, SCSI_PROTOCOL_ISCSI);\n"
-
-	buf += "	if (ret < 0) {\n"
-	buf += "		kfree(tpg);\n"
-	buf += "		return NULL;\n"
-	buf += "	}\n"
-	buf += "	return &tpg->se_tpg;\n"
-	buf += "}\n\n"
-	buf += "static void " + fabric_mod_name + "_drop_tpg(struct se_portal_group *se_tpg)\n"
-	buf += "{\n"
-	buf += "	struct " + fabric_mod_name + "_tpg *tpg = container_of(se_tpg,\n"
-	buf += "				struct " + fabric_mod_name + "_tpg, se_tpg);\n\n"
-	buf += "	core_tpg_deregister(se_tpg);\n"
-	buf += "	kfree(tpg);\n"
-	buf += "}\n\n"
-
-	buf += "static struct se_wwn *" + fabric_mod_name + "_make_" + fabric_mod_port + "(\n"
-	buf += "	struct target_fabric_configfs *tf,\n"
-	buf += "	struct config_group *group,\n"
-	buf += "	const char *name)\n"
-	buf += "{\n"
-	buf += "	struct " + fabric_mod_name + "_" + fabric_mod_port + " *" + fabric_mod_port + ";\n"
-
-	if proto_ident == "FC" or proto_ident == "SAS":
-		buf += "	u64 wwpn = 0;\n\n"
-
-	buf += "	/* if (" + fabric_mod_name + "_parse_wwn(name, &wwpn, 1) < 0)\n"
-	buf += "		return ERR_PTR(-EINVAL); */\n\n"
-	buf += "	" + fabric_mod_port + " = kzalloc(sizeof(struct " + fabric_mod_name + "_" + fabric_mod_port + "), GFP_KERNEL);\n"
-	buf += "	if (!" + fabric_mod_port + ") {\n"
-	buf += "		printk(KERN_ERR \"Unable to allocate struct " + fabric_mod_name + "_" + fabric_mod_port + "\");\n"
-	buf += "		return ERR_PTR(-ENOMEM);\n"
-	buf += "	}\n"
-
-	if proto_ident == "FC" or proto_ident == "SAS":
-		buf += "	" + fabric_mod_port + "->" + fabric_mod_port + "_wwpn = wwpn;\n"
-
-	buf += "	/* " + fabric_mod_name + "_format_wwn(&" + fabric_mod_port + "->" + fabric_mod_port + "_name[0], " + fabric_mod_name.upper() + "_NAMELEN, wwpn); */\n\n"
-	buf += "	return &" + fabric_mod_port + "->" + fabric_mod_port + "_wwn;\n"
-	buf += "}\n\n"
-	buf += "static void " + fabric_mod_name + "_drop_" + fabric_mod_port + "(struct se_wwn *wwn)\n"
-	buf += "{\n"
-	buf += "	struct " + fabric_mod_name + "_" + fabric_mod_port + " *" + fabric_mod_port + " = container_of(wwn,\n"
-	buf += "				struct " + fabric_mod_name + "_" + fabric_mod_port + ", " + fabric_mod_port + "_wwn);\n"
-	buf += "	kfree(" + fabric_mod_port + ");\n"
-	buf += "}\n\n"
-
-	buf += "static const struct target_core_fabric_ops " + fabric_mod_name + "_ops = {\n"
-	buf += "	.module				= THIS_MODULE,\n"
-	buf += "	.name				= \"" + fabric_mod_name + "\",\n"
-	buf += "	.get_fabric_name		= " + fabric_mod_name + "_get_fabric_name,\n"
-	buf += "	.tpg_get_wwn			= " + fabric_mod_name + "_get_fabric_wwn,\n"
-	buf += "	.tpg_get_tag			= " + fabric_mod_name + "_get_tag,\n"
-	buf += "	.tpg_check_demo_mode		= " + fabric_mod_name + "_check_false,\n"
-	buf += "	.tpg_check_demo_mode_cache	= " + fabric_mod_name + "_check_true,\n"
-	buf += "	.tpg_check_demo_mode_write_protect = " + fabric_mod_name + "_check_true,\n"
-	buf += "	.tpg_check_prod_mode_write_protect = " + fabric_mod_name + "_check_false,\n"
-	buf += "	.tpg_get_inst_index		= " + fabric_mod_name + "_tpg_get_inst_index,\n"
-	buf += "	.release_cmd			= " + fabric_mod_name + "_release_cmd,\n"
-	buf += "	.sess_get_index			= " + fabric_mod_name + "_sess_get_index,\n"
-	buf += "	.sess_get_initiator_sid		= NULL,\n"
-	buf += "	.write_pending			= " + fabric_mod_name + "_write_pending,\n"
-	buf += "	.set_default_node_attributes	= " + fabric_mod_name + "_set_default_node_attrs,\n"
-	buf += "	.get_cmd_state			= " + fabric_mod_name + "_get_cmd_state,\n"
-	buf += "	.queue_data_in			= " + fabric_mod_name + "_queue_data_in,\n"
-	buf += "	.queue_status			= " + fabric_mod_name + "_queue_status,\n"
-	buf += "	.queue_tm_rsp			= " + fabric_mod_name + "_queue_tm_rsp,\n"
-	buf += "	.aborted_task			= " + fabric_mod_name + "_aborted_task,\n"
-	buf += "	/*\n"
-	buf += "	 * Setup function pointers for generic logic in target_core_fabric_configfs.c\n"
-	buf += "	 */\n"
-	buf += "	.fabric_make_wwn		= " + fabric_mod_name + "_make_" + fabric_mod_port + ",\n"
-	buf += "	.fabric_drop_wwn		= " + fabric_mod_name + "_drop_" + fabric_mod_port + ",\n"
-	buf += "	.fabric_make_tpg		= " + fabric_mod_name + "_make_tpg,\n"
-	buf += "	.fabric_drop_tpg		= " + fabric_mod_name + "_drop_tpg,\n"
-	buf += "};\n\n"
-
-	buf += "static int __init " + fabric_mod_name + "_init(void)\n"
-	buf += "{\n"
-	buf += "	return target_register_template(&" + fabric_mod_name + "_ops);\n"
-	buf += "};\n\n"
-
-	buf += "static void __exit " + fabric_mod_name + "_exit(void)\n"
-	buf += "{\n"
-	buf += "	target_unregister_template(&" + fabric_mod_name + "_ops);\n"
-	buf += "};\n\n"
-
-	buf += "MODULE_DESCRIPTION(\"" + fabric_mod_name.upper() + " series fabric driver\");\n"
-	buf += "MODULE_LICENSE(\"GPL\");\n"
-	buf += "module_init(" + fabric_mod_name + "_init);\n"
-	buf += "module_exit(" + fabric_mod_name + "_exit);\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-
-	return
-
-def tcm_mod_scan_fabric_ops(tcm_dir):
-
-	fabric_ops_api = tcm_dir + "include/target/target_core_fabric.h"
-
-	print "Using tcm_mod_scan_fabric_ops: " + fabric_ops_api
-	process_fo = 0;
-
-	p = open(fabric_ops_api, 'r')
-
-	line = p.readline()
-	while line:
-		if process_fo == 0 and re.search('struct target_core_fabric_ops {', line):
-			line = p.readline()
-			continue
-
-		if process_fo == 0:
-			process_fo = 1;
-			line = p.readline()
-			# Search for function pointer
-			if not re.search('\(\*', line):
-				continue
-
-			fabric_ops.append(line.rstrip())
-			continue
-
-		line = p.readline()
-		# Search for function pointer
-		if not re.search('\(\*', line):
-			continue
-
-		fabric_ops.append(line.rstrip())
-
-	p.close()
-	return
-
-def tcm_mod_dump_fabric_ops(proto_ident, fabric_mod_dir_var, fabric_mod_name):
-	buf = ""
-	bufi = ""
-
-	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_fabric.c"
-	print "Writing file: " + f
-
-	p = open(f, 'w')
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	fi = fabric_mod_dir_var + "/" + fabric_mod_name + "_fabric.h"
-	print "Writing file: " + fi
-
-	pi = open(fi, 'w')
-	if not pi:
-		tcm_mod_err("Unable to open file: " + fi)
-
-	buf = "#include <linux/slab.h>\n"
-	buf += "#include <linux/kthread.h>\n"
-	buf += "#include <linux/types.h>\n"
-	buf += "#include <linux/list.h>\n"
-	buf += "#include <linux/types.h>\n"
-	buf += "#include <linux/string.h>\n"
-	buf += "#include <linux/ctype.h>\n"
-	buf += "#include <asm/unaligned.h>\n"
-	buf += "#include <scsi/scsi_common.h>\n"
-	buf += "#include <scsi/scsi_proto.h>\n"
-	buf += "#include <target/target_core_base.h>\n"
-	buf += "#include <target/target_core_fabric.h>\n"
-	buf += "#include \"" + fabric_mod_name + "_base.h\"\n"
-	buf += "#include \"" + fabric_mod_name + "_fabric.h\"\n\n"
-
-	buf += "int " + fabric_mod_name + "_check_true(struct se_portal_group *se_tpg)\n"
-	buf += "{\n"
-	buf += "	return 1;\n"
-	buf += "}\n\n"
-	bufi += "int " + fabric_mod_name + "_check_true(struct se_portal_group *);\n"
-
-	buf += "int " + fabric_mod_name + "_check_false(struct se_portal_group *se_tpg)\n"
-	buf += "{\n"
-	buf += "	return 0;\n"
-	buf += "}\n\n"
-	bufi += "int " + fabric_mod_name + "_check_false(struct se_portal_group *);\n"
-
-	total_fabric_ops = len(fabric_ops)
-	i = 0
-
-	while i < total_fabric_ops:
-		fo = fabric_ops[i]
-		i += 1
-#		print "fabric_ops: " + fo
-
-		if re.search('get_fabric_name', fo):
-			buf += "char *" + fabric_mod_name + "_get_fabric_name(void)\n"
-			buf += "{\n"
-			buf += "	return \"" + fabric_mod_name + "\";\n"
-			buf += "}\n\n"
-			bufi += "char *" + fabric_mod_name + "_get_fabric_name(void);\n"
-			continue
-
-		if re.search('get_wwn', fo):
-			buf += "char *" + fabric_mod_name + "_get_fabric_wwn(struct se_portal_group *se_tpg)\n"
-			buf += "{\n"
-			buf += "	struct " + fabric_mod_name + "_tpg *tpg = container_of(se_tpg,\n"
-			buf += "				struct " + fabric_mod_name + "_tpg, se_tpg);\n"
-			buf += "	struct " + fabric_mod_name + "_" + fabric_mod_port + " *" + fabric_mod_port + " = tpg->" + fabric_mod_port + ";\n\n"
-			buf += "	return &" + fabric_mod_port + "->" + fabric_mod_port + "_name[0];\n"
-			buf += "}\n\n"
-			bufi += "char *" + fabric_mod_name + "_get_fabric_wwn(struct se_portal_group *);\n"
-
-		if re.search('get_tag', fo):
-			buf += "u16 " + fabric_mod_name + "_get_tag(struct se_portal_group *se_tpg)\n"
-			buf += "{\n"
-			buf += "	struct " + fabric_mod_name + "_tpg *tpg = container_of(se_tpg,\n"
-			buf += "				struct " + fabric_mod_name + "_tpg, se_tpg);\n"
-			buf += "	return tpg->" + fabric_mod_port + "_tpgt;\n"
-			buf += "}\n\n"
-			bufi += "u16 " + fabric_mod_name + "_get_tag(struct se_portal_group *);\n"
-
-		if re.search('tpg_get_inst_index\)\(', fo):
-			buf += "u32 " + fabric_mod_name + "_tpg_get_inst_index(struct se_portal_group *se_tpg)\n"
-			buf += "{\n"
-			buf += "	return 1;\n"
-			buf += "}\n\n"
-			bufi += "u32 " + fabric_mod_name + "_tpg_get_inst_index(struct se_portal_group *);\n"
-
-		if re.search('\*release_cmd\)\(', fo):
-			buf += "void " + fabric_mod_name + "_release_cmd(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return;\n"
-			buf += "}\n\n"
-			bufi += "void " + fabric_mod_name + "_release_cmd(struct se_cmd *);\n"
-
-		if re.search('sess_get_index\)\(', fo):
-			buf += "u32 " + fabric_mod_name + "_sess_get_index(struct se_session *se_sess)\n"
-			buf += "{\n"
-			buf += "	return 0;\n"
-			buf += "}\n\n"
-			bufi += "u32 " + fabric_mod_name + "_sess_get_index(struct se_session *);\n"
-
-		if re.search('write_pending\)\(', fo):
-			buf += "int " + fabric_mod_name + "_write_pending(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return 0;\n"
-			buf += "}\n\n"
-			bufi += "int " + fabric_mod_name + "_write_pending(struct se_cmd *);\n"
-
-		if re.search('set_default_node_attributes\)\(', fo):
-			buf += "void " + fabric_mod_name + "_set_default_node_attrs(struct se_node_acl *nacl)\n"
-			buf += "{\n"
-			buf += "	return;\n"
-			buf += "}\n\n"
-			bufi += "void " + fabric_mod_name + "_set_default_node_attrs(struct se_node_acl *);\n"
-
-		if re.search('get_cmd_state\)\(', fo):
-			buf += "int " + fabric_mod_name + "_get_cmd_state(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return 0;\n"
-			buf += "}\n\n"
-			bufi += "int " + fabric_mod_name + "_get_cmd_state(struct se_cmd *);\n"
-
-		if re.search('queue_data_in\)\(', fo):
-			buf += "int " + fabric_mod_name + "_queue_data_in(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return 0;\n"
-			buf += "}\n\n"
-			bufi += "int " + fabric_mod_name + "_queue_data_in(struct se_cmd *);\n"
-
-		if re.search('queue_status\)\(', fo):
-			buf += "int " + fabric_mod_name + "_queue_status(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return 0;\n"
-			buf += "}\n\n"
-			bufi += "int " + fabric_mod_name + "_queue_status(struct se_cmd *);\n"
-
-		if re.search('queue_tm_rsp\)\(', fo):
-			buf += "void " + fabric_mod_name + "_queue_tm_rsp(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return;\n"
-			buf += "}\n\n"
-			bufi += "void " + fabric_mod_name + "_queue_tm_rsp(struct se_cmd *);\n"
-
-		if re.search('aborted_task\)\(', fo):
-			buf += "void " + fabric_mod_name + "_aborted_task(struct se_cmd *se_cmd)\n"
-			buf += "{\n"
-			buf += "	return;\n"
-			buf += "}\n\n"
-			bufi += "void " + fabric_mod_name + "_aborted_task(struct se_cmd *);\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-
-	ret = pi.write(bufi)
-	if ret:
-		tcm_mod_err("Unable to write fi: " + fi)
-
-	pi.close()
-	return
-
-def tcm_mod_build_kbuild(fabric_mod_dir_var, fabric_mod_name):
-
-	buf = ""
-	f = fabric_mod_dir_var + "/Makefile"
-	print "Writing file: " + f
-
-	p = open(f, 'w')
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	buf += fabric_mod_name + "-objs			:= " + fabric_mod_name + "_fabric.o \\\n"
-	buf += "					   " + fabric_mod_name + "_configfs.o\n"
-	buf += "obj-$(CONFIG_" + fabric_mod_name.upper() + ")		+= " + fabric_mod_name + ".o\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-	return
-
-def tcm_mod_build_kconfig(fabric_mod_dir_var, fabric_mod_name):
-
-	buf = ""
-	f = fabric_mod_dir_var + "/Kconfig"
-	print "Writing file: " + f
-
-	p = open(f, 'w')
-	if not p:
-		tcm_mod_err("Unable to open file: " + f)
-
-	buf = "config " + fabric_mod_name.upper() + "\n"
-	buf += "	tristate \"" + fabric_mod_name.upper() + " fabric module\"\n"
-	buf += "	depends on TARGET_CORE && CONFIGFS_FS\n"
-	buf += "	default n\n"
-	buf += "	help\n"
-	buf += "	  Say Y here to enable the " + fabric_mod_name.upper() + " fabric module\n"
-
-	ret = p.write(buf)
-	if ret:
-		tcm_mod_err("Unable to write f: " + f)
-
-	p.close()
-	return
-
-def tcm_mod_add_kbuild(tcm_dir, fabric_mod_name):
-	buf = "obj-$(CONFIG_" + fabric_mod_name.upper() + ")	+= " + fabric_mod_name.lower() + "/\n"
-	kbuild = tcm_dir + "/drivers/target/Makefile"
-
-	f = open(kbuild, 'a')
-	f.write(buf)
-	f.close()
-	return
-
-def tcm_mod_add_kconfig(tcm_dir, fabric_mod_name):
-	buf = "source \"drivers/target/" + fabric_mod_name.lower() + "/Kconfig\"\n"
-	kconfig = tcm_dir + "/drivers/target/Kconfig"
-
-	f = open(kconfig, 'a')
-	f.write(buf)
-	f.close()
-	return
-
-def main(modname, proto_ident):
-#	proto_ident = "FC"
-#	proto_ident = "SAS"
-#	proto_ident = "iSCSI"
-
-	tcm_dir = os.getcwd();
-	tcm_dir += "/../../"
-	print "tcm_dir: " + tcm_dir
-	fabric_mod_name = modname
-	fabric_mod_dir = tcm_dir + "drivers/target/" + fabric_mod_name
-	print "Set fabric_mod_name: " + fabric_mod_name
-	print "Set fabric_mod_dir: " + fabric_mod_dir
-	print "Using proto_ident: " + proto_ident
-
-	if proto_ident != "FC" and proto_ident != "SAS" and proto_ident != "iSCSI":
-		print "Unsupported proto_ident: " + proto_ident
-		sys.exit(1)
-
-	ret = tcm_mod_create_module_subdir(fabric_mod_dir)
-	if ret:
-		print "tcm_mod_create_module_subdir() failed because module already exists!"
-		sys.exit(1)
-
-	tcm_mod_build_base_includes(proto_ident, fabric_mod_dir, fabric_mod_name)
-	tcm_mod_scan_fabric_ops(tcm_dir)
-	tcm_mod_dump_fabric_ops(proto_ident, fabric_mod_dir, fabric_mod_name)
-	tcm_mod_build_configfs(proto_ident, fabric_mod_dir, fabric_mod_name)
-	tcm_mod_build_kbuild(fabric_mod_dir, fabric_mod_name)
-	tcm_mod_build_kconfig(fabric_mod_dir, fabric_mod_name)
-
-	input = raw_input("Would you like to add " + fabric_mod_name + " to drivers/target/Makefile..? [yes,no]: ")
-	if input == "yes" or input == "y":
-		tcm_mod_add_kbuild(tcm_dir, fabric_mod_name)
-
-	input = raw_input("Would you like to add " + fabric_mod_name + " to drivers/target/Kconfig..? [yes,no]: ")
-	if input == "yes" or input == "y":
-		tcm_mod_add_kconfig(tcm_dir, fabric_mod_name)
-
-	return
-
-parser = optparse.OptionParser()
-parser.add_option('-m', '--modulename', help='Module name', dest='modname',
-		action='store', nargs=1, type='string')
-parser.add_option('-p', '--protoident', help='Protocol Ident', dest='protoident',
-		action='store', nargs=1, type='string')
-
-(opts, args) = parser.parse_args()
-
-mandatories = ['modname', 'protoident']
-for m in mandatories:
-	if not opts.__dict__[m]:
-		print "mandatory option is missing\n"
-		parser.print_help()
-		exit(-1)
-
-if __name__ == "__main__":
-
-	main(str(opts.modname), opts.protoident)
-- 
2.39.3


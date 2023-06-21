Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB96737D10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFUHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjFUHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:40:10 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B1210B;
        Wed, 21 Jun 2023 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687333181;
        bh=UqApaAasoEBoMc0dxYV4OnhSyfSEoo7sl5sXBYzYfds=;
        h=From:To:Cc:Subject:Date;
        b=WCV6uW5r4UcO67rokvNvBOtVGkznnBl2vKOKD9816+y1dwNO3igJQAVEdGBlMlbKF
         l53y1EK3mIeXTpQ1slXy9NczFBlxBw75rn1KGTmbGZaFCLNz9ZGQG9yeA77Q1rvYUm
         9QMkudbFYgWKpqqUm4PvWPo4LJxs6JrFT+OhCs3s=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 8603282D; Wed, 21 Jun 2023 15:33:32 +0800
X-QQ-mid: xmsmtpt1687332812t2jwfvdiw
Message-ID: <tencent_F3895D0EA868BCCE8C56221619BC093D660A@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQjtOqTDlIV94yDrHmkwsY56bVPolYhQ89M8b1VZfbz8XhMultN9
         2xBjYkXEzUFu76fKZNAsQOlL8OhtaDzw/sK9uvnSIVwTtg7Dx8NUosziNzoyaOw8gYYaOlIqX/HB
         tSmmvm6MTN8NPtbcvZjVPFcU92BQhq7snXgooRbpUTtFy/9JrV9bBMjb/dehvF0b1fY1sQ2Mgp9b
         Uoza7fQFr4kIVOgrXEJbl65uLjvZLSf1jtisvIeuNw18mt1Pbxj1OdU0hUSRh0JRwN5z5x1ISnAU
         mjQTNrLTl+kaWF0v+Oev4SmZM8m+0A1pMVAK3TuaL3AfVfRT/XE0eHyiqChpkaUNji0I7u7wsF4T
         GCGOsQ4C5Dhvl2bM3Troc+JHMoVNfhZNxM4tS5RkUgS/6jAy9p3xiSuEG5QMTvsSIeC3pSCgL3pL
         RRDjpJrjfcx4/KXow7luA4Kz3QOIjTDw8GGanLwNP9t3oDYD+MynjOO/JAMX5QqTiBPpK8o6InZO
         vkgrqv/i44HBKJ3Z03sPIk40UDLpV2kgEI4zII1343ldpMK7N4nYM9J1PMVxnxqeUnF2l/ZraqE1
         FfjUUrk/fz3vXOnj1LR4tSIQ6pv3kedIh701tWYZxf4dKygkL9ecnUjBKmrPccHJQS19K52AYdnF
         4lubXf+EvnSV6dGyMSp22EYwYrij7lrDPTHbfAbSuECnyf3HBOFiMyvBFvK1cDPWXzFFnsz1a2UR
         rMh511MudjQlHnMu28jI1Cpt/OYCh+iPRMR1Erpl81OYcJtT7ip7oKPJ3ABvf6zyhkovuFi+KcCb
         xNXEre3wX+paOww/KokfN1XlNf+8Jl+xXvWCDnNhxzno6xIYTQnU16GdTN2385vWCkmXbKf7LX6/
         viViVS3f1ergI3BwpSx6vvyoWw5JengErO1EG+GnZTwaC7TvNTwtIWuaSvlt1/WOwTktiLE6TGMR
         oOwBY5rQc8eJ8Z6EXc/bk0uJ/AA3S/NcbwKdI6mq16FaXsKBdvtw==
X-QQ-XMRINFO: NjIWXnpjOUTzjNa+72IgnqZv1lPwKoxBEg==
From:   Rong Tao <rtoax@foxmail.com>
To:     martin.petersen@oracle.com
Cc:     rongtao@cestc.cn, Jonathan Corbet <corbet@lwn.net>,
        linux-scsi@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        target-devel@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: target: Convert tcm_mod_builder.py print syntax to python3
Date:   Wed, 21 Jun 2023 15:33:30 +0800
X-OQ-MSGID: <20230621073331.85873-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Convert the tcm_mod_builder.py file to python3 and fix indentation.

Error:

    $ ./tcm_mod_builder.py
    File "/home/sda/git-repos/linux/Documentation/target/./tcm_mod_builder.py", line 23
        print msg
            ^
    SyntaxError: Missing parentheses in call to 'print'. Did you mean print(msg)?

    $ ./tcm_mod_builder.py
    File "/home/sda/git-repos/linux/Documentation/target/./tcm_mod_builder.py", line 186
        p = open(f, 'w');
    TabError: inconsistent use of tabs and spaces in indentation

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 Documentation/target/tcm_mod_builder.py | 44 ++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/target/tcm_mod_builder.py b/Documentation/target/tcm_mod_builder.py
index 54492aa813b9..e2ef72925de3 100755
--- a/Documentation/target/tcm_mod_builder.py
+++ b/Documentation/target/tcm_mod_builder.py
@@ -20,7 +20,7 @@ fabric_mod_port = ""
 fabric_mod_init_port = ""
 
 def tcm_mod_err(msg):
-	print msg
+	print(msg)
 	sys.exit(1)
 
 def tcm_mod_create_module_subdir(fabric_mod_dir_var):
@@ -28,7 +28,7 @@ def tcm_mod_create_module_subdir(fabric_mod_dir_var):
 	if os.path.isdir(fabric_mod_dir_var) == True:
 		return 1
 
-	print "Creating fabric_mod_dir: " + fabric_mod_dir_var
+	print("Creating fabric_mod_dir: " + fabric_mod_dir_var)
 	ret = os.mkdir(fabric_mod_dir_var)
 	if ret:
 		tcm_mod_err("Unable to mkdir " + fabric_mod_dir_var)
@@ -41,7 +41,7 @@ def tcm_mod_build_FC_include(fabric_mod_dir_var, fabric_mod_name):
 	buf = ""
 
 	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w');
 	if not p:
@@ -85,7 +85,7 @@ def tcm_mod_build_SAS_include(fabric_mod_dir_var, fabric_mod_name):
 	buf = ""
 
 	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w');
 	if not p:
@@ -128,7 +128,7 @@ def tcm_mod_build_iSCSI_include(fabric_mod_dir_var, fabric_mod_name):
 	buf = ""
 
 	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_base.h"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w');
 	if not p:
@@ -172,7 +172,7 @@ def tcm_mod_build_base_includes(proto_ident, fabric_mod_dir_val, fabric_mod_name
 	elif proto_ident == "iSCSI":
 		tcm_mod_build_iSCSI_include(fabric_mod_dir_val, fabric_mod_name)
 	else:
-		print "Unsupported proto_ident: " + proto_ident
+		print("Unsupported proto_ident: " + proto_ident)
 		sys.exit(1)
 
 	return
@@ -181,11 +181,11 @@ def tcm_mod_build_configfs(proto_ident, fabric_mod_dir_var, fabric_mod_name):
 	buf = ""
 
 	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_configfs.c"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
-        p = open(f, 'w');
-        if not p:
-                tcm_mod_err("Unable to open file: " + f)
+	p = open(f, 'w');
+	if not p:
+		tcm_mod_err("Unable to open file: " + f)
 
 	buf = "#include <linux/module.h>\n"
 	buf += "#include <linux/moduleparam.h>\n"
@@ -339,7 +339,7 @@ def tcm_mod_scan_fabric_ops(tcm_dir):
 
 	fabric_ops_api = tcm_dir + "include/target/target_core_fabric.h"
 
-	print "Using tcm_mod_scan_fabric_ops: " + fabric_ops_api
+	print("Using tcm_mod_scan_fabric_ops: " + fabric_ops_api)
 	process_fo = 0;
 
 	p = open(fabric_ops_api, 'r')
@@ -375,14 +375,14 @@ def tcm_mod_dump_fabric_ops(proto_ident, fabric_mod_dir_var, fabric_mod_name):
 	bufi = ""
 
 	f = fabric_mod_dir_var + "/" + fabric_mod_name + "_fabric.c"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w')
 	if not p:
 		tcm_mod_err("Unable to open file: " + f)
 
 	fi = fabric_mod_dir_var + "/" + fabric_mod_name + "_fabric.h"
-	print "Writing file: " + fi
+	print("Writing file: " + fi)
 
 	pi = open(fi, 'w')
 	if not pi:
@@ -537,7 +537,7 @@ def tcm_mod_build_kbuild(fabric_mod_dir_var, fabric_mod_name):
 
 	buf = ""
 	f = fabric_mod_dir_var + "/Makefile"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w')
 	if not p:
@@ -558,7 +558,7 @@ def tcm_mod_build_kconfig(fabric_mod_dir_var, fabric_mod_name):
 
 	buf = ""
 	f = fabric_mod_dir_var + "/Kconfig"
-	print "Writing file: " + f
+	print("Writing file: " + f)
 
 	p = open(f, 'w')
 	if not p:
@@ -603,20 +603,20 @@ def main(modname, proto_ident):
 
 	tcm_dir = os.getcwd();
 	tcm_dir += "/../../"
-	print "tcm_dir: " + tcm_dir
+	print("tcm_dir: " + tcm_dir)
 	fabric_mod_name = modname
 	fabric_mod_dir = tcm_dir + "drivers/target/" + fabric_mod_name
-	print "Set fabric_mod_name: " + fabric_mod_name
-	print "Set fabric_mod_dir: " + fabric_mod_dir
-	print "Using proto_ident: " + proto_ident
+	print("Set fabric_mod_name: " + fabric_mod_name)
+	print("Set fabric_mod_dir: " + fabric_mod_dir)
+	print("Using proto_ident: " + proto_ident)
 
 	if proto_ident != "FC" and proto_ident != "SAS" and proto_ident != "iSCSI":
-		print "Unsupported proto_ident: " + proto_ident
+		print("Unsupported proto_ident: " + proto_ident)
 		sys.exit(1)
 
 	ret = tcm_mod_create_module_subdir(fabric_mod_dir)
 	if ret:
-		print "tcm_mod_create_module_subdir() failed because module already exists!"
+		print("tcm_mod_create_module_subdir() failed because module already exists!")
 		sys.exit(1)
 
 	tcm_mod_build_base_includes(proto_ident, fabric_mod_dir, fabric_mod_name)
@@ -647,7 +647,7 @@ parser.add_option('-p', '--protoident', help='Protocol Ident', dest='protoident'
 mandatories = ['modname', 'protoident']
 for m in mandatories:
 	if not opts.__dict__[m]:
-		print "mandatory option is missing\n"
+		print("mandatory option is missing\n")
 		parser.print_help()
 		exit(-1)
 
-- 
2.39.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBA5EEBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiI2CdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI2CdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:12 -0400
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE6124756
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8964; q=dns/txt; s=iport;
  t=1664418789; x=1665628389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ie6EtdAViAiALCeFYxNqsCsTGUdiUZbe/6PrULxlkAo=;
  b=LpXhLVMHA0rcrT7kHek2En6NFLLUO9HWBjPf9L4Mvs9cvw73kIx1sCRR
   iw9Zakeu/8p9jzohy+iGVVYmbB7hl7kRV7I01a5ELx3sWjQ76uiVAvy40
   ddQrosDMWYoO5L7IM9EyDcLBSJN7CW1IbS6i15AYABtcrI7HxxRgptvzJ
   Y=;
IronPort-Data: =?us-ascii?q?A9a23=3AGR8q6KwBLHetJ1Wwz996t+dyxyrEfRIJ4+Muj?=
 =?us-ascii?q?C+fZmUNrF6WrkUDzzBOD2CGa6vca2rwKI10OYm+8BxQ6sTTmNI1GgA/+FhgH?=
 =?us-ascii?q?ilAwSbn6Xt1DatR0xt/paQvdWo/hyklQoSGfZlcokP0/E/3aOC89CckjMlke?=
 =?us-ascii?q?5KlYAL6EnEpLeNbYH9JZSJLw4bVs6Yw6TSLK1rlVeDa+6UzDGSYNwtcaQr43?=
 =?us-ascii?q?U4sRCRH55wesBtA1rA3iGsiUFX2zxH5B7pHTU29wueRf2VaIgK6b76rILCR5?=
 =?us-ascii?q?GjV+VImDcmo1+a9eUwRSbmUNg+L4pZUc/H92V4Z+WpjieBiaKZ0hUR/011lm?=
 =?us-ascii?q?/h9wdNMuJivQC8iP7bHn6IWVBww/yRWZPUbo+eXeyLu6aR/yGWDKRMA2c5GC?=
 =?us-ascii?q?EAwIJ1d+ettB2xK3eIXJSpLbR2Zge+yhrWhRYFEnckqKo/iOo8SoGpnyxnCA?=
 =?us-ascii?q?P0hB5vERs3i7NxA2R80h8ZTDbPQYNcfZTNzbRPGJRpVNT8/BJs4neqsrnb+d?=
 =?us-ascii?q?iVVrF+LpKE3pXPaykl/yrHrO9vOcdvMTswTg13wjnjB9WTRARwAMtGbjz2f/?=
 =?us-ascii?q?RqEje/VnDjnX5oSGfu8++RtkXWY3WMJDwAOE1amydGmi0q6c9FSMUoZ/mwpt?=
 =?us-ascii?q?6dayaABZrERRDWiq3KC+xUbQdcVQ6sx6RqGzezf5APxO4TNdRYZAPROiSP8b?=
 =?us-ascii?q?WVCOoe1ou7U?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5cHFxaBVTlETZYblHemX55DYdb4zR+YMi2?=
 =?us-ascii?q?TDGXocdfUzSL39qynAppomPHPP4gr5HUtQ+uxoW5PwJE80i6QV3WB5B97LNz?=
 =?us-ascii?q?UO+lHYTr2KhrGM/9SPIUDDH8dmpMBdmtBFaOEZyTNB/L/HCM7SKadH/OW6?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BZAAAHbIJi/5BdJa1aHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQGBfQUBAQsBgiqBSz1DlVmBFptRgXwLAQEBD0IEAQGFAgKFPgI?=
 =?us-ascii?q?lNgcOAQIEAQEBEgEBBQEBAQIBBwSBCROFdYZDBicLAUYQUVcGARKCfYMYq1a?=
 =?us-ascii?q?BeTKBAYgZgWUUgSgBiUOFHCccgUlEgRWCc3WKfwSWHgMJBgcFgT4SgSFxAQg?=
 =?us-ascii?q?GBgcKBTIGAgwYFAQCExJNBgwSAhMMCgYWDg40EhkMDwMSAxEBBwILEggVLAg?=
 =?us-ascii?q?DAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDEQQ?=
 =?us-ascii?q?DExgLFggQBAYDCS8NKAsDBQ8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EIx0?=
 =?us-ascii?q?DAwUmAwICGwcCAgMCBhcGAgIZJzEKKA0IBAgEGAQeJQ4FBQIHMQUELwIeBAU?=
 =?us-ascii?q?GEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIxYGLBEFBhYDJlIGIh2?=
 =?us-ascii?q?WcGsFAQF7E0OBQ2WST44PghaeKoNWgUOeLRoxg3WMPpgklmYgogU0hE6BaAM?=
 =?us-ascii?q?ygVkzGggbFYMjURkPjikDFo1xAVwkMTsCBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1053082290"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:08 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yr007711;
        Thu, 29 Sep 2022 02:33:07 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] scripts: insert-sys-cert: add command line insert capability
Date:   Wed, 28 Sep 2022 19:32:48 -0700
Message-Id: <20220929023301.3344694-3-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds changes to the insert-sys-cert tool to allow updating
the cmdline_prepend and cmdline_append symbols in addition to
adding certificates.

Updating the cmdline symbols was tested on a PVH virtual machine
with a vmlinux, and with a bzImage which was repackaged on x86.

This commit intentionally keeps the tool filename the same to allow
the changes to be seen more easily. The next commit will change
the name of the tool.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 scripts/insert-sys-cert.c | 241 +++++++++++++++++++++++++++-----------
 1 file changed, 170 insertions(+), 71 deletions(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..77d3306cfbfb 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -30,6 +30,9 @@
 #define USED_SYM  "system_extra_cert_used"
 #define LSIZE_SYM "system_certificate_list_size"
 
+#define CMDLINE_APPEND "cmdline_append"
+#define CMDLINE_PREPEND "cmdline_prepend"
+
 #define info(format, args...) fprintf(stderr, "INFO:    " format, ## args)
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
@@ -267,95 +270,46 @@ static void print_sym(Elf_Ehdr *hdr, struct sym *s)
 
 static void print_usage(char *e)
 {
-	printf("Usage %s [-s <System.map>] -b <vmlinux> -c <certfile>\n", e);
+	printf("Usage %s [-s <System.map>] -b <vmlinux> [ -c <certfile> | -p <command line prepend> | -a <command line append> ]-\n", e);
 }
 
-int main(int argc, char **argv)
+static char *cmdline_prepend, *cmdline_append;
+static char *system_map_file;
+static char *cert_file;
+static char *cli_name;
+
+static int insert_certificate(Elf_Ehdr *hdr)
 {
-	char *system_map_file = NULL;
-	char *vmlinux_file = NULL;
-	char *cert_file = NULL;
-	int vmlinux_size;
+	struct sym cert_sym, lsize_sym, used_sym;
+	Elf_Shdr *symtab = NULL;
+	unsigned long *lsize;
+	FILE *system_map;
 	int cert_size;
-	Elf_Ehdr *hdr;
 	char *cert;
-	FILE *system_map;
-	unsigned long *lsize;
 	int *used;
-	int opt;
-	Elf_Shdr *symtab = NULL;
-	struct sym cert_sym, lsize_sym, used_sym;
-
-	while ((opt = getopt(argc, argv, "b:c:s:")) != -1) {
-		switch (opt) {
-		case 's':
-			system_map_file = optarg;
-			break;
-		case 'b':
-			vmlinux_file = optarg;
-			break;
-		case 'c':
-			cert_file = optarg;
-			break;
-		default:
-			break;
-		}
-	}
 
-	if (!vmlinux_file || !cert_file) {
-		print_usage(argv[0]);
-		exit(EXIT_FAILURE);
+	if (!cert_file) {
+		print_usage(cli_name);
+		return EXIT_FAILURE;
 	}
 
 	cert = read_file(cert_file, &cert_size);
 	if (!cert)
-		exit(EXIT_FAILURE);
-
-	hdr = map_file(vmlinux_file, &vmlinux_size);
-	if (!hdr)
-		exit(EXIT_FAILURE);
-
-	if (vmlinux_size < sizeof(*hdr)) {
-		err("Invalid ELF file.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if ((hdr->e_ident[EI_MAG0] != ELFMAG0) ||
-	    (hdr->e_ident[EI_MAG1] != ELFMAG1) ||
-	    (hdr->e_ident[EI_MAG2] != ELFMAG2) ||
-	    (hdr->e_ident[EI_MAG3] != ELFMAG3)) {
-		err("Invalid ELF magic.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if (hdr->e_ident[EI_CLASS] != CURRENT_ELFCLASS) {
-		err("ELF class mismatch.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if (hdr->e_ident[EI_DATA] != endianness()) {
-		err("ELF endian mismatch.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if (hdr->e_shoff > vmlinux_size) {
-		err("Could not find section header.\n");
-		exit(EXIT_FAILURE);
-	}
+		return EXIT_FAILURE;
 
 	symtab = get_symbol_table(hdr);
 	if (!symtab) {
 		warn("Could not find the symbol table.\n");
 		if (!system_map_file) {
 			err("Please provide a System.map file.\n");
-			print_usage(argv[0]);
-			exit(EXIT_FAILURE);
+			print_usage(cli_name);
+			return EXIT_FAILURE;
 		}
 
 		system_map = fopen(system_map_file, "r");
 		if (!system_map) {
 			perror(system_map_file);
-			exit(EXIT_FAILURE);
+			return EXIT_FAILURE;
 		}
 		get_symbol_from_map(hdr, system_map, CERT_SYM, &cert_sym);
 		get_symbol_from_map(hdr, system_map, USED_SYM, &used_sym);
@@ -371,7 +325,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!cert_sym.offset || !lsize_sym.offset || !used_sym.offset)
-		exit(EXIT_FAILURE);
+		return EXIT_FAILURE;
 
 	print_sym(hdr, &cert_sym);
 	print_sym(hdr, &used_sym);
@@ -382,14 +336,14 @@ int main(int argc, char **argv)
 
 	if (cert_sym.size < cert_size) {
 		err("Certificate is larger than the reserved area!\n");
-		exit(EXIT_FAILURE);
+		return EXIT_FAILURE;
 	}
 
 	/* If the existing cert is the same, don't overwrite */
 	if (cert_size == *used &&
 	    strncmp(cert_sym.content, cert, cert_size) == 0) {
 		warn("Certificate was already inserted.\n");
-		exit(EXIT_SUCCESS);
+		return EXIT_SUCCESS;
 	}
 
 	if (*used > 0)
@@ -406,5 +360,150 @@ int main(int argc, char **argv)
 						cert_sym.address);
 	info("Used %d bytes out of %d bytes reserved.\n", *used,
 						 cert_sym.size);
-	exit(EXIT_SUCCESS);
+	return EXIT_SUCCESS;
+}
+
+static int insert_cmdline(Elf_Ehdr *hdr)
+{
+	struct sym cmdline_prepend_sym, cmdline_append_sym;
+	Elf_Shdr *symtab = NULL;
+	FILE *system_map;
+
+	symtab = get_symbol_table(hdr);
+	if (!symtab) {
+		warn("Could not find the symbol table.\n");
+		if (!system_map_file) {
+			err("Please provide a System.map file.\n");
+			print_usage(cli_name);
+			return EXIT_FAILURE;
+		}
+
+		system_map = fopen(system_map_file, "r");
+		if (!system_map) {
+			perror(system_map_file);
+			return EXIT_FAILURE;
+		}
+		get_symbol_from_map(hdr, system_map, CMDLINE_PREPEND, &cmdline_prepend_sym);
+		get_symbol_from_map(hdr, system_map, CMDLINE_APPEND, &cmdline_append_sym);
+	} else {
+		info("Symbol table found.\n");
+		if (system_map_file)
+			warn("System.map is ignored.\n");
+		get_symbol_from_table(hdr, symtab, CMDLINE_PREPEND, &cmdline_prepend_sym);
+		get_symbol_from_table(hdr, symtab, CMDLINE_APPEND, &cmdline_append_sym);
+	}
+
+	print_sym(hdr, &cmdline_prepend_sym);
+	print_sym(hdr, &cmdline_append_sym);
+
+
+	if (cmdline_prepend) {
+		if ((strlen(cmdline_prepend) + 1) > cmdline_prepend_sym.size) {
+			err("cmdline prepend is larger than the reserved area!\n");
+			return EXIT_FAILURE;
+		}
+
+		memcpy(cmdline_prepend_sym.content, cmdline_prepend, strlen(cmdline_prepend) + 1);
+		if ((strlen(cmdline_prepend) + 1) < cmdline_prepend_sym.size)
+			memset(cmdline_prepend_sym.content + strlen(cmdline_prepend) + 1,
+				0, cmdline_prepend_sym.size - (strlen(cmdline_prepend) + 1));
+
+		info("Inserted cmdline prepend of \"%s\" into vmlinux.\n", cmdline_prepend);
+
+	}
+	if (cmdline_append) {
+		if ((strlen(cmdline_append) + 1) > cmdline_append_sym.size) {
+			err("cmdline append is larger than the reserved area!\n");
+			return EXIT_FAILURE;
+		}
+
+		memcpy(cmdline_append_sym.content, cmdline_append, strlen(cmdline_append) + 1);
+		if ((strlen(cmdline_append) + 1) < cmdline_append_sym.size)
+			memset(cmdline_append_sym.content + strlen(cmdline_append) + 1,
+				0, cmdline_append_sym.size - (strlen(cmdline_append) + 1));
+
+		info("Inserted cmdline append of \"%s\" into vmlinux.\n", cmdline_append);
+
+	}
+	return EXIT_SUCCESS;
+}
+
+int main(int argc, char **argv)
+{
+	char *vmlinux_file = NULL;
+	int vmlinux_size;
+	Elf_Ehdr *hdr;
+	int opt;
+	int ret = EXIT_SUCCESS;
+
+	while ((opt = getopt(argc, argv, "b:c:s:p:a:")) != -1) {
+		switch (opt) {
+		case 's':
+			system_map_file = optarg;
+			break;
+		case 'b':
+			vmlinux_file = optarg;
+			break;
+		case 'c':
+			cert_file = optarg;
+			break;
+		case 'p':
+			cmdline_prepend = optarg;
+			break;
+		case 'a':
+			cmdline_append = optarg;
+			break;
+		default:
+			break;
+		}
+	}
+
+	cli_name = argv[0];
+
+	if (!vmlinux_file) {
+		print_usage(cli_name);
+		exit(EXIT_FAILURE);
+	}
+
+	hdr = map_file(vmlinux_file, &vmlinux_size);
+	if (!hdr)
+		exit(EXIT_FAILURE);
+
+	if (vmlinux_size < sizeof(*hdr)) {
+		err("Invalid ELF file.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if ((hdr->e_ident[EI_MAG0] != ELFMAG0) ||
+	    (hdr->e_ident[EI_MAG1] != ELFMAG1) ||
+	    (hdr->e_ident[EI_MAG2] != ELFMAG2) ||
+	    (hdr->e_ident[EI_MAG3] != ELFMAG3)) {
+		err("Invalid ELF magic.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (hdr->e_ident[EI_CLASS] != CURRENT_ELFCLASS) {
+		err("ELF class mismatch.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (hdr->e_ident[EI_DATA] != endianness()) {
+		err("ELF endian mismatch.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (hdr->e_shoff > vmlinux_size) {
+		err("Could not find section header.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (cert_file) {
+		ret = insert_certificate(hdr);
+		printf("%s\n", cert_file);
+	}
+
+	if (cmdline_append || cmdline_prepend)
+		ret = insert_cmdline(hdr);
+
+	exit(ret);
 }
-- 
2.25.1


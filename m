Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C017120F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbjEZHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEZHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:30:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3C116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:30:24 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230526073022epoutp01f47b85de15a23f5e27bee2a5296431ca~ioP3FRsCL2499024990epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:30:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230526073022epoutp01f47b85de15a23f5e27bee2a5296431ca~ioP3FRsCL2499024990epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685086222;
        bh=otdeJumuZeizLE5XvOGATbymMIixUp3P2LEWcJSe6UU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KFMcKb8EmQ0WekGkeXTTWmU86zyuAGMfOdhZ4FSw11YC2zUQMZPtQXcmOnEnASxUL
         mphxkeDPDXFSmeLAbNi9blBziUOOdeZbR2G1LkiBKgv3KntVyHp+k5obcwq8zZ8sE3
         Q2dm+NH0+SoSjzw5Cn0zmEJ4IDp5qOkac5Ae4K+s=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230526073021epcas5p354caed83c7d3f675b8fc8145d2dc333e~ioP2Nm66I2024320243epcas5p37;
        Fri, 26 May 2023 07:30:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.43.04567.D0060746; Fri, 26 May 2023 16:30:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230526072134epcas5p12d0971c15890541639b4d2d85db84b43~ioILYJQtE0992309923epcas5p1i;
        Fri, 26 May 2023 07:21:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230526072134epsmtrp1325f4cdf2cade3c0a54fbc69741f77b2~ioILXR53j2203722037epsmtrp1M;
        Fri, 26 May 2023 07:21:34 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-d7-6470600d2ada
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.37.27706.EFD50746; Fri, 26 May 2023 16:21:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230526072131epsmtip117493cd21f69aa80cb0ecff28945beb5~ioIInLCdJ0355703557epsmtip1B;
        Fri, 26 May 2023 07:21:31 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     cai@lca.pw, mcgrof@kernel.org, thunder.leizhen@huawei.com,
        vincenzopalazzodev@gmail.com, wedsonaf@google.com,
        pmladek@suse.com, ojeda@kernel.org, peterz@infradead.org,
        keescook@chromium.org, alan.maguire@oracle.com,
        stephen.s.brennan@oracle.com, samitolvanen@google.com
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] kallsyms: remove unsed API lookup_symbol_attrs
Date:   Fri, 26 May 2023 12:51:23 +0530
Message-Id: <20230526072123.807160-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7bCmhi5vQkGKwZwN4hY3DjWyWLzc7GFx
        pjvX4vKuOWwWDbO/s1ocnt/GYnFjwlNGi5XzlzNaHO89wGTx//FXVoulK96yWvw9cpDJ4smv
        T2wWh07OZbToOxtk0bF4JaODgMfshossHjtn3WX3WLCp1KPlyFtWj80rtDw2repk83izei6r
        x8ent1g8+rasYvRYv+Uqi8fnTXIB3FFcNimpOZllqUX6dglcGSu37GYsOKNYsXHqfdYGxsnS
        XYycHBICJhKHvj5i7WLk4hAS2M0osWL/diYI5xOjxLrTN1ggnG+MEu9+72DsYuQAa7l4LQIi
        vpdR4lPPUTYI5wujxOzvb1lB5rIJ6Ems2rUHrFtEYCaTxKUL89hBHGaBRkaJib0rmECqhAWc
        JV6efM8GYrMIqEqcezCHGcTmFbCV+PX2ERvEhfISMy99Z4eIC0qcnPmEBcRmBoo3b53NDDJU
        QmAPh8SnDYtZIBpcJDbv62OGsIUlXh3fwg5hS0m87G9jh/ihXGLrhHqI3hZGif1zpkAts5d4
        cnEhK0gNs4CmxPpd+hBhWYmpp9YxQezlk+j9/YQJIs4rsWMejK0q0XJzAyuELS3x+eNHqHM8
        JB7eeQVmCwnEStxftZRxAqP8LCTvzELyziyEzQsYmVcxSqYWFOempxabFhjmpZbrFSfmFpfm
        pesl5+duYgQnOi3PHYx3H3zQO8TIxMF4iFGCg1lJhHdDTn6KEG9KYmVValF+fFFpTmrxIUZp
        DhYlcV5125PJQgLpiSWp2ampBalFMFkmDk6pBibPQ8z9dZUq/9ZeT5WRrF89ZZXe/YVrzydc
        WWfTtd999/o8hiMH+G+Eus0084rhWlD8s7z2W8qECZIPXA4V1IVHGBYffvRJxmd6zpwTunYq
        m/uXr90mn6X4cOkyj78iQizRvI2f414JTFQvW6oWk/DF/9CEA3HvpyV9352htCjrmrnddO9J
        2Rzz3jy3vxrEdF0urOet7Idfoj2K/atiOQRb3h0qjdDcz7xWR271N54lzc9dwzsilWoP/3BU
        Pfn39T6L08s07/1Ok9CpcQpvD7jbzFB/60f04cuJkn3X5h4wOHKpqW6959T7okxKC848t+6d
        lXmx4+hGN7afIV9OvFyQbNJeIWTVotjJF/m/oVyJpTgj0VCLuag4EQDix9Zu4wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO6/2IIUgys/+SxuHGpksXi52cPi
        THeuxeVdc9gsGmZ/Z7U4PL+NxeLGhKeMFivnL2e0ON57gMni/+OvrBZLV7xltfh75CCTxZNf
        n9gsDp2cy2jRdzbIomPxSkYHAY/ZDRdZPHbOusvusWBTqUfLkbesHptXaHlsWtXJ5vFm9VxW
        j49Pb7F49G1ZxeixfstVFo/Pm+QCuKO4bFJSczLLUov07RK4MlZu2c1YcEaxYuPU+6wNjJOl
        uxg5OCQETCQuXovoYuTiEBLYzSjxc/Um1i5GTqC4tMTPf+9ZIGxhiZX/nrNDFH1ilJi7bAcz
        SIJNQE9i1a49LCAJEYHlTBJ/es6CVTELtDJKzLs6gQmkSljAWeLlyfdsIDaLgKrEuQdzwLp5
        BWwlfr19xAaxQl5i5qXv7BBxQYmTM5+ArWYGijdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNGS3MH4/ZVH/QOMTJxMB5ilOBgVhLh3ZCTnyLEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD0+mEB+VhUX53Flad
        DJeeahh3b/n0E32R7zTeWTAzLva6rf637AaTadhxS+f6jGXqS+KOsvrLsX+ecijdgjf9cUSI
        pE0g/5qOo1yd+RLnIry4rLacTP4rkq55+GupxGuT2w+YLzNfC/M5r9jCuqLfL3mJ+b4HE63O
        K156wW9pOPGdKqd7ziLWBKY/Z+e0ck6fF6LSfj9v5kfGVjY2bamCM7X986b9P+NSdClONZ7p
        3ZZTdlayJl4NOudSLNW5OHTnLU4QbuA5v0DqQf/yfSrHft05clHwnYO6jS+L3NPb786/fJL5
        XXHF4pMLEwsClW+IteT1OV67Z1jxdOK57XzrslriBa6cTZxgv2tVXFWCEktxRqKhFnNRcSIA
        8gEfIwkDAAA=
X-CMS-MailID: 20230526072134epcas5p12d0971c15890541639b4d2d85db84b43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230526072134epcas5p12d0971c15890541639b4d2d85db84b43
References: <CGME20230526072134epcas5p12d0971c15890541639b4d2d85db84b43@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with commit '7878c231dae0 ("slab: remove /proc/slab_allocators")'
lookup_symbol_attrs usage is removed.

Thus removing redundant API.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h |  6 ------
 include/linux/module.h   |  9 ---------
 kernel/kallsyms.c        | 28 ----------------------------
 kernel/module/kallsyms.c | 28 ----------------------------
 4 files changed, 71 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index fe3c9993b5bf..1037f4957caa 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -93,7 +93,6 @@ extern int sprint_backtrace(char *buffer, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);
 
 /* How and when do we show kallsyms values? */
 extern bool kallsyms_show_value(const struct cred *cred);
@@ -155,11 +154,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname)
 	return -ERANGE;
 }
 
-static inline int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name)
-{
-	return -ERANGE;
-}
-
 static inline bool kallsyms_show_value(const struct cred *cred)
 {
 	return false;
diff --git a/include/linux/module.h b/include/linux/module.h
index 9e56763dff81..a98e188cf37b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -968,15 +968,6 @@ static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
 	return -ERANGE;
 }
 
-static inline int lookup_module_symbol_attrs(unsigned long addr,
-					     unsigned long *size,
-					     unsigned long *offset,
-					     char *modname,
-					     char *name)
-{
-	return -ERANGE;
-}
-
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
 				     char *type, char *name,
 				     char *module_name, int *exported)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b..d31a1461529e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -484,34 +484,6 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 	return 0;
 }
 
-int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
-			unsigned long *offset, char *modname, char *name)
-{
-	int res;
-
-	name[0] = '\0';
-	name[KSYM_NAME_LEN - 1] = '\0';
-
-	if (is_ksym_addr(addr)) {
-		unsigned long pos;
-
-		pos = get_symbol_pos(addr, size, offset);
-		/* Grab name */
-		kallsyms_expand_symbol(get_symbol_offset(pos),
-				       name, KSYM_NAME_LEN);
-		modname[0] = '\0';
-		goto found;
-	}
-	/* See if it's in a module. */
-	res = lookup_module_symbol_attrs(addr, size, offset, modname, name);
-	if (res)
-		return res;
-
-found:
-	cleanup_symbol_name(name);
-	return 0;
-}
-
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index c550d7d45f2f..ef73ae7c8909 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -381,34 +381,6 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 	return -ERANGE;
 }
 
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
-			       unsigned long *offset, char *modname, char *name)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		if (within_module(addr, mod)) {
-			const char *sym;
-
-			sym = find_kallsyms_symbol(mod, addr, size, offset);
-			if (!sym)
-				goto out;
-			if (modname)
-				strscpy(modname, mod->name, MODULE_NAME_LEN);
-			if (name)
-				strscpy(name, sym, KSYM_NAME_LEN);
-			preempt_enable();
-			return 0;
-		}
-	}
-out:
-	preempt_enable();
-	return -ERANGE;
-}
-
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		       char *name, char *module_name, int *exported)
 {
-- 
2.17.1


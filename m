Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C65F637E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJFJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJFJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:20:46 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1BB2F666
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:20:45 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id BLB00143;
        Thu, 06 Oct 2022 17:20:43 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Thu, 6 Oct 2022 17:20:43 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <keescook@chromium.org>, <boqun.feng@gmail.com>,
        <gregkh@linuxfoundation.org>, <ojeda@kernel.org>,
        <masahiroy@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] kallsyms: add required space for unified style
Date:   Thu, 6 Oct 2022 05:20:42 -0400
Message-ID: <20221006092042.1753-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202210061720433fc399169644100ccc40985d8b7e1c2e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add required space before and after operators.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 scripts/kallsyms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03fa07ad45d9..1df9944030e2 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -213,7 +213,7 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[KSYM_NAME_LEN_BUFFER+1], type;
+	char name[KSYM_NAME_LEN_BUFFER + 1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
@@ -388,7 +388,7 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 		c = *data;
 		/* if the table holds a single char that is the same as the one
 		 * we are looking for, then end the search */
-		if (best_table[c][0]==c && best_table_len[c]==1) {
+		if (best_table[c][0] == c && best_table_len[c] == 1) {
 			*result++ = c;
 			total++;
 		} else {
@@ -641,7 +641,7 @@ static int find_best_token(void)
 {
 	int i, best, bestprofit;
 
-	bestprofit=-10000;
+	bestprofit = -10000;
 	best = 0;
 
 	for (i = 0; i < 0x10000; i++) {
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6A620F93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiKHLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiKHLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:53:58 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339A31261C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667908431;
        bh=bbKu1P+qGVqPUy+1ca70kdCJ4KEA+NhRefzquToDDM0=;
        h=From:To:Cc:Subject:Date;
        b=KRNBKc4nYXcVAQ/Ec/oh/ZRARhled3vDDATWcbqqu4MAODxTKBh3y7XOpzxaXH16Z
         CwMSg/MurUbxND6EMTj4lHfUdA80AmQnW19VEuZBT/EiGLZws85UMUBr4u3VwlqXZr
         JOAr5RiS6TPYpqJ84bN8H/dW300hBB8fFqsVeQ54=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza2-0.qq.com (NewEsmtp) with SMTP
        id D719B49B; Tue, 08 Nov 2022 19:53:49 +0800
X-QQ-mid: xmsmtpt1667908429t9aveu9lm
Message-ID: <tencent_F6CAC0ABE16839E2B2419BD07316DA65BB06@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSK7m+z34x+37K1Sh8BEWUQ2lYI3gDRtnqHvQPgjfB2BNdUoi+jc
         pv3uAjCgpPgF9wBZeKArvYfmSmybOqmG534Se0tCyA5zcG6RUqMuvvOs7JbxarR9SDEcfI815iqk
         WS57/ttRQOytB+pDwf1P2+oA36xup/fTOkC9ftv5/J5HeaM08w00l9QtmDNR/4yArM4YXATJQYZ/
         2HuTrgpPiMHSYuF6roSb0ALzPxAVAI5oVBp1JsDQrObdp08vJTWMujW223a0JXt7kEzI3zqkpf3i
         mUCyCann8sW3FYu1K+8b9evvM6Qi2M/EfkqiM2K8NgUIt8puMcGVUrPYzzqpSGigWzqvz9P6t0pT
         9P2wHIOH5d28vdhGY6DBt2mkZ7GUsof2TwtssOZl/NAE6LCyXFtSNsTzWe0qQ1DW323Q0WdY39yM
         jHbkYiI8taL940dIpALV3QScq4wp1Pbt6+VIn2oL2YtoZJi7Wy/YQ96kZk0I9PmZ5wZ2NLKSF5fp
         ezY8e12KObmgIXXazI/T6iS2fWjwqmdXdH8ltYsxAr8L5152lvT+adnBjHKY2FD5huAI7CxwT729
         3C4l14RwPdz9unANi/2mM0Lu4fnYxhyHIewRVXom3nCltxknIG6XsIylmkF5kU4eqiqmZuUP5lzH
         3rpKwC5ZY/lJ4bv98eYSg5AUgnwgpZdewQK2c3KujiGY+nlrLJt4BPEvptmhpp0C7v8LA0QcbPYY
         SfR+i8ELa1InHJj8iJHVLervDVp2Dav9YKGcogqx3uVn+v36i2kltU/eGHDnNzKvBy2NP91ObqUu
         DHKwTzM4tJutNNPoIr6+ql6FwDV20S1JpFfkqxD5IlnG7QsDXdZ/dZdsQFxoZ/WJf7wHESSkAXjR
         UNc1na0hDnMKrrt9chG/ErYNy9TaJR2CGpwLnRHTD/4zKObnHo7fO5CJZnWEsKPEudgQNbuxamYb
         F5fomDhg/tp2P1+PKsxpqY+MxeCfbgfnm3GWDH20M=
From:   Rong Tao <rtoax@foxmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Rong Tao <rongtao@cestc.cn>
Subject: [PATCH] tools/vm/page_owner: ignore page_owner_sort binary
Date:   Tue,  8 Nov 2022 19:53:48 +0800
X-OQ-MSGID: <20221108115348.22927-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

page_owner_sort was introduced since commit 48c96a368579("mm/page_owner:
keep track of page owners"), and we should ignore it.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/vm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/vm/.gitignore b/tools/vm/.gitignore
index 79bb92ae1bb3..922879f93fc8 100644
--- a/tools/vm/.gitignore
+++ b/tools/vm/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 slabinfo
 page-types
+page_owner_sort
-- 
2.31.1


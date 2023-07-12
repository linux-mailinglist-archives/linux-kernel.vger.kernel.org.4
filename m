Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C875095C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjGLNPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGLNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:15:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76119B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:15:40 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1JBx6xhzzBS5qG
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:15:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689167737; x=1691759738; bh=lIACBBIWEslS2W9Rjwr485k8/PG
        5Tw8UIlfYyRgLO4M=; b=I9rRep9/iqPKkZKrfpy0mQ3xzvlerKiuCT7c+m36OIP
        /YTOQQ/60J8LKq/Xm37vXMXzui8/SpYdKR+6lmxawdF0qdOPtim79sNmRXXYd/dx
        NuhqmezsXuwVnqhmMkBQ6IuJ0WfEqLwPDwF9TJBqEFl9vKV7Ly24fEw/yXmZhxsh
        s4u6zv4egZQ9wGtxRiJK09J4zzKbRg9aunURqJlUYADrO2K2vbGG+py/0POvDpiz
        jXMnl3lxQVPC3+Dk8tVHIwSBac0XQkMAEe/5P1L7Rr4cfn5XK5Dp171igTTdKq+Z
        Wxk3kGmgC9M5rl/IO7mM4LjOP/w5WcDIkOor8a7QgoA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4XdvfVd44kx3 for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 21:15:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1JBx3bHXzBS5q7;
        Wed, 12 Jul 2023 21:15:37 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 21:15:37 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix warnings in intel_ds.h
In-Reply-To: <tencent_1C96FDD9B8D4FE5447D7CD3250D9B768B10A@qq.com>
References: <tencent_1C96FDD9B8D4FE5447D7CD3250D9B768B10A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <4578aecf58124c6bd268ca0de5cf1b27@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch warnings are removed:
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/intel_ds.h | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel_ds.h 
b/arch/x86/include/asm/intel_ds.h
index 2f9eeb5c3069..6bc6621f6d9f 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
  #ifndef _ASM_INTEL_DS_H
  #define _ASM_INTEL_DS_H

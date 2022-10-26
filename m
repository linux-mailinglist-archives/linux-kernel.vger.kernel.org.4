Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72160DEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiJZKnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiJZKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:43:18 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC4BECC7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:43:14 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666780837tnocriqo
Received: from localhost.localdomain ( [101.6.93.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Oct 2022 18:40:20 +0800 (CST)
X-QQ-SSF: 0140000000000060B000000A0000000
X-QQ-FEAT: /dh/S7faoAIKBd2C5GJ0Of9RdLfgrEtMrQ6BkXeX3UpsjiE9o+0zZjJErafrq
        EQHZDShdY6rYXbwDzIeMAxgarEhYQpkR7gHDTnH34j3AgEd8k5kMMwm+OZ0rFveFbDGLrar
        9CiYRl5rQlpEAXIYCvf7Q2cgC1rjBBzjh3TwgQqjcJgQt5IR5AysKG6xT0MHA6XiUMw9crD
        liPjbpXBcn1uxknkvCRM6RI9mVoMT5B3A7SRFtxx2JIFSh684r0u+FZ/rWDSz+viC5AzsAw
        XSUWgxypCX2kPhnzBRPDEpnMWOsq97lb1EQeuskD+ppNGk/0yoclTO5ujzqWJ0ydQEo18FI
        HUwDcKxqzcdOkuzjVuz40a60qD6hNn/HjaGHGVN70Qr8KvZXMnwaWpQD0cgVWEBWeGBpGRH
X-QQ-GoodBg: 1
From:   Wen Yao <haiwenyao@uniontech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org,
        cl@linux.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Wen Yao <haiwenyao@uniontech.com>
Subject: [PATCH 0/2] riscv: Rewrite percpu operations and support cmpxchg-local feature
Date:   Wed, 26 Oct 2022 18:40:13 +0800
Message-Id: <20221026104015.565468-1-haiwenyao@uniontech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series try to use riscv amo instructions to optimise some percpu
operations and select HAVE_CMPXCHG_LOCAL to support cmpxchg-local feature.

Wen Yao (2):
  riscv: percpu:Add riscv percpu operations
  riscv:kconfig:select HAVE_CMPXCHG_LOCAL

 arch/riscv/Kconfig              |   1 +
 arch/riscv/include/asm/percpu.h | 101 ++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.25.1


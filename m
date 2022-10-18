Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44990602A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJRLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJRLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:55:24 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191495AE;
        Tue, 18 Oct 2022 04:55:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666094119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p1pHbprhXkTEzsEX5N8roFvnRzHIR+4tcfEqHqpfjDU=;
        b=Fjx1TxyczRMGZq1CqUdP8Ys1pW2oP6OGDJiDljsZm6TSCkl34KwQ2vhBhkdxUgWXWECP98
        KmAro1g0Uzfs97bh9JmvUza4QrwK1mNlEj86Hk4pO6W+hLmaXTxfz9A50VDbH/vrVNZUzr
        MOcazpYWXlc9luW4In96bvCu95Yp45ZnCflsE8ITmkeipRjzIWfUjSOotPqLI8RR2Jn8jw
        3RwveSafK3x17YqVmj3yvPIk4npf+sy96j9kHSGqlulPUmDs09UKHAz2vb6oek75dpe8SG
        k4FhBuadXi+XBHSmOWViUViXGJjVcWxX/jvbhFkgXOuWc6vzx88GCYDsfJpX+A==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH v2 0/2] docs/zh_CN: Add userspace-api/index and ebpf Chinese translation
Date:   Tue, 18 Oct 2022 19:54:51 +0800
Message-Id: <cover.1666093699.git.me@lirui.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following documents into Chinese:

- Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
- Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
- Documentation/translations/zh_CN/userspace-api/index.rst

Add userspace-api into the menu of zh_CN index.

Rui Li (2):
  docs/zh_CN: Add userspace-api/ebpf Chinese translation
  docs/zh_CN: Add userspace-api/index Chinese translation

 Documentation/translations/zh_CN/index.rst    |  2 +-
 .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++
 .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 +++++++++++
 .../zh_CN/userspace-api/index.rst             | 51 +++++++++++++++++++
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst

-- 
2.30.2


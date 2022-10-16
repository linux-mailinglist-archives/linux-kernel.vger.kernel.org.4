Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1C5FFF0C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJPMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJPMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:08:39 -0400
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 05:08:36 PDT
Received: from mail-200163.simplelogin.co (mail-200163.simplelogin.co [176.119.200.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3331F9F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=dkim;
        t=1665921536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pbbFFRETcqbPxIYeu3GqDRTtJt9V9EKGK3LVAFNYRmA=;
        b=BGOScIprcB9RW6Ed4E671GX7Tpkkk8bHwGoZELnHuQYCWKHbxtfj/2fo9TzThYVNCvR09G
        EdpAV8LiRpPe4eFzf8jtC7MD7G7VzP9c9mF8xeiHRsORd91vM0JhshhBIXIBbOp8cfNIde
        zbQJR79+nnXrv1qLk3UVGyfSTe0v8e4=
Subject: [PATCH 0/2] docs/zh_CN: Add userspace-api/index and ebpf Chinese
 translation
Date:   Sun, 16 Oct 2022 19:58:42 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <166592153626.7.4500669936128595360.69288105@lirui.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 69288108
X-SimpleLogin-Want-Signing: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 ++++++++++++
 .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst

-- 
2.30.2



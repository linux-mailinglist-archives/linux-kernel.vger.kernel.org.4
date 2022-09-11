Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5B5B4CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIKIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIKIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:48 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E42326EF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:44 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 3803 invoked from network); 11 Sep 2022 10:47:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886061; bh=NrbuMo7pml/6HDr/p1bJVrGnZTanZptTHqXEc6++eJE=;
          h=From:To:Cc:Subject;
          b=RJbuEPJhx1MVuVJhsanSpvGjY2sERhsA2+DFH6G6/+PuW2tlZK7psq7Fli1ADXH2v
           7rNajQRA3jP3OLjBsDr7S22DLBcsIn3ORsHiGyueGfvrD4+UQ8xLFiEk5+KUU18OYf
           NJ9J1aP/ZTsTyD5dd2tYjHsEH4ujBbnDgfwW15RM=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:41 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 00/10] x86: Kconfig cleanups and help text improvements
Date:   Sun, 11 Sep 2022 10:47:01 +0200
Message-Id: <20220911084711.13694-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 1b1859e56eb1157802a5ce6f979e9650
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [saOk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There are some problems with Kconfig help texts in the kernel. They are
frequently confusing and use language that is difficult to understand
for people unfamiliar with the feature. Sometimes, the help text was not
updated after important kernel or ecosystem changes. References to
something "future" or "old" are also usually given without specifying
any dates.

First version of this patch series was sent out in February 2022.

Greetings,
Mateusz

Mateusz Jończyk (10):
  x86/Kconfig: enable X86_X2APIC by default and improve help text
  x86/apic: fix panic message when x2APIC is not supported
  x86/Kconfig: always enable ARCH_SPARSEMEM_ENABLE
  x86/Kconfig: drop X86_32_NON_STANDARD
  x86/Kconfig: move all X86_EXTENDED_PLATFORM options together
  x86/Kconfig: update lists in X86_EXTENDED_PLATFORM
  x86/Kconfig: document CONFIG_PCI_MMCONFIG
  x86/Kconfig: make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
  x86/Kconfig: document release year of glibc 2.3.3
  x86/Kconfig: remove CONFIG_ISA_BUS

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org

 arch/x86/Kconfig            | 136 ++++++++++++++++++++----------------
 arch/x86/kernel/apic/apic.c |   2 +-
 drivers/iio/dac/Kconfig     |   2 +-
 3 files changed, 76 insertions(+), 64 deletions(-)


base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D156CCB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjC1URu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjC1URo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:17:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A833144A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:17:15 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89F7C1EC0338;
        Tue, 28 Mar 2023 22:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680034633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kFsCdhfkmyUE8dh7nh5WbRx/wlVVqOjTxXee2PAdFbg=;
        b=FdF+186YrHjVu3ePm9jtyPXYlfhvUxb9NJmmildi12nK5FMk2xZKhBizN+BdswpJesq9sg
        nK96OAbvT/WfeRyNtACv91lEZ3ZBiJYe8wn+3nqoTrePxuRl530lHDcL3yAIdxyd4yGVH8
        9cQPHfeSS9A/MurkOl0gDDi8ovRtlzw=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] SEV-*: Cleanups
Date:   Tue, 28 Mar 2023 22:17:10 +0200
Message-Id: <20230328201712.25852-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

here's v2.

tglx says it is better for cc_platform_has() and descendants to be
noinstr vs inlining it as the whole code is a bit bigger for that.

I've queued the export of cc_vendor already so that the parallel CPU
bringup stuff can use it:

https://git.kernel.org/tip/5ae57743f578725a5dadb6f31d7798ee55e6e967

Thx.

Borislav Petkov (AMD) (2):
  x86/coco: Mark cc_platform_has() and descendants noinstr
  x86/sev: Get rid of special sev_es_enable_key

 arch/x86/coco/core.c       |  8 ++++----
 arch/x86/include/asm/sev.h | 11 +++++++----
 arch/x86/kernel/sev.c      |  5 -----
 3 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.35.1


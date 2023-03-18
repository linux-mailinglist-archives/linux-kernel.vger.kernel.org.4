Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334AE6BF9B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCRL4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:56:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C74783A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 04:56:41 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53ADB1EC0645;
        Sat, 18 Mar 2023 12:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679140600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZrkPvsIHhH2abDvFuy5ugcfd5BauW24WdZG83MZNIyk=;
        b=PtFC6jwXD0VWhkGlj+aNg3D6GvhpnnzDlZ6xFmmK/luD01hkq0t7PsGVyjcYUvBTjD2FK9
        3VvZ36oKHZGNY3wJPH3OUwXfRy3AQEgy1IJ85lMjPenXbJpJW0DoPe8jFQzVXum1n6SxpK
        AH68T7dCB6PEM0Y3o0lbIkZqKyqFzac=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] SECC-ES: Cleanups
Date:   Sat, 18 Mar 2023 12:56:32 +0100
Message-Id: <20230318115634.9392-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

as part of recent parallel CPU bringup needs, here are two cleanups.

Thx.

Borislav Petkov (AMD) (2):
  x86/coco: Export cc_vendor
  x86/sev: Get rid of special sev_es_enable_key

 arch/x86/coco/core.c               | 15 +++++----------
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/include/asm/coco.h        |  2 +-
 arch/x86/include/asm/sev.h         | 11 +++++++----
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/kernel/sev.c              |  5 -----
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 7 files changed, 16 insertions(+), 23 deletions(-)

-- 
2.35.1


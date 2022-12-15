Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7AD64E09F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLOSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLOSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B64667C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13DE3B81C34
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C5C433D2;
        Thu, 15 Dec 2022 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128624;
        bh=8PNaS5DZTOGpbTorR0Yw13t8v/jr0DO4D+UXelTK8hc=;
        h=From:To:Cc:Subject:Date:From;
        b=i4b68wh65v/O6+kXx38KJmc6T8psOrM32ER6BScfH2hJKDEe06wrjSPnstjpvsKrI
         p4MgMiyt4NoIwa17EGFXdVFThNmuYFyubtkVMvg2HiXxJhWzEmZMqwXJU2P+nVtaiD
         Wx3W/clFzJKnjsWgzhbqdbB6UROKSa2vEwrpS5RRy57VgU/DuYPfhzM0rNMFtc/Xcr
         h/rGurGYsr57sGNU3URxf3smx8E0ZKfFxGnDRoMKSW5IIIlrHoNxM3RhGw3sr5QILn
         k7Qs8xiLhY8ja0BUkTIV0NsH9oDui1KwRFGAG+yxFSotoGSC0JV8WQV8i4LeRLI+qJ
         zHbS0BrEf45/Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] kexec: Remove unnecessary arch hook
Date:   Thu, 15 Dec 2022 12:23:37 -0600
Message-Id: <20221215182339.129803-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

There are no arch-specific things in arch_kexec_kernel_image_load(), so
remove it and just use the generic version.

Bjorn Helgaas (2):
  x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
  kexec: Remove unnecessary arch_kexec_kernel_image_load()

 arch/x86/include/asm/kexec.h       |  3 ---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  8 --------
 kernel/kexec_file.c                |  6 +++---
 4 files changed, 3 insertions(+), 25 deletions(-)

-- 
2.25.1


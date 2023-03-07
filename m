Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90906AF923
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCGWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCGWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:45:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3564EE4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D59EB81AC6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C954C433D2;
        Tue,  7 Mar 2023 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678229081;
        bh=ra2ig/GUIIdjFMBuwDWCO4KS9VvonAX7AhGw6h3HB6g=;
        h=From:To:Cc:Subject:Date:From;
        b=lHOHdGcXvzFRcEhvkX8UwLfx7BODSYMt8zRBGoAa4KEJX//F+7uixuv2E91/CJnDD
         1/aEeeDIl30OvcYrP/4iu+MIl3jIeda2kKAediFQ8JZICj+vhh4js/aKFScOcn4jWx
         jvUyfihhDt9QgbcLCcH+gfwJssfNYd9EYbBiEjHS1SVhU3mV/pgLMQC5pCdDLbHt1v
         tH1bdcoAtpemrJJA4N2iFFqHKqR7igYMxsZVUJ+ik3rMQE/EktLRDdxsfv/VRG6QI/
         HvBxebRNTFq5K0REXwhEMEO+rOhzTKfdPtpb7gqCgRpktMxVE39+nP2H8EKqwT1yeK
         yuU3IJEEQLrOw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Date:   Tue,  7 Mar 2023 16:44:14 -0600
Message-Id: <20230307224416.907040-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

There are no arch-specific things in arch_kexec_kernel_image_load(), so
remove it and just use the generic version.

v1 is at:
https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/

This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
slightly.


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


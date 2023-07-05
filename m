Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A36748B09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGERyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjGERyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5E19AF;
        Wed,  5 Jul 2023 10:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9547616A9;
        Wed,  5 Jul 2023 17:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFECDC433AD;
        Wed,  5 Jul 2023 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688579655;
        bh=vvW4OOfsiJD2KZ/I1z1PcbwrS0WK3qE/jaHdZ79UQCg=;
        h=From:To:Cc:Subject:Date:From;
        b=kY57anfiizAgAenn/BpfXPg5Ax/xvPH/rY2rX6155stZ5Kwcsirc/iWo2EIQuMlSW
         CQFD/NNWIs/QjshxzpzicHrp0EPVHm/SHnWFtIIuOO9ourfYt+GD/EWDF+YAZ7WDej
         q7sCR/H60bs3k/4MIxUzJDNyepxoMq3VqMXX2LyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.38
Date:   Wed,  5 Jul 2023 18:54:01 +0100
Message-ID: <2023070502-detail-mundane-3668@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.38 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/process/changes.rst        |    7 ++++
 Makefile                                 |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |    4 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c |   50 ++++++++++++++++-------------
 drivers/nubus/proc.c                     |   22 +++++++++---
 drivers/pci/pci-acpi.c                   |   53 +++++++++++++++++++++++--------
 include/linux/mm.h                       |    4 +-
 mm/nommu.c                               |    7 +++-
 scripts/tags.sh                          |    9 ++++-
 tools/perf/util/symbol.c                 |   17 ++++++++-
 10 files changed, 130 insertions(+), 45 deletions(-)

Ahmed S. Darwish (2):
      scripts/tags.sh: Resolve gtags empty index generation
      docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

Alvin Lee (1):
      drm/amd/display: Remove optimization for VRR updates

Aric Cyr (1):
      drm/amd/display: Do not update DRR while BW optimizations pending

Bas Nieuwenhuizen (1):
      drm/amdgpu: Validate VM ioctl flags.

Bjorn Helgaas (1):
      PCI/ACPI: Validate acpi_pci_set_power_state() parameter

Finn Thain (1):
      nubus: Partially revert proc_create_single_data() conversion

Greg Kroah-Hartman (1):
      Linux 6.1.38

Krister Johansen (1):
      perf symbols: Symbol lookup with kcore can fail if multiple segments match stext

Linus Torvalds (1):
      execve: always mark stack as growing down during early stack setup

Mario Limonciello (1):
      PCI/ACPI: Call _REG when transitioning D-states

Max Filippov (1):
      xtensa: fix lock_mm_and_find_vma in case VMA not found

Rodrigo Siqueira (1):
      drm/amd/display: Ensure vmin and vmax adjust for DCE


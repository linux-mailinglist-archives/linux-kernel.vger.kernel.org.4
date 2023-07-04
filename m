Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD7746C55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGDItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGDIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559E4186;
        Tue,  4 Jul 2023 01:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67D56118B;
        Tue,  4 Jul 2023 08:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630FC433C9;
        Tue,  4 Jul 2023 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688460522;
        bh=ztK4gfqf8b9jPihzjl8ZjJJnSrbvmffSvJobYTkZb2k=;
        h=From:To:Cc:Subject:Date:From;
        b=Ep1s9S83gAWvEJs+nyFP8GOMgsbF21xhcdvd9BCYc9YCjQl4ny/Qb/NcqVv1xGSM+
         BPWYmhKd9XAZV2oybSfY9Krkq9CU6kbOOQKZZf4fvID8PbzbqESFtmP9UqsgmsI4po
         lxUKFGbI7rEAb/TOxVIvvDflIEFuLY57PRhXnpDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.3 00/14] 6.3.12-rc2 review
Date:   Tue,  4 Jul 2023 09:48:39 +0100
Message-ID: <20230704084611.028211988@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.12-rc2
X-KernelTest-Deadline: 2023-07-06T08:46+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.12 release.
There are 14 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.12-rc2

Linus Torvalds <torvalds@linux-foundation.org>
    gup: avoid stack expansion warning for known-good case

Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    drm/amd/display: Ensure vmin and vmax adjust for DCE

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Demi Marie Obenour <demi@invisiblethingslab.com>
    dm ioctl: Avoid double-fetch of version

Ahmed S. Darwish <darwi@linutronix.de>
    docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Finn Thain <fthain@linux-m68k.org>
    nubus: Partially revert proc_create_single_data() conversion

Dan Williams <dan.j.williams@intel.com>
    Revert "cxl/port: Enable the HDM decoder capability for switch ports"

Jeff Layton <jlayton@kernel.org>
    nfs: don't report STATX_BTIME in ->getattr

Linus Torvalds <torvalds@linux-foundation.org>
    execve: always mark stack as growing down during early stack setup

Mario Limonciello <mario.limonciello@amd.com>
    PCI/ACPI: Call _REG when transitioning D-states

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ACPI: Validate acpi_pci_set_power_state() parameter

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Do not update DRR while BW optimizations pending

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix lock_mm_and_find_vma in case VMA not found


-------------

Diffstat:

 Documentation/process/changes.rst        |  7 +++++
 Makefile                                 |  4 +--
 drivers/cxl/core/pci.c                   | 27 +++-------------
 drivers/cxl/cxl.h                        |  1 -
 drivers/cxl/port.c                       | 14 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  4 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c | 49 +++++++++++++++++------------
 drivers/md/dm-ioctl.c                    | 33 ++++++++++++--------
 drivers/nubus/proc.c                     | 22 ++++++++++---
 drivers/pci/pci-acpi.c                   | 53 ++++++++++++++++++++++++--------
 fs/nfs/inode.c                           |  2 +-
 include/linux/mm.h                       |  4 ++-
 mm/memory.c                              |  4 +++
 mm/nommu.c                               |  7 ++++-
 scripts/tags.sh                          |  9 +++++-
 tools/testing/cxl/Kbuild                 |  1 -
 tools/testing/cxl/test/mock.c            | 15 ---------
 17 files changed, 152 insertions(+), 104 deletions(-)



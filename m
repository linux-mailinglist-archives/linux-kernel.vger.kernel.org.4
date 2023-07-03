Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9F7462FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGCS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGCS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AFE70;
        Mon,  3 Jul 2023 11:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F53D60D3A;
        Mon,  3 Jul 2023 18:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81024C433C9;
        Mon,  3 Jul 2023 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410591;
        bh=Ckp1qXdz3eIxZe31BzHYzDb9A2dOK1fsUwqEU/fAqgk=;
        h=From:To:Cc:Subject:Date:From;
        b=iDiY7bQ0CJa/PZO9tPFBcr3k8J8hRumtJzmztMmQ+qxfAjzSjELqJhxyujDcCfqEu
         0B+juyt5Ou/YcS5ykb38z98KyAgYetz7fUPy7oVPwU+IIBHTHF6c5qStWHOvOPGkDZ
         jWT4lpDeKqoPtFzd4mX82jCc6ociYW5Qycma6rpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.3 00/13] 6.3.12-rc1 review
Date:   Mon,  3 Jul 2023 20:54:10 +0200
Message-ID: <20230703184519.206275653@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.12-rc1
X-KernelTest-Deadline: 2023-07-05T18:45+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.3.12 release.
There are 13 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.12-rc1

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Demi Marie Obenour <demi@invisiblethingslab.com>
    dm ioctl: Avoid double-fetch of version

Ahmed S. Darwish <darwi@linutronix.de>
    docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlb: revert use of page_cache_next_miss()

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
 drivers/gpu/drm/amd/display/dc/core/dc.c | 48 +++++++++++++++++------------
 drivers/md/dm-ioctl.c                    | 33 ++++++++++++--------
 drivers/nubus/proc.c                     | 22 ++++++++++---
 drivers/pci/pci-acpi.c                   | 53 ++++++++++++++++++++++++--------
 fs/hugetlbfs/inode.c                     |  8 ++---
 fs/nfs/inode.c                           |  2 +-
 include/linux/mm.h                       |  4 ++-
 mm/hugetlb.c                             | 12 ++++----
 mm/nommu.c                               |  7 ++++-
 scripts/tags.sh                          |  9 +++++-
 tools/testing/cxl/Kbuild                 |  1 -
 tools/testing/cxl/test/mock.c            | 15 ---------
 18 files changed, 156 insertions(+), 115 deletions(-)



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4117A74630B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGCS5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGCS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585E90;
        Mon,  3 Jul 2023 11:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B81FD60F24;
        Mon,  3 Jul 2023 18:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75DCC433C8;
        Mon,  3 Jul 2023 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410622;
        bh=uXGgUq0PG4Hr4m0AZtyS2fWMtp45vW8lW+MmbkOjaGE=;
        h=From:To:Cc:Subject:Date:From;
        b=N7BLrJZwOcmYAXZMX9vpfuOQZatVIC0krh5ZlNm/aPqmGHjrlScsVhB8V0FOnObHc
         mKlLR1+QzvXkiWbCUofHNLW/aSFCiERCm6Yy2Ujf7o5XRjUEOERd5Mx4j9MrObadIz
         U3cbUP09E/mlsxUEN4E66/sU6cqrZtUl4bn8+rZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 00/11] 6.1.38-rc1 review
Date:   Mon,  3 Jul 2023 20:54:19 +0200
Message-ID: <20230703184519.121965745@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.38-rc1
X-KernelTest-Deadline: 2023-07-05T18:45+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.38 release.
There are 11 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.38-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.38-rc1

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Ahmed S. Darwish <darwi@linutronix.de>
    docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Krister Johansen <kjlx@templeofstupid.com>
    perf symbols: Symbol lookup with kcore can fail if multiple segments match stext

Finn Thain <fthain@linux-m68k.org>
    nubus: Partially revert proc_create_single_data() conversion

Linus Torvalds <torvalds@linux-foundation.org>
    execve: always mark stack as growing down during early stack setup

Mario Limonciello <mario.limonciello@amd.com>
    PCI/ACPI: Call _REG when transitioning D-states

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ACPI: Validate acpi_pci_set_power_state() parameter

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Do not update DRR while BW optimizations pending

Alvin Lee <Alvin.Lee2@amd.com>
    drm/amd/display: Remove optimization for VRR updates

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix lock_mm_and_find_vma in case VMA not found


-------------

Diffstat:

 Documentation/process/changes.rst        |  7 +++++
 Makefile                                 |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  4 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c | 49 ++++++++++++++++-------------
 drivers/nubus/proc.c                     | 22 ++++++++++---
 drivers/pci/pci-acpi.c                   | 53 ++++++++++++++++++++++++--------
 include/linux/mm.h                       |  4 ++-
 mm/nommu.c                               |  7 ++++-
 scripts/tags.sh                          |  9 +++++-
 tools/perf/util/symbol.c                 | 17 ++++++++--
 10 files changed, 130 insertions(+), 46 deletions(-)



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474136F16C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjD1LaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjD1LaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EB59F7;
        Fri, 28 Apr 2023 04:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCA664301;
        Fri, 28 Apr 2023 11:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B37BC433D2;
        Fri, 28 Apr 2023 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681403;
        bh=hi6LvnQT2lEUem2/Uqw8NbA5f523DEKv1R81iVhRCmc=;
        h=From:To:Cc:Subject:Date:From;
        b=r5v+LdmDlcpEGI+03BTBmc4awicoKoSSNFqc3+8KJ3LuprUXovxnWS6i+dEalCj9D
         0dUevmqPfsrtMyGXUU+LhSqxUkHnzjc4pVCy80keHGhKiz1te/dp2J1Jx5NOWev90/
         4L2cudA/liE5uE5W4SViH7oD9SpfmseH2Rcf1+b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 5.15 00/13] 5.15.110-rc1 review
Date:   Fri, 28 Apr 2023 13:28:04 +0200
Message-Id: <20230428112039.133978540@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.110-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.110-rc1
X-KernelTest-Deadline: 2023-04-30T11:20+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.110 release.
There are 13 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.110-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.110-rc1

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: No need to relocate the dtb as it lies in the fixmap region

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Do not set initial_boot_params to the linear address of the dtb

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Move early dtb mapping into the fixmap region

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"

Stephen Boyd <swboyd@chromium.org>
    driver core: Don't require dynamic_debug for initcall_debug probe timing

Arınç ÜNAL <arinc.unal@arinc9.com>
    USB: serial: option: add UNISOC vendor and TOZED LT70C product

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Perform careful capability checks in hci_sock_ioctl()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Jisoo Jang <jisoo.jang@yonsei.ac.kr>
    wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Dan Carpenter <dan.carpenter@linaro.org>
    KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()

David Matlack <dmatlack@google.com>
    KVM: arm64: Retry fault if vma_lookup() results become invalid

SeongJae Park <sjpark@amazon.de>
    selftests/kselftest/runner/run_one(): allow running non-executable files

Kai-Heng Feng <kai.heng.feng@canonical.com>
    PCI/ASPM: Remove pcie_aspm_pm_state_change()


-------------

Diffstat:

 Documentation/riscv/vm-layout.rst                  |  2 +-
 Makefile                                           |  4 +-
 arch/arm64/kvm/mmu.c                               | 47 +++++++--------
 arch/arm64/kvm/psci.c                              |  2 +
 arch/riscv/include/asm/fixmap.h                    |  8 +++
 arch/riscv/include/asm/pgtable.h                   |  8 ++-
 arch/riscv/kernel/setup.c                          |  6 +-
 arch/riscv/mm/init.c                               | 68 ++++++++++++----------
 drivers/base/dd.c                                  |  7 ++-
 drivers/gpu/drm/drm_fb_helper.c                    |  3 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  5 ++
 drivers/pci/pci.c                                  |  3 -
 drivers/pci/pci.h                                  |  2 -
 drivers/pci/pcie/aspm.c                            | 19 ------
 drivers/usb/serial/option.c                        |  6 ++
 net/bluetooth/hci_sock.c                           |  9 ++-
 tools/testing/selftests/kselftest/runner.sh        | 28 +++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  2 +-
 18 files changed, 124 insertions(+), 105 deletions(-)



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C7746C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjGDItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D110CE;
        Tue,  4 Jul 2023 01:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C4E36118B;
        Tue,  4 Jul 2023 08:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097FDC433C7;
        Tue,  4 Jul 2023 08:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688460530;
        bh=EspsVqameX3ivIVN5aauxB90aVJe0cYYkjZn3kRiGLU=;
        h=From:To:Cc:Subject:Date:From;
        b=jqrIIeXyoc6en53BlOEUtKPKy2iFs8k//xVUesPlJg4UhvaW6h4OlfwtO4e7XCH4T
         CoYz3wsIqtLPt5rZX6KAMd/0h7QRmgqwtqQDR1FyZSDpwwFaidd5+zlMinBw6mAvnB
         tSlps86+mnF//ZyPggJTfIf2Mqs2DsqkproNMeyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/17] 5.15.120-rc2 review
Date:   Tue,  4 Jul 2023 09:48:47 +0100
Message-ID: <20230704084610.981452877@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.120-rc2
X-KernelTest-Deadline: 2023-07-06T08:46+00:00
Content-Type: text/plain; charset=UTF-8
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

This is the start of the stable review cycle for the 5.15.120 release.
There are 17 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.120-rc2

Finn Thain <fthain@linux-m68k.org>
    nubus: Partially revert proc_create_single_data() conversion

Ben Hutchings <benh@debian.org>
    parisc: Delete redundant register definitions in <asm/assembly.h>

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Krister Johansen <kjlx@templeofstupid.com>
    perf symbols: Symbol lookup with kcore can fail if multiple segments match stext

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"

Mike Hommey <mh@glandium.org>
    HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Use ktime_t rather than int when dealing with timestamps

Krister Johansen <kjlx@templeofstupid.com>
    bpf: ensure main program has an extable

Oliver Hartkopp <socketcan@hartkopp.net>
    can: isotp: isotp_sendmsg(): fix return error fix on TX path

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Use dedicated cache-line for mwait_play_dead()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/microcode/AMD: Load late on both threads too

Philip Yang <Philip.Yang@amd.com>
    drm/amdgpu: Set vmbo destroy after pt bo is created

Jane Chu <jane.chu@oracle.com>
    mm, hwpoison: when copy-on-write hits poison, take page offline

Tony Luck <tony.luck@intel.com>
    mm, hwpoison: try to recover from copy-on write faults

Paolo Abeni <pabeni@redhat.com>
    mptcp: consolidate fallback and non fallback state machine

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible divide by zero in recvmsg()


-------------

Diffstat:

 Makefile                                   |  4 +--
 arch/parisc/include/asm/assembly.h         |  4 ---
 arch/x86/kernel/cpu/microcode/amd.c        |  2 +-
 arch/x86/kernel/smpboot.c                  | 24 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  4 +++
 drivers/hid/hid-logitech-hidpp.c           |  2 +-
 drivers/hid/wacom_wac.c                    |  6 ++--
 drivers/hid/wacom_wac.h                    |  2 +-
 drivers/nubus/proc.c                       | 22 ++++++++++----
 drivers/thermal/mtk_thermal.c              | 14 ++-------
 include/linux/highmem.h                    | 24 ++++++++++++++++
 include/linux/mm.h                         |  5 +++-
 kernel/bpf/verifier.c                      |  7 +++--
 mm/memory.c                                | 33 ++++++++++++++-------
 net/can/isotp.c                            |  5 ++--
 net/mptcp/protocol.c                       | 46 ++++++++++++++----------------
 net/mptcp/subflow.c                        | 17 ++++++-----
 scripts/tags.sh                            |  9 +++++-
 tools/perf/util/symbol.c                   | 17 +++++++++--
 20 files changed, 159 insertions(+), 89 deletions(-)



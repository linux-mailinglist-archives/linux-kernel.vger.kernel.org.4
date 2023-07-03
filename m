Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640E074631D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGCS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGCS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEC1E70;
        Mon,  3 Jul 2023 11:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D53260D3A;
        Mon,  3 Jul 2023 18:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310FFC433C8;
        Mon,  3 Jul 2023 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410663;
        bh=ZP3cJ2R+JbG+59E5fYy11eI5Z25vNRTQd6BPmrkpEXw=;
        h=From:To:Cc:Subject:Date:From;
        b=G+aLUe1sFfmIpdNpIkBfQsJ+3Q8xw8reWVQ1kluQAW22CO0PiJxMplLzX3uK1/cie
         Mb9MtaaO/V0kMZp8q/yQ2286QtpfhPDyYOIC9t3d2kYVuZEz4Ie5lynJwL6cDHfGZd
         p0vhWs0V0POlsgXeafwwgedl1cb7aK/VeJrOEWDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 00/15] 5.15.120-rc1 review
Date:   Mon,  3 Jul 2023 20:54:45 +0200
Message-ID: <20230703184518.896751186@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.120-rc1
X-KernelTest-Deadline: 2023-07-05T18:45+00:00
Content-Type: text/plain; charset=UTF-8
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

This is the start of the stable review cycle for the 5.15.120 release.
There are 15 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.120-rc1

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
 arch/x86/kernel/cpu/microcode/amd.c        |  2 +-
 arch/x86/kernel/smpboot.c                  | 24 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  4 +++
 drivers/hid/hid-logitech-hidpp.c           |  2 +-
 drivers/hid/wacom_wac.c                    |  6 ++--
 drivers/hid/wacom_wac.h                    |  2 +-
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
 18 files changed, 142 insertions(+), 80 deletions(-)



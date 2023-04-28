Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEEE6F1689
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjD1L2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjD1L2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E7558B;
        Fri, 28 Apr 2023 04:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AAE60C53;
        Fri, 28 Apr 2023 11:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B65C4339B;
        Fri, 28 Apr 2023 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681272;
        bh=NdGhhELJE5wYzCIdIBTAojApFEWZy0N7kuexAW+veDA=;
        h=From:To:Cc:Subject:Date:From;
        b=NUpI1nbFdTk0xw3QUnC9hMBYzRwJuW8xCxeGAZ3rB+UXuJBJPfOCExXM0wqmFjkXs
         ZhgtR6x5U2HlFjfDQkFaru9sS9xtejFUpTqFNhO/5/sCnFsc38hKxtoYgrTGjtsERS
         HELurNHTorzoxwYMu08ih55lF9vYtwxkZtbi9IkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: [PATCH 6.3 00/11] 6.3.1-rc1 review
Date:   Fri, 28 Apr 2023 13:27:35 +0200
Message-Id: <20230428112039.886496777@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.3.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.3.1-rc1
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

This is the start of the stable review cycle for the 6.3.1 release.
There are 11 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.3.1-rc1

Stephen Boyd <swboyd@chromium.org>
    driver core: Don't require dynamic_debug for initcall_debug probe timing

Arınç ÜNAL <arinc.unal@arinc9.com>
    USB: serial: option: add UNISOC vendor and TOZED LT70C product

Vlastimil Babka <vbabka@suse.cz>
    mm/mremap: fix vm_pgoff in vma_merge() case 3

Genjian Zhang <zhanggenjian@kylinos.cn>
    btrfs: fix uninitialized variable warnings

Marek Vasut <marex@denx.de>
    wifi: brcmfmac: add Cypress 43439 SDIO ids

Ruihan Li <lrh2000@pku.edu.cn>
    bluetooth: Perform careful capability checks in hci_sock_ioctl()

Werner Sembach <wse@tuxedocomputers.com>
    gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU

Eric Biggers <ebiggers@google.com>
    fsverity: explicitly check for buffer overflow in build_merkle_tree()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var

Eric Biggers <ebiggers@google.com>
    fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds

Jisoo Jang <jisoo.jang@yonsei.ac.kr>
    wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()


-------------

Diffstat:

 Makefile                                                |  4 ++--
 drivers/base/dd.c                                       |  7 ++++++-
 drivers/gpio/gpiolib-acpi.c                             | 13 +++++++++++++
 drivers/gpu/drm/drm_fb_helper.c                         |  3 +++
 .../net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |  9 ++++++++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |  5 +++++
 drivers/usb/serial/option.c                             |  6 ++++++
 fs/btrfs/send.c                                         |  2 +-
 fs/btrfs/volumes.c                                      |  2 +-
 fs/verity/enable.c                                      | 17 +++++++++++++++++
 include/linux/mmc/sdio_ids.h                            |  5 ++++-
 mm/mmap.c                                               |  2 +-
 net/bluetooth/hci_sock.c                                |  9 ++++++++-
 13 files changed, 75 insertions(+), 9 deletions(-)



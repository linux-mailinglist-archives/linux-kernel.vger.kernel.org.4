Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3169BA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBRNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBRNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:20:43 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8F18AA7;
        Sat, 18 Feb 2023 05:20:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id bd10so400029pfb.3;
        Sat, 18 Feb 2023 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rn86ibAcj0MP34P9tfsJbMqy1bIVlwSzMFz1qF4qaOM=;
        b=n3q2lr0PmU1uuemyajDPLfCzgGNiSaL+y2BlLLJ+SjQV1YXr0737F00y2tr9Iv13Tg
         CbwWUOFwJzs8qB34YPYbE3/i+xcAn0YvIzhMDE4mUku6lq9pbRyOSvz+vc6TjLbLK+r9
         0YIK4g4ctBer32qbYK7jZJV3mjxsbBVwshYd8luY9qBVfsZh1b2DKJYVfEif5BsyJdTI
         8YS2i/GIHQzV5hu8JwPxg0y124dz9AUd4C/rD5HzlWUn8WXlkYrCSAN2tuI5obPlC6B9
         KLG0ZuaZdMju8nEvhhblotvpVdyfYQ5zkKEjV42TX0VVnaOQXHfeNF6eL/ExMHNjwv4x
         gkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn86ibAcj0MP34P9tfsJbMqy1bIVlwSzMFz1qF4qaOM=;
        b=utRYp9Rba///UQn8QVJO+8S3hMWFqwpIXbgAPJE6DAN2chINKWXYwmO45Yg+8M2PCx
         7CIcKQ5VqA+4Cl7n+MsLmjLQj4Mb8JpAfyBfqaGn8+NBfjx6fijarmN4Isn5EhnnN4tH
         ZNk0pwf5RWb2SIfgKD4gOJS09G6XGcyT6CDYMtk+Ym2sffEVupzaKcB7H4wLM9KwJV8L
         fRz1hQUzMA+czn13qGPdTz7ghvdPbrQGPZHlCbdgsNySUVDIY8+9aoAhtJgTaekaTGiW
         xJHS8VAD4ZSKFdV71foN4O3+MKtkdENstckSOAxilN5puE3ZSoni8c51fhZxFjMGX2YS
         +Ebw==
X-Gm-Message-State: AO0yUKVH8RjFU0FjjbD476/7k7Di9v4rvoraCV4cECF9Jdtsq3k1IYJv
        N+INEK3NES4wbOOErDykums=
X-Google-Smtp-Source: AK7set8LTp1t9LS2JspNJY014XScQlN1avsKoe1Y2yRiAdyxXZUdPDp+R16s/WyRzFCpwbavKgxmUw==
X-Received: by 2002:a62:3841:0:b0:5a8:4e9c:32a9 with SMTP id f62-20020a623841000000b005a84e9c32a9mr4452051pfa.32.1676726442290;
        Sat, 18 Feb 2023 05:20:42 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0058e24050648sm4769448pff.12.2023.02.18.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:20:41 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Date:   Sun, 19 Feb 2023 00:20:02 +1100
Message-Id: <20230218132007.3350-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support for the MMIO based gmux present on these
Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3, MacBookPro16,1,
MacBookPro16,4 (although amdgpu isn't working on MacBookPro16,4 [1]).

Changes from v2[2]:

- Add "," to last item in apple_gmux_type enum
- Don't not clear interrupts when status is 0
- Don't check if we failed to make debugfs folder
- Check for fake mmio gmux

# 1:

has a slight change in how the switch state is read: instead of checking
for x == 2, check !(x & 1)

# 2:

implements a system to support more than 2 gmux types

# 3:

start using the gmux's GMSP acpi method when handling interrupts on MMIO
gmux's. This is needed for the MMIO gmux's to clear interrupts.

# 4:

Adds support for the MMIO based gmux on T2 macs.

# 5:

Add a debugfs interface to apple-gmux so data from ports can be read
and written to from userspace.

This can be used for more easily researching what unknown ports do,
and switching gpus when vga_switcheroo isn't ready (e.g. when one gpu
is bound to vfio-pci and in use by a Windows VM, I can use this to
switch my internal display between Linux and Windows easily).

# Issues:

1. Switching gpus at runtime has the same issue as indexed gmux's: the
inactive gpu can't probe the DDC lines for eDP [3]

2. iMacPro1,1, iMac20,1 and iMac20,2 all seem to have a gmux in their
acpi tables, but they shouldn't. A check that hopefully will detect this
is used, but it's untested as I don't have any of those computers.

3. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
told on the MacBookPro15,1 it works sometimes, and adding delays helps,
but on my MacBookPro16,1 I haven't been able to get it to work at all:

amdgpu: switched off
amdgpu: switched on
amdgpu 0000:03:00.0:
    Unable to change power state from D3hot to D0, device inaccessible
amdgpu 0000:03:00.0:
    Unable to change power state from D3cold to D0, device inaccessible
[drm] PCIE GART of 512M enabled (table at 0x00000080FEE00000).
[drm] PSP is resuming...
[drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
[drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[drm:amdgpu_device_fw_loading [amdgpu]]
    *ERROR* resume of IP block <psp> failed -62
amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
snd_hda_intel 0000:03:00.1:
    Unable to change power state from D3cold to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535
snd_hda_codec_hdmi hdaudioC0D0: Unable to sync register 0x2f0d00. -5

There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls when
changing the amdgpu's power state, but we don't use them and that could be
a cause. Additionally unlike previous generation Macbooks which work
better, on MacBookPro16,1 the gpu is located behind 2 pci bridges:

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 XL Downstream Port of PCI Express Switch
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
    Navi 10 HDMI Audio

Upon attempting to power on the gpu with vga_switcheroo, all these
devices except 01:00.0 have their config space filled with 1s.
Rescanning pci makes the config space of all the devices go back to
normal, however amdgpu still fails to resume with the same logs as
above.

[1]: https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
[2]: https://lore.kernel.org/platform-driver-x86/20230216122342.5918-1-orlandoch.dev@gmail.com/
[3]: https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
[4]: https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
[5]: https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/

Orlando Chamberlain (5):
  apple-gmux: use first bit to check switch state
  apple-gmux: refactor gmux types
  apple-gmux: Use GMSP acpi method for interrupt clear
  apple-gmux: support MMIO gmux on T2 Macs
  apple-gmux: add debugfs interface

 drivers/platform/x86/apple-gmux.c | 349 ++++++++++++++++++++++++++----
 include/linux/apple-gmux.h        |  70 ++++--
 2 files changed, 357 insertions(+), 62 deletions(-)

-- 
2.39.1


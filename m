Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE216A9209
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCCHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCCHyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:54:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9A38B4C;
        Thu,  2 Mar 2023 23:54:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h8so1857895plf.10;
        Thu, 02 Mar 2023 23:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677830074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvMRpBHGsmqI4XAunhHv/2BkvqzD7tqq/n+XqNFTqus=;
        b=pCxOK44i+SJOwg2Q6wqLAxAVYWBm5Rq4R4MSWVPxbevO4c5XUG8jMenWe9oVddQnEd
         2zjbyNaj/Pk/Lit20QlWDW4VZdiQvN0K4lhOiTJUx5olo9nfjetbydoLPeiwk7bPC+9w
         vfo8on5wiiOR619SILMB37ss4V0IIZFrDvObbSAzZbHhfZdNCqx8aHRGlAmFXUAoYZhn
         PHneoHMUwu5A/J2epa8Qh1cMH61Qj1HfawicnbIYW5IrT+xSYx519L6IFpV56ZfnU3Oz
         E+pjzSAm+tz9SpEGBow9SueJKqccmbUz6J8mtwHMKHjV0KJn3K09ad4q4PaRskkfpycM
         a4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677830074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvMRpBHGsmqI4XAunhHv/2BkvqzD7tqq/n+XqNFTqus=;
        b=8Oy0AaqwsdHOgVvF8oDMhsbIC7Wg2/22r+Mbf0wRrHVmubLJh5Mh8QMAvMuatnmgy9
         XI1k9VpMqtuyrVJe7mogZJxDn3+hOIqMVfxfM7GmMnt5qEQoHrXEvmUZt6iPdaVntBUD
         j0nr3XyC8N2SGSzgGksdWEbt9C4QLeDKj/CROcCH7lv9Ik5MNu/3ydsriL1GN43GYoKf
         4NpEXDQT3J0ENUwfAKSvaZWHtyfslC0EbYNPJOOa1VP2I49GkWhGlKeSZDDzwziwzxdY
         2yF150pkxZ6KVAbn7hqYspNrhP1r2TnJU6CejFFDaZNQGhzGXwtFiTqUwCneSHusnet5
         k42w==
X-Gm-Message-State: AO0yUKWw7WomAP6f8/bl77Wrj7RZdCXz9Ynwc0Vh5zjDDwdZyO0iWXQ/
        QRc9DYwTaKq0suM2aAZ3aSQ=
X-Google-Smtp-Source: AK7set8a2KzsYmksRPcdIorz8RPty10A5Hc4ARnZXOGgsO89NQzyJrNZjmkbFzp7nTTIWHJ5oCpXuw==
X-Received: by 2002:a17:90b:164e:b0:233:cc4c:2945 with SMTP id il14-20020a17090b164e00b00233cc4c2945mr704823pjb.38.1677830074110;
        Thu, 02 Mar 2023 23:54:34 -0800 (PST)
Received: from redecorated-mbp (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090acc0400b002308e6e645bsm914437pju.49.2023.03.02.23.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:54:33 -0800 (PST)
Date:   Fri, 3 Mar 2023 18:54:23 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Message-ID: <20230303185423.30bd115f@redecorated-mbp>
In-Reply-To: <4ccb9139-1e70-e669-646a-1975460962cd@redhat.com>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
        <4ccb9139-1e70-e669-646a-1975460962cd@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, 1 Mar 2023 13:54:37 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/18/23 14:20, Orlando Chamberlain wrote:
> > Hi All,
> > 
> > This patch series adds support for the MMIO based gmux present on
> > these Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3,
> > MacBookPro16,1, MacBookPro16,4 (although amdgpu isn't working on
> > MacBookPro16,4 [1]).
> > 
> > Changes from v2[2]:
> > 
> > - Add "," to last item in apple_gmux_type enum
> > - Don't not clear interrupts when status is 0
> > - Don't check if we failed to make debugfs folder
> > - Check for fake mmio gmux  
> 
> Thanks, this looks good to me now:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for the entire series.
> 
> Can you prepare a v4 addressing Lukas's remarks:
> 
> 1. Switch to acpi_execute_simple_method()
> 2. Add extra info about the gmux provided by Lukas 
>    to either the docs or as comments
> 
> With those changes added I believe v4 will be ready
> for merging.

Good to hear, I'll try to send out a v4 tonight.

> 
> Regards,
> 
> Hans
> 
> 
> > 
> > # 1:
> > 
> > has a slight change in how the switch state is read: instead of
> > checking for x == 2, check !(x & 1)
> > 
> > # 2:
> > 
> > implements a system to support more than 2 gmux types
> > 
> > # 3:
> > 
> > start using the gmux's GMSP acpi method when handling interrupts on
> > MMIO gmux's. This is needed for the MMIO gmux's to clear interrupts.
> > 
> > # 4:
> > 
> > Adds support for the MMIO based gmux on T2 macs.
> > 
> > # 5:
> > 
> > Add a debugfs interface to apple-gmux so data from ports can be read
> > and written to from userspace.
> > 
> > This can be used for more easily researching what unknown ports do,
> > and switching gpus when vga_switcheroo isn't ready (e.g. when one
> > gpu is bound to vfio-pci and in use by a Windows VM, I can use this
> > to switch my internal display between Linux and Windows easily).
> > 
> > # Issues:
> > 
> > 1. Switching gpus at runtime has the same issue as indexed gmux's:
> > the inactive gpu can't probe the DDC lines for eDP [3]
> > 
> > 2. iMacPro1,1, iMac20,1 and iMac20,2 all seem to have a gmux in
> > their acpi tables, but they shouldn't. A check that hopefully will
> > detect this is used, but it's untested as I don't have any of those
> > computers.
> > 
> > 3. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
> > told on the MacBookPro15,1 it works sometimes, and adding delays
> > helps, but on my MacBookPro16,1 I haven't been able to get it to
> > work at all:
> > 
> > amdgpu: switched off
> > amdgpu: switched on
> > amdgpu 0000:03:00.0:
> >     Unable to change power state from D3hot to D0, device
> > inaccessible amdgpu 0000:03:00.0:
> >     Unable to change power state from D3cold to D0, device
> > inaccessible [drm] PCIE GART of 512M enabled (table at
> > 0x00000080FEE00000). [drm] PSP is resuming...
> > [drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
> > [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> > [drm:amdgpu_device_fw_loading [amdgpu]]
> >     *ERROR* resume of IP block <psp> failed -62
> > amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> > snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
> > snd_hda_intel 0000:03:00.1:
> >     Unable to change power state from D3cold to D0, device
> > inaccessible snd_hda_intel 0000:03:00.1: CORB reset timeout#2,
> > CORBRP = 65535 snd_hda_codec_hdmi hdaudioC0D0: Unable to sync
> > register 0x2f0d00. -5
> > 
> > There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls
> > when changing the amdgpu's power state, but we don't use them and
> > that could be a cause. Additionally unlike previous generation
> > Macbooks which work better, on MacBookPro16,1 the gpu is located
> > behind 2 pci bridges:
> > 
> > 01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> >     Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
> > 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> >     Navi 10 XL Downstream Port of PCI Express Switch
> > 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
> > 03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
> >     Navi 10 HDMI Audio
> > 
> > Upon attempting to power on the gpu with vga_switcheroo, all these
> > devices except 01:00.0 have their config space filled with 1s.
> > Rescanning pci makes the config space of all the devices go back to
> > normal, however amdgpu still fails to resume with the same logs as
> > above.
> > 
> > [1]:
> > https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
> > [2]:
> > https://lore.kernel.org/platform-driver-x86/20230216122342.5918-1-orlandoch.dev@gmail.com/
> > [3]:
> > https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
> > [4]:
> > https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
> > [5]:
> > https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/
> > 
> > Orlando Chamberlain (5):
> >   apple-gmux: use first bit to check switch state
> >   apple-gmux: refactor gmux types
> >   apple-gmux: Use GMSP acpi method for interrupt clear
> >   apple-gmux: support MMIO gmux on T2 Macs
> >   apple-gmux: add debugfs interface
> > 
> >  drivers/platform/x86/apple-gmux.c | 349
> > ++++++++++++++++++++++++++---- include/linux/apple-gmux.h        |
> > 70 ++++-- 2 files changed, 357 insertions(+), 62 deletions(-)
> >   
> 


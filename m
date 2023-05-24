Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92070F3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjEXKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjEXKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:00:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC312F;
        Wed, 24 May 2023 03:00:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2533b600d35so44636a91.1;
        Wed, 24 May 2023 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684922419; x=1687514419;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNSvuvrQGvwdxH/qdhsUYjzWunRTiKdWvSzt8OcjbNQ=;
        b=Ov0+DpbPgrrIqbyKmxJ+eJ4OawMMguWIsxAEKBxkEwH9mGRlImk+DEcubbX31amMYS
         /gER4DSD7hEX9AuQYr0rQy4ZSHTJDKwdxeWkKQ+S0sD/JE/rInkDwSiOBt/oDV5wRxfb
         vWE9PDql6Nyda03C2wIETWhGABocjrwVTWq6tg9TO5tSmQoKuvCZ2l2KEct442PhJQyB
         o2e70YCyKVuFVmCLmUG57s07QejSurdW3IVS1RmgyC5hPFvj12rXf3rQvXF7ATRl9ZKA
         grZRyK7KBe055EMpJPiS/4SsD6H7G9fki7IX7pmsS7nD2zMm1KWQ9e88edddj97YtOUw
         k0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922419; x=1687514419;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNSvuvrQGvwdxH/qdhsUYjzWunRTiKdWvSzt8OcjbNQ=;
        b=BkNGOVLuJpeITnR77pXIYYvOXDgU4PDSY1iICLh2rbzgwHOS3a6gZpLnBYlIv204cH
         ZNFRqu0G+cs6t2uiBOdTpJRxAdEUAE7Q+kGFYnO7Gqy7/czKC+PhICh8cr8ibDcvqo2e
         Uldh4by3hArcz8noNtCShgm0Oi23NgjATK4sNvTz9vqll4NR2ooe9mtYhBc+c1XyGQ0V
         LpcuWvZwZLQcvYPfsLz8r7OkJmaKlE6n7O79b/6dqsi6FDIQSHJ60L2+onXEHJ7S50Iq
         TS2Gb9uCG1sy1joF7qAT83I2XEr3eQ2K3Mr1F+0BixiyIFywmCzWpRI5moNzG9TbS3CM
         obsg==
X-Gm-Message-State: AC+VfDzGJlRFVEm6yt7FdVNLdRB6VDBCaUSuR7U/ULe+VY7CCusQyenU
        itBFx4BaiKZTe/+pGAW3sG8Zd5RIHAU=
X-Google-Smtp-Source: ACHHUZ4HzUkejSTlixUkOvAE8dm9+V31YmC0hmTMMOxd/VAwP5P9I9OQi2IKm7VCjKB7xthZmInJaw==
X-Received: by 2002:a17:90a:ab08:b0:234:889f:c35d with SMTP id m8-20020a17090aab0800b00234889fc35dmr15271241pjq.3.1684922418865;
        Wed, 24 May 2023 03:00:18 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id 137-20020a63028f000000b0053423447a12sm7515016pgc.73.2023.05.24.03.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:00:18 -0700 (PDT)
Message-ID: <a8461137-0c87-fd7d-8354-5b8675d8e45d@gmail.com>
Date:   Wed, 24 May 2023 16:59:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        "Linux Bluetooth (Bluez)" <linux-bluetooth@vger.kernel.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Alberto Garcia <berto@igalia.com>,
        Aaron Ma <aaron.ma@canonical.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Foxconn / Hon Hai Bluetooth adapter 0489:e0cd stops working on
 ThinkPad T14s AMD Gen1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hi,
> 
> I'm running Linux on a ThinkPad T14s AMD Gen 1 and I'm having problems
> with its Bluetooth adapter.
> 
> The adapter is a Foxconn / Hon Hai, USB ID 0489:e0cd, and it uses the
> Mediatek MT7921 driver. Sometimes it just works but often if I suspend
> the laptop and come back it stops working. This also happens when I
> use the RF kill switch. The kernel errors vary a bit depending on the
> moment but it's usually a combination of these:
> 
> kernel: Bluetooth: hci0: Failed to get device id (-108)
> kernel: Bluetooth: hci0: Failed to get fw version (-108)
> kernel: bluetooth hci0: firmware: direct-loading firmware mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin
> kernel: Bluetooth: hci0: Execution of wmt command timed out
> kernel: Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
> kernel: Bluetooth: hci0: Failed to set up firmware (-110)
> kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> 
> Interestingly I noticed that if I try to use it on a Linux VM (using
> USB passthrough) it generally works better, even when it's not working
> on the host and the guest and the host are running the same OS and
> kernel version. Still it fails sometimes, although the error messages
> tend to be a bit different:
> 
> kernel: usbcore: registered new interface driver btusb
> kernel: Bluetooth: hci0: Device setup in 153593 usecs
> kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> kernel: Bluetooth: hci0: Opcode 0x c03 failed: -110
> kernel: Bluetooth: hci0: Failed to read MSFT supported features (-110)
> kernel: Bluetooth: hci0: AOSP get vendor capabilities (-110)
> 
> (I also tried the adapter with a Windows VM, again using USB
> passthrough, but here it works perfectly fine)
> 
> Back to the host I found out that resetting the adapter using
> "usb_modeswitch -R -v 0489 -p e0cd" sometimes is enough to bring the
> adapter back to life and make it work. But this doesn't always
> succeed, and at some point I end up in a situation like this:
> 
> kernel: xhci_hcd 0000:06:00.4: xHCI host not responding to stop endpoint command
> kernel: xhci_hcd 0000:06:00.4: xHCI host controller not responding, assume dead
> kernel: xhci_hcd 0000:06:00.4: HC died; cleaning up
> 
> Sometimes I can get out of it with this:
> 
> $ echo 0000:06:00.4 > /sys/bus/pci/drivers/xhci_hcd/unbind
> $ echo 0000:06:00.4 > /sys/bus/pci/drivers/xhci_hcd/bind
> 
> All this has been happening since I got the laptop, but I'm testing it
> now with Linux 6.3.3 and the problem is still there.
> 
> The end result is that I basically cannot rely on the USB adapter so I
> have it almost always disabled.
> 
> A bit more information about the system:
> 
> $ lspci -nn | grep USB
> 02:00.4 USB controller [0c03]: Realtek Semiconductor Co., Ltd. RTL811x EHCI host controller [10ec:816d] (rev 0e)
> 05:00.0 USB controller [0c03]: Renesas Technology Corp. uPD720202 USB 3.0 Host Controller [1912:0015] (rev 02)
> 06:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1 [1022:1639]
> 06:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne USB 3.1 [1022:1639]
> 
> $ lsusb
> Bus 007 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 006 Device 003: ID 0489:e0cd Foxconn / Hon Hai Wireless_Device
> Bus 006 Device 002: ID 06cb:00bd Synaptics, Inc. Prometheus MIS Touch Fingerprint Reader
> Bus 006 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 005 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 002 Device 002: ID 04f2:b6cb Chicony Electronics Co., Ltd Integrated Camera
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 

See bugzilla for the full thread.

The reporter said that the bluetooth adapter works well on Windows VM via
device passthrough, but not on Linux host.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217475

-- 
An old man doll... just what I always wanted! - Clara

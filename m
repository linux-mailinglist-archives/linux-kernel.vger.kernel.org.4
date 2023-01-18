Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238AB6729D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjARVAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjARU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:59:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C253E53
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:59:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b5so14080899wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-language:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAWdVvIILnWxK4OHJVRZQ0Iq//EaZpc5wfd5pT2azIA=;
        b=qwp7dBlCxrCDr4JLpsgYmaXkkmYubgYdMHoDrHzPZ0NolRuX1ujn7OfgWq9LI1umX6
         sLiGh3FVH+nuhGToGEE/sFB3WILlJ4KDkf4TBpC1fAVkg4574I6k6erPFQBTaK172rFj
         JAG0SqyaOxv+CAe65HyJt9IfFV8pitA1vJONN5+0+H4Nder4W2o+vjL8T+6gCVB1IiyO
         hW59fg087sQxO1Wcuv01R3UKLzrgx9YUa0WPCwTing2kyIgGFHTZC59CExi24QqQ0brc
         aLrOQaLM86WOZ0SrD1+/AIrGdjBoihw609IER44TJDxx2y8+k6KZGkmkR5Rg7DLPr3jk
         DWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAWdVvIILnWxK4OHJVRZQ0Iq//EaZpc5wfd5pT2azIA=;
        b=GsVybPTaU/2Y5tBczpVu2dw6mQmhcTc41j8V1Ogj7eLatw54XqrFZBzDv35OE9TUTv
         8m+DWSkAzBB0QUm3ZuS7xrIXULCGyz3rnyL+ZISXR5SqZHzNE6K6md3z1E1HYRHrzOsE
         QU4zgmYAjm/heoZJse8vN3M+IvyW5ZHmRkOTZbbQvGVM0JqEMwrgHNLITi66HcyDv7KW
         omYwNifHcRppsHG70Mks6V9MJwwexZeETR+iS3G9qhfMPXVjVoMH580kuWjetYtUXLOK
         3wliF2JZBtP47Jxy5zl7UQX7S1yBZ8RjSTU3qYjzUQOSuD7+jCovzvO0HU16QfGPPfCY
         whnQ==
X-Gm-Message-State: AFqh2kqIksx0GRbHkleQn5LHNi22I/z0xfj3/h5wcP+B0Z66kBdK7TKn
        pYo0BKTtUFU9GBMC42GcaddcODFxtyo=
X-Google-Smtp-Source: AMrXdXuh0+b7uPBly+Y71xj6trgRnhMsitLLOpLKH0OOpsi9QUmQeJohjOvIRGnOruw0RDktZzxHbw==
X-Received: by 2002:a5d:42c6:0:b0:2b5:8ba4:3b12 with SMTP id t6-20020a5d42c6000000b002b58ba43b12mr6962609wrr.23.1674075579421;
        Wed, 18 Jan 2023 12:59:39 -0800 (PST)
Received: from [192.168.1.10] (97e09f27.skybroadband.com. [151.224.159.39])
        by smtp.googlemail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm29092050wrx.14.2023.01.18.12.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:59:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ts5GJAsjqSKrD421iAgXH1BN"
Message-ID: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
Date:   Wed, 18 Jan 2023 20:59:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Chris Clayton <chris2553@googlemail.com>
Subject: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     LKML <linux-kernel@vger.kernel.org>, bskeggs@redhat.com
Content-Language: en-GB
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ts5GJAsjqSKrD421iAgXH1BN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

I build and installed the lastest development kernel earlier this week. I've found that when I try the laptop down (or
reboot it), it hangs right at the end of closing the current session. The last line I see on  the screen when rebooting is:

	sd 4:0:0:0: [sda] Synchronising SCSI cache

when closing down I see one additional line:

	sd 4:0:0:0 [sda]Stopping disk

In both cases the machine then hangs and I have to hold down the power button fot a few seconds to switch it off.

Linux 6.1 is OK but 6.2-rc1 hangs, so I bisected between this two and landed on:

	# first bad commit: [0e44c21708761977dcbea9b846b51a6fb684907a] drm/nouveau/flcn: new code to load+boot simple HS FWs
(VPR scrubber)

I built and installed a kernel with f15cde64b66161bfa74fb58f4e5697d8265b802e (the parent of the bad commit) checked out
and that shuts down and reboots fine. It the did the same with the bad commit checked out and that does indeed hang, so
I'm confident the bisect outcome is OK.

Kernels 6.1.6 and 5.15.88 are also OK.

My system had dual GPUs - one intel and one NVidia. Related extracts from 'lscpi -v' is:

00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05) (prog-if 00 [VGA controller])
        Subsystem: CLEVO/KAPOK Computer CometLake-H GT2 [UHD Graphics]

        Flags: bus master, fast devsel, latency 0, IRQ 142

        Memory at c2000000 (64-bit, non-prefetchable) [size=16M]

        Memory at a0000000 (64-bit, prefetchable) [size=256M]

        I/O ports at 5000 [size=64]

        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]

        Capabilities: [40] Vendor Specific Information: Len=0c <?>

        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00

        Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-

        Capabilities: [d0] Power Management version 2

        Kernel driver in use: i915

        Kernel modules: i915


01:00.0 VGA compatible controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Ti Mobile] (rev a1) (prog-if 00 [VGA
controller])
        Subsystem: CLEVO/KAPOK Computer TU117M [GeForce GTX 1650 Ti Mobile]
        Flags: bus master, fast devsel, latency 0, IRQ 141
        Memory at c4000000 (32-bit, non-prefetchable) [size=16M]
        Memory at b0000000 (64-bit, prefetchable) [size=256M]
        Memory at c0000000 (64-bit, prefetchable) [size=32M]
        I/O ports at 4000 [size=128]
        Expansion ROM at c3000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Express Legacy Endpoint, MSI 00
        Kernel driver in use: nouveau
        Kernel modules: nouveau

DRI_PRIME=1 is exported in one of my init scripts (yes, I am still using sysvinit).

I've attached the bisect.log, but please let me know if I can provide any other diagnostics. Please cc me as I'm not
subscribed.


Chris
--------------ts5GJAsjqSKrD421iAgXH1BN
Content-Type: text/plain; charset=UTF-8; name="bisect-log.txt"
Content-Disposition: attachment; filename="bisect-log.txt"
Content-Transfer-Encoding: base64

IyBiYWQ6IFsxYjkyOWMwMmFmZDM3ODcxZDVhZmI5ZDQ5ODQyNmY4MzQzMmU3MWMyXSBMaW51
eCA2LjItcmMxCiMgZ29vZDogWzgzMGIzYzY4YzFmYjFlOTE3NjAyOGQwMmVmODZmM2NmNzZh
YTI0NzZdIExpbnV4IDYuMQpnaXQgYmlzZWN0IHN0YXJ0ICd2Ni4yLXJjMScgJ3Y2LjEnCiMg
YmFkOiBbZmM0YzlmNDUwNDkzZGFlZjFjOTk2YzlkNGIzYzY0N2VjMzEyMTUwOV0gTWVyZ2Ug
dGFnICdlZmktbmV4dC1mb3ItdjYuMicgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L2VmaS9lZmkKZ2l0IGJpc2VjdCBiYWQgZmM0YzlmNDUwNDkz
ZGFlZjFjOTk2YzlkNGIzYzY0N2VjMzEyMTUwOQojIGdvb2Q6IFs4ZWNkMjhiN2EzYTRjNDNh
ODc1YTg4NDA4NTFmNzI0NjhhMmNhMWQ3XSBNZXJnZSB0YWcgJ2F0YS02LjItcmMxJyBvZiBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGxlbW9hbC9s
aWJhdGEKZ2l0IGJpc2VjdCBnb29kIDhlY2QyOGI3YTNhNGM0M2E4NzVhODg0MDg1MWY3MjQ2
OGEyY2ExZDcKIyBiYWQ6IFs2NmVmZmY1MTVhNjUwMGQ0YjQ5NzZmYmFiM2JlZThiOTJhMTEz
N2ZiXSBNZXJnZSB0YWcgJ2FtZC1kcm0tbmV4dC02LjItMjAyMi0xMi0wNycgb2YgaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2FnZDVmL2xpbnV4IGludG8gZHJtLW5leHQKZ2l0
IGJpc2VjdCBiYWQgNjZlZmZmNTE1YTY1MDBkNGI0OTc2ZmJhYjNiZWU4YjkyYTExMzdmYgoj
IGdvb2Q6IFs0OWU4ZTYzNDNkZjY4OGQ2OGIxMmMyYWY1MDc5MWNhMzc1MjBmMGI3XSBNZXJn
ZSB0YWcgJ2FtZC1kcm0tbmV4dC02LjItMjAyMi0xMS0wNCcgb2YgaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL2FnZDVmL2xpbnV4IGludG8gZHJtLW5leHQKZ2l0IGJpc2VjdCBn
b29kIDQ5ZThlNjM0M2RmNjg4ZDY4YjEyYzJhZjUwNzkxY2EzNzUyMGYwYjcKIyBiYWQ6IFtm
YzU4NzY0YmJmNjAyYjY1YTZmNjNjNTNlNWZkNmZlYWU3NmM1MTBjXSBNZXJnZSB0YWcgJ2Ft
ZC1kcm0tbmV4dC02LjItMjAyMi0xMS0xOCcgb2YgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0
b3Aub3JnL2FnZDVmL2xpbnV4IGludG8gZHJtLW5leHQKZ2l0IGJpc2VjdCBiYWQgZmM1ODc2
NGJiZjYwMmI2NWE2ZjYzYzUzZTVmZDZmZWFlNzZjNTEwYwojIGJhZDogWzRlMjkxZjJmNTg1
MzEzZWZhNTIwMGNjZTY1NWUxN2M5NDkwNmU1MGFdIE1lcmdlIHRhZyAnZHJtLW1pc2MtbmV4
dC0yMDIyLTExLTEwLTEnIG9mIGdpdDovL2Fub25naXQuZnJlZWRlc2t0b3Aub3JnL2RybS9k
cm0tbWlzYyBpbnRvIGRybS1uZXh0CmdpdCBiaXNlY3QgYmFkIDRlMjkxZjJmNTg1MzEzZWZh
NTIwMGNjZTY1NWUxN2M5NDkwNmU1MGEKIyBiYWQ6IFs3OGE0M2M3ZTNiMmZmNWFlZDE4MDlm
OTNiNGY4N2E0MTgzNTU3ODllXSBkcm0vbm91dmVhdS9nci9nZjEwMC06IG1ha2UgZ2xvYmFs
IGF0dHJpYl9jYiBhY3R1YWxseSBnbG9iYWwKZ2l0IGJpc2VjdCBiYWQgNzhhNDNjN2UzYjJm
ZjVhZWQxODA5ZjkzYjRmODdhNDE4MzU1Nzg5ZQojIGdvb2Q6IFtlYjM5YzYxMzQ4MWZkMmZl
NmIyZjY2ZWMyY2EyMWY4ZmRjZGQ0Y2FjXSBkcm0vbm91dmVhdS9maWZvOiBleHBvc2UgcGVy
LXJ1bmxpc3QgQ0hJRCBpbmZvcm1hdGlvbgpnaXQgYmlzZWN0IGdvb2QgZWIzOWM2MTM0ODFm
ZDJmZTZiMmY2NmVjMmNhMjFmOGZkY2RkNGNhYwojIGdvb2Q6IFs4YWI4NDlkNmRkNGMyZWI4
ODgwMDk2ZTUzZTkxZGZiNmNhMzdiNTg5XSBkcm0vbm91dmVhdS9maWZvOiBhZGQgbmV3IGVu
Z2luZSBjb250ZXh0IGhhbmRsaW5nCmdpdCBiaXNlY3QgZ29vZCA4YWI4NDlkNmRkNGMyZWI4
ODgwMDk2ZTUzZTkxZGZiNmNhMzdiNTg5CiMgYmFkOiBbMGU0NGMyMTcwODc2MTk3N2RjYmVh
OWI4NDZiNTFhNmZiNjg0OTA3YV0gZHJtL25vdXZlYXUvZmxjbjogbmV3IGNvZGUgdG8gbG9h
ZCtib290IHNpbXBsZSBIUyBGV3MgKFZQUiBzY3J1YmJlcikKZ2l0IGJpc2VjdCBiYWQgMGU0
NGMyMTcwODc2MTk3N2RjYmVhOWI4NDZiNTFhNmZiNjg0OTA3YQojIGdvb2Q6IFtiN2Y0NGVm
NzMyMGE1MGRkNjcxOGRmMDZmODc1MDQ4OWMxYjFkNWVhXSBkcm0vbm91dmVhdS9wbXU6IG1v
dmUgcHJlaW5pdCgpIGZhbGNvbiByZXNldCB0byBkZXZpbml0CmdpdCBiaXNlY3QgZ29vZCBi
N2Y0NGVmNzMyMGE1MGRkNjcxOGRmMDZmODc1MDQ4OWMxYjFkNWVhCiMgZ29vZDogWzNiMzMw
ZjA4NzUwMTRiNDc1Y2EzZGMzN2U0Mzk3YWVlMTNmMDA5ODZdIGRybS9ub3V2ZWF1L3NlYzI6
IHVubG9hZCBSVE9TIGJlZm9yZSB0ZWFyaW5nIGRvd24gV1BSCmdpdCBiaXNlY3QgZ29vZCAz
YjMzMGYwODc1MDE0YjQ3NWNhM2RjMzdlNDM5N2FlZTEzZjAwOTg2CiMgZ29vZDogW2YxNWNk
ZTY0YjY2MTYxYmZhNzRmYjU4ZjRlNTY5N2Q4MjY1YjgwMmVdIGRybS9ub3V2ZWF1L2ZsY246
IHJld29yayBmYWxjb24gcmVzZXQKZ2l0IGJpc2VjdCBnb29kIGYxNWNkZTY0YjY2MTYxYmZh
NzRmYjU4ZjRlNTY5N2Q4MjY1YjgwMmUKIyBmaXJzdCBiYWQgY29tbWl0OiBbMGU0NGMyMTcw
ODc2MTk3N2RjYmVhOWI4NDZiNTFhNmZiNjg0OTA3YV0gZHJtL25vdXZlYXUvZmxjbjogbmV3
IGNvZGUgdG8gbG9hZCtib290IHNpbXBsZSBIUyBGV3MgKFZQUiBzY3J1YmJlcikK

--------------ts5GJAsjqSKrD421iAgXH1BN--

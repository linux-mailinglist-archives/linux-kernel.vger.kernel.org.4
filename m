Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95073710C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbjEYMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEYMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:46:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A912F;
        Thu, 25 May 2023 05:46:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d293746e0so2441726b3a.2;
        Thu, 25 May 2023 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685018816; x=1687610816;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsp+ooFC9A3hWuO7X2DuDaXuAcIvAuRjOpppctZ/9JY=;
        b=gW6oLronwV/BZTKxBkSlNXGKnDhG+vEHmEEGuQ0FnkkDYMOh5Nt5TzaKflaTKeXaPT
         2zIKYGCW4kuGOg+VCFRObTwcU4z7X6yeG7zmY3Kd8YZmHDVf1e0pg3mAwN491wwn7/lw
         51RZ/7hm0jFDaBw7B5lZEm+jjgOVR63wkjtl5raBpLa/i5zfWeNmfjH/mjHSBt7KG7iG
         IFE0sWX+M8PVFE4KDZgnTIGUxoq2/UVWALPQHsnEd210SqGS8/yAJoEI8w2ex3Vk4tqK
         v/V3ZkuO22NCCppngswi5QkURJ98qI/1fYHCqeKczrkxxhxzsH2ikmX8P3y+uPoP02yO
         sjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685018816; x=1687610816;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rsp+ooFC9A3hWuO7X2DuDaXuAcIvAuRjOpppctZ/9JY=;
        b=PC6nQ8imyTBiD38d5ot5U/PFboM8vLXDYrNdzr63zKL6D6PDs+d7fKKsXzoQgrMaVF
         6HL6L1ErtMMIpml57Jl55JPNB1hvE41rSkBWghLSrHdbuEtwsUGc3FfoNSAy4qZO76wc
         evwNIoayLKfuEvw/YbeRNRmN/EOUlMW6q4+zX7NkMy2lCcl7cwcszHuUPEtYDw8TVdSN
         sZRK3nxf0Vr+I4hE+wbVPHfnBHmQdUcmpWOT9SD7Wijt9UihSz3Lty9aJS0upBkGIe/O
         5H2K7nclHxC3n/R8QWxn5VwZyZGRs/hpFpdIZdtdk0kwabIq8Kz3r1wPw4frq0r/t1PK
         qWLw==
X-Gm-Message-State: AC+VfDxSUvg301r4cn1OTwbz8XFR3Brii8mamfYHzKUfyCJxCbxqN0EV
        IUWXiDqi1W5OlbgGj3p5JnM85fqmP/E=
X-Google-Smtp-Source: ACHHUZ4I5hWrGXOc2+qeG6NRq0yzOpcbMZDzxaAKpUO8YySNSuUowYF+Lgm7+3CQHwYHz428EcyvfQ==
X-Received: by 2002:a05:6a20:d90b:b0:104:b21f:26b0 with SMTP id jd11-20020a056a20d90b00b00104b21f26b0mr18468904pzb.47.1685018816311;
        Thu, 25 May 2023 05:46:56 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-46.three.co.id. [116.206.12.46])
        by smtp.gmail.com with ESMTPSA id w32-20020a634920000000b0050927cb606asm1102405pga.13.2023.05.25.05.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 05:46:55 -0700 (PDT)
Message-ID: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
Date:   Thu, 25 May 2023 19:46:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel >= v6.2 no longer boots on Apple's
 Virtualization.framework (x86_64); likely to be related to ACPICA
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Akihiro Suda <suda.kyoto@gmail.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Linux kernel >= v6.2 no longer boots on Apple's Virtualization.framework (x86_64).
> 
> It is reported that the issue is not reproducible on ARM64: https://github.com/lima-vm/lima/issues/1577#issuecomment-1561577694
> 
> 
> ## Reproduction
> - Checkout the kernel repo, and run `make defconfig bzImage`.
> 
> - Create an initrd (see the attached `initrd-example.txt`)
> 
> - Transfer the bzImage and initrd to an Intel Mac.
> 
> - On Mac, download `RunningLinuxInAVirtualMachine.zip` from https://developer.apple.com/documentation/virtualization/running_linux_in_a_virtual_machine , and build the `LinuxVirtualMachine` binary with Xcode.
>   Building this binary with Xcode requires logging in to Apple.
>   If you do not like logging in, a third party equivalent such as https://github.com/Code-Hex/vz/blob/v3.0.6/example/linux/main.go can be used.
> 
> - Run `LinuxVirtualMachine /tmp/bzImage /tmp/initrd.img`.
>   v6.1 successfully boots into the busybox shell.
>   v6.2 just hangs before printing something in the console.
> 
> 
> ## Tested versions
> ```
> v6.1: OK
> ...
> v6.1.0-rc2-00002-g60f2096b59bc (included in v6.2-rc1): OK
> v6.1.0-rc2-00003-g5c62d5aab875 (included in v6.2-rc1): NG <-- This commit caused a regression
> ...
> v6.2-rc1: NG
> ...
> v6.2: NG
> ...
> v6.3.0-rc7-00181-g8e41e0a57566 (included in v6.3): NG     <-- Reverts 5c62d5aab875 but still NG
> ...
> v6.3: NG
> v6.4-rc3: NG
> ```
> 
> Tested on MacBookPro 2020 (Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz) running macOS 13.4.
> 
> 
> The issue seems a regression in [5c62d5aab8752e5ee7bfbe75ed6060db1c787f98](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c62d5aab8752e5ee7bfbe75ed6060db1c787f98) "ACPICA: Events: Support fixed PCIe wake event".
> 
> This commit was introduced in v6.2-rc1, and apparently reverted in v6.3 ([8e41e0a575664d26bb87e012c39435c4c3914ed9](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e41e0a575664d26bb87e012c39435c4c3914ed9)).
> However, v6.3 and the latest v6.4-rc3 still don't boot.

See bugzilla for the full thread.

Interestingly, this regression still occurs despite the culprit is
reverted in 8e41e0a575664d ("Revert "ACPICA: Events: Support fixed
PCIe wake event""), so this (obviously) isn't wake-on-lan regression,
but rather early boot one.

Also, the reporter can't provide dmesg log (forget to attach serial
console?).

Anyway, I'm adding it to regzbot:

#regzbot introduced: 5c62d5aab8752e https://bugzilla.kernel.org/show_bug.cgi?id=217485
#regzbot title: Linux v6.2+ (x86_64) no longer boots on Apple's Virtualization framework (ACPICA issue)

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217485

-- 
An old man doll... just what I always wanted! - Clara

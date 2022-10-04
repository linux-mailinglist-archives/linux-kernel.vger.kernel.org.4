Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1D5F4CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJDXxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJDXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:53:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9998564D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:53:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 83so7475513pfw.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Me4MtrhkzwJ/+NLdmToxO2yl0aqX6DoqofwZcoelHg=;
        b=AR7bf0iAVx4nuUqI6C2YPK4bvX5RRdEhmEEMpd8ltbpZwoqKNZgTz+R59HUuZttpAW
         FRLCpuOTAumssWjBZviJDBzkEAn5zsrhZi9x1B10Zx4afUS+4G+kwM51FCcpKd93qAjS
         q187NUk+1tD4nzN7AL5bY8XfwAbzGX1nYCWph5diKNf0k8CO4f8nJorLzoJnGGEQCXIF
         4utx6Yu2xGr8+ZOtnt1nT7jZmgo4vyextjXtSUUN/gXxNAxqfey/9aAyzd5QrP4ymy0I
         0q5Ez6DNUN5S+Xx8xZS3OLkkdb9Shw5f+MN9oJst/6i/bT+K8ZNO27D1cMpRWGkx3ZkU
         DuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Me4MtrhkzwJ/+NLdmToxO2yl0aqX6DoqofwZcoelHg=;
        b=Kd8Iv4c934FbEImN10I9A5wGXj5dfxX2Po46Q0geIdRANf3GtYh9tEphnkgz/bcljP
         1fnPHdKKUEEZtlI+P3EuIcIqsPeBO25BIo2hOfkUkey0CfpiIGia60nx9tL3xNHkSf7R
         HVcbLsyCMq0qXKebyjAK/PpSCAWQVN09F2+aECDT2BhP5BPMNajZIpEzfCYwiphL9WKh
         Ws5Jm5c+a49u+gTWaQX+GCcSkh8v6U0WrpV83E5KD/hWOGTEGwR5/IK2Efr05CmRQ/ZR
         Oqci0vbl1gzt4FyMWlOY5R6AkG+BYIjIwznSLVPYXWaSCLNmkX4wv7SPM3UpoycUsoQJ
         1J2g==
X-Gm-Message-State: ACrzQf15PYqwvomUQK1XvaEQqSZsrKVS9MwPPGyimK6rEjfy1jbx+5KP
        g+RPtFOtPdqEzXpd+nri+ruF6w==
X-Google-Smtp-Source: AMsMyM5jTp6XHAJzlLg7NZSgkkC8npqddXYgcsYEEZRklZmzdkq4aKdmfDh3gGaDlzI2DVQ/0IZ7zw==
X-Received: by 2002:a63:91c2:0:b0:44b:89d5:715 with SMTP id l185-20020a6391c2000000b0044b89d50715mr13709124pge.304.1664927594082;
        Tue, 04 Oct 2022 16:53:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b0016ee3d7220esm9566668plh.24.2022.10.04.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 16:53:13 -0700 (PDT)
Date:   Tue, 04 Oct 2022 16:53:13 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Oct 2022 16:52:37 PDT (-0700)
Subject:     Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
In-Reply-To: <CAOnJCUKUTt1VfU+wMfxE4P21ttW5uaegXD+0oq4O4KgpGOWhaQ@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        heinrich.schuchardt@canonical.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-1bcc94fc-bb33-4caf-ab65-fca155189645@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 14:29:03 PDT (-0700), atishp@atishpatra.org wrote:
> On Tue, May 24, 2022 at 5:08 AM Anup Patel <anup@brainfault.org> wrote:
>>
>> Hi Palmer,
>>
>> On Wed, Apr 20, 2022 at 4:54 PM Anup Patel <apatel@ventanamicro.com> wrote:
>> >
>> > Currently, the range and default value of NR_CPUS is too restrictive
>> > for high-end RISC-V systems with large number of HARTs. The latest
>> > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
>> > restrictive for QEMU as well. Other major architectures (such as
>> > ARM64, x86_64, MIPS, etc) have a much higher range and default
>> > value of NR_CPUS.
>> >
>> > This patch increases NR_CPUS range to 2-512 and default value to
>> > XLEN (i.e. 32 for RV32 and 64 for RV64).
>> >
>> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>
>> Can this PATCH be considered for 5.19 ?
>>
>> Thanks,
>> Anup
>>
>> > ---
>> > Changes since v2:
>> >  - Rebased on Linux-5.18-rc3
>> >  - Use a different range when SBI v0.1 is enabled
>> > Changes since v1:
>> >  - Updated NR_CPUS range to 2-512 which reflects maximum number of
>> >    CPUs supported by QEMU virt machine.
>> > ---
>> >  arch/riscv/Kconfig | 9 ++++++---
>> >  1 file changed, 6 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 00fd9c548f26..1823f281069f 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -275,10 +275,13 @@ config SMP
>> >           If you don't know what to do here, say N.
>> >
>> >  config NR_CPUS
>> > -       int "Maximum number of CPUs (2-32)"
>> > -       range 2 32
>> > +       int "Maximum number of CPUs (2-512)"
>> >         depends on SMP
>> > -       default "8"
>> > +       range 2 512 if !SBI_V01
>> > +       range 2 32 if SBI_V01 && 32BIT
>> > +       range 2 64 if SBI_V01 && 64BIT
>> > +       default "32" if 32BIT
>> > +       default "64" if 64BIT
>> >
>> >  config HOTPLUG_CPU
>> >         bool "Support for hot-pluggable CPUs"
>> > --
>> > 2.25.1
>> >
>
>
> Ping ?
> It would be useful to include this patch sooner than later to enable
> high HART count testing by default.

Ya, I think that's reasonable: the higher CPU counts have found a bunch 
of issues, but they're not really Linux bugs and stopping folks from 
running them is just going to stop those bugs from being fixed.  It 
seems like these higher default NR_CPUS are stable on smaller systems so 
that shouldn't hurt anything.

I'm still getting a bunch of issues when trying to run the larger CPU 
count systems in QEMU, but I think it's OK just assuming those are 
long-tail issues that would manifest anyway and are just more likely 
with the higher core counts.

So I've got this on for-next, under the rationale that the new default 
CPU counts are safe.

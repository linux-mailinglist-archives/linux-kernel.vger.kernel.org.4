Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130D368178E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbjA3R1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjA3R1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:27:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DD3EC66
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:27:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8733795wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2VAOUAnZrrTaW8atAzm2YZfzH9NyPYsAl1667ENi80=;
        b=YZTDascVmQZqB3c/4sRTKFl51YdSOobEpQyYvVWJDHxbdr+51HsOvDbWgZDJAlwxxU
         1kW0GCyqsz+7tLBi0O19obgVdFbV3SyWwgdHJTYbcLxMhiYKB9C4AiKhdTAIMAnjDHWE
         4zIyP7EyHlc3wUvPuiQ+RWaXwPpz8Z1yNRJJSewe0/SfODzqbcWw+PDSF0muUS9wbbtR
         ZUIB/jdEJoZGh4jCWZ2sWAbF8cYS9j5I2nrBXyLGPUDcXCRMF8urMyaedKIjjgUQxyCy
         vQOjU+S7H1JC5iilU9CIq69NnS0Fap4Cx6gJqvfbdxSXSRb+jcPrhkNHJjA2iM9Deozq
         R4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2VAOUAnZrrTaW8atAzm2YZfzH9NyPYsAl1667ENi80=;
        b=TE2t+Y7xg8Rs1iZ5emM1hK3pQN7VELNQGJH5eEB3HHHC7oKUoNY6IP6Z2Jt2wsiFZ+
         WIR+sLdqVpCeNxXwno0+lWE3mjcl+0d7IrkmenxuUYhWavHHFJU1na88lCr+pw9r36sy
         79Ne96wwMa19kdImbf90FXWd9txpLgyY37ja2Nd1dVBD8ByEfNbVNyqQr1tJiXqRevGF
         C6bRVkiFSvDAQlBsa2zpMvozc16vrNv2+Dg6dfUMzrMSTYzjtRVAUlDN/U4m4qI+fugq
         if1+Qpvx9A1+nyiQr9rKnhuIas0I9MiWiTuRwFVPSdAJuhiWTphvqEMOA8UpsndB+CXm
         hjaQ==
X-Gm-Message-State: AFqh2krwR0yPbKes2h+TntxnVs3CDUGftdwoKfcaHVoNdJHOhqdq3yaU
        LFkBmuoDc2dRKnO7W+ojzTUGzA==
X-Google-Smtp-Source: AMrXdXviQFi3sihPpurt8rdcKqZfVzxFO3/bkpVeQGK/zf7LvG7QPjCQ8MMQgH9HLEbEA7amD+J8DQ==
X-Received: by 2002:a05:600c:c05:b0:3db:3476:6f02 with SMTP id fm5-20020a05600c0c0500b003db34766f02mr36605938wmb.41.1675099639973;
        Mon, 30 Jan 2023 09:27:19 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003dc36981727sm11203411wma.14.2023.01.30.09.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:27:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v1] riscv: support arch_has_hw_pte_young()
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230130104900.muwgikgkvkn2byna@orel>
Date:   Mon, 30 Jan 2023 17:27:18 +0000
Cc:     Anup Patel <apatel@ventanamicro.com>, Jinyu Tang <tjytimi@163.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, yuzhao@google.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, tongtiangen@huawei.com,
        Anup Patel <anup@brainfault.org>,
        Andrew Morton <akpm@linux-foundation.org>, falcon@tinylab.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBC27F74-6AB4-43B3-90B9-107C05467167@jrtc27.com>
References: <20230129064956.143664-1-tjytimi@163.com>
 <CAK9=C2VaxNezv+M=s=ZSA-YDf_17+hcom_z1=_j2YkRHg-yg7Q@mail.gmail.com>
 <20230130104900.muwgikgkvkn2byna@orel>
To:     Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2023, at 10:49, Andrew Jones <ajones@ventanamicro.com> wrote:
>=20
> On Mon, Jan 30, 2023 at 03:55:55PM +0530, Anup Patel wrote:
>> On Sun, Jan 29, 2023 at 12:21 PM Jinyu Tang <tjytimi@163.com> wrote:
>>>=20
>>> The arch_has_hw_pte_young() is false for riscv by default. If it's
>>> false, page table walk is almost skipped for MGLRU reclaim. And it
>>> will also cause useless step in __wp_page_copy_user().
>>>=20
>>> RISC-V Privileged Book says that riscv have two schemes to manage A
>>> and D bit.
>>>=20
>>> So add a config for selecting, the default is true. For simple
>>> implementation riscv CPU which just generate page fault, unselect =
it.
>>=20
>> I totally disagree with this approach.
>>=20
>> Almost all existing RISC-V platforms don't have HW support
>> PTE.A and PTE.D updates.
>>=20
>> We want the same kernel image to run HW with/without PTE.A
>> and PTE.D updates so kconfig based approach is not going to
>> fly.
>>=20
>>>=20
>>> Signed-off-by: Jinyu Tang <tjytimi@163.com>
>>> ---
>>> arch/riscv/Kconfig               | 10 ++++++++++
>>> arch/riscv/include/asm/pgtable.h |  7 +++++++
>>> 2 files changed, 17 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index e2b656043abf..17c82885549c 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -180,6 +180,16 @@ config PAGE_OFFSET
>>>        default 0x80000000 if 64BIT && !MMU
>>>        default 0xff60000000000000 if 64BIT
>>>=20
>>> +config ARCH_HAS_HARDWARE_PTE_YOUNG
>>> +       bool "Hardware Set PTE Access Bit"
>>> +       default y
>>> +       help
>>> +         Select if hardware set A bit when PTE is accessed. The =
default is
>>> +         'Y', because most RISC-V CPU hardware can manage A and D =
bit.
>>> +         But RISC-V may have simple implementation that do not =
support
>>> +         hardware set A bit but only generate page fault, for that =
case just
>>> +         unselect it.
>>> +
>>> config KASAN_SHADOW_OFFSET
>>>        hex
>>>        depends on KASAN_GENERIC
>>> diff --git a/arch/riscv/include/asm/pgtable.h =
b/arch/riscv/include/asm/pgtable.h
>>> index 4eba9a98d0e3..1db54ab4e1ba 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct =
vm_area_struct *vma,
>>>         */
>>>        return ptep_test_and_clear_young(vma, address, ptep);
>>> }
>>> +#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
>>=20
>>> +#define arch_has_hw_pte_young arch_has_hw_pte_young
>>> +static inline bool arch_has_hw_pte_young(void)
>>> +{
>>> +       return true;
>>=20
>> Drop the kconfig option ARCH_HAS_HARDWARE_PTE_YOUNG
>> and instead use code patching to return true only when Svadu
>> ISA extension is available in DT ISA string.
>=20
> Indeed. I should have checked if there was an extension for this
> first. It crossed my mind that we should only be enabling features
> when the extensions are present, but looking at the privileged manual
> isn't sufficient to learn about the Svadu extension. I should have
> checked https://wiki.riscv.org/display/HOME/Specification+Status
>=20
> Anyway, I retract my r-b and agree with Anup.

Svadu is a bit of a mess, for years it=E2=80=99s been legal to implement
hardware A/D tracking and such implementations exist (it=E2=80=99s what =
QEMU
has done for many years, and I know of an FPGA-based implementation
that does it too), yet RVA20S64 outlaws that by requiring what it calls
Ssptead and Svadu gets introduced to re-allow that behaviour gated
behind a CSR bit.

Jess


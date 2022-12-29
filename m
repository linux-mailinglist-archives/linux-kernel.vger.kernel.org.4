Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEC658F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiL2Qrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2Qru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:47:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A275F4B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:47:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 1so28259680lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7aD/QfTo34ngEFuuBxrXukknuKdvHckRsofn98sFzo=;
        b=dNj/sPH7wNbWULcuRqpYfqWjfXnaNb6tg91cCg6Vuc4mwULBZtsvQ8WTL+p9ffAHso
         fT8gSrdkxPEyxv9nU0weQYRukj6PrUvyS6p8m5vUUp6KBAUVtVhpNbq3FeXBXnyFGEDz
         ACoIj8uIbIhiSDiLtnbVJePac1Bpo0vBe5QKj9JsvzlTkqdQjIs4Q47D8OfVfWzb5Y5s
         P07S+VFbQfpBLIZSblmeTjjhNVszsg+4+xO2g8/snxI2UP0/+Jl6LaZQWbzuM4vz/67Q
         A1b465FmkIf81CGQk+42KTmUe9bt6w5uyVhE4uYhn4kgWlxzKw8Fa8yjYWDY+xzjhTF3
         s+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7aD/QfTo34ngEFuuBxrXukknuKdvHckRsofn98sFzo=;
        b=pr40C8Ff4KusV0gPiuGLjfK5jA1U4IL2tqKOd/L3zVJSFysBxP4x6pNI1knRHIMXbN
         iutU9+xZkMOrdqZOX1OEADldekgUQ4je/OEabkO4yi85UNg8NK7d2liE8IOg/CrZIcAP
         cAj3r7SiDKaL8yvp7KQTqH1JUWpqi9YPe9EstiH5YIAIBxSCGw/uVaJfnWocG5Bopd/j
         Bt28BX/7MScHrTTyyv5oknptVWHNasXbyC0DTAQ761HnUztBAhL9uWnG4gThrYRPSWWq
         Suwe0QEWCNWlar+lQWjPeMZ/BU7RtDze4PINA1EW3ekfL+uj2DNyqOp/qfe132gRR4Tv
         YBQA==
X-Gm-Message-State: AFqh2kpoo/BnizE7+v6y1kIfd0U75yVMqDZYR1R+5Y3kCR0PpaXyMAsS
        Tg7pBgqFcXkHdz1nLDCn5NaAhg==
X-Google-Smtp-Source: AMrXdXtBLsLTG27ozjx7A6/PGS8aZr1JUGpWu/vMHTSy7IXp+kkPjS8nk+8hutNsM4FVdE98VsFNmQ==
X-Received: by 2002:a05:6512:3f88:b0:4b6:e64c:aec7 with SMTP id x8-20020a0565123f8800b004b6e64caec7mr8840354lfa.3.1672332466513;
        Thu, 29 Dec 2022 08:47:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s8-20020a197708000000b004b55ddeb7e3sm3144829lfc.309.2022.12.29.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:47:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0REcS9c6YWq96Psx5p82DcBx"
Message-ID: <0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org>
Date:   Thu, 29 Dec 2022 17:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/5] arch_topology: Build cacheinfo from primary CPU
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, Ionela.Voinescu@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221209103130.572196-1-pierre.gondois@arm.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209103130.572196-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0REcS9c6YWq96Psx5p82DcBx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2022 11:31, Pierre Gondois wrote:
> v2:
>  - Applied renaming/formatting comments from v1.
>  - Check CACHE_TYPE_VALID flag in pppt.c.
> v3:
>  - Applied Sudeep's suggestions (for patch 5/5):
>    - Renaming allocate_cache_info() -> fecth_cache_info()
>    - Updated error message
>    - Extract an inline allocate_cache_info() function
>  - Re-run checkpatch with --strict option
> 
> Note:
> This patchset requires the following patch to be applied first in
> order to avoid the same bug described in the commit message:
> https://lore.kernel.org/all/20221116094958.2141072-1-pierre.gondois@arm.com/
> 
> [1] and [2] build the CPU topology from the cacheinfo information for
> both DT/ACPI based systems and remove (struct cpu_topology).llc_id
> which was used by ACPI only.
> 
> Creating the cacheinfo for secondary CPUs is done during early boot.
> Preemption and interrupts are disabled at this stage. On PREEMPT_RT
> kernels, allocating memory (and parsing the PPTT table for ACPI based
> systems) triggers a:
>   'BUG: sleeping function called from invalid context' [4]
> 
> To prevent this bug, allocate the cacheinfo from the primary CPU when
> preemption and interrupts are enabled and before booting secondary
> CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
> only, without relying on the arm64 CLIDR_EL1 register.
> If no cache information is found in the DT/ACPI PPTT, then fallback
> to the current state, triggering [4] on PREEMPT_RT kernels.
> 
> Patches to update the arm64 device trees that have incomplete cacheinfo
> (mostly for missing the 'cache-level' or 'cache-unified' property)
> have been sent at [3].
> 
> Tested platforms:
> - ACPI + PPTT: Ampere Altra, Ampere eMAG, Cavium ThunderX2,
>   Kunpeng 920, Juno-r2
> - DT: rb5, db845c, Juno-r2
> 

I gave the patchset a try with DTS fixes for cache topology on Qualcomm
RB5 board (SM8250 SoC) and with KASAN it produces:

BUG: KASAN: slab-out-of-bounds in populate_cache_leaves+0x84/0x15c
[    0.633014]  dump_backtrace.part.0+0xe0/0xf0
[    0.633035]  show_stack+0x18/0x40
[    0.633050]  dump_stack_lvl+0x8c/0xb8
[    0.633085]  print_report+0x188/0x488
[    0.633106]  kasan_report+0xac/0xf0
[    0.633136]  __asan_store4+0x80/0xa4
[    0.633158]  populate_cache_leaves+0x84/0x15c
[    0.633181]  detect_cache_attributes+0xc0/0x8c4
[    0.633213]  update_siblings_masks+0x28/0x43c
[    0.633235]  store_cpu_topology+0x98/0xc0
[    0.633251]  smp_prepare_cpus+0x2c/0x15c
[    0.633281]  kernel_init_freeable+0x22c/0x424
[    0.633310]  kernel_init+0x24/0x13c
[    0.633328]  ret_from_fork+0x10/0x20
[    0.633388]
[    0.708729] Allocated by task 1:
[    0.712078]  kasan_save_stack+0x2c/0x60
[    0.716066]  kasan_set_track+0x2c/0x40
[    0.719959]  kasan_save_alloc_info+0x24/0x3c
[    0.724387]  __kasan_kmalloc+0xa0/0xbc
[    0.728278]  __kmalloc+0x74/0x110
[    0.731740]  fetch_cache_info+0x170/0x210
[    0.735902]  init_cpu_topology+0x254/0x2bc
[    0.740171]  smp_prepare_cpus+0x20/0x15c
[    0.744272]  kernel_init_freeable+0x22c/0x424
[    0.748791]  kernel_init+0x24/0x13c
[    0.752420]  ret_from_fork+0x10/0x20

Best regards,
Krzysztof

--------------0REcS9c6YWq96Psx5p82DcBx
Content-Type: text/plain; charset=UTF-8; name="log.txt"
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gYXJjaF90aW1lcjogY3AxNSBhbmQgbW1pbyB0aW1lcihzKSBydW5u
aW5nIGF0IDE5LjIwTUh6ICh2aXJ0L3ZpcnQpLgpbICAgIDAuMDAwMDAwXSBjbG9ja3NvdXJj
ZTogYXJjaF9zeXNfY291bnRlcjogbWFzazogMHhmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVz
OiAweDQ2ZDk4N2U0NywgbWF4X2lkbGVfbnM6IDQ0MDc5NTIwMjc2NyBucwpbICAgIDAuMDAw
MDAxXSBzY2hlZF9jbG9jazogNTYgYml0cyBhdCAxOU1IeiwgcmVzb2x1dGlvbiA1Mm5zLCB3
cmFwcyBldmVyeSA0Mzk4MDQ2NTExMDc4bnMKWyAgICAwLjAwNTA1MV0gQ29uc29sZTogY29s
b3VyIGR1bW15IGRldmljZSA4MHgyNQpbICAgIDAuNDc4OTgwXSBMb2NrIGRlcGVuZGVuY3kg
dmFsaWRhdG9yOiBDb3B5cmlnaHQgKGMpIDIwMDYgUmVkIEhhdCwgSW5jLiwgSW5nbyBNb2xu
YXIKWyAgICAwLjQ3ODk5Ml0gLi4uIE1BWF9MT0NLREVQX1NVQkNMQVNTRVM6ICA4ClsgICAg
MC40NzkwMDJdIC4uLiBNQVhfTE9DS19ERVBUSDogICAgICAgICAgNDgKWyAgICAwLjQ3OTAx
MV0gLi4uIE1BWF9MT0NLREVQX0tFWVM6ICAgICAgICA4MTkyClsgICAgMC40NzkwMTldIC4u
LiBDTEFTU0hBU0hfU0laRTogICAgICAgICAgNDA5NgpbICAgIDAuNDc5MDI3XSAuLi4gTUFY
X0xPQ0tERVBfRU5UUklFUzogICAgIDMyNzY4ClsgICAgMC40NzkwMzVdIC4uLiBNQVhfTE9D
S0RFUF9DSEFJTlM6ICAgICAgNjU1MzYKWyAgICAwLjQ3OTA0M10gLi4uIENIQUlOSEFTSF9T
SVpFOiAgICAgICAgICAzMjc2OApbICAgIDAuNDc5MDUyXSAgbWVtb3J5IHVzZWQgYnkgbG9j
ayBkZXBlbmRlbmN5IGluZm86IDYzNjUga0IKWyAgICAwLjQ3OTA2MV0gIG1lbW9yeSB1c2Vk
IGZvciBzdGFjayB0cmFjZXM6IDQyMjQga0IKWyAgICAwLjQ3OTA2OV0gIHBlciB0YXNrLXN0
cnVjdCBtZW1vcnkgZm9vdHByaW50OiAxOTIwIGJ5dGVzClsgICAgMC40Nzk5NzZdIENhbGli
cmF0aW5nIGRlbGF5IGxvb3AgKHNraXBwZWQpLCB2YWx1ZSBjYWxjdWxhdGVkIHVzaW5nIHRp
bWVyIGZyZXF1ZW5jeS4uIDM4LjQwIEJvZ29NSVBTIChscGo9MTkyMDApClsgICAgMC40ODAw
MDddIHBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQpbICAgIDAuNDgyMjU2
XSBMU006IFNlY3VyaXR5IEZyYW1ld29yayBpbml0aWFsaXppbmcKWyAgICAwLjQ4NDYyOV0g
TW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3
MiBieXRlcywgbGluZWFyKQpbICAgIDAuNDg0NjkyXSBNb3VudHBvaW50LWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMsIGxpbmVhcikK
WyAgICAwLjUxODI5NV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClsgICAgMC42MTcwMDFdIEJVRzogS0FTQU46
IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBwb3B1bGF0ZV9jYWNoZV9sZWF2ZXMrMHg4NC8weDE1
YwpbICAgIDAuNjI0NDg5XSBXcml0ZSBvZiBzaXplIDQgYXQgYWRkciBmZmZmMGQ4MzQwMDM2
NmM4IGJ5IHRhc2sgc3dhcHBlci8wLzEKWyAgICAwLjYzMTQwMF0KWyAgICAwLjYzMjk3M10g
Q1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNi4xLjAtcnQ1LTAw
MzcyLWdhNjMzOWQwYjRlOGUgIzQ1ClsgICAgMC42MzI5OTVdIEhhcmR3YXJlIG5hbWU6IFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBSb2JvdGljcyBSQjUgKERUKQpbICAgIDAuNjMz
MDA2XSBDYWxsIHRyYWNlOgpbICAgIDAuNjMzMDE0XSAgZHVtcF9iYWNrdHJhY2UucGFydC4w
KzB4ZTAvMHhmMApbICAgIDAuNjMzMDM1XSAgc2hvd19zdGFjaysweDE4LzB4NDAKWyAgICAw
LjYzMzA1MF0gIGR1bXBfc3RhY2tfbHZsKzB4OGMvMHhiOApbICAgIDAuNjMzMDg1XSAgcHJp
bnRfcmVwb3J0KzB4MTg4LzB4NDg4ClsgICAgMC42MzMxMDZdICBrYXNhbl9yZXBvcnQrMHhh
Yy8weGYwClsgICAgMC42MzMxMzZdICBfX2FzYW5fc3RvcmU0KzB4ODAvMHhhNApbICAgIDAu
NjMzMTU4XSAgcG9wdWxhdGVfY2FjaGVfbGVhdmVzKzB4ODQvMHgxNWMKWyAgICAwLjYzMzE4
MV0gIGRldGVjdF9jYWNoZV9hdHRyaWJ1dGVzKzB4YzAvMHg4YzQKWyAgICAwLjYzMzIxM10g
IHVwZGF0ZV9zaWJsaW5nc19tYXNrcysweDI4LzB4NDNjClsgICAgMC42MzMyMzVdICBzdG9y
ZV9jcHVfdG9wb2xvZ3krMHg5OC8weGMwClsgICAgMC42MzMyNTFdICBzbXBfcHJlcGFyZV9j
cHVzKzB4MmMvMHgxNWMKWyAgICAwLjYzMzI4MV0gIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4
MjJjLzB4NDI0ClsgICAgMC42MzMzMTBdICBrZXJuZWxfaW5pdCsweDI0LzB4MTNjClsgICAg
MC42MzMzMjhdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMApbICAgIDAuNjMzMzg4XQpbICAg
IDAuNzA4NzI5XSBBbGxvY2F0ZWQgYnkgdGFzayAxOgpbICAgIDAuNzEyMDc4XSAga2FzYW5f
c2F2ZV9zdGFjaysweDJjLzB4NjAKWyAgICAwLjcxNjA2Nl0gIGthc2FuX3NldF90cmFjaysw
eDJjLzB4NDAKWyAgICAwLjcxOTk1OV0gIGthc2FuX3NhdmVfYWxsb2NfaW5mbysweDI0LzB4
M2MKWyAgICAwLjcyNDM4N10gIF9fa2FzYW5fa21hbGxvYysweGEwLzB4YmMKWyAgICAwLjcy
ODI3OF0gIF9fa21hbGxvYysweDc0LzB4MTEwClsgICAgMC43MzE3NDBdICBmZXRjaF9jYWNo
ZV9pbmZvKzB4MTcwLzB4MjEwClsgICAgMC43MzU5MDJdICBpbml0X2NwdV90b3BvbG9neSsw
eDI1NC8weDJiYwpbICAgIDAuNzQwMTcxXSAgc21wX3ByZXBhcmVfY3B1cysweDIwLzB4MTVj
ClsgICAgMC43NDQyNzJdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDIyYy8weDQyNApbICAg
IDAuNzQ4NzkxXSAga2VybmVsX2luaXQrMHgyNC8weDEzYwpbICAgIDAuNzUyNDIwXSAgcmV0
X2Zyb21fZm9yaysweDEwLzB4MjAKWyAgICAwLjc1NjEzMV0KWyAgICAwLjc1NzcyNl0gVGhl
IGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgb2JqZWN0IGF0IGZmZmYwZDgzNDAwMzY2
MDAKWyAgICAwLjc1NzcyNl0gIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGttYWxsb2Mt
MjU2IG9mIHNpemUgMjU2ClsgICAgMC43NzA2MDddIFRoZSBidWdneSBhZGRyZXNzIGlzIGxv
Y2F0ZWQgMjAwIGJ5dGVzIGluc2lkZSBvZgpbICAgIDAuNzcwNjA3XSAgMjU2LWJ5dGUgcmVn
aW9uIFtmZmZmMGQ4MzQwMDM2NjAwLCBmZmZmMGQ4MzQwMDM2NzAwKQpbICAgIDAuNzgyNjkw
XQpbICAgIDAuNzg0MjU2XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwaHlz
aWNhbCBwYWdlOgpbICAgIDAuNzkwMDA4XSBwYWdlOihfX19fcHRydmFsX19fXykgcmVmY291
bnQ6MSBtYXBjb3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZu
OjB4MTAwMDM0ClsgICAgMC43OTk2ODZdIGhlYWQ6KF9fX19wdHJ2YWxfX19fKSBvcmRlcjoy
IGNvbXBvdW5kX21hcGNvdW50OjAgY29tcG91bmRfcGluY291bnQ6MApbICAgIDAuODA3NDA1
XSBmbGFnczogMHg4MDAwMDAwMDAwMTAyMDAoc2xhYnxoZWFkfG5vZGU9MHx6b25lPTIpClsg
ICAgMC44MTMzNjVdIHJhdzogMDgwMDAwMDAwMDAxMDIwMCAwMDAwMDAwMDAwMDAwMDAwIGRl
YWQwMDAwMDAwMDAxMjIgZmZmZjBkODM0MDAwMjQ4MApbICAgIDAuODIxMzQ5XSByYXc6IDAw
MDAwMDAwMDAwMDAwMDAgMDAwMDAwMDA4MDIwMDAyMCAwMDAwMDAwMWZmZmZmZmZmIDAwMDAw
MDAwMDAwMDAwMDAKWyAgICAwLjgyOTM2NF0gcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46
IGJhZCBhY2Nlc3MgZGV0ZWN0ZWQKWyAgICAwLjgzNTExN10KWyAgICAwLjgzNjY3OV0gTWVt
b3J5IHN0YXRlIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoKWyAgICAwLjg0MTYzOV0gIGZm
ZmYwZDgzNDAwMzY1ODA6IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZj
IGZjIGZjIGZjClsgICAgMC44NDkwODVdICBmZmZmMGQ4MzQwMDM2NjAwOiAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMApbICAgIDAuODU2NTYyXSA+
ZmZmZjBkODM0MDAzNjY4MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMKWyAgICAwLjg2NDAwNV0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4KWyAgICAwLjg2OTc2MF0gIGZmZmYwZDgzNDAwMzY3MDA6
IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjClsgICAg
MC44NzcyMDZdICBmZmZmMGQ4MzQwMDM2NzgwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYwpbICAgIDAuODg0NjUwXSA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KWyAg
ICAwLjg5MjEwMF0gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5nIGR1ZSB0byBrZXJuZWwgdGFp
bnQKWyAgICAwLjkwNDIwMF0gY2JsaXN0X2luaXRfZ2VuZXJpYzogU2V0dGluZyBhZGp1c3Rh
YmxlIG51bWJlciBvZiBjYWxsYmFjayBxdWV1ZXMuClsgICAgMC45MDQyNDFdIGNibGlzdF9p
bml0X2dlbmVyaWM6IFNldHRpbmcgc2hpZnQgdG8gMyBhbmQgbGltIHRvIDEuClsgICAgMC45
MTg3MThdIGNibGlzdF9pbml0X2dlbmVyaWM6IFNldHRpbmcgc2hpZnQgdG8gMyBhbmQgbGlt
IHRvIDEuClsgICAgMC45MjU3MjFdIFJ1bm5pbmcgUkNVLXRhc2tzIHdhaXQgQVBJIHNlbGYg
dGVzdHMKWyAgICAxLjAzNjEwOF0gcmN1OiBIaWVyYXJjaGljYWwgU1JDVSBpbXBsZW1lbnRh
dGlvbi4KWyAgICAxLjAzNjExOF0gcmN1OiAgICAgTWF4IHBoYXNlIG5vLWRlbGF5IGluc3Rh
bmNlcyBpcyA0MDAuClsgICAgMS4wMzY3NTZdIHByaW50azogYm9vdGNvbnNvbGUgW3Fjb21f
Z2VuaTBdIHByaW50aW5nIHRocmVhZCBzdGFydGVkClsgICAgMS4wNDg4MDhdIENhbGxiYWNr
IGZyb20gY2FsbF9yY3VfdGFza3NfdHJhY2UoKSBpbnZva2VkLgpbICAgIDEuMDgxNzExXSBF
Rkkgc2VydmljZXMgd2lsbCBub3QgYmUgYXZhaWxhYmxlLgpbICAgIDEuMDkxNTI5XSBzbXA6
IEJyaW5naW5nIHVwIHNlY29uZGFyeSBDUFVzIC4uLgpbICAgIDEuMTAzNTg1XSBEZXRlY3Rl
ZCBWSVBUIEktY2FjaGUgb24gQ1BVMQpbICAgIDEuMTAzNzQ3XSBHSUN2MzogQ1BVMTogZm91
bmQgcmVkaXN0cmlidXRvciAxMDAgcmVnaW9uIDA6MHgwMDAwMDAwMDE3YTgwMDAwClsgICAg
MS4xMDM4MzBdIENQVTE6IEJvb3RlZCBzZWNvbmRhcnkgcHJvY2Vzc29yIDB4MDAwMDAwMDEw
MCBbMHg1MWRmODA1ZV0KWyAgICAxLjEyOTc2N10gRGV0ZWN0ZWQgVklQVCBJLWNhY2hlIG9u
IENQVTIKWyAgICAxLjEyOTkxMV0gR0lDdjM6IENQVTI6IGZvdW5kIHJlZGlzdHJpYnV0b3Ig
MjAwIHJlZ2lvbiAwOjB4MDAwMDAwMDAxN2FhMDAwMApbICAgIDEuMTI5OTc5XSBDUFUyOiBC
b290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAyMDAgWzB4NTFkZjgwNWVdClsg
ICAgMS4xNTU3NDJdIERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFUzClsgICAgMS4xNTU4
NzZdIEdJQ3YzOiBDUFUzOiBmb3VuZCByZWRpc3RyaWJ1dG9yIDMwMCByZWdpb24gMDoweDAw
MDAwMDAwMTdhYzAwMDAKWyAgICAxLjE1NTkzNl0gQ1BVMzogQm9vdGVkIHNlY29uZGFyeSBw
cm9jZXNzb3IgMHgwMDAwMDAwMzAwIFsweDUxZGY4MDVlXQpbICAgIDEuMTgyNzkxXSBDUFUg
ZmVhdHVyZXM6IGRldGVjdGVkOiBTcGVjdHJlLXY0ClsgICAgMS4xODI4MjRdIENQVSBmZWF0
dXJlczogZGV0ZWN0ZWQ6IFNwZWN0cmUtQkhCClsgICAgMS4xODI4NTRdIENQVSBmZWF0dXJl
czogZGV0ZWN0ZWQ6IEFSTSBlcnJhdHVtIDE1MDg0MTIgKGtlcm5lbCBwb3J0aW9uKQpbICAg
IDEuMTgyOTAwXSBEZXRlY3RlZCBQSVBUIEktY2FjaGUgb24gQ1BVNApbICAgIDEuMTgzMTg3
XSBHSUN2MzogQ1BVNDogZm91bmQgcmVkaXN0cmlidXRvciA0MDAgcmVnaW9uIDA6MHgwMDAw
MDAwMDE3YWUwMDAwClsgICAgMS4xODMyOTRdIENQVTQ6IEJvb3RlZCBzZWNvbmRhcnkgcHJv
Y2Vzc29yIDB4MDAwMDAwMDQwMCBbMHg0MTFmZDBkMF0KWyAgICAxLjIyNTY0MF0gRGV0ZWN0
ZWQgUElQVCBJLWNhY2hlIG9uIENQVTUKWyAgICAxLjIyNjAwMF0gR0lDdjM6IENQVTU6IGZv
dW5kIHJlZGlzdHJpYnV0b3IgNTAwIHJlZ2lvbiAwOjB4MDAwMDAwMDAxN2IwMDAwMApbICAg
IDEuMjI2MDk5XSBDUFU1OiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDA1
MDAgWzB4NDExZmQwZDBdClsgICAgMS4yNTIzNThdIERldGVjdGVkIFBJUFQgSS1jYWNoZSBv
biBDUFU2ClsgICAgMS4yNTI3MjJdIEdJQ3YzOiBDUFU2OiBmb3VuZCByZWRpc3RyaWJ1dG9y
IDYwMCByZWdpb24gMDoweDAwMDAwMDAwMTdiMjAwMDAKWyAgICAxLjI1MjgyMV0gQ1BVNjog
Qm9vdGVkIHNlY29uZGFyeSBwcm9jZXNzb3IgMHgwMDAwMDAwNjAwIFsweDQxMWZkMGQwXQpb
ICAgIDEuMjY2MDI0XSBDYWxsYmFjayBmcm9tIGNhbGxfcmN1X3Rhc2tzKCkgaW52b2tlZC4K
WyAgICAxLjI4NDMwM10gRGV0ZWN0ZWQgUElQVCBJLWNhY2hlIG9uIENQVTcKWyAgICAxLjI4
NDQ3NV0gR0lDdjM6IENQVTc6IGZvdW5kIHJlZGlzdHJpYnV0b3IgNzAwIHJlZ2lvbiAwOjB4
MDAwMDAwMDAxN2I0MDAwMApbICAgIDEuMjg0NTI1XSBDUFU3OiBCb290ZWQgc2Vjb25kYXJ5
IHByb2Nlc3NvciAweDAwMDAwMDA3MDAgWzB4NDExZmQwZDBdClsgICAgMS4yODQ5MjZdIHNt
cDogQnJvdWdodCB1cCAxIG5vZGUsIDggQ1BVcwpbICAgIDEuMjg0OTQzXSBTTVA6IFRvdGFs
IG9mIDggcHJvY2Vzc29ycyBhY3RpdmF0ZWQuClsgICAgMS4yODQ5NTRdIENQVSBmZWF0dXJl
czogZGV0ZWN0ZWQ6IDMyLWJpdCBFTDAgU3VwcG9ydApbICAgIDEuMjg0OTYzXSBDUFUgZmVh
dHVyZXM6IGRldGVjdGVkOiBEYXRhIGNhY2hlIGNsZWFuIHRvIHRoZSBQb1Ugbm90IHJlcXVp
cmVkIGZvciBJL0QgY29oZXJlbmNlClsgICAgMS4yODQ5NzVdIENQVSBmZWF0dXJlczogZGV0
ZWN0ZWQ6IENvbW1vbiBub3QgUHJpdmF0ZSB0cmFuc2xhdGlvbnMKWyAgICAxLjI4NDk4NV0g
Q1BVIGZlYXR1cmVzOiBkZXRlY3RlZDogQ1JDMzIgaW5zdHJ1Y3Rpb25zClsgICAgMS4yODQ5
OTldIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IFJDcGMgbG9hZC1hY3F1aXJlIChMREFQUikK
WyAgICAxLjI4NTAwOV0gQ1BVIGZlYXR1cmVzOiBkZXRlY3RlZDogTFNFIGF0b21pYyBpbnN0
cnVjdGlvbnMKWyAgICAxLjI4NTAxOV0gQ1BVIGZlYXR1cmVzOiBkZXRlY3RlZDogUHJpdmls
ZWdlZCBBY2Nlc3MgTmV2ZXIKWyAgICAxLjI4NTAyOV0gQ1BVIGZlYXR1cmVzOiBkZXRlY3Rl
ZDogUkFTIEV4dGVuc2lvbiBTdXBwb3J0ClsgICAgMS4yODUwNDRdIENQVSBmZWF0dXJlczog
ZGV0ZWN0ZWQ6IFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzc2luZyBTYWZlIChTU0JTKQpbICAg
IDEuMjk2ODI2XSBDUFU6IEFsbCBDUFUocykgc3RhcnRlZCBhdCBFTDEKWyAgICAxLjI5Njg5
MV0gYWx0ZXJuYXRpdmVzOiBhcHBseWluZyBzeXN0ZW0td2lkZSBhbHRlcm5hdGl2ZXMKWyAg
ICAxLjMxNTY0MV0gZGV2dG1wZnM6IGluaXRpYWxpemVkClsgICAgMS42NzAxMjNdIGNsb2Nr
c291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZm
ZmYsIG1heF9pZGxlX25zOiAxOTExMjYwNDQ2Mjc1MDAwIG5zClsgICAgMS42NzAzMjddIGZ1
dGV4IGhhc2ggdGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDYsIDM5MzIxNiBieXRlcywg
bGluZWFyKQpbICAgIDEuNjczNTM3XSBwaW5jdHJsIGNvcmU6IGluaXRpYWxpemVkIHBpbmN0
cmwgc3Vic3lzdGVtClsgICAgMS42ODQwMjFdIERNSSBub3QgcHJlc2VudCBvciBpbnZhbGlk
LgpbICAgIDEuNjg3MTY1XSBORVQ6IFJlZ2lzdGVyZWQgUEZfTkVUTElOSy9QRl9ST1VURSBw
cm90b2NvbCBmYW1pbHkKWyAgICAxLjY5NTU5NV0gRE1BOiBwcmVhbGxvY2F0ZWQgMTAyNCBL
aUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9taWMgYWxsb2NhdGlvbnMKWyAgICAxLjY5NjM3
M10gRE1BOiBwcmVhbGxvY2F0ZWQgMTAyNCBLaUIgR0ZQX0tFUk5FTHxHRlBfRE1BIHBvb2wg
Zm9yIGF0b21pYyBhbGxvY2F0aW9ucwpbICAgIDEuNjk4Mzc5XSBETUE6IHByZWFsbG9jYXRl
ZCAxMDI0IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEzMiBwb29sIGZvciBhdG9taWMgYWxsb2Nh
dGlvbnMKWyAgICAxLjY5ODc0Ml0gYXVkaXQ6IGluaXRpYWxpemluZyBuZXRsaW5rIHN1YnN5
cyAoZGlzYWJsZWQpClsgICAgMS42OTk2MjhdIGF1ZGl0OiB0eXBlPTIwMDAgYXVkaXQoMS42
Mjg6MSk6IHN0YXRlPWluaXRpYWxpemVkIGF1ZGl0X2VuYWJsZWQ9MCByZXM9MQpbICAgIDEu
NzA4NTQzXSB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdzdGVw
X3dpc2UnClsgICAgMS43MDg1NzBdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwg
Z292ZXJub3IgJ3Bvd2VyX2FsbG9jYXRvcicKWyAgICAxLjcwODk2MV0gY3B1aWRsZTogdXNp
bmcgZ292ZXJub3IgbGFkZGVyClsgICAgMS43MDkwMzVdIGNwdWlkbGU6IHVzaW5nIGdvdmVy
bm9yIG1lbnUKWyAgICAxLjcwOTg0OV0gTkVUOiBSZWdpc3RlcmVkIFBGX1FJUENSVFIgcHJv
dG9jb2wgZmFtaWx5ClsgICAgMS43MTEzNDVdIGh3LWJyZWFrcG9pbnQ6IGZvdW5kIDYgYnJl
YWtwb2ludCBhbmQgNCB3YXRjaHBvaW50IHJlZ2lzdGVycy4KWyAgICAxLjcxOTI5N10gQVNJ
RCBhbGxvY2F0b3IgaW5pdGlhbGlzZWQgd2l0aCAzMjc2OCBlbnRyaWVzClsgICAgMS43MzMx
OTddIFNlcmlhbDogQU1CQSBQTDAxMSBVQVJUIGRyaXZlcgpbICAgIDEuODU1MzM5XSBwbGF0
Zm9ybSAxZDg3MDAwLnBoeTogRml4aW5nIHVwIGN5Y2xpYyBkZXBlbmRlbmN5IHdpdGggMWQ4
NDAwMC51ZnNoYwpbICAgIDIuMDQxMjc5XSBLQVNMUiBlbmFibGVkClsgICAgMi4xNzQ2MTJd
IEh1Z2VUTEI6IHJlZ2lzdGVyZWQgMS4wMCBHaUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVk
IDAgcGFnZXMKWyAgICAyLjE3NDYyNl0gSHVnZVRMQjogMTYzODAgS2lCIHZtZW1tYXAgY2Fu
IGJlIGZyZWVkIGZvciBhIDEuMDAgR2lCIHBhZ2UKWyAgICAyLjE3NDYzNF0gSHVnZVRMQjog
cmVnaXN0ZXJlZCAzMi4wIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpb
ICAgIDIuMTc0NjQwXSBIdWdlVExCOiA1MDggS2lCIHZtZW1tYXAgY2FuIGJlIGZyZWVkIGZv
ciBhIDMyLjAgTWlCIHBhZ2UKWyAgICAyLjE3NDY0N10gSHVnZVRMQjogcmVnaXN0ZXJlZCAy
LjAwIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpbICAgIDIuMTc0NjUy
XSBIdWdlVExCOiAyOCBLaUIgdm1lbW1hcCBjYW4gYmUgZnJlZWQgZm9yIGEgMi4wMCBNaUIg
cGFnZQpbICAgIDIuMTc0NjYwXSBIdWdlVExCOiByZWdpc3RlcmVkIDY0LjAgS2lCIHBhZ2Ug
c2l6ZSwgcHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMi4xNzQ2NjVdIEh1Z2VUTEI6IDAg
S2lCIHZtZW1tYXAgY2FuIGJlIGZyZWVkIGZvciBhIDY0LjAgS2lCIHBhZ2UKWyAgICAyLjE4
ODU4M10gQUNQSTogSW50ZXJwcmV0ZXIgZGlzYWJsZWQuClsgICAgMi4zMDY2NDVdIGlvbW11
OiBEZWZhdWx0IGRvbWFpbiB0eXBlOiBUcmFuc2xhdGVkClsgICAgMi4zMDY2NjBdIGlvbW11
OiBETUEgZG9tYWluIFRMQiBpbnZhbGlkYXRpb24gcG9saWN5OiBzdHJpY3QgbW9kZQpbICAg
IDIuMzEwMzQzXSBTQ1NJIHN1YnN5c3RlbSBpbml0aWFsaXplZApbICAgIDIuMzEzNjExXSB1
c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmZzClsgICAgMi4z
MTM5ODddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgaHViClsg
ICAgMi4zMTQzMTRdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRldmljZSBkcml2ZXIgdXNi
ClsgICAgMi4zMjExMzhdIHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVyLiAxIHJlZ2lzdGVy
ZWQKWyAgICAyLjMyMTE0NF0gcHBzX2NvcmU6IFNvZnR3YXJlIHZlci4gNS4zLjYgLSBDb3B5
cmlnaHQgMjAwNS0yMDA3IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRpQGxpbnV4Lml0Pgpb
ICAgIDIuMzIxMjQ2XSBQVFAgY2xvY2sgc3VwcG9ydCByZWdpc3RlcmVkClsgICAgMi4zMjE0
NTJdIEVEQUMgTUM6IFZlcjogMy4wLjAKWyAgICAyLjMyNDg1M10gQ1BVaWRsZSBQU0NJOiBJ
bml0aWFsaXplZCBDUFUgUE0gZG9tYWluIHRvcG9sb2d5ClsgICAgMi4zMjc1NjRdIHFjb21f
c2NtOiBjb252ZW50aW9uOiBzbWMgYXJtIDY0ClsgICAgMi4zMzU4NjJdIEZQR0EgbWFuYWdl
ciBmcmFtZXdvcmsKCg==

--------------0REcS9c6YWq96Psx5p82DcBx--

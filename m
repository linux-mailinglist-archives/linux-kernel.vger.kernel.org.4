Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C370AC27
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEUDWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 23:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEUDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 23:22:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F5119
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 20:22:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E93155C0073;
        Sat, 20 May 2023 23:22:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 20 May 2023 23:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684639357; x=1684725757; bh=5x449E8xOblw0cWhc2zaiCyBHOICHOXIWTj
        e+n35wtI=; b=EjtTcWCh+TATl0B1ppu+eEjmWT6bkd/Z1dLDzpA8brfCmq+zS2M
        MICMbj7XZ/IUEeRugfbjWi8l9hg/Eqj/m9q1BnyDpDiza4zMRZg2ebbQW6wmiaqk
        wSjmmpd/EV2tMI3DjxwUYdf0bhCQCI5TlV5wsrqWjBJM2Rmmm7bRg5PffH0JsAXQ
        Uez4r12kKLLhfQid8sMnXI36N9qRePhiCWc6+AFUUV3auvX6VRzCt8LeCzZd0zsI
        pRGb8tMF2lsgqRSDFT+vopNd8qDC1dWaJ3mxoaO8VpXauTIFNUBPBJ1hfv8ruwGG
        5CMXEGCagyopfcW6fG5phHP94cr/m6t/fjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684639357; x=1684725757; bh=5x449E8xOblw0cWhc2zaiCyBHOICHOXIWTj
        e+n35wtI=; b=G05n+AltallEGNUVXYH17ypowjA8m+ND4dth3mdHO35rYgtI390
        x95JOdFUmXj0Va/RthgNlqWBgZbEFDciRxK8omPhaebCusJZtefTljzL/Mn9oSDV
        emGolvlAZ1AeNRlsYG955vt0ql0CfUH1iQ26uncu5NQx4PaYduNtjd8NpDgXjNYW
        91BsKGnH7urKNK7zvcHDtRileZT2FUPU/HyMetndXhw6rEMk5GvjptFVwpD7kPIj
        4TVCaWYru1KfgWMz5fd9sPjs4VMyloGxp0nXIUcP2k0ess0dXKuc3ow7jjGEs+SE
        5UoVJKOfYWYzwF2aTvJvdBmfEV3aZ83pRyw==
X-ME-Sender: <xms:fY5pZJSiHUyjM8DxzMZ6P4obLTPGHBerBHXZDXd2C8jCrcvsvlN_lw>
    <xme:fY5pZCxNFYn2P-Jtu0cEXFVXIYsFI4AiwMQ9eOItDQ74jBocWViG0wF9HliLAVZij
    ni4UPuXhnFxfFW6zQ>
X-ME-Received: <xmr:fY5pZO27V8WyJw4lJo8OuChWYJC1oIM3x-Exkyk6bZC87-z7dOXDDnHpzH71Gajrtcx9Dek5OXnIXYLeOTMIfChqf9IIRiXK2ylMd51cWrB75NFur0NLy6rQvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeikedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:fY5pZBBekeLprzpI4h8vjuEu24cNSyqf3eVQcSzb3FO_uQ2JodkDBQ>
    <xmx:fY5pZCgxa-XbBl9A-fIsGlQmW3FeA4cm1MTPYFXXOJL6XhCbQRTTyg>
    <xmx:fY5pZFp6lH4KWGXIbwraOziZusg7LxduYl937an2WCvISqsZRceDNw>
    <xmx:fY5pZLV50QlMhrKsAZpnbRyz5eRmuTkDRnr8aDsK4asVGVf3STEpVg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 May 2023 23:22:36 -0400 (EDT)
Message-ID: <51339689-b92f-52fb-9202-2b91733f9180@sholland.org>
Date:   Sat, 20 May 2023 22:22:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
References: <ZGl8gn/rD8WZ0nak@x1>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: riscv: boot failure for 3335068f8721 ("riscv: Use PUD/P4D/PGD
 pages for the linear mapping")
In-Reply-To: <ZGl8gn/rD8WZ0nak@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Drew,

On 5/20/23 21:05, Drew Fustini wrote:
> Hello, I tested 6.4-rc1 on an internal RISC-V SoC and observed a boot
> failure on a Store/AMO access fault (exception code 7) in __memset().
> stval (e.g. badaddr) was set to 0xffffaf8000000000. This SoC is RV64GC
> with Sv48 so it seems that address is the start of the "direct mapping
> of all physical memory" [1].
> 
> The 6.3 release boots okay and the system is able to operate correctly
> with an Ubuntu 23.04 rootfs on eMMC. Therefore, I decided to bisect and
> I found the failure begins with 3335068f8721 ("riscv: Use PUD/P4D/PGD
> pages for the linear mapping"). The system boots okay with the prior
> commit 8589e346bbb6 ("riscv: Move the linear mapping creation in its
> own function").
> 
> The boot log [2] shows that the fault happens right after buildroot's
> init script [3] uses switch_root to execute init from the Ubuntu rootfs
> on the eMMC.
> 
> DWARF4 is enabled in .config [4] and the decoded stack trace [5] shows:
> 
>   epc : __memset (/eng/dfustini/gitlab/linux/arch/riscv/lib/memset.S:67)
> 
> From memset.S:
> 
>  Line 67:         REG_S a1,        0(t0)
> 
> From the oops:
> 
>  epc : ffffffff81122d6c ra : ffffffff80218504 sp : ffffaf8002e47500
>   gp : ffffffff82695010 tp : ffffaf8002e2ec00 t0 : ffffaf8000000000
>   t1 : 0000000000000080 t2 : 0000000000000001 s0 : ffffaf8002e47550
>   s1 : ffff8d8200000040 a0 : ffffaf8000000000 a1 : 0000000000000000
> 
> Thus I think it is trying to store 0x0 to 0xffffaf8000000000 which is
> the start of the direct map. From the boot log [2], OpenSBI shows:
> 
>  Domain0 Region00 : 0x0000000002080000-0x00000000020bffff M: (I,R,W) S/U: ()
>  Domain0 Region01 : 0x0000008000000000-0x000000800003ffff M: (R,W,X) S/U: ()
>  Domain0 Region02 : 0x0000000002000000-0x000000000207ffff M: (I,R,W) S/U: ()
>  Domain0 Region03 : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
> 
> The DDR memory on this SoC starts at 0x8000000000 with size 2GB. The
> memory node from the device tree [6]:
> 
>         memory@8000000000 {
>                 device_type = "memory";
>                 reg = <0x80 0 0x00000000 0x80000000>;
>         };
> 
> I think the direct map address 0xffffaf8000000000 would map to physical
> address 0x8000000000. Thus I think the attempted store in S-mode to that
> address would violate the PMP settings for Region01.
> 
> I do not yet understand why this happens with 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") but not for the prior commit
> 8589e346bbb6 ("riscv: Move the linear mapping creation in its own
> function").

Where does Linux's DTB come from? It should be the one that was modified
by OpenSBI to add a reserved-memory node matching PMP Region01
(fdt_reserved_memory_fixup()).

Before this commit, Linux ignored the first 2 MiB of physical RAM. So if
OpenSBI was loaded in this region, you could get away with ignoring the
firmware-provided DTB; now you actually need to use it, as intended.

Regards,
Samuel


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67A963B98D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiK2Fsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiK2Fsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:48:36 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE627DE3;
        Mon, 28 Nov 2022 21:48:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DD4BD5C01DE;
        Tue, 29 Nov 2022 00:48:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 29 Nov 2022 00:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669700914; x=
        1669787314; bh=OtfQNo4nBjhbfnvx8isDNgBx4T5htxvRGKcm6tW94mg=; b=o
        avnOvJEzRNfJ7QUj2BqBionlqcCj/DsrLIsZ3IwKxhy5538k1ZzBTSRtClb04QuM
        G2Y8ugcQmJDnPw4vuUSlUlTV13DlrmnSLgsa71pGkWXp+IY0jWc6LkRTEK2JO+1Y
        gOUv3XY9Dlk4c9lMZnF+KQioKtF1q3JKx9hqnVQEGaIssLMQoMG6sIhy6YkST6V0
        GA4f2g8rIv+H+LT0YZaxce2SIC3rybJLoH0dk7YWbgMFpilZKV4xWaS3EI4Vg1yN
        pudsB3axUtlccw92duJY0HgswWEdxQYyZ0eKf/EtDgHcv72iEl8TBJDyts//x0q7
        kHx/IAJqWpMhlvq5Mdcyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669700914; x=
        1669787314; bh=OtfQNo4nBjhbfnvx8isDNgBx4T5htxvRGKcm6tW94mg=; b=e
        T84H1ozXR+7bsLn30kqtVVW/xXB160B9oiA9AcQRX9Ld8A9c3sCzILEiGJOYH2GC
        dQMtKBhkLfa/VvQbMy1ZMkhk+GDvOg1kl+zFl2sSSlkIUuOpi0pJDDaVYvQAVUBM
        qTOv4x3eSNuk4+rjfctj3w6n0n90iYgP6vMk/NI+lIEcCZv1A8oDQGZDd0zHIn8/
        7qLF/ZzBDNEjvr3+bYwgdOPa5QbjLiFlkNjElT2foITOcsqVK7fMIb1rjK83fV6e
        dIhEALlnMuwaZJA9X3xeqYA8Lr4scOrhLkKJdDEgar84YRiQZq3I6J7nDrppzquC
        EotvH36gFIQrPLDJxDDCA==
X-ME-Sender: <xms:MZ2FYy0GJnIOdwFN6ZYPPzr3ULSQeCz83ro34gjwHFGjM4lLbiwMJQ>
    <xme:MZ2FY1ErL8O0gihDnKlSVlqRQvQCu1ldPteOs2LA4ZcL3z2563SIVFQWaFcgt6Aid
    W9dypPnPeTQb8Sgug>
X-ME-Received: <xmr:MZ2FY66PDKB_m2iiDzVViphUSkU-M5pK0U6g-UJym6_hcL-qXbfwRtxGPjkh4KKe1wRktMWSNvMWcIHu6e5cnWtYONkgTm19xGehKTekyE5lmsNgqBqsGfin-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepteeuvddvveeigefhkeduueduudefgfdvleejgfeiuefgjefhteei
    hfdtleffgeelnecuffhomhgrihhnpegrnhguvghsthgvtghhrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Mp2FYz3tugtGPNTJlPrs0FVGIA4iDG_IuTpKu8k2XsV8BUKor3NkKQ>
    <xmx:Mp2FY1GVO8bfXIyBPllldm06Ip7cS4oKyn2iSk1_sLOJuoyWSLxYjw>
    <xmx:Mp2FY8_1F1UbL5viVm-RsYz2Uhu9r7b7Dj84ecrgi6ACNt6jFCvRiA>
    <xmx:Mp2FY8kX6RIb12MRVwEMimvW_EmQDzR2b9ERm97fYWRCUI9BFaOmuQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 00:48:32 -0500 (EST)
Message-ID: <df0fed9d-6d0a-3e76-1ebf-920e4d19d624@sholland.org>
Date:   Mon, 28 Nov 2022 23:48:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     opensbi@lists.infradead.org, Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org>
 <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
 <CAMuHMdWQO_usrJwmVYDx6o-CpzmotVZLt176eKbqLzY-GXiDng@mail.gmail.com>
 <CA+V-a8s5mZoLMhjjpo_89taaBx+M_EwXMZUu-TUpZc8Q3bw4ug@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five
 SoC
In-Reply-To: <CA+V-a8s5mZoLMhjjpo_89taaBx+M_EwXMZUu-TUpZc8Q3bw4ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 06:08, Lad, Prabhakar wrote:
> Hi Geert,
> 
> On Sun, Nov 27, 2022 at 9:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Prabhakar,
>>
>> On Sat, Nov 26, 2022 at 10:10 PM Lad, Prabhakar
>> <prabhakar.csengg@gmail.com> wrote:
>>> On Fri, Nov 25, 2022 at 7:43 PM Samuel Holland <samuel@sholland.org> wrote:
>>>> On 11/24/22 11:22, Prabhakar wrote:
>>>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>>
>>>>> On the AX45MP core, cache coherency is a specification option so it may
>>>>> not be supported. In this case DMA will fail. As a workaround, firstly we
>>>>> allocate a global dma coherent pool from which DMA allocations are taken
>>>>> and marked as non-cacheable + bufferable using the PMA region as specified
>>>>> in the device tree. Synchronization callbacks are implemented to
>>>>> synchronize when doing DMA transactions.
>>>>>
>>>>> The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
>>>>> block that allows dynamic adjustment of memory attributes in the runtime.
>>>>> It contains a configurable amount of PMA entries implemented as CSR
>>>>> registers to control the attributes of memory locations in interest.
>>>>>
>>>>> Below are the memory attributes supported:
>>>>> * Device, Non-bufferable
>>>>> * Device, bufferable
>>>>> * Memory, Non-cacheable, Non-bufferable
>>>>> * Memory, Non-cacheable, Bufferable
>>>>> * Memory, Write-back, No-allocate
>>>>> * Memory, Write-back, Read-allocate
>>>>> * Memory, Write-back, Write-allocate
>>>>> * Memory, Write-back, Read and Write-allocate
>>>>>
>>>>> This patch adds support to configure the memory attributes of the memory
>>>>> regions as passed from the l2 cache node and exposes the cache management
>>>>> ops.
>>>>
>>>> Forgive my ignorance, but why do you need both a DMA pool and explicit
>>>> cache maintenance? Wouldn't the purpose of marking a memory region as
>>>> permanently non-cacheable be to avoid cache maintenance? And likewise,
>>>> if you are doing cache maintenance anyway, why does it matter if/how the
>>>> memory is cacheable?
>>>>
>>> "Memory, Non-cacheable, Bufferable" raises an AXI signal for
>>> transactions hence needing SW implementation for cache maintenance.
>>>
>>>>> More info about PMA (section 10.3):
>>>>> Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
>>>>>
>>>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>>>>> +static int ax45mp_configure_pma_regions(struct device_node *np)
>>>>> +{
>>>>> +     const char *propname = "andestech,pma-regions";
>>>>> +     u32 start, size, flags;
>>>>> +     unsigned int entry_id;
>>>>> +     unsigned int i;
>>>>> +     int count;
>>>>> +     int ret;
>>>>> +
>>>>> +     count = of_property_count_elems_of_size(np, propname, sizeof(u32) * 3);
>>>>> +     if (count < 0)
>>>>> +             return count;
>>>>> +
>>>>> +     if (count > AX45MP_MAX_PMA_REGIONS)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
>>>>> +             of_property_read_u32_index(np, propname, i, &start);
>>>>> +             of_property_read_u32_index(np, propname, i + 1, &size);
>>>>> +             of_property_read_u32_index(np, propname, i + 2, &flags);
>>>>> +             ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
>>>>> +             if (!ret)
>>>>> +                     pr_err("Failed to setup PMA region 0x%x - 0x%x flags: 0x%x",
>>>>> +                            start, start + size, flags);
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>
>>>> If firmware support is required to set up these PMA regions, why is
>>>> Linux doing this at all? The firmware has access to the devicetree as
>>>> well. It can set this up before entering S-mode, and then you don't need
>>>> to expose this capability via an SBI extension. In fact, firmware could
>>>> generate the reserved-memory node based on these regions at runtime (or
>>>> vice versa).
>>>>
>>> That's a good point. I'll do some research on this and get back.
>>>
>>> Btw are there any existing examples where the firmware adds DT nodes?
>>
>> /memory, reserved-memory, optee on ARM, RPC status on R-Car Gen3/4, ...
>>
> On the TF-A we pass the FDT blob to u-boot and this does the magic.
> 
> On the RISC-V what would be the correct approach?
> - We setup the PMA regions in OpenSBI
> - We provide a vendor specific EXT to check if the PMA is setup
> - In u-boot ft_board_setup() callback add the reserved-memory node
> 
> Does the above approach sound good or is there a better approach I'm missing?

My suggestion was to fix up the DT in OpenSBI itself. See
lib/utils/fdt/fdt_fixup.c in the OpenSBI source tree. There is also a
platform hook for this. Then OpenSBI passes the FDT to U-Boot, and
U-Boot passes it on to Linux. No SBI extension is needed in that case.

If you optionally want your U-Boot to support loading a replacement FDT
from disk, then ft_board_setup() would need to copy the reserved-memory
nodes from U-Boot's control FDT to the loaded FDT. But this logic is the
same for all reserved-memory nodes, including the one OpenSBI adds
already. U-Boot has some code for this copying which you could reuse.

Regards,
Samuel


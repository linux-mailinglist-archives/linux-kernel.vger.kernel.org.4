Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B333D69F867
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjBVPzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBVPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:55:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA923B3FA;
        Wed, 22 Feb 2023 07:55:35 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BF0335C01A5;
        Wed, 22 Feb 2023 10:55:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Feb 2023 10:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677081334; x=
        1677167734; bh=w67oEu2E19AZfAjVi0U6OotIuBhYGM6gAf2Nt5qYYBU=; b=B
        w3Y7oWb6zR5Hy1tIOLHDPZwtv+tzKifOSl2K7jIA6SWWH8GNw7a6SDHmwQLrdBuQ
        e/noD0F4HdYwQvk5Vk2pS/iJWAMAKVQa3omEz+Qo6kDa2hyWa/VfVyxWkDy+23zF
        89Ytetx5+OInv03VdiNvB81vUum98r3Ig7KwaE7yfUieFQF5RMKaTvBgN+sq5idY
        v+32DQZMj4Z4EHdoyn5qmxTYIBlHwkCsUBE0ZKb6B1NA/YDktW4EKwsUp8hDspQI
        d0kszAiklI0yq+AfnnF322KyI4RXoH/r/PmB/MuuSVYRtaaGduYOHR/9vtQdVqf3
        CKGtfIpym8qMcgEubu6yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677081334; x=
        1677167734; bh=w67oEu2E19AZfAjVi0U6OotIuBhYGM6gAf2Nt5qYYBU=; b=g
        3z+0c2oLRO9m2vG7FYwPiirPv2tmDR4JTPz/L696D7dTzEHPcamN9tcD0242eWRn
        VcEiGX9OXUdrHQ0tHNu0kep7ry54Km8oG2cEcoAKc6TzWldLPUH5Isg+vdLgU8OE
        RdM6FDAIPu/ix24rWP0XaVZRBJOIRtnYmfxoLOdrNwFNwQHm9Llc9L9UZ14gTQ5L
        KXE5n9YVunWkQgm0SDDcJ7Srz8D3EuXWYqtyCS4szzw+DC/Kdo56ne1AsHgZ1JAC
        FvrjFVurYPQSBFUwyW9Z+9SwscA1PX9ApgNZpaY47Gc6DqoE6NuZ+CeFd+1dI33c
        ZZpDuQXFMfP0CBsKY4k8g==
X-ME-Sender: <xms:9Tr2Y84p9rx2_U9mTVCy2jC7J-xXkMqdYPoMPhb1i5XBdeAVv75Dzw>
    <xme:9Tr2Y978PBRzrhsd43EZEzXxVfQjYqcFv30n8xp_v0iu2SW6drrlLFdp_2BAd7ZVV
    caXa4xjJ_RUXy3N1rc>
X-ME-Received: <xmr:9Tr2Y7d2LwF0HO9JahyvBZIIxVsyiyfWMKUvYHg60ZAzD3vDry8p9ORwgImmGOUh38Us>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9Tr2YxJidY20RX6wrJ4ef8Tvw837BX92FROYlm7Yp8d__tzfADpb6A>
    <xmx:9Tr2YwKy8vGbMO44sGnG5YM9rl5jTcLkWR2LVo2gOxPhSrXbL3sbpQ>
    <xmx:9Tr2YywzAmdQFIOq81iYwotob1yANO2k334rmGd-und2_KtuASxoSA>
    <xmx:9jr2Y-xoexrMS1sbQ9FyOyXs-6P7Zk_BSjXjqG6_s0lk4FJzeOuN5g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 10:55:31 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 2/3] riscv: Set dma_default_coherent to true
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <Y/YrvDBJcYUQt4WC@spud>
Date:   Wed, 22 Feb 2023 15:55:19 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BBA7BEA-8595-436D-B4BF-D7DB95069C53@flygoat.com>
References: <20230222133712.8079-1-jiaxun.yang@flygoat.com>
 <20230222133712.8079-3-jiaxun.yang@flygoat.com> <Y/YrvDBJcYUQt4WC@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8822=E6=97=A5 14:50=EF=BC=8CConor Dooley =
<conor@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Feb 22, 2023 at 01:37:11PM +0000, Jiaxun Yang wrote:
>> For riscv our assumption is unless a device states it is =
non-coherent,
>> we take it to be DMA coherent.
>>=20
>> For devicetree probed devices that have been true since very begining
>> with OF_DMA_DEFAULT_COHERENT selected.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> arch/riscv/kernel/setup.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 376d2827e736..34b371180976 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -300,6 +300,9 @@ void __init setup_arch(char **cmdline_p)
>> riscv_init_cbom_blocksize();
>> riscv_fill_hwcap();
>> apply_boot_alternatives();
>> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>> + dma_default_coherent =3D true;
>> +#endif
>=20
> Do we really need to add ifdeffery for this here?
> It's always coherent by default, so why do we need to say set it in
> setup_arch() when we know that, regardless of options, it is true?

Because this symbol is only a variable when:

defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)

Which is only true if  CONFIG_RISCV_DMA_NONCOHERENT is selected.

Otherwise this symbol is defined to true and we can=E2=80=99t make a =
assignment to it.

Thanks
- Jiaxun


>=20
> Cheers,
> Conor.
>=20
>> if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
>>     riscv_isa_extension_available(NULL, ZICBOM))
>> riscv_noncoherent_supported();
>> --=20
>> 2.37.1 (Apple Git-137.1)



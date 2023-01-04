Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768A65D085
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjADKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjADKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:20:11 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D021CFEE;
        Wed,  4 Jan 2023 02:20:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 91F435C01CF;
        Wed,  4 Jan 2023 05:20:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 05:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672827605; x=1672914005; bh=8iXmcHFFNZ
        h9AmH4Kilxio1EfsB6nCxBvRuiZDX3K/M=; b=e2/nToEoyFuPKgFE+6AZ+dnZg8
        UbR+0CntnFotz/eOIJHA96OR/Bm7laq07XDlEGGPVyb8f/H93Lp04/Z0XuE0vVzJ
        WpYjX0Cdzpq2fQongsI6YwJTshAMuYWvGNBsGezajwqxP36bb6gD+GqnTRyxqASC
        x2oFMtqMMlPYjRT/fzIWYToTUcQYCV/mtFlWguLjp+5dDBd4eKMQlfRGDA1jE93K
        IRzxQ9mZ7GH/UwpTMR2EYD+QfruHG6uz+JXtXOUacIROjBc7Cym86PVfV2161+9F
        diP+4IWw0yxVeix/VQysMYaqeXzAx723T7D37Lhr2hprYruNNCx2LMZVRn6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672827605; x=1672914005; bh=8iXmcHFFNZh9AmH4Kilxio1EfsB6
        nCxBvRuiZDX3K/M=; b=Xd7ZQBRnvHy6TSPL+UJsY+q6W7Hu1G8vJ3ZVFJ7JX2mx
        0tKs30DbZrEa+XwJ536vwfKlfv6UmOF5xQE5Xn/N2wRoYYtq6bwFo6eC/abtW0Ls
        IO0o3BNPAfZ4Ni47sLFh9ZZLd/K5OirVZyOmoZqUYNKc+YEQaeQeXalTKaLlmUXH
        1p7eFRvBadX6+/VmGYyxBvZWCENubwR3pqVzqyD7HJo6VbHYKldne7eClVF3wZ2g
        ZkjSIUtqVgw3CBWyrznltDUx/sgO4FlCaEzN1FRzwE1Ep7/Lh1q0/0oizqsnUFty
        ubQlxwlYBJIHRXBlCDucPZhW8L/NMD6YCd5jw6rylw==
X-ME-Sender: <xms:1FK1Y0A3R08OP0S5tKvWH-5G04spYycE5JdtRGZAnRqJYWz5ZvIO-A>
    <xme:1FK1Y2gi7HM9WoUuu3y_DRCOXCmUlijK4jX5gUtXKtRoGXmTabq2ZxKbkqQ6O_xeu
    -Pn8Mikvq3TpBnpNrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1FK1Y3lutGGwbQtpmWj6iPoyrDc9C-auLx1vY2Ilnq9-cslpiG4DtA>
    <xmx:1FK1Y6wrg799sf4qLw5pjwtb5t0VTIk1l4Yg_BGzOXPsWQpCM9VvmA>
    <xmx:1FK1Y5Tk6QqIIGUyDPksJGpf1-t2EvTjClxq6bzkYwMMgqk6HESXTA>
    <xmx:1VK1Y5r3HRWC2cGdiaU7OSHUmhtd80iC1pihL_so3-3DYw6nwCLSgg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 688E9B60086; Wed,  4 Jan 2023 05:20:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fastmail.com>
In-Reply-To: <CFB874A3-3E6F-4C5B-B47D-381EB1E07C02@kernel.org>
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-10-conor@kernel.org>
 <b5712732-40a2-4e29-b29f-e0ab5516d518@app.fastmail.com>
 <Y7TBh+CJdZPJ6Xzl@spud>
 <ed198390-1bde-44ec-9f3f-b0e016b4b24c@app.fastmail.com>
 <CFB874A3-3E6F-4C5B-B47D-381EB1E07C02@kernel.org>
Date:   Wed, 04 Jan 2023 11:19:44 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        guoren <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, soc@kernel.org,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [RFC v5.1 9/9] [DON'T APPLY] cache: sifive-ccache: add cache flushing
 capability
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023, at 10:23, Conor Dooley wrote:
>>Right, no need to touch the existing file as part of this series,
>>it probably just gets in the way of defining a good interface here.
>
> Sure. Can leave it where it was & I'll sort it out later when it's 
> errata etc get added.
>
> Btw, would you mind pointing out where you wanted to have that if/else 
> you mentioned on IRC?

I meant replacing both of the runtime patching indirections in
arch_sync_dma_for_device(). At the moment, this function calls
ALT_CMO_OP(), which is patched to either call the ZICBOM or the
THEAD variant, and if I read this right you add a third case
there with another level of indirection using static_branch.

I would try to replace both of these indirections and instead
handle it all from C code in arch_sync_dma_for_device() directly,
for the purpose of readability and maintainability.

static inline void dma_cache_clean(void *vaddr, size_t size)
{
        if (!cache_maint_ops.clean)
               zicbom_cache_clean(vaddr, size, riscv_cbom_block_size);
        else
               cache_maint_ops.clean(vaddr, size, riscv_cbom_block_size);
}

void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
                              enum dma_data_direction dir)
{
        void *vaddr = phys_to_virt(paddr);

        switch (dir) {
        case DMA_TO_DEVICE:
        case DMA_FROM_DEVICE:
                dma_cache_clean(vaddr, size);
                break;
        case DMA_BIDIRECTIONAL:
                dma_cache_flush(vaddr, size);
                break;
        default:
                break;
        }
}

which then makes it very clear what the actual code path
is, while leaving the zicbom case free of indirect function
calls. You can still use a static_branch() to optimize the
conditional, but I would try to avoid any extra indirection
levels or errata checks.

     Arnd

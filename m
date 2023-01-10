Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EA9664409
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbjAJPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbjAJPDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:03:34 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2005C92F;
        Tue, 10 Jan 2023 07:03:30 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 08B1C5C0178;
        Tue, 10 Jan 2023 10:03:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 10 Jan 2023 10:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673363008; x=1673449408; bh=v3VJLtajZK
        CBQxf+Vq3GTyXhe7qQAAYt+5mUsd1Fy8Q=; b=Jf40gXAUV0xd/+YwHcvsTmL4tO
        EixbAhPWV52xzkdF+fSLEqModXN0nTmqcit8vZoD3vf8zYzZHfCPoj/YPVspXF61
        yByBufqJbUOW/io4ZfuHhd1fDs4ehHvgSpJ60DYbk5igw/SQLgGXGY5mBQ3Z86+F
        k2dXM9iFv57Tf2bU59oUEzqY++FoR/3Y0C2wI6ZTPPHIE5So6ORaV/chZDzj1BwX
        nGmJQr4Z9a1K83m9jSzkZ4u4DloBwOOn9zy+x8ImgJtDbDTeM2etUVcMnuRONvVW
        j1a5CC9trhqoj3uKTrl6VccPugaDnlQrc+Yb6+ukdI/IoZwSpG/sIeEVnyaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673363008; x=1673449408; bh=v3VJLtajZKCBQxf+Vq3GTyXhe7qQ
        AAYt+5mUsd1Fy8Q=; b=b1oyJyzJ6mDlM1ZqGAIoNknDqe5M7xCCApXW093okFKV
        Q//jwGz+aGzgOvBXwsaMS7vQHkozjylpAW1T8Vz3x3hCUnOa90ec21NxJQ1jBRx/
        m8uUtdbnrOp9aK5PrBY3/qlpIJOvRcIAU0sJzIzaY8d4N5bws8pPUqOmsbVaTQxC
        rMMwX4+GuFlTZXEQc7TXBwIDvnLY5dyQIqriSWPocZQceVZqE1khy5rxunvUUvXx
        fanoMS9Iw1OYPhn5fyMywe9rSlA/hvOFPdsA+urP+Es49SFL3OGqRHp8ZL7EcuUn
        1Kwuw6pgl+W1GO8fLN6/N3oDrXwdjzhooUdc0c3EBQ==
X-ME-Sender: <xms:PX69YyqscoZMqzIlLG4soaywFw-JXXYO3bRqaRQVtJjxeS_bNxFYzQ>
    <xme:PX69Y6S8zUOPLBuvSc6cUdrdFzU2MpIVgkHQEUqt-xTwouvMTVlWnBAAa-OmgtlBW
    E2w06ruMq5HE4RJBlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffvvefu
    tgesthdtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrh
    hnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeeghfeihfeuheelvdejheev
    udfhvdetffevleffteetgeefffduheefgfeugfelveenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgpdhgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PX69Y3OhFoe5TqUOPVmakLQpXFE6Vq5P_y7G3sqDkIAcXzhbtXpeug>
    <xmx:PX69Y1MYMp4Y4y5wNeZASE2lgGckyfKNDQPhP6g0MU_Ht30tNdd84w>
    <xmx:PX69Y_twfawou-Sd3PzkbZLL5EAj2UGq1dr3hRxfRDWQ0a9-4z4ozw>
    <xmx:QH69Y8dsG_zpY9EFCetqc5Hs1r6-PYYABHW7ec297lnKiYJKVJw14A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D3A8FB60089; Tue, 10 Jan 2023 10:03:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <02988e70-b099-46fd-b260-2d537c50543a@app.fastmail.com>
In-Reply-To: <20230110070144.GG10289@lst.de>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
 <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
 <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
 <20230110070144.GG10289@lst.de>
Date:   Tue, 10 Jan 2023 16:03:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Tsukasa OI" <research_trasio@irq.a4lg.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Mayuresh Chitale" <mchitale@ventanamicro.com>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023, at 08:01, Christoph Hellwig wrote:
> On Mon, Jan 09, 2023 at 01:59:12PM +0100, Arnd Bergmann wrote:
>> I had another look at the arm64 side, which (like the zicbom
>> variant) uses 'clean' on dma_sync_single_for_device(DMA_FROM_DEVICE),
>> as that has changed not that long ago, see
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c50f11c6196f45c92ca48b16a5071615d4ae0572
>
> which IIRC has been reverted recently.

To clarify: I was looking at arch_sync_dma_for_device(), which
changed from 'invalidate' to 'clean' last June in commit
c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers
at start of DMA transfer"). I don't see  a revert for that.

The one that was reverted recently is arch_dma_prep_coherent, which
was changed and reverted in

c44094eee32 Aug 23 2022 flush->clean
b7d9aae4048 Dec 6  2022 clean->flush

I'm primarily interested in the streaming mappings (arch_sync_*)
at the moment.

>> I'm still not sure what the correct set of operations has
>> to be, but nothing in that patch description sounds ISA
>> or even microarchitecture specific.
>
> Nothing is ISA specific, and the only micro architecture related thing
> is if the specific core can speculate memory accesses.  See the table
> in arch/arc/mm/dma.c for details.
>
> And as commented on the arm64 patch I really hate architectures getting
> creative here, as I'd much prefer to move the choice of primitives to
> the core DMA code and just provide helpers to invalidate/writeback/
> writeback+invalidate from the architectures eventually.

Agreed, that's why I particularly don't like the idea of giving SoC
specific L2$ drivers the option of making custom choices here.

The arch_dma_prep_coherent() change is arguably arm64 specific
because it is only needed for machines sharing memory with EL3
firmware that enforces buffer ownership, but even for that it would
be nice to have a central definition and some architecture specific
flag that picks one behavior or the other. Same thing for the
speculative access difference.

I looked at all the implementations now and put them in a table[1]
to see what the differences are. The only bit that I think needs
discussion is the dma_sync_single_for_device(DMA_FROM_DEVICE) op
that I mentioned above. I see that arm64, csky, powerpc, riscv
and parisc all write out at least partical cache lines first to
avoid losing dirty data in the part that is not written by the
device[2][3], while the other ones don't[4]. 

The other differences I found are:

- arm and arm64 use clean instead of flush for
  dma_sync_single_for_device(DMA_BIDIRECTIONAL).
  This seems harmless, since there is another
  invalidation at the _for_cpu() step.

- hexagon, m68k, openrisc and sh don't deal with
  speculative loads

- m68k, nios2, openrisc, parisc and xtensa use
  flush instead of clean for DMA_TO_DEVICE, presumably
  because they don't have a flush without invalidate.

- microblaze, parisc and powerpc use the same function
  for _for_device and _for_cpu, which is slightly wasteful
  but harmless.

- openrisc lacks support for bidirectional mappings,
  which is a bug

- sparc32 and xtensa only supports writethrough caches
  and consequently skips the clean before DMA but
  instead invalidate the buffer in the _for_cpu
  operation.

I also see that at least arc, arm, mips and riscv all want
CPU specific cache management operations to be registered
at boot time. While Russell had some concerns about your
suggestion to generalize the arm version, we could start
by moving the abstracted riscv version into
kernel/dma/direct.c and make sure it can be shared with
at least mips and arc, provided that we can agree on the
DMA_FROM_DEVICE behavior.

     Arnd

[1] https://docs.google.com/spreadsheets/d/1qDuMqB6TnRTj_CgUwgIIm_RJ6EZO76qohpTJUMQjUEo/edit#gid=0
[2] https://git.kernel.org/torvalds/c/c50f11c6196f
[3] https://git.kernel.org/torvalds/c/03d70617b8a7
[4] https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/

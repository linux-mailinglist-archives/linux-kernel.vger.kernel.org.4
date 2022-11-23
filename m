Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA0634FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiKWFtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKWFtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:49:53 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E9F1DA2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:49:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A8D675C01A8;
        Wed, 23 Nov 2022 00:49:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Nov 2022 00:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669182591; x=
        1669268991; bh=mBVtnDaBkuQcFRIzo1SOlDo6jVRm6UTP6X8KNYwdMJE=; b=H
        Zz3mifbUFIUVLbv02TCGZLRukTLnclKvWTd9dVrjGSHwykx3MK1rkTvGdNLWZaiE
        3ABtEvoUvkM8/y43GBztZojQUOqaEYiTqiEH4hOT2YTKzRE71K+hK3pgi9M6rp/b
        Fh8+JUQNmuTEvlxTHn4Q7Mp0aRr3Hst1sue4I4W+YU9fcIoLAqIO7UfLE1oz2Dby
        Xs3X8pFuYst+35l22uBbQBigxuWxmQ+R7XIOF4NGlUzEKuDs9xgfhN+9ghQ714p2
        wQYrUbcmNq8jP/l2knmwRytY/s1zrxNj0Ps0u3yyo9NZeEB//M1qrDxByEmuSEPu
        A1U2r8tk+C/vuV6Lba/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669182591; x=
        1669268991; bh=mBVtnDaBkuQcFRIzo1SOlDo6jVRm6UTP6X8KNYwdMJE=; b=F
        Cjlyb/A2mVMfUg2HKISjGwIgr3mvFWS0kyTuDfiFgpfeHs3SR/X7TKtwvBhmHr21
        4aklCAeGNNiCufAndXVGNAi2d4KAOF2v58R4Gpymz/RVsmKtVD65KeT8Mv/dab8z
        bSkFp07Gp5NqevVDLL/0d7QbDnVN2Y0yQe5ZHIVvaPIWkf5JYx4MdSUEl++rF9cq
        hLsNPlT46m703KzN6ChxeA1EzWK5tIYKqYbsEqvJ8fvLYvPz3Z3JqCnQ9+EciIgy
        t5mEBZNFEdVm5sTscBU+Rkyc97uD6VsB+YNo+9Vf0AnZwRCTevRQQe2+E2n+G8of
        ftq0uMZSuGsk2UeQvhrEA==
X-ME-Sender: <xms:f7R9Y2JJepbnANxyT0sH7va8I-hEnRTTKqiCMZkMCaVF7k76gr3KHg>
    <xme:f7R9Y-JmTdqLW0zpc8DcM9jncqptLYDCCKQcrP-7ucGRK9BfoCrUhrO3zjKJxalXm
    p7wTbWuLfmN_n7u3A>
X-ME-Received: <xmr:f7R9Y2syHEniHltffTZ6zaRB9qRuu67SzXUZ-6I-476UfH-9VYYhd7NdVnla1aeyLrdAhuQuGOX9o-HsCb1haI20mjmHJFbCkgD-NsHDrpN5CKJ62_RWXQMuiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepteehheehtdegledtiedvfeeludekhfdtkeeuiefgfffhuedtjedt
    fffhfeelleeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:f7R9Y7YF1f_d71J_y2hI3Z6qOUOdDp4_OrNDUegkBKYPE8VMad9C6w>
    <xmx:f7R9Y9a24KQR-hjs7Y3AJQciwbOWD302TJHVRH4oPt2_kJRAhz2kXw>
    <xmx:f7R9Y3C5ILrszIF9DwU1VEqZCa2TckxbgoW2CPyN_4NHHFxApWawkw>
    <xmx:f7R9Y6Sq2kdIQ3CTQcreeodpgf9J_UxkTnPk9HLOXYYkDTDcsYYa4Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 00:49:50 -0500 (EST)
Message-ID: <a218ebf8-0fba-168d-6598-c970bbff5faf@sholland.org>
Date:   Tue, 22 Nov 2022 23:49:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] Revert "clocksource/drivers/riscv: Events are stopped
 during CPU suspend"
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, dmitriy@oss-tech.org,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20221122121620.3522431-1-conor.dooley@microchip.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221122121620.3522431-1-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 06:16, Conor Dooley wrote:
> This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.
> 
> On the subject of suspend, the RISC-V SBI spec states:
>> Request the SBI implementation to put the calling hart in a platform
>> specific suspend (or low power) state specified by the suspend_type
>> parameter. The hart will automatically come out of suspended state and
>> resume normal execution when it receives an interrupt or platform
>> specific hardware event.
> 
> This does not cover whether any given events actually reach the hart or
> not, just what the hart will do if it receives an event. On PolarFire
> SoC, and potentially other SiFive based implementations, events from the
> RISC-V timer do reach a hart during suspend. This is not the case for
> the implementation on the Allwinner D1 - there timer events are not
> received during suspend.
> 
> To fix this, the x86 C3STOP feature was enabled for the timer driver -

C3STOP isn't inherently x86-specific.

> but this has broken both RCU stall detection and timers generally on
> PolarFire SoC (and potentially other SiFive based implementations).
> 
> If an AXI read to the PCIe controller on PolarFire SoC times out, the
> system will stall, however, with this patch applied, the system just
> locks up without RCU stalling:
> 	io scheduler mq-deadline registered
> 	io scheduler kyber registered
> 	microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> 	microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: axi read request error
> 	microchip-pcie 2000000000.pcie: axi read timeout
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	Freeing initrd memory: 7332K
> 
> Similarly issues were reported with clock_nanosleep() - with a test app
> that sleeps each cpu for 6, 5, 4, 3 ms respectively, HZ=250 & the blamed
> commit in place, the sleep times are rounded up to the next jiffy:
> 
> == CPU: 1 ==      == CPU: 2 ==      == CPU: 3 ==      == CPU: 4 ==
> Mean: 7.974992    Mean: 7.976534    Mean: 7.962591    Mean: 3.952179
> Std Dev: 0.154374 Std Dev: 0.156082 Std Dev: 0.171018 Std Dev: 0.076193
> Hi: 9.472000      Hi: 10.495000     Hi: 8.864000      Hi: 4.736000
> Lo: 6.087000      Lo: 6.380000      Lo: 4.872000      Lo: 3.403000
> Samples: 521      Samples: 521      Samples: 521      Samples: 521
> 
> Fortunately, the D1 has a second timer, which is "currently used in
> preference to the RISC-V/SBI timer driver" so a revert here does not
> hurt operation of D1 in it's current form.

typo: its

> Ultimately, a DeviceTree property (or node) will be added to encode the
> behaviour of the timers, but until then revert the addition of
> CLOCK_EVT_FEAT_C3STOP.
> 
> Link: https://lore.kernel.org/linux-riscv/YzYTNQRxLr7Q9JR0@spud/
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98/
> Link: https://lore.kernel.org/linux-riscv/bf6d3b1f-f703-4a25-833e-972a44a04114@sholland.org/
> Fixes: 232ccac1bd9b ("clocksource/drivers/riscv: Events are stopped during CPU suspend")
> CC: Samuel Holland <samuel@sholland.org>
> CC: Anup Patel <anup@brainfault.org>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> For v2, I have re-worked the commit message to (hopefully) add improved
> context.
> 
> CC: aou@eecs.berkeley.edu
> CC: atishp@atishpatra.org
> CC: daniel.lezcano@linaro.org
> CC: dmitriy@oss-tech.org
> CC: paul.walmsley@sifive.com
> CC: tglx@linutronix.de
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> ---
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 969a552da8d2..a0d66fabf073 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -51,7 +51,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };

Acked-by: Samuel Holland <samuel@sholland.org>


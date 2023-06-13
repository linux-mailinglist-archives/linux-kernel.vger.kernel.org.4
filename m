Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7272D9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbjFMGhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFMGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:37:04 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3AE54
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:37:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 52BFF32006F5;
        Tue, 13 Jun 2023 02:36:59 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Tue, 13 Jun 2023 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686638218; x=1686724618; bh=3F
        ZTRxLrHXD3Xm5q4Gr9FJo1SoQ3BCmMhPOkll2o7pw=; b=Z1Q5htHfdGX5fBNvv4
        sveyeHD0Hwx1nBULbzz4lGXbxo6P7l2zrE+3IC/veQLUUTsJr3DQ5ye55vgawVPP
        Z/A9EwVoOhUtkzh0nrSpiCgwiAI4KPgn+HrZ6/1ovOBiRNfS9yIBDT7tEAkCOqDh
        73cJBUPLzTlHAtdD4bnatgr4GrBRHjhWzjVl8X7NkDwNQwVXqlnyQoW+DLliTZXx
        15aeBFU1kourbUW6Sp2z9VBoAfaFf+mUF3NTIcUpokvSdxjcY0Gw1+vG2pOzbNjb
        ITkDQUyHjR6/ilt2Dwnfs+tfdK5vWMEuqeivWEvvlgPaAJD6Wf9djZ2qY55HjpMe
        Pbew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686638218; x=1686724618; bh=3FZTRxLrHXD3X
        m5q4Gr9FJo1SoQ3BCmMhPOkll2o7pw=; b=m6iNhMZ+Zn4Krpl3SHtx2X8RAz0ff
        e8TSRlW5bTRnzraYYJeOrLdy2jjL6hTbApLUD4zwOVbyIlvA++UsJ2aPTBrCK3D6
        9Pu2PP+rzdcQcMvXsxVoW87Hp0Iu6aOx2NN/EWM6EL8ZwmQIT6Mrql5tkWP3LrlV
        s45Pc1HFG98isBVyGRrSfnTuFICuEj0k5nf8CwCu1H/wfyBJF0K5WZEEIQ/B+Cq7
        wJuJOi/NeomHEEgS9tVwP1xmSZRZH43RPFqgiotmbnyGvRQCaOzZfF4Nw1RlHyZw
        TWu3wgPqjty+TezvnauB47Nbp4RfdGuEqVQq/sa0C5xjqxHxU35t3b2uA==
X-ME-Sender: <xms:ig6IZHjxvmCEGYiVMNt3t-f8TivcklBZWqM6qye8_JlDamPbaHXKFQ>
    <xme:ig6IZEC81LBtFICISnpaqFE0kc4VE1Ztf6AedC1zCRAKuGXsPqL6o-RRqNgCal4Wf
    JsRyaf2FpWzUKdceQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefudejvdejuddvjeejudekgfeikeevveevleeitddvtedu
    jeegjeejgfeugfeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ig6IZHH_FW5IDhG5XbukEga-97ECL21KVm2yXWtd35blv9dDqHuCCA>
    <xmx:ig6IZES17GFt_TuoSBGbUAAALgR5_Vf7Bd8Jl9P9ij_7KiVDE_PmGw>
    <xmx:ig6IZEwKmKtr5TpsPALaV1g-MsiZQDtI3a77vzmaSbw9rU1OTe0IhA>
    <xmx:ig6IZLmkKySqM5X0srh4F9E50VuyRVe70Aog6zksBgAsK_2mXGLrtA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F0A91700093; Tue, 13 Jun 2023 02:36:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <75071be8-272d-45e7-989f-5d717f313fe2@app.fastmail.com>
In-Reply-To: <20230228215435.3366914-3-heiko@sntech.de>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <20230228215435.3366914-3-heiko@sntech.de>
Date:   Tue, 13 Jun 2023 02:35:53 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Heiko Stuebner" <heiko@sntech.de>, palmer@dabbelt.com
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023, at 4:54 PM, Heiko Stuebner wrote:
> @@ -29,6 +78,7 @@ static __always_inline bool has_vector(void)
>  static inline void __vstate_clean(struct pt_regs *regs)
>  {
>  	regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> +
>  }
> 
>  static inline void vstate_off(struct pt_regs *regs)
> @@ -58,30 +108,75 @@ static __always_inline void rvv_disable(void)
> 
>  static __always_inline void __vstate_csr_save(struct __riscv_v_state *dest)
>  {
> -	asm volatile (
> +	register u32 t1 asm("t1") = (SR_FS);
> +
> +	/*
> +	 * CSR_VCSR is defined as
> +	 * [2:1] - vxrm[1:0]
> +	 * [0] - vxsat
> +	 * The earlier vector spec implemented by T-Head uses separate
> +	 * registers for the same bit-elements, so just combine those
> +	 * into the existing output field.
> +	 *
> +	 * Additionally T-Head cores need FS to be enabled when accessing
> +	 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
> +	 */
> +	asm volatile (ALTERNATIVE(
>  		"csrr	%0, " CSR_STR(CSR_VSTART) "\n\t"
>  		"csrr	%1, " CSR_STR(CSR_VTYPE) "\n\t"
>  		"csrr	%2, " CSR_STR(CSR_VL) "\n\t"
>  		"csrr	%3, " CSR_STR(CSR_VCSR) "\n\t"
> +		__nops(5),
> +		"csrs	sstatus, t1\n\t"
> +		"csrr	%0, " CSR_STR(CSR_VSTART) "\n\t"
> +		"csrr	%1, " CSR_STR(CSR_VTYPE) "\n\t"
> +		"csrr	%2, " CSR_STR(CSR_VL) "\n\t"
> +		"csrr	%3, " CSR_STR(THEAD_C9XX_CSR_VXRM) "\n\t"
> +		"slliw	%3, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> +		"csrr	t4, " CSR_STR(THEAD_C9XX_CSR_VXSAT) "\n\t"
> +		"or	%3, %3, t4\n\t"
> +		"csrc	sstatus, t1\n\t",
> +		THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>  		: "=r" (dest->vstart), "=r" (dest->vtype), "=r" (dest->vl),
> -		  "=r" (dest->vcsr) : :);
> +		  "=r" (dest->vcsr) : "r"(t1) : "t4");
>  }
> 
>  static __always_inline void __vstate_csr_restore(struct __riscv_v_state *src)
>  {
> -	asm volatile (
> +	register u32 t1 asm("t1") = (SR_FS);
> +
> +	/*
> +	 * Similar to __vstate_csr_save above, restore values for the
> +	 * separate VXRM and VXSAT CSRs from the vcsr variable.
> +	 */
> +	asm volatile (ALTERNATIVE(
>  		"vsetvl	 x0, %2, %1\n\t"
>  		"csrw	" CSR_STR(CSR_VSTART) ", %0\n\t"
>  		"csrw	" CSR_STR(CSR_VCSR) ", %3\n\t"
> +		__nops(6),
> +		"csrs	sstatus, t1\n\t"
> +		"vsetvl	 x0, %2, %1\n\t"
> +		"csrw	" CSR_STR(CSR_VSTART) ", %0\n\t"
> +		"srliw	t4, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> +		"andi	t4, t4, " CSR_STR(VCSR_VXRM_MASK) "\n\t"
> +		"csrw	" CSR_STR(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
> +		"andi	%3, %3, " CSR_STR(VCSR_VXSAT_MASK) "\n\t"
> +		"csrw	" CSR_STR(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
> +		"csrc	sstatus, t1\n\t",
> +		THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>  		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> -		    "r" (src->vcsr) :);
> +		    "r" (src->vcsr), "r"(t1): "t4");
>  }

vxrm and vxsat are part of fcsr in 0.7.1, so they should already have been
handled by __fstate_save and __fstate_restore, and this code is likely to
misbehave (saving the new process's vxrm/vxsat in the old process's save area
because float state is swapped before vector state in __switch_to).

-s

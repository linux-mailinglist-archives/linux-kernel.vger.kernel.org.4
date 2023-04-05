Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F636D7768
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjDEIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjDEIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:55:52 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 01:55:49 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D592F3;
        Wed,  5 Apr 2023 01:55:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id D88F52B0670E;
        Wed,  5 Apr 2023 04:16:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 05 Apr 2023 04:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680682599; x=1680689799; bh=E4
        FRrBsELPivENRQDY0P/B5Hrosa4b2SmzmKSYFWm74=; b=O/RfOi1e5gJBwc3CRO
        6EWvOBPfA7kqdj7sZ1wQWWJRIVpKzE5AI1hqc9WANjEOPc0VlKVpBB4IA4gZh8jQ
        7gQbGkU/Y7DjtFOLLPN2B+vqHOOIpYuv14gSHyL8hoTTLdHfdixPwXlAinewnJDy
        pCU4zgyjDP5nazvefaHE4a+MCCjlehkk78cElYr1RQto9eQtQ66JYTUtMLTXLFyT
        alXZtoTKYSuJlOQrx08qlQ0XnRUG+rrBgeadWFfm485RuHUuAtjGh84wQTvAYf1u
        Z4J5r1RhIdDO0VDx3umJg901SgI7cGEjedjvsQUVn+HdOdl7WOHeLra+pJfCDene
        /X1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680682599; x=1680689799; bh=E4FRrBsELPivE
        NRQDY0P/B5Hrosa4b2SmzmKSYFWm74=; b=irXtbfnN+lz4Id+q0cchgDiq/0att
        SZqF0jA+dW9eKrzI/Hdz0raj/1VcYz0S2gflBmiiqXTKBYnMjkxwwGXfOBUii5yE
        UrocSTbwq7UP1YsQOV8mpGny+1J6D/q3YTuWIjpoWhsH+YM/IfYiygJCac3N83Rc
        FJfmsJfFPEZjMUiI7b0DptN2qlYh2d+yzFiyZZCVdZw8M2Qder99fArmpHJjQqtb
        qgM7HX6Vcg63d5aPXxLvB+iY6dIDVy5KgzAvwHDcIEJfNmboJODOxqD/5X2FpFq8
        3vw1jmm7OATqI4D9ojOZsheWtwXNAsp0MSV7XYqVK+79+CiIBWKVP4crA==
X-ME-Sender: <xms:ZS4tZMZI9AV0RkcBkz6u_qTZcu_jT_tJVGVzJyGanPX9Z0iZPDhS6Q>
    <xme:ZS4tZHb84hRVmfo9CZeAclAfKYo1GAUMzA1q3vIakl9kqrd-rtexHH9Q_vpBMa_vo
    DitDxNyuewPeT5a4og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZS4tZG_an9tb6QDw-DeyRnF-MoiRX3UK2FT5yYldQhdyUCEPK3p6cw>
    <xmx:ZS4tZGonhwZm-UauGA8CU4Sr3yRYaGJgKoEqtpioN0iBOguVj5kRVA>
    <xmx:ZS4tZHrI8LJ6T2u70F_faSulNUPHdK-DiuwYUbgSpTxTR3iMl3AIXw>
    <xmx:Zy4tZBagRz_7kfsOKTOayTV_ewyD5h_EN8mJJP8RTtf85jnMin17RvleoA4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B97AB6008F; Wed,  5 Apr 2023 04:16:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <dcd04005-2dba-4ccc-a235-a809220f9dbd@app.fastmail.com>
In-Reply-To: <20230404182037.863533-24-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-24-sunilvl@ventanamicro.com>
Date:   Wed, 05 Apr 2023 10:16:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sunil V L" <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Len Brown" <lenb@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Weili Qian" <qianweili@huawei.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Marc Zyngier" <maz@kernel.org>,
        "Maximilian Luz" <luzmaximilian@gmail.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 23/23] crypto: hisilicon/qm: Workaround to enable build with
 RISC-V clang
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023, at 20:20, Sunil V L wrote:
> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
> allmodconfig build. The gcc tool chain builds this driver removing the
> inline arm64 assembly code. However, clang for RISC-V tries to build
> the arm64 assembly and below error is seen.
>
> drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint 
> '+Q' in asm
>                        "+Q" (*((char __iomem *)fun_base))
>                        ^
> It appears that RISC-V clang is not smart enough to detect
> IS_ENABLED(CONFIG_ARM64) and remove the dead code.
>
> As a workaround, move this check to preprocessing stage which works
> with the RISC-V clang tool chain.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Your patch looks correct for this particular problem, but I
see that there are a couple of other issues in the same function:

> -	}
> +#if IS_ENABLED(CONFIG_ARM64)
> +	unsigned long tmp0 = 0, tmp1 = 0;
> 
>  	asm volatile("ldp %0, %1, %3\n"
>  		     "stp %0, %1, %2\n"
> @@ -627,6 +623,11 @@ static void qm_mb_write(struct hisi_qm *qm, const 
> void *src)
>  		       "+Q" (*((char __iomem *)fun_base))
>  		     : "Q" (*((char *)src))
>  		     : "memory");

For the arm64 version:

- the "dmb oshst" barrier needs to come before the stp, not after
  it,  otherwise there is no guarantee that data written to memory
  is visible by the device when the mailbox gets triggered
- The input/output arguments need to be pointers to 128-bit types,
  either a struct or a __uint128_t
- this lacks a byteswap on big-endian kernels

> +#else
> +	memcpy_toio(fun_base, src, 16);
> +	dma_wmb();
> +#endif

This version has the same problems, plus the write is not actually
atomic. I wonder if a pair of writeq() calls would just do the
right thing here for both arm64 and others, or possibly a
writeq() followed by a writeq_relaxed() to avoid the extra dmb()
in the middle.

     Arnd

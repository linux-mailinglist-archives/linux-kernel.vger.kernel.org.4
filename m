Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F706E7CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjDSOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjDSOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:35:33 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48E2703;
        Wed, 19 Apr 2023 07:35:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 91D492B06805;
        Wed, 19 Apr 2023 10:35:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 19 Apr 2023 10:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681914925; x=1681922125; bh=Ut
        qJg87sclxB8kmKKjm1dWi2X4vfjejVvTPZmHeTPGw=; b=G/roXKLhk54CD8O/zz
        DKOt+KTNmyPZq5TIMil3xkVjiJd4gTK4vjA1iahL90dev069v5N6GP6D4X6S6QHQ
        WvYaQZRGXnUiawwq3737yfdLPM2FOqs0nwDb7kNkl5nEB+zj4GrWnuK/Kpldb/Q/
        KnMEA8pt7JkCJ+uTC/cvsYNEDCBt4czLcz09XIeWKn6tV59dg5QJLPtoBdbmT/EY
        n6ATaxC8nX7Gmf3KCQDLWQWIxVie3bO/EC39/Hz6xlFqWSSNQRyKJ2f6pdFxgHR4
        MhmcUGyiZMhTk52DLlrVJJosS9E95J7dPuHvPLnK8g4ANCtUf10ccU/yv1WcWyVC
        yKWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681914925; x=1681922125; bh=UtqJg87sclxB8
        kmKKjm1dWi2X4vfjejVvTPZmHeTPGw=; b=Ayoqp8BoVyIaTqYKSvWcxI+q7xXHr
        U+07R4ERCxUYUq9YFS4IqW+Gp+PHOE9ohJpaIuy3LN0j+q7mtre99MEphni+CUi9
        GtHvEkeMTNUO4uqC9evL9j2oAnCozJ6LR8DD3f/kodBPsj2ygXPb1r+HDejWXVn7
        4LAysEHDz3DVFtZL89xxbtsWqphFWxgpWNewdaa1+F1eebn0gCrxeDdXX8yCuouy
        u75OYXRGMFXHyqklWYD2DE7ZEOLnRrGJ0S0bdwI/TDq59f97r0HzBBFAjIzg6ZxM
        MvrlEEl3DLz6yob+G9qptjb/YVCkVWlk99w394m3NYhW9ZlG5SBEnnSMw==
X-ME-Sender: <xms:K_w_ZAAcnt0IFxlEu-sWYxxCFj4E5HCrdO6gr4X0MJfFAiGmxaV84w>
    <xme:K_w_ZCgIcIHgK9Z_PsDoB7b-8pvkx6wG9Mbj9U1d8bQhT3GT-hf-oSqbx10GP8B9f
    Jhbjv9YwQGYOZs3ACg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:K_w_ZDnBR_BAFwoanwfv8B7_PSBstC3_JVczRuVfTB6V2PuNb39qew>
    <xmx:K_w_ZGznlZkjeBrmRL2dmDP6FxH9drM_zy3lWKa4ZN2-MD9ep5xGag>
    <xmx:K_w_ZFRVkk5niRZjuNrSLjU3rJcwPSBhzMaC4kF6tovakEg27aFodQ>
    <xmx:Lfw_ZOCz7NLW2Y2zhw3Ebr9-jzkAqBwZ7jwfeV0CSme0H9PGF0Ss2-wPCx8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 04D1AB60086; Wed, 19 Apr 2023 10:35:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <d0cf8fa6-d1d2-4a61-ac54-1a268030febc@app.fastmail.com>
In-Reply-To: <487a20e7-2894-218a-47e9-b222aef4ec6e@huawei.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-24-sunilvl@ventanamicro.com>
 <dcd04005-2dba-4ccc-a235-a809220f9dbd@app.fastmail.com>
 <487a20e7-2894-218a-47e9-b222aef4ec6e@huawei.com>
Date:   Wed, 19 Apr 2023 16:34:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Weili Qian" <qianweili@huawei.com>,
        "Sunil V L" <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
Cc:     "Jonathan Corbet" <corbet@lwn.net>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Len Brown" <lenb@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023, at 13:42, Weili Qian wrote:
> On 2023/4/5 16:16, Arnd Bergmann wrote:
>> On Tue, Apr 4, 2023, at 20:20, Sunil V L wrote:
>>> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
>>> allmodconfig build. The gcc tool chain builds this driver removing the
>>> inline arm64 assembly code. However, clang for RISC-V tries to build
>>> the arm64 assembly and below error is seen.
>>>
>>> drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint 
>>> '+Q' in asm
>>>                        "+Q" (*((char __iomem *)fun_base))
>>>                        ^
>>> It appears that RISC-V clang is not smart enough to detect
>>> IS_ENABLED(CONFIG_ARM64) and remove the dead code.
>>>
>>> As a workaround, move this check to preprocessing stage which works
>>> with the RISC-V clang tool chain.
>>>
>>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>> 
>> Your patch looks correct for this particular problem, but I
>> see that there are a couple of other issues in the same function:
>> 
>>> -	}
>>> +#if IS_ENABLED(CONFIG_ARM64)
>>> +	unsigned long tmp0 = 0, tmp1 = 0;
>>>
>>>  	asm volatile("ldp %0, %1, %3\n"
>>>  		     "stp %0, %1, %2\n"
>>> @@ -627,6 +623,11 @@ static void qm_mb_write(struct hisi_qm *qm, const 
>>> void *src)
>>>  		       "+Q" (*((char __iomem *)fun_base))
>>>  		     : "Q" (*((char *)src))
>>>  		     : "memory");
>> 
>> For the arm64 version:
>> 
>> - the "dmb oshst" barrier needs to come before the stp, not after
>>   it,  otherwise there is no guarantee that data written to memory
>>   is visible by the device when the mailbox gets triggered
>> - The input/output arguments need to be pointers to 128-bit types,
>>   either a struct or a __uint128_t
>> - this lacks a byteswap on big-endian kernels
> Sorry for the late reply.
>
> - the execution order relies on the data dependency between ldp and stp:
>   load "src" to "tmp0" and "tmp1", then
>   store "tmp0" and "tmp1" to "fun_base";

Not entirely sure how that data dependency would help serialize
the store into the DMA buffer against the device access. The problem
here is not the qm_mailbox structure but the data pointed to by the
'u64 base' (e.g. struct qm_eqc *eqc) which may still be in a store
buffer waiting to make it to physical memory at the time the mailbox
store triggers the DMA from the device.

>   The "dmb oshst" is used to ensure that the stp instruction has been executed
>   before CPU checking mailbox status. Whether the execution order
>   cannot be guaranteed via data dependency?

There is no need to have barriers between MMIO operations, they
are implicitly serialized already. In this case specifically,
the read is even on the same address as the write. Note that the
"dmb oshst" does not actually guarantee that the store has made it
to the device, as (at least on PCIe semantics) it can be posted,
but the read from the same address does guarantee that the write
is completed first, and this may be required to ensure that it does
not complete after the mutex_unlock().

> - The input argument "src" is struct "struct qm_mailbox".
> - Before call this funcion, the data has been byteswapped.
>
> 	mailbox->w0 = cpu_to_le16((cmd) |
> 		((op) ? 0x1 << QM_MB_OP_SHIFT : 0) |
> 		(0x1 << QM_MB_BUSY_SHIFT));
> 	mailbox->queue_num = cpu_to_le16(queue);
> 	mailbox->base_l = cpu_to_le32(lower_32_bits(base));
> 	mailbox->base_h = cpu_to_le32(upper_32_bits(base));
> 	mailbox->rsvd = 0;

Right, this bit does look correct.

      Arnd

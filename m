Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB61868C93E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBFWTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBFWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:19:44 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9405BA7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:19:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9981732001BB;
        Mon,  6 Feb 2023 17:19:39 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 06 Feb 2023 17:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1675721979; x=1675808379; bh=EhU5mxbffR
        Xm0x5laM1ASfdUD7zMs29F6yHriTCPm8w=; b=nH0xfajzJ/jwEBbPhLbl6vPtzV
        qdUH66CqwbtwA/wtOLWhR7Ia/2ssdB5UwZxmMDRs0JJ3tqc83NXmgN5zWUxVcPvw
        3Dt7ebZXne7gzo5695hLnlKAB2KEChWcU1pGcfu3ZMlnnVQfxk+ni4WudmsJtIUC
        JXHkT9qujPBZMfUGevgelAQgBWguB7owizIA8EcZSKMJKLEP9td8O4Yed65SksRD
        j2Ujk09gODZtjL7mVJeBFFFlxIO8tyaCzQu7QXPaoaouoyQqetVakir98PYCb+uT
        04RBLqfEw5qa6+iiNQRRrnlj4cvZc0tOBMXpyFkslih60EAaKasj+jJG2FyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675721979; x=1675808379; bh=EhU5mxbffRXm0x5laM1ASfdUD7zM
        s29F6yHriTCPm8w=; b=JsvEdVzHbJJhMbvWfTD51EMLEeX33UEC0YWF1PPvkfgU
        s25POegIxgHIvX/Vix3ytCJnJulHIKa+cg8d+NyLd9abzsScVfn+O+gzTtAhwqjs
        aoaWUX414dq/hE8vDtvSj9Rp022hNpi5OKQCv2bZYgjiwvXgAC+KnoKpcf3vKMgM
        8IYxZQjMqGSeUcV8TFSyicWR3vc1L7qV7TD5qVk41Dd4Fhj7Xbyp1vb2WPZugoiU
        cT0yckNlHIvIb+bQzii6varoFfAW8a65Xqz686zPP4pqxEM1udor1FR4mDuAmajD
        jwRmK5OAJpOCyboogRDwkeMHg2ljS8aJ6qWTslp1NQ==
X-ME-Sender: <xms:-nzhYxn11_H9KO9P_g6dzBuvLV_ztUsdukulk_hk5MouFAKwZBN30Q>
    <xme:-nzhY83tKeidskOuuleDtN6e1eg7F-8vdx0QvrSPHNlZIC8FVMgK3PDGMAgTGyIXU
    UaaH18fPHVhHO2wqnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtse
    httdertderredtnecuhfhrohhmpedfgghinhgtvghnthcuffgrghhonhhnvggruhdfuceo
    vhesvhgurgdrihhoqeenucggtffrrghtthgvrhhnpeegtdehhfehudetvedvvddtffevff
    dtgfetieekvefghefgudegffdtjedthffggeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvh
    esvhgurgdrihho
X-ME-Proxy: <xmx:-nzhY3rG3HujkXUQ3xeMRhVhiCyXlU-KOggS6gnk0965PDMT_ebS4Q>
    <xmx:-nzhYxmKrSAyeknz_MnaE62ePjKqCEo34y7qMsre_J5KdikBGFfitw>
    <xmx:-nzhY_0GRg1jIFr8oZhhHCUIDsQPhiDet9LjpahvbpPwnI0GOi8GwA>
    <xmx:-3zhY0gtfxl7K45raHPvEk2ASq9XSI1Ql7OkUSFim_K71tBkbjWe1g>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E0846BC0078; Mon,  6 Feb 2023 17:19:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-108-ge995779fee-fm-20230203.001-ge995779f
Mime-Version: 1.0
Message-Id: <bff2a9f8-6f70-409a-8acb-cf8917f653a6@app.fastmail.com>
In-Reply-To: <Y+C6mj4F77U43atS@1wt.eu>
References: <20230206013248.471664-1-v@vda.io> <Y+C6mj4F77U43atS@1wt.eu>
Date:   Mon, 06 Feb 2023 17:19:18 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023, at 03:30, Willy Tarreau wrote:
> Hi Vincent,
>
> On Sun, Feb 05, 2023 at 08:32:45PM -0500, Vincent Dagonneau wrote:
>> Hi,
>> 
>> This is version 3 of my patch to add stdint.h to nolibc. Previous
>> versions of this patch are available here:
>> 
>> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
>> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
>> 
>> This version should address most of the concerns raised by Willy on the
>> previous version (missing LL, ULL suffixes, uintptr/size_max size).
>
> OK thank you, that's much better already. I'm still having a few comments:
>   - please avoid the present participle in the subjects of your commits,
>     the imperative form is generally preferred (e.g: "add foo" instead of
>     "adding foo").
>

Noted.

>   - do not forget your signed-off-by on patches.
>

Again, sorry. I'm quite new to the send-email workflow. I just figured that I was probably supposed to use format-patch then send-email rather than just send-email... Makes way more sense though and now I can have a file with my cover letter and carry it over to the next version.

>   - 3rd commit had an empty message. There's always something to say
>     about a change, at least why and what it provides.
>

Noted.

>   - You still have this definition which is only valid for 64-bit,
>     you will need to move it to your ifdef __WORDSIZE block to adjust
>     it based on the word size:
>
>     #define         SIZE_MAX UINT64_MAX
>
>     Maybe this one should also be part of the tests ?
>

Ok.

>> I tested it successfully on x86_64 and arm64 (on qemu). I have some
>> trouble setting up my cross compilation chain for i386, arm and mips
>> however.
>
> What compilers do you use ? I'm using version 11.3 from these ones:
>
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> All supported archs work fine for me. Usually on x86_64 you can even
> start the i386 binaries locally (if your kernel has COMPAT or COMPAT_32
> built in, which is most often the case). And very commonly arm64 support
> armv7 binaries as well.
> 
> Just let me know if I can help you set up your environment, it's always
> a good long-term investment!
>

Ah, foolishly I was relying on the packaged cross compiler for Arch. Compiled everything just fine with the packaged versions on Ubuntu (gcc-10 mips/arm/arm64/i386). I'll try with the toolchains @ https://mirrors.edge.kernel.org/pub/tools/crosstool/ as well.

> Regards,
> Willy

Thanks,
Vincent.

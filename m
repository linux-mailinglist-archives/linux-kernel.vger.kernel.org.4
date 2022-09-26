Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8DE5EA681
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiIZMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiIZMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:48:35 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102D4504C;
        Mon, 26 Sep 2022 04:24:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B11BF41EF0;
        Mon, 26 Sep 2022 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1664190994; bh=rOuuto//9X2yVHXbZW7PA1Ohl4IJGMNIa4F1RVFPT7M=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=JzqNXDipIlQwwGnZOEmalB3DCXA8ACeevo7PBd8Tf6hEgVGX8isUPzkW2pkT3TtrA
         jK2QtBtlw1//90TBODlINJXWWtTgxXPhGRYI+6zRp6gcfkotBZUYzmPl9KlEMWYdq4
         FuhYGRNq02QRNZhBJ+LmEp4u573KWSoFJaFFimNCmSyEFbvRmGw8sC++BivEXZRPlE
         VLD1Wc8cTTlRULjmgZajaeDnjwTXGnNwVc723YEI9/54We+zjglFfPJTntTsOj+LYd
         0Fr/FQ8jUs80yWnhNI2q/+9Eufc2tUiGsq+XjHik8Fbh1xciHEgyOm3OyYiwV9QdIO
         8ftjoKBp5TheQ==
Message-ID: <4fdda77e-6aed-b148-ddbc-52ef2d29b565@marcan.st>
Date:   Mon, 26 Sep 2022 20:16:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: es-ES
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Sven Peter <sven@svenpeter.dev>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
 <ba821ade-1573-4c35-8fbb-285283817147@app.fastmail.com>
 <478D9484-E404-4A96-908C-4DE0F7C23997@cutebit.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: Any interest in building the Linux kernel from a MacOS host?
In-Reply-To: <478D9484-E404-4A96-908C-4DE0F7C23997@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 18.06, Martin Povišer wrote:
> FWIW my current workflow includes building the kernel under macOS, so
> there’s some interest from me, but that will pass once the porting
> project progresses enough. So far I get by with some local duct tape.
> 
>> On 26. 9. 2022, at 10:09, Sven Peter <sven@svenpeter.dev> wrote:
>>
>> On Mon, Sep 26, 2022, at 09:51, Nick Desaulniers wrote:
> 
> (...)
> 
>>> If this might seem helpful
>>> to anyone's workflow, I wouldn't mind pursuing this (with some
>>> cleanup, sending a more formal patch set).  Maybe this helps us
>>> bootstrap or get Linux up and running sooner on these machines?
>>
>> I've been either using a Linux VM or just a bare metal system running
>> on these machine for quite a while now to build kernels. This would've
>> been useful when I originally started though and VMs weren't working very
>> well yet so maybe it's still worth pursuing.
> 
> I really wanted to do it in a VM as a saner path, but I didn't find
> a satisfactory way to share the working source tree between the macOS
> host and Linux guest (which wouldn't slow down the build).
> 
> Martin

Just for context: Most of our (Asahi) developers' workflow involves
loading kernels over USB from another machine. That other machine can be
any OS, but if it's another M1/2 running macOS you get the additional
perk of USB-PD tooling to remote-force-reboot the target machine as well
as get a real physical serial port. The same tooling could be ported to
Linux-on-M1/2 relatively easily, but nobody has done that yet (probably
because these days we have a hypervisor that gives you a superset of
that functionality anyway, over standard USB, so it's not that necessary).

I personally use an x86 host and a hardware contraption to provide the
same hard reboot/UART functionality (for the rare case when the
hypervisor borks, to avoid having to hold down power buttons).

So there are certainly some people who'd benefit from using a macOS
machine as a build host, either for the special USB-PD functionality or
because they just like macOS as a development environment. It sounds
like getting it to work isn't that hard, so perhaps it's worth upstreaming?

- Hector

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE845E9BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiIZIKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiIZIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:10:13 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C91572F;
        Mon, 26 Sep 2022 01:10:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F3B35C00D9;
        Mon, 26 Sep 2022 04:10:02 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 26 Sep 2022 04:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664179802; x=1664266202; bh=kU
        oCi2yT1GwD1ISOCgS7Z4CUQnF93+E9jTByctv07pA=; b=kiA47cQdqnCwoNrsgU
        wIO8oxm2UF8wrn048UyULmo6cmWkdwJTjaFpTAshkknSSK5s7ECibWNzoYNzeCoE
        wmgQ2Oa4o7IMYPEXAHvtOdFG3lYNtuLdjOs8QeAqUAgOeTLn2VziDVg8uPE7mibz
        1duHcPWT5/0o0pLA0ExVZhwyvZSNPfe1ToIL42MsVNh+wJo2vawOfcNcexyA1bvs
        9EyynETxlwt/VoXSphFQFumH3K4XCvFjbSvwaF/ZjIUAfstW0NEuDvuAI/wj5Xst
        5plKpbRgUBRd7wmGaGFXg7UFOyxzbAo+TyQYhDuyG2TakvpLWEGkgI/hG3I53xox
        iksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664179802; x=1664266202; bh=kUoCi2yT1GwD1ISOCgS7Z4CUQnF9
        3+E9jTByctv07pA=; b=KKLgz9moR3Jb69T09+NZHuE/0e0JD65ExOz3uPzge2XY
        24ooOcgBZJrQuxqF65s0gTlNJtmW2iE0ki1ClcDQwoYoJhx+Atom3l0rW7CzJ4za
        VEpvFhEaV1zdFzYm5KttM2fUN39g688msOtIIlckBBzozypTTUG3AxjsvrAF4Pmu
        KrCxzxMpjfkOnKcKvNUEI8VvOcP7iRIIUWeyYhL0SM5nBWLxJTzK8ocqOqk1BxRZ
        BDfbMs65IrQ9QRJKxTvl/AR/YlRf4dz0hNAGYrHOcAoE0vgrCJ6btss5sMQaY3aW
        Hn2B5fNQhVbObmIkodLIPKHLZwZjayY/XZaWDwj7hQ==
X-ME-Sender: <xms:WV4xYzhIDIDVXGgSFLsmg4vdcx1gwkftdb0oMlFvxubCzA3Pz9yvXg>
    <xme:WV4xYwAss_mJITZFcbTf1QYd2ikzI8RB7nsCpi6gwhk0763cp29bG_yjz_U9yzJ-t
    dfbfV942WGb8V_YMjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgeegkeektdejveeiteffvddugffggeeuudehvdfgtddvudfgjedtuedu
    vdevueevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:WV4xYzEUMtKswNS3oToI_WJsMsmiVxdC7GfmYQuMpgw3dXK6kUa1BA>
    <xmx:WV4xYwQLht2Tx4uUZZTthtsabBN7bZ1rbPqGLpnU8QfQPOmRSNwTtg>
    <xmx:WV4xYwwN7JuznA08G2hCE0tmMjrYL26lpQbwifZcXZz5dPFBReAAUw>
    <xmx:Wl4xYzy2P6-GQXVmsGzTXZB3usRbZZhVPeRjBTW6KHmGLCv7KnGaMQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9E3F3A6007C; Mon, 26 Sep 2022 04:10:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <ba821ade-1573-4c35-8fbb-285283817147@app.fastmail.com>
In-Reply-To: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
References: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
Date:   Mon, 26 Sep 2022 10:09:41 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Nick Desaulniers" <nick.desaulniers@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Hector Martin" <marcan@marcan.st>
Cc:     "Nick Desaulniers" <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        "Linux Kbuild mailing list" <linux-kbuild@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: Any interest in building the Linux kernel from a MacOS host?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022, at 09:51, Nick Desaulniers wrote:
> Not sure if this is potentially interesting to anyone but I was able
> to get the kernel building from MacOS my M2 Air with a small amount of
> effort (read: duct tape and bailing wire).  

I originally tried exactly that last year but I guess my duct tape wasn't
quite strong enough ;)

> If this might seem helpful
> to anyone's workflow, I wouldn't mind pursuing this (with some
> cleanup, sending a more formal patch set).  Maybe this helps us
> bootstrap or get Linux up and running sooner on these machines?

I've been either using a Linux VM or just a bare metal system running
on these machine for quite a while now to build kernels. This would've
been useful when I originally started though and VMs weren't working very
well yet so maybe it's still worth pursuing.


>
> Take a look at the commit message linked below for the trials & 
> tribulations:
> https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb340355f471c1dfe95a
>
> Thanks,
> ~Nick Desaulniers


Best,


Sven

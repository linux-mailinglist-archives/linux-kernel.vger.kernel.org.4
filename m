Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160BD5EF617
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiI2NKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiI2NJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:09:52 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9411455;
        Thu, 29 Sep 2022 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664456977;
        bh=ZgFnvr+tO3Kg3sa9+Y1OtbNvBi5R8dQvED6XwNUy2hY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dn3r6tbCE3lEOSDDRVFnb5FhZSrE2krtDhM87SObFutgPB6h5Q+4JYhKyy/ntBfQO
         U8L7c4NkUFpns065CKjqf4uoIrvT19oPAuufZyah6NjBrPODy0mNrtwY3HfE3gE8P0
         I4nPTJGF2I5HxpKvejixuNgjjFHx3G+D3LX+kBt8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.7.110.20] ([143.244.37.136]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6Mt-1pDEB93BA3-00aDcf; Thu, 29
 Sep 2022 15:09:36 +0200
Message-ID: <92c43f2b-c89d-cb9b-a7ce-777171258185@gmx.com>
Date:   Thu, 29 Sep 2022 13:09:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com> <YzWVJpqNq4UeeaoH@kroah.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YzWVJpqNq4UeeaoH@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GMCFnZYbbXGMtXkE357kEuS1JgUdf9FhiUgCBubgt4MWrwszaJA
 Kwfe6yrXXn0Rv9cKeyDJTWK0CXUoNvLcCax12f2tDZbPNTvbvOA95mqww/+QfJktON9JkU/
 QwQ2k8Y+V6+bD/C73hLkgFYWemr7TR2cD+uqiVy5KpazPdpLAiRaGgwsWy0ojPQuDCO+PiW
 boxzqz2DIdRDG5p59rdbQ==
X-UI-Out-Filterresults: junk:10;V03:K0:9UBbDhxoGOg=:v1P5Cj0RkGkCg8smSvZz8oXb
 TlxOIn+uko1hffMwT/Y0/9crPsMqFcKfn+H2HwsDDUqWGeuBRmxHoYvpWFuZsRSVTHF8IE4c5
 wwIl0di+GmpUgOCueFWKRCt/ax+Y5Km6ND8Bjmirwu+XfgCwqtVYGykFjUzvUFnvi0FeCeER/
 F6TxGDX4sU29HkMO05IYVDSGWlqY+yzBNpDEXkNp1IB3vpVS0ZPD8lpsm/qy0BYZF2eiSQcsO
 pxoykyjm6X0eL/1iV96TgUuZwMH4r0toE9yKJ7SQTtWAlpEkBN69ShNjok6ZzDf57e/DfXvQd
 j+lDT3CI1+55xAktR3jESZqOj91bV4d0I4PhBDqa/hNSlHxu469g+Y20vLQWFK/1+p5+eP+rq
 TG29QYEo4yzSxC2sXtfmELw61mHhVV0w5A+XZK/YhsTli+xDfeVLmzJ/WYU0izVTkK6iPbPpq
 2li8jFDfO14SqlGoyOoDlKLnpe9JDaUzAVglyYWE9QpUWYCwm3robxXeTDCMrbl0cX/TRkB2S
 l9XeDqNi+0/MNvepiOcm/D8qKj3r3aWJNG7foRiPY3jDGXWWXgJVRzMOC4GLEeq6HgtWJqFoV
 P+Ed2iYflrhGsaU0VjbaeYIiw53d9J9TNcpDnWGTnz4RIKpCQP0Pn3TCDuaAkUnDkHo54Mnb8
 qmjBf3/kX8zOGS7zOaPgbYdVnqmr/7tI0vS8XJb1MbZDYOBnovncEn0fyyyLkAdO21+GdC7MR
 3/R5Y4UHGbxP4X9yiZg2VG2HPWAdVxYICcQUUKhLoulJWcdsYmbQRijR+YeHJ20ytcZkXsYay
 0Ied7ZBBOWx/D9bYQBOukO9oNFsO/+y8fXgHMOWnnSSUM1VYIgG2IS44s/G3ly0Hceyve5FDx
 RXIUYNsZ/QfgxeOJ3XH8Rqe7idjJPDFRbP3JuYt+fRTXqVv3vAGGesfXmYRufzSy8OkoI4Lco
 Xi6fU8Y3cmwEjl7SmxMhpsWSLPaeBpV/N7Vo7tTEyvViHGa7HfG+exX1ojEy/2pcERdQn1+Ls
 Wd2tozeMxfopg3yTt7LeybNsIhHDPs2IGvOW52nci5fxSdVLfKaBL0UC4ZYGYK3+GtglDnaF8
 MhcC+gDBJuxu9natIRrKrBTrjgX8UpNVqcNyk35z6ZgaKBIrulUBBzESIMos3JEWc4VmqCvJN
 zlrBaQ6pcdy6BnYDAh0D2aK1X1vfw5+BLXyg/AzrlMJRkg==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 12:52, Greg KH wrote:
> On Thu, Sep 29, 2022 at 12:22:35PM +0000, Artem S. Tashkinov wrote:
>> Let me be brutally honest here, if you're working on the kernel,
>> specially for a large company such as e.g. Intel, you're _expected_ to
>> address the issues which are related to the kernel component[s] you're
>> maintaining/developing otherwise it's not "development" it's "I'm
>> dumping my code because my employer pays me to do that". That also mean=
s
>> you're expected to address bug reports.
>
> I wish that were the case, unfortunately it is quite rare that
> maintainers of subsystems of the kernel are allowed to work on upstream
> issues like this all the time.  Heck, part of the time would be
> wonderful too, but that is also quite rare.  So while maintainers would
> love to be able to work like this, getting their management to agree to
> this is not very common, sadly.

Understood but it's illogical and I cannot/will not accept it. For
instance, here's a very common scenario: you work for company X. The
company tells you to fix a bug/add a new feature/etc. You write the
code, submit it and it results in a regression for other use cases. Are
you saying it's alright and shouldn't be addressed? That's _exactly_ how
many if not _most_ regressions in the kernel are introduced.

>
>> AFAIK, the kernel bugzilla is a Linux Foundation project and the
>> organization receives funding from its very rich members including
>> Google, Meta, Intel, and even Microsoft. The fact that no one is
>> seriously working on it looks shameful and sad. We are not talking abou=
t
>> a minor odd library with a dozen users we are talking about the kernel.
>
> bugzilla.kernel.org is _hosted_ by the LF, and does a great job of
> keeping it running and alive.  The LF has nothing to do with the content
> of the bugs in it, the reporting, the response of people to reported
> bugs, assigning bugs to anyone, getting them fixed, or anything else
> related to the content in the database at all.  Please don't get
> confused with the resources provided to host the system vs. the people
> who actually do the kernel development itself.
>
> Note, the LF does sponsor a few kernel developers to do work on the
> kernel, including myself, but we are a tiny drop in the bucket compared
> to the 4000+ developers who contribute to the kernel every year.
 >
 > thanks,
 >
 > greg k-h

Keeping the website up and running requires next to zero human
time/resources, that's not proper maintenance. The
components/subsystems/developers haven't been updated in over a decade
which results in a bug tracker which is nearly useless. People often
file bug reports under "Other/Other" and no one is notified of anything.
I don't even want to touch on the fact that the  Bugzilla version the
website is running is terribly outdated.

That's the issue I thought we're trying to resolve - making bugzilla
useful. Under no circumstances I want to engage kernel developers or
blame them for anything. I'm grateful you exist and do your work :-)

Best regards,
Artem

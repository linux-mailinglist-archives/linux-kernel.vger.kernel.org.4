Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B1C67B5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjAYPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjAYPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:23:48 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552104E526
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:23:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ADB075C019C;
        Wed, 25 Jan 2023 10:23:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 10:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674660224; x=1674746624; bh=rQpcdqG/Qv
        CurjPIHFwcDIcF/tD39eajK/ztGr+w+mk=; b=Y02LNsWNKL7P0aktoR5nPwRRvD
        Ec3Wx7cAGg8wz1Bv/DS2H6ZWk+ctN9oMUFksvsTIkeSEsdgK76W59CaShhNv+pqS
        i/7rSYN5HN3gMc54zGuIUqXVU/XZgwtVqACUSuYMfrF8baBz4gPtwqhhMiSskKdy
        SM0fN4NVqT5Usyt5/Sazxj1028OHAgSmBwbqMketazqUk5yddgcDcXoC4alVGwC5
        4w1hOaH0x8m7lJYcfJWkfXvyqXK0cxUB/I6D0OyzxjGNPiFG6kTbHyfJROLdp29y
        j+n0gYKtqfTHz1gGryThhY9grOZFRD04h6EBcS3pJe9gh4Q0fiwLyLcWVVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674660224; x=1674746624; bh=rQpcdqG/QvCurjPIHFwcDIcF/tD3
        9eajK/ztGr+w+mk=; b=jYwgcclXTw85GVZ8CuAfNSN0cBI/5mfMYnY3DaBuzVSs
        +24krFtRfvS/W2Ryyl02QcqwmvWQY/SrQ1LCG9ixC2aGJ9ei0vjtj+5PLu6GfyQa
        WHiVtKK869YhT6+QL8eHnWRXkluUXYfWp2/0AdnW1CA6hUvG3ZCUxm/5QII+n4tx
        8dNLF4+4pz5k41ZgC4w6QgE0sOGIq9ewkZZLm+KFkDRk9wOwM3h8ICWxWsxEWaZy
        twV8W9CNhC55l3k4zs93Kwmb/S8WAObCpIldRTOvPcgK2+TnLJ1QIt0Zve2DfPZR
        byGSqeMqR+cgmw2I/XXy5wslozY1CJX92UtCFUXOoA==
X-ME-Sender: <xms:gEnRY0li0WEPKwHJhfBUkolS0qbQBXkwQwOu8kC3ucFnUBMGgABu4Q>
    <xme:gEnRYz2LtvWgGze3SXZKNUEdpXQQFvz7Pebaaq-ohKQ3kU6WrTCnAxJsXuNhBrjXg
    xJTBU4iOsiNVcLis90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvdeludeuhfejgeeiledvjedtleekgeduhedtgeduueffhffghefhhfevhfeu
    geefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgpdhgih
    htlhgrsgdrtghomhdpthhugihsuhhithgvrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gEnRYypvbtmaRwPm6TMoDai5PAdDpH-ZWmYYdzsezBl6AOqoNcbVOw>
    <xmx:gEnRYwl9gPeVFR1-6TvwUSY3klcNaPXNgOhTKEYLhzpQKSCyv3YlmA>
    <xmx:gEnRYy0XmyAuvGbyHhTFX74MuKXjQcI5iiPOnbn8b9wJiMOFsi3uyw>
    <xmx:gEnRYzJ2n2hlsGY60p7pCCpFBMOSILwEL6tMnqwi32z8DLbBfH5OTg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0273CB60086; Wed, 25 Jan 2023 10:23:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <777c2c8f-1d2a-48d4-a662-38a87341e92c@app.fastmail.com>
In-Reply-To: <CA+G9fYsoGiJRYeuUpak+5aQ4Ev8s_u0YZKXMQuP7CwQsWo1G6g@mail.gmail.com>
References: <CA+G9fYsoGiJRYeuUpak+5aQ4Ev8s_u0YZKXMQuP7CwQsWo1G6g@mail.gmail.com>
Date:   Wed, 25 Jan 2023 16:23:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "LTP List" <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     chrubis <chrubis@suse.cz>, "Shakeel Butt" <shakeelb@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Vasily Averin" <vvs@virtuozzo.com>,
        "Luiz Capitulino" <luizcap@amazon.com>
Subject: Re: next-20230124: LTP: shmctl01.c:120: TFAIL: after child shmdt()
 shm_nattcg=20 expected 0
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

On Wed, Jan 25, 2023, at 16:11, Naresh Kamboju wrote:
> LTP syscalls shmctl01 test failed on Linux next-20230124 tag across all the
> available architectures with following error logs,
>
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> shmctl01.c:256: TINFO: shm_id=9 maps to kernel index=9
> shmctl01.c:220: TINFO: Basic checks
> shmctl01.c:175: TPASS: IPC_STAT: shm_segsz=2048
> shmctl01.c:182: TPASS: IPC_STAT: shm_cpid=103946
> shmctl01.c:189: TPASS: IPC_STAT: shm_ctime=1674621556 in range
> <1674621556,1674621556>
> shmctl01.c:175: TPASS: SHM_STAT: shm_segsz=2048
> shmctl01.c:182: TPASS: SHM_STAT: shm_cpid=103946
> shmctl01.c:189: TPASS: SHM_STAT: shm_ctime=1674621556 in range
> <1674621556,1674621556>
> shmctl01.c:220: TINFO: Children attach SHM
> shmctl01.c:116: TPASS: before child shmat() shm_nattch=0
> shmctl01.c:116: TPASS: after child shmat() shm_nattch=20
> shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=20 expected 0
> shmctl01.c:220: TINFO: Chidlren inherit SHM
> shmctl01.c:116: TPASS: inherited after fork() shm_nattch=21
> shmctl01.c:120: TFAIL: after child shmdt() shm_nattcg=21 expected 1
> shmctl01.c:120: TFAIL: after parent shmdt() shm_nattcg=21 expected 0
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

$ git log ..next-20230125 --stat --stat ipc/

commit 823fb3d78226e9b89c6a707654bd3284b06aef61
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri Jan 20 11:26:16 2023 -0500

    ipc/shm: use the vma iterator for munmap calls
    
    Pass through the vma iterator to do_vmi_munmap() to handle the iterator
    state internally
    
    Link: https://lkml.kernel.org/r/20230120162650.984577-16-Liam.Howlett@oracle.com
    Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

 ipc/shm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Sven Schnelle also reported this earlier today:

https://lore.kernel.org/all/20230125134558.mm3dopfa7cxqux5h@revolver/

    Arnd

> Test logs:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230124/testrun/14344836/suite/ltp-syscalls/test/shmat01/details/
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/log
>
> Test history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230125/testrun/14356742/suite/ltp-syscalls/test/shmat01/history/
>
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: a54df7622717a40ddec95fd98086aff8ba7839a6
>   git_describe: next-20230124
>   kernel_version: 6.2.0-rc5
>   kernel-config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/config
>   build-url: 
> https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/755587911
>   artifact-location:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl19cvIBraXOcZpBGCPzCajGAs/
>   toolchain: gcc-11
>
> --
> Linaro LKFT
> https://lkft.linaro.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFD745993
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGCKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGCKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:04:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B8E74
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:04:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 008413200909;
        Mon,  3 Jul 2023 06:04:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 03 Jul 2023 06:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688378641; x=1688465041; bh=XD
        MTdubj4bFh9b2AITgPBVqq5Be93OkL1yTP/pmBOI8=; b=gb2LnScsr4wdBbRVZd
        Vrn4qPQGFGMPWyKRGLG4OBK8+basSfJduDyWmZvhDc1vg0xk7LDG6/a7fWVxZLlM
        +tkl7cQ4LKmKSAuGNRHyhL/2ew4kHyMk0WJ/dsEe2g0TVkbUBUtni9OJ9vmUVVG5
        z4V4p6f5j2HFVetEskzkcfHb+RGmgm2FfVSSv6W0NuSuFsBUn/ctzvbYPYAWuC2e
        59HWu7ruHlqgPI5imbTIxVVXQuNTkefIdFTww+4rXFV4Qblz3z+1rCL7WyMlMdIR
        Z34bBcq8ybXctQdgALhWsBb/kk9fLmd9b4fNlJwl3zlTDxXCumDR806WbR5Ul9l2
        ZcMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688378641; x=1688465041; bh=XDMTdubj4bFh9
        b2AITgPBVqq5Be93OkL1yTP/pmBOI8=; b=NKEZ8MHL9NSJNbGwY6IsT+NL5twVY
        IDVrUISXktuA5JqoKrpZr0pJgHJOluJt3209N7TeBTao+WlsOiKz+CaLXK8Pjrqd
        nZ6UBvoJEbxWNKThdj4yEWJKecb5P+pqhZZVRJrCELgsqBvoRDbb2uncqc51Odj4
        wQQTg5H4lPGL7M1FiveMVTu0CynVZFFiDHoWC2IkR8G6ZsJZv+RZjnjzZP2YLkNg
        WnNsNohjZ+u7MJlw76n7LsoedzhR/oYE1pOWpBeo+oig8/sZ1RwPCn2ctdJ6lCDb
        fiG2FpOILvXpYWRbc6hq+V+atlPrMqoD9LuLyfrE5Bl0BPLff4D3zIKlg==
X-ME-Sender: <xms:EZ2iZPiWTZq13Ce0HXPfkBl6CZ55J2pfuJsDelQzNnj0nmNOQp8dYg>
    <xme:EZ2iZMAzQu33ZmGrd0QvySCxXQXmD-fJAOr6nptTPQVgxKmGc8l0v2irUHILK_OBD
    7eQvCdYNprHLTnE3eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffjeduteevtedvtddvgfffleefvdekhfefgeelvedtkeffffegveehheefvdfh
    ieenucffohhmrghinhepthhugihsuhhithgvrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:EZ2iZPHgDqySQjJzdyzMtvX6Vln9_kBPl4E-q68uJSyvkeDspsEhxA>
    <xmx:EZ2iZMS4fUGzwjkYUcOSPV3ApY9FnEhJmXdXrrGA08WhIPn4BiVJEg>
    <xmx:EZ2iZMyHe1_C4n2rkr66sLurO18JZjluY2Do5C67T-l1dFZrs2fyKg>
    <xmx:EZ2iZDmqrtwa4eac932opdvCUPhETbpHlc_bdx8WJaftO-OQPNKqrg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 380D5B60086; Mon,  3 Jul 2023 06:04:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <cd9d8682-08b6-4307-9eb7-9ac838d62eb2@app.fastmail.com>
In-Reply-To: <ZKKaOeRj5Quf00S2@FVFF77S0Q05N>
References: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
 <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
 <CA+G9fYt0Sh-0vFQSWjJz0di-vAc-Ke-bwjqyGM=d_M==x6OnOg@mail.gmail.com>
 <ZKKaOeRj5Quf00S2@FVFF77S0Q05N>
Date:   Mon, 03 Jul 2023 12:03:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Rutland" <mark.rutland@arm.com>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING: CPU: 3 PID:
 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023, at 11:51, Mark Rutland wrote:
> On Mon, Jul 03, 2023 at 12:02:22PM +0530, Naresh Kamboju wrote:
>> On Sun, 2 Jul 2023 at 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Sat, Jul 1, 2023, at 10:42, Naresh Kamboju wrote:
>> >
>> 
>> Here is the build artifacts location with kselftest merge configs.
>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2Rum1V78RQJMftEanwtN28dApDO/
>
> In your .config here, I note you have:
>
> | CONFIG_UBSAN_TRAP=y
>
> Can you try this with CONFIG_UBSAN_TRAP=n ?
>
>> [   56.150153] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
>> sha512_ce sha512_arm64 cfg80211 bluetooth rfkill sch_fq_codel fuse drm
>> [   56.151781] CPU: 0 PID: 438 Comm: seccomp_bpf Not tainted 6.4.0 #1
>> [   56.152043] Hardware name: linux,dummy-virt (DT)
>> [   56.152396] pstate: 41400005 (nZcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>> [   56.152667] pc : alloc_pid+0x3b4/0x3c8
>> [   56.154243] lr : alloc_pid+0x140/0x3c8
>
> Looking at objdump, that's:
>
> | ffff8000800d73b0 <alloc_pid>:
> | ...
> | ffff8000800d7764:       d4207d00        brk     #0x3e8
>
> ... and addr2line fingers this as:
>
> | [mark@lakrids:~/tmp-naresh-kamboju]% usekorg 10.3.0 
> aarch64-linux-addr2line -ife vmlinux ffff8000800d7764                   
>        
> | alloc_pid
> | /builds/linux/kernel/pid.c:244
>
> ... which appears to be:
>
> | 244                 pid->numbers[i].nr = nr;
>
> Full objdump of the function below; as above I suspect this is UBSAN triggering
> a __builtin_trap() on an out-of-range access.

It looks like a fix has already made it into mainline now, so it
should be fixed on the latest linux-next:

https://lore.kernel.org/lkml/20230630180418.gonna.286-kees@kernel.org/

     arnd

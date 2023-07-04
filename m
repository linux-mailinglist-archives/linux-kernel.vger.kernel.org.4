Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125E746F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGDKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:53:42 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFDE6E;
        Tue,  4 Jul 2023 03:53:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9768D5C027C;
        Tue,  4 Jul 2023 06:53:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 06:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688468018; x=1688554418; bh=KL
        sZWuI+VjipuyvuWBTWE6vo83syrjKoVbPEreEW6BE=; b=HN4fYNxR3LjTwXgXOe
        /+NhtE9yRZ8BxtkofVurr/pHK3ipCXj3fSsHAIep3HFwKFnQ9uft4hmnT7c3EgGk
        4xP+kmH7Mu4ibS/GLsET4c6SGlHBAM7VjqjMMDZYimOhoRu360M+6H0+n2zxJlHx
        IFMfqSOcRid3w6tk04BKcygiDjqiNf6zDdxYuDWc/8+jQLnz+2mDTj7wntM+KVSv
        QY2iHCwq36JRtwBx2xCOhtZzjxfEol6eWmhhk42Jdp7mxOLxRFRjf+6h+GfURe8+
        GiGVPGmnrjwgq4tso6hJDMD9imK4f3QabC2VDBjnfr1uHDa6UZLq2+OMkgAUKcUy
        /qOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688468018; x=1688554418; bh=KLsZWuI+Vjipu
        yvuWBTWE6vo83syrjKoVbPEreEW6BE=; b=RvWWQHr2VfqQzN+tr0z6zalSxtjAI
        4ZO94uUfRzW4E0nANpXW1wS3I90Ix7Z9PFN2M6s40Yq0RHhsGH63nQ4E0yBmgs5B
        mEgaZgzJsaiGP2B5aUe5Lh7SDlcnr+c/OYnpNXElnqbxvnIqQH3y1ZtGVFnRHJmg
        jHUfE1SwfJC//uwp6Bw+k2w03dVwn+xpcDZiJgVAhpc7Y4WhPh4vXnBW6mPR0fQm
        Xd8k0FBcJf3p1DtCPNQ1T6uEeSzVkYf+LSBS8lXKN2iqBSuGgiBvVC6aztbZd22o
        qtKHWpTGNx5KlWY6Pm4VigEWUv1z20LNxp1XowDxNTD+5Bv372ciaaBAQ==
X-ME-Sender: <xms:MfqjZBJBDEasCnUjWBIATTC60d3XiG5jSqaQZBG0xpgrcTfqgunXmw>
    <xme:MfqjZNL8O7bz-qHt6Tdtb2-zWINOm6OATnDzUzGYoGlWvspjw0YIxIqYPs93sJJWs
    EaHa8_XWoXeE4v1ibA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MvqjZJupp6HnR_H9BuCC2ZASgFPLr1rKvU_iRI5T3zPFZ7nwh7xmVA>
    <xmx:MvqjZCbli4BY_EnafUW2C4ag-QRbUzDwBNlu9yf4rlzeaXwW8-fxnA>
    <xmx:MvqjZIZ5vNqduZtKEGVdCHwB0T2FNJ9657mNUauTAikrr86umpxxgQ>
    <xmx:MvqjZFKPTxZgIIIeM-P932C7LqIyGeRL4CM3aP0C4Y0UmNrdYPyWhQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E510AB60086; Tue,  4 Jul 2023 06:53:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <e653087d-207f-483c-8795-fc278ccad765@app.fastmail.com>
In-Reply-To: <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
References: <20230703184519.206275653@linuxfoundation.org>
 <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
Date:   Tue, 04 Jul 2023 12:53:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Guenter Roeck" <linux@roeck-us.net>, shuah <shuah@kernel.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        "Pavel Machek" <pavel@denx.de>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        srw@sladewatkins.net, rwarsow@gmx.de,
        "Conor Dooley" <conor@kernel.org>
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023, at 09:34, Naresh Kamboju wrote:
> On Tue, 4 Jul 2023 at 00:26, Greg Kroah-Hartman
> [   54.386939] hugefallocate01 (410): drop_caches: 3
> g tests.......
> tst_hugepage.c:83: TINFO: 2 huge[   54.396708] BUG: kernel NULL
> pointer dereference, address: 0000000000000034
> [   54.404495] #PF: supervisor write access in kernel mode
> [   54.409718] #PF: error_code(0x0002) - not-present page
> [   54.414849] PGD 800000010394a067 P4D 800000010394a067 PUD 1033ba067 PMD 0
> [   54.421721] Oops: 0002 [#1] PREEMPT SMP PTI
> [   54.425900] CPU: 3 PID: 411 Comm: hugefallocate01 Not tainted 6.3.12-rc1 #1
> [   54.432860] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [   54.440244] RIP: 0010:hugetlbfs_fallocate+0x256/0x580
> [   54.445296] Code: 3d 6f 37 06 02 89 c3 48 c1 e3 05 48 01 df e8 71
> fa cb 00 31 c9 31 d2 4c 89 e6 4c 89 f7 e8 72 a6 de ff 48 3d 00 f0 ff
> ff 77 53 <f0> ff 48 34 74 43 48 03 1d 3d 37 06 02 48 89 df e8 25 f0 cb
> 00 48
> [   54.464041] RSP: 0018:ffffab24409f7dc0 EFLAGS: 00010207
> [   54.469260] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
> [   54.476390] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fe006b253c0
> [   54.483514] RBP: ffffab24409f7ec0 R08: 0000000000000000 R09: 0000000000000000
> [   54.490640] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   54.497762] R13: ffff9fe006a68010 R14: ffff9fe006a68188 R15: 0000000000000000
> [   54.504887] FS:  00007f8bec2ff740(0000) GS:ffff9fe367b80000(0000)
> knlGS:0000000000000000
> [   54.512965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.518702] CR2: 0000000000000034 CR3: 0000000101cd2003 CR4: 00000000003706e0
> [   54.525826] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   54.532950] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   54.540075] Call Trace:
> [   54.542519]  <TASK>
> [   54.544618]  ? show_regs+0x6e/0x80
> [   54.548022]  ? __die+0x29/0x70
> [   54.551080]  ? page_fault_oops+0x154/0x470
> [   54.555186]  ? do_user_addr_fault+0x2f3/0x580
> [   54.559551]  ? exc_page_fault+0x6b/0x170
> [   54.563502]  ? asm_exc_page_fault+0x2b/0x30
> [   54.567686]  ? hugetlbfs_fallocate+0x256/0x580

From your vmlinux file I see this hugetlbfs_fallocate+0x256/0x580
is folio_put(NULL):

ffffffff815bdd29:       e8 72 a6 de ff          call   ffffffff813a83a0 <__filemap_get_folio>
ffffffff815bdd2e:       48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
ffffffff815bdd34:       77 53                   ja     ffffffff815bdd89 <hugetlbfs_fallocate+0x2a9>
ffffffff815bdd36:       f0 ff 48 34             lock decl 0x34(%rax)


                /* See if already present in mapping to avoid alloc/free */
                folio = filemap_get_folio(mapping, index);
                if (!IS_ERR(folio)) {
                        folio_put(folio);

It looks like filemap_get_folio() has always returned NULL on error
rather than an error pointer.

     Arnd

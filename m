Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379673AEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjFWDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFWDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:07:10 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA59DD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:07:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B0AE1320093A;
        Thu, 22 Jun 2023 23:07:05 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Thu, 22 Jun 2023 23:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687489625; x=1687576025; bh=zc5Go08f26aOzzulWzMcRDT6ExbHeakAyT6
        t5lQIPUI=; b=h3/AXS9xmtUA7qGJMkyzw4rljncEljhzL6lBelGYvZzE8gcJiF7
        5D/beNqo5yo/Wz/4zC/P9jTU990o3QYPrnrbS+wXtpPewbfLeIgaPSMNmK5KDtYf
        NICu39DortiQ198td2udfa0+sF3qxYS8ZO+1bO236SFQlS4QpHnA5Ovu6Q21ytAR
        O1Klc8eK11F97qkJzNqDS5EmCarn6am9ya1fFNNkNk9ZVUm1rkOFBzS74MoVDGbG
        lQIGzOfZMUa5ctsPpE8L+dhYKO3ixiOrifOR74fy+ChScrcW7zBJWORZIPhSzh8d
        RFzN9b+lwUktcfZal3xOVh4JV2E13qJcCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687489625; x=1687576025; bh=zc5Go08f26aOzzulWzMcRDT6ExbHeakAyT6
        t5lQIPUI=; b=eHLEqZZwScuPAFSBC5/O6mMNCRgh09UKe9NcmEYuhDuc5UfkSDU
        DHeq5wSxXqQDZtxRZb8SD6eOzK9Fwe4RqMgFAkFL2Mt3qsZYl4/ePdd4336eWsAB
        /TkbZxiHmb6IETi0zOYUITktpwshsu0xGIw3aW2uPhAYPZHDcoIuUNsJhAX3IjB1
        HOmSxh5gN1uj8rjjnjR0x8mWR5rXXAfIVVbilBy+oENtSBfFnvcUzmOGTja+ki/v
        hbtF05uyqFlDeREr/UgAUNwb11MiOlU5Wf9l+kzKad14F5Ua98rnHRL7RKdHzjDe
        lpn7uxePybyf4gMf/5ZBo1lkePilC7HiIsg==
X-ME-Sender: <xms:WQyVZPbgEh_xOEqPUmZ26TrTGRrELfyhWeXYmSICaoig3xatBMosCA>
    <xme:WQyVZObo5C8wQwpMqzBSEbhTvKH4uh_Mm6bg6fUUp_jUq6QC_7zR4sT3xgfJOPh2e
    bm2WWVomo7OejZV-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegfedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeijedvffelueelveeitedvkefgjeegueehfedtgfffjefg
    tdfhieffhfdtgeegjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehfrghs
    thhmrghilhdrtghomh
X-ME-Proxy: <xmx:WQyVZB8mHi2pdopa-_wb-ffWxpyW_XiXZGMP2_BWRHX0BlNuFc-6iQ>
    <xmx:WQyVZFqBjZfTiHFgkMJZzEq9GilHGGWwxUxxSnDtiALPUn46h-dlYQ>
    <xmx:WQyVZKqzsjDU0JbwFCQhHbgxUfEShwkBbX97T6_o0VQakTERMDsKxw>
    <xmx:WQyVZHBTdvB5oHEfX9YOJaHL5KtloSPA9AwgpSNBAMHPn025KvHsbA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ECA061700093; Thu, 22 Jun 2023 23:07:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <c01ee919-9abb-4796-9ed4-9bb4565dc863@app.fastmail.com>
In-Reply-To: <9132027.CDJkKcVGEf@diego>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <1941316.PYKUYFuaPT@diego>
 <23381fc8-c297-46ed-9e11-a2643e18e4c9@app.fastmail.com>
 <9132027.CDJkKcVGEf@diego>
Date:   Thu, 22 Jun 2023 23:06:44 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Heiko Stuebner" <heiko@sntech.de>,
        "Palmer Dabbelt" <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 4:35 PM, Heiko St=C3=BCbner wrote:
> Am Donnerstag, 22. Juni 2023, 20:58:37 CEST schrieb Stefan O'Rear:
>> Are you aware of "3.7. Vector Fixed-Point Fields in fcsr" in
>> riscv-v-spec-0.7.1.pdf?
>
> oh wow, thanks a lot for that pointer, now I understand your concern.
>
> So in vector-0.7.1 fcsr[10:9] mirrors vxrm and fcsr[8] mirrors vxsat.
>
>
> On a positive note, the T-Head cores seem to not implement the full
> vector 0.7.1 specification after all, in the documentation I have [0]
> fcsr[31:8] are declared as "0" and uppermost bits are [7:5] for the "f=
rm"
> field.

Given that the pdf you linked does not mention any vector CSRs, I am not
confident that it provides a complete and accurate description of vector
functionality in other registers for the C906 with vector extension.

Assuming that you have access to such a chip, I would be much happier wi=
th
the proposed "just a comment" approach if our understanding of the behav=
ior
were confirmed on hardware (specifically: csr_write(CSR_FCSR, 0x700) sho=
uld
not affect csr_read(CSR_VXRM) or csr_read(CSR_VXSAT)).

-s

> So I guess a code comment should suffice to explain :-)
>
>
> Regards
> Heiko
>
>
> [0]=20
> https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%=
81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
> 16.3.1.3 =E6=B5=AE=E7=82=B9=E6=8E=A7=E5=88=B6=E7=8A=B6=E6=80=81=E5=AF=84=
=E5=AD=98=E5=99=A8=EF=BC=88FCSR=EF=BC=89 on page 334

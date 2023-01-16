Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8766BB89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAPKSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAPKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:17:25 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A40E3A0;
        Mon, 16 Jan 2023 02:17:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 037C45C00B5;
        Mon, 16 Jan 2023 05:17:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 16 Jan 2023 05:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1673864221; x=
        1673950621; bh=iejAn/JA2IrvyMX9kgO+F6LQ9d4XrEBaYkb9PfZupCU=; b=X
        v4kOJhW3fCQ06lB5cyOKmnI0pwoCJwp0NET8xASsDqh+z5WZ5TTFHGcxj2i8135d
        wGYHjAwiTs5/092AgaqvXTHC560dE6A+71h/2XUzgwmRBh7rDXeG7EeT8p0AqYjX
        C1wcBzqylqnTLBhf/KbrJ2NFcVVCLs9ziejZTugY3tiy51bBMvOhJrx40xhkuCrE
        qm0nCZxab5zE9lKi2CjllW7ps3sit2deeKUAKd/KBYW6pWG1av5YGTrjW6mEFgIA
        IEEj3AVnjDrjvQaEPFBAOnnu0VGT12GXGv3Znh/+oH+XMIg/aSAAot4i8P+CmLb7
        tUY8vXyiO5dFp3IAeCLqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673864221; x=
        1673950621; bh=iejAn/JA2IrvyMX9kgO+F6LQ9d4XrEBaYkb9PfZupCU=; b=p
        u5NB9L5T21juEG5S38HhlEz0/cRdp5S22ZR3xTNlBTuXnA08FjH5h6Udev3MPcB0
        rzIpctp3LxJgXZctmKmVTuHUA0in+HmnuhqNyHXnxC11ehL64efj3aMTA6pgj0Fk
        hJK8V8cIdlgCfiqbAC8nZSNE7S09ZqxvSNjjx4djoOD9vGeKT+uyXIuC+rHZgPFT
        MsIjmr9YKuSjcongAgHUwLe8MF5cOKidhy3LjiwUP3FLfJaNPbecREUjsPa3gOL1
        /rem4nGE94O5Qig3jNBWS9SX2LrfhoBtIKWmVtWAlOfRUNPr2jEalmkTdl/1gQK2
        wXpjZAUFPZ39QNhX/Gvew==
X-ME-Sender: <xms:HSTFY7LTLSPascLpB_uAV1xwRvONmaWTKfJG4SDcopQ5SMa1kS9oHQ>
    <xme:HSTFY_Iqw_L-Z6aLVcQLq1Qq3d-CY3VV7wY7MTWWe75gAuRK_RbHtG6ApYjQX71Su
    XMF0guM-YySU-HVhtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HSTFYzsNJyDJaCb5-WEg7MPnAqnYV3JrmShdu-6XIbyh92W13dssdQ>
    <xmx:HSTFY0YQy2eE72fnr_MkduADhuYyogOIVfamFDrmuo9xwIJSe5_nhQ>
    <xmx:HSTFYyaW4JIFBq8AP3cbHqZvtgUzWYsfDXUr33SXOfvjuTEoBMadxQ>
    <xmx:HSTFYxkCfnadbAsPCED_Y3sXy6Q20yxf7-QdSzjZT4AWgXfbYmIm6w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5711AB60086; Mon, 16 Jan 2023 05:17:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <7278f631-1b79-46d9-b765-ac3ba8789028@app.fastmail.com>
In-Reply-To: <20230116162739.529247b5@canb.auug.org.au>
References: <20230116162739.529247b5@canb.auug.org.au>
Date:   Mon, 16 Jan 2023 11:16:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023, at 06:27, Stephen Rothwell wrote:
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (various)
> failed like this:
>
> arch/arm/mach-sa1100/h3600.c:125:3: error: =E2=80=98struct irda_platfo=
rm_data=E2=80=99=20
> has no member named =E2=80=98shutdown=E2=80=99
> arch/arm/mach-sa1100/h3600.c:124:3: error: =E2=80=98struct irda_platfo=
rm_data=E2=80=99=20
> has no member named =E2=80=98startup=E2=80=99
> arch/arm/mach-sa1100/h3600.c:123:3: error: =E2=80=98struct irda_platfo=
rm_data=E2=80=99=20
> has no member named =E2=80=98set_speed=E2=80=99
> arch/arm/mach-sa1100/h3600.c:122:3: error: =E2=80=98struct irda_platfo=
rm_data=E2=80=99=20
> has no member named =E2=80=98set_power=E2=80=99
> arch/arm/mach-sa1100/h3600.c:121:34: error: storage size of=20
> =E2=80=98h3600_irda_data=E2=80=99 isn=E2=80=99t known
> arch/arm/mach-sa1100/h3600.c:121:15: error: variable =E2=80=98h3600_ir=
da_data=E2=80=99=20
> has initializer but incomplete type
> arch/arm/mach-sa1100/collie.c:148:3: error: =E2=80=98struct irda_platf=
orm_data=E2=80=99=20
> has no member named =E2=80=98set_power=E2=80=99
> arch/arm/mach-sa1100/collie.c:147:3: error: =E2=80=98struct irda_platf=
orm_data=E2=80=99=20
> has no member named =E2=80=98shutdown=E2=80=99
> arch/arm/mach-sa1100/collie.c:146:3: error: =E2=80=98struct irda_platf=
orm_data=E2=80=99=20
> has no member named =E2=80=98startup=E2=80=99
> arch/arm/mach-sa1100/collie.c:145:34: error: storage size of=20
> =E2=80=98collie_ir_data=E2=80=99 isn=E2=80=99t known
> arch/arm/mach-sa1100/collie.c:145:15: error: variable =E2=80=98collie_=
ir_data=E2=80=99=20
> has initializer but incomplete type
>
> Caused by commit
>
>   56d3391e6c85 ("ARM: sa1100: remove irda references")
>
> These came from the kernelci builds.

Fixed now, thanks for the report!

I had completed a few thousand randconfig builds on this without
seeing the issue, but could reproduce it easily with the
defconfigs.  I had some settings in my randconfig builder to
tip it towards the more common armv6/v7 builds, will adjust it
to do the opposite now for testing that better, and hopefully
remember to undo it all later.

      Arnd

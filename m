Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C4B7195FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjFAItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjFAItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:49:09 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0487D1;
        Thu,  1 Jun 2023 01:49:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1B49F3200951;
        Thu,  1 Jun 2023 04:49:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685609345; x=1685695745; bh=eCFpniw22qDie5oeMCbZFBk/KMmwPbOSe7i
        8BTT45wg=; b=L8xExEjLpQNsoKnji8d+A/N0BZLx5irY/WkqTe1zH1yQrRPZk7Q
        zLNwxAOzNsFXLTom275zEYf2xh3/BHbfbSCPt1ekZ1ANs4TkDsb1VMIffDCC4lIW
        8+ZC9tBftMJDG8k6m+0ZyEKMElh9BsSuJq+wRV6efCXET728Ukn96F7r3DrcIts3
        D0nkxaULN9JvPlcxamelGZvYvGdsfP0gYkhWSw5zgAnSnzXZ9QJQvmCRcxXtVBp2
        xGPjkKqUUdk/R3gXeiUMi+Ca5/IAQEr/tLTZN8b8nicVIO+6lycRQ4ohm38UEICJ
        oxQrG5O9oFF8B4lHYlkcCNFhi3wkvVrjnTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685609345; x=1685695745; bh=eCFpniw22qDie5oeMCbZFBk/KMmwPbOSe7i
        8BTT45wg=; b=B9NyJNbFmVrZeL4fR9Hwr3P9i/NzWRq6wBlit2TccIwyy+4YRZW
        6F8wfE+jopOwQ995bR/ReyfC/HdcevdKv7iRyiH7wl98Usb1Htj/1Ojc9y6k7voN
        5jWXBGlnjUB0pO75jNQNvXNH9oYTDxp88SiWM3SEa3vkqYgOncv6sXPWBshjckRh
        xXuLg20wjuYxsb0zSjIUcxAqRzmLqUppMCI6DxpUo4TZ/bdlFvUrRhBAmpUOzwpS
        YAvhvdfFQDzcKqvMxeTTxgh11mEs4Cq88XP/frnF70xoJIKopK0XA6bUys4H4u5B
        DiAw85zHd/oqDEbvXOnuNuWPBYvHqRzQYLg==
X-ME-Sender: <xms:gVt4ZMIcms5FSWkeryyQVQZaYFZ0EG7FW11EpeTNS0wqQ5-BytubOw>
    <xme:gVt4ZMKmQnSsmsR62gXj5cTxSjNxEy7oMqRYJrtlE2V19sAiYwM9z_9oSbPLlav1J
    wOBJ44BRkcHFqEwo38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gVt4ZMuka1A5xQb1bhbkOM0_sBLsDexmH_FlTLYnMEfpXfLwglUXfw>
    <xmx:gVt4ZJb46i0S0-3TEUg2nfkKMsDV91qXs_hHezxWV3Iemet_OispKQ>
    <xmx:gVt4ZDZg7iI_YwnSjQdmbG9a0trgRfPWkuOpR6OnZS9bz_0ldPvngg>
    <xmx:gVt4ZCn-FL0nl0gXfcqxaU5pAnhTSyJNXZI2jg75LTiR0Ds46BQbeA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28D7FB60086; Thu,  1 Jun 2023 04:49:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <e3bc3d54-53df-46e2-9ebd-08a958be370e@app.fastmail.com>
In-Reply-To: <CACRpkdYneu+c0d5jGgZqEHqyoAbcx6UbkQYHXsNeFvGnehp6SQ@mail.gmail.com>
References: <20230525092202.78a1fb01@canb.auug.org.au>
 <CACRpkdYUPmaBWDwH_ARHp-bFtpML3aShd_mKBBq+ndQATGEJjQ@mail.gmail.com>
 <1b757588-66cc-4946-a9fb-a2a88c5c54cf@app.fastmail.com>
 <CACRpkdYneu+c0d5jGgZqEHqyoAbcx6UbkQYHXsNeFvGnehp6SQ@mail.gmail.com>
Date:   Thu, 01 Jun 2023 10:48:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Will Deacon" <will@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the asm-generic tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023, at 13:36, Linus Walleij wrote:
> On Thu, May 25, 2023 at 6:41=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrato=
r.git
> tags/virt-to-pfn-for-arch-v6.5-2
>
> for you to fetch changes up to ef7d0f5d03b9e65c9daa8dfe8b405b10566055e=
b:
>
>   m68k/mm: Make pfn accessors static inlines (2023-05-29 11:27:08 +020=
0)
>
> ----------------------------------------------------------------
> This is an attempt to harden the typing on virt_to_pfn()
> and pfn_to_virt().

Updated now, thanks.,

     Arnd

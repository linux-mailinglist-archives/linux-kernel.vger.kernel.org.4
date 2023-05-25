Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA8D711129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjEYQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjEYQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:41:28 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4A97;
        Thu, 25 May 2023 09:41:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B3152320091A;
        Thu, 25 May 2023 12:41:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 25 May 2023 12:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685032885; x=1685119285; bh=Rb6sOXU+wJaOoqht5Pzr74z+sqHL7zh/zzB
        TEW0T9PM=; b=xNB2En33usxQ0DXIFHajxHMW8fPE+2WB1XwDS0owgT7zl7cRT7N
        5ocm9J2NBQEhvBYoNIJ1km9ioVvx2xIqyAhCQ6QoUD/uQwpqCP1+30iCHF8UcBKZ
        AP769gF7yN0X316nrEnbq5sRcjgqUNMFXLwFA7WruiW8v13/T+p+Z17eYa23leMS
        mgfc0/fDcdI3wQSYf0VDDVnbscisxut8LzQ86Q4EMfhkoLygT1s7t7FQg1w0zgM9
        E+v1dOaQ/5maBbUQj/DhILhZVk/NuP//Verc39YdAETMSenfs8C65kLeI3g0LSu5
        KjtqAq5d1GNX2jvYOUkkphQ3af5rO2pyUCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685032885; x=1685119285; bh=Rb6sOXU+wJaOoqht5Pzr74z+sqHL7zh/zzB
        TEW0T9PM=; b=YXjCkkMxU02kQE4IYm0d0n08AsSYyGk/dw0DW+R6LRoeKOB/V53
        rBQZzLCshydXNEzHkCLQtnzueKrkgbiWNC6hOvgTPVTbxnb3roN7v+wEpYAgixar
        HfSh6+UZ3fX+LgmWlMSK4trzneY9nz6J/tfykdLlS9lmCHp58qeDDQB0VR4xV+WD
        PUEmDHbg8ixe3K8B1Ra74540IAlADl1wTGrt9Y8pmgqnmEjZubd57EED4cjXedjM
        dpKMHNdLaXjrV/UR/KQFaorgiPe+SKUzhpM6vLZGEfxg0EhXerM3CwJX6AQyqG3h
        w25xR8poPnUDeeNT6jfQPV15uGADWhfF4tw==
X-ME-Sender: <xms:tI9vZLVbKw5rIIzjD7CRI3ykq8Ktp81t2eqenFoJ9EsLxsK-FO3pHg>
    <xme:tI9vZDnGrMUJ5x9tx8vHuqKeZHdeFEolXUdS91i5rPpgzHwGxQsaz16wowGsnz_Nj
    lOdhTLnkeTvmpGa_uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tI9vZHb0k4ZFVOiBd5UDa1oVRLNhyPOju9pM8Yni3drcctwjCv_lmQ>
    <xmx:tI9vZGWGTDB-N-ocKhOK2D5AiPVI_gYSApI4GUC82jagpUmJYV4qpg>
    <xmx:tI9vZFm7swgByX-XykfO-0id1cd7sqYMMUFKekPdqZIB6GvgtZFkuQ>
    <xmx:tY9vZKx6L9hWAaYEmdi9Zw-e330srY8DpP5U1U3qCXYvKlxIV39hQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02493B60086; Thu, 25 May 2023 12:41:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <1b757588-66cc-4946-a9fb-a2a88c5c54cf@app.fastmail.com>
In-Reply-To: <CACRpkdYUPmaBWDwH_ARHp-bFtpML3aShd_mKBBq+ndQATGEJjQ@mail.gmail.com>
References: <20230525092202.78a1fb01@canb.auug.org.au>
 <CACRpkdYUPmaBWDwH_ARHp-bFtpML3aShd_mKBBq+ndQATGEJjQ@mail.gmail.com>
Date:   Thu, 25 May 2023 18:41:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Will Deacon" <will@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the asm-generic tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023, at 15:41, Linus Walleij wrote:
> On Thu, May 25, 2023 at 1:22=E2=80=AFAM Stephen Rothwell <sfr@canb.auu=
g.org.au> wrote:
>
>> The following commits are also in Linus Torvalds' tree as different
>> commits (but the same patches):
>>
>>   b1e7601203a8 ("arm64: vdso: Pass (void *) to virt_to_page()")
>>
>> This is commit
>>
>>   b0abde80620f ("arm64: vdso: Pass (void *) to virt_to_page()")
>>
>> in Linus' tree.
>
> Aha Catalin ACKed it and Will picked it up, perhaps Arnd can drop it f=
rom
> his tree, albeit it is not a disaster, I am surprised this was the
> biggest fallout
> we've seen of those patches.

I can't easily drop it without undoing the merge from your branch.

Maybe you can just rebase your branch on top of -rc2 and send
a new pull request. That should automatically drop the duplicate
patch.

    Arnd

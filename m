Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89D5F5048
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJEHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJEHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:21:47 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680D75396;
        Wed,  5 Oct 2022 00:21:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB7EE58045B;
        Wed,  5 Oct 2022 03:21:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 03:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664954502; x=
        1664958102; bh=hcYTWpc/3N5vEGSKaH2rpYtLEFnHbmeildrec60PXfw=; b=C
        9LhZlFz5Si+YNHNT5HThHJcJyaYbICbYTsPGXLKpp/8woqw3NMi2xeaiqD+VpfIN
        y8Lo61lPuExELQLJJnkt2tfYeoawcR/Bli3fnQsqE0WFC5ciaClvosViML5J9k97
        DA16UmM9e7YLAUTgLLZbAYCApOql+0pp0WoUUFROEoLqp6oPp8vYPT8AnPqJStUU
        nDjCvCETHvb+Zs9nRBylu0hxomMlovqv1OKzHGZXSWjMISLdYSyzcYlaofV/Vktg
        iVZ4cOhJZ/jHvzAw8Riid203h2Bralt4yYHaYAhC4qYuHhaFatY+rVM4ABrVDq39
        wa2hqsF3j8NMZWIjfiaeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664954502; x=
        1664958102; bh=hcYTWpc/3N5vEGSKaH2rpYtLEFnHbmeildrec60PXfw=; b=Z
        d7uGHZpc3T5sp68MR2EmUQ15TnQYo1s/8yjPsC7g1f0zw6BKBbGh5jvZsNnKehy1
        8CerLvAje3Ng7fnLi99KxV4xefAod+HiT5FMoCWlrqOayygFWGfiw+nhZOhcfxNo
        Hfz8D0Z3mKQvUkPmnq+AZzNnwiwtPdLTsbwpbEfyl1JW9mxqCsPP5F88mlHL8Uh6
        bj4YSc9WAWlVxtCxSUb4exlicZyMr+oUSDwTHkX5v6OPF1Ed96wJlL+bFa4AdMP7
        rYnTuJY7V97Tebm7VPaJxKSCmNit2cQZSHZhKifBYbDcR2i1QwKx7+chrD1sBQ/N
        vPhfVuq1gqx208jIGqBDw==
X-ME-Sender: <xms:hTA9Y9VHZ5PzjcgB0OOcoChmy9mTKUb1JRdjMHNV7AlIjNxuZTMZ-Q>
    <xme:hTA9Y9kP1cOGgPSyTXhICsLRLiST-kqaLnyl3AzGYbMFtMCr-jmBfTHUzGPRxnsRT
    3jPqruzmHUKFLoyaRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeivddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hTA9Y5YNYY8lK38hWwfSKTBMYakTNRi-EpQfHzKd2Af1Tuq1KWxNpA>
    <xmx:hTA9YwX5sh3MBtknVDgS7_lGcRII-phKgfPOpJDW59CFkdfcQlhZjg>
    <xmx:hTA9Y3lJzpPehmhZYM-GdjP-42II50vuw95kWHuaFIOCUSeqJdxzfg>
    <xmx:hjA9YysrRaS5bQaTd23h6Mh-t7qvUj1UwBPDCKV_97X32yWNCvNOoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 60BB4B60089; Wed,  5 Oct 2022 03:21:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <f8416a63-3460-4b43-8532-2d5eacea4457@app.fastmail.com>
In-Reply-To: <CACPK8Xecn8ZREAqcLcuZHjA=NhaanRMKu4W39okAkBFX4aaOnw@mail.gmail.com>
References: <20220725095913.31e859ec@canb.auug.org.au>
 <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
 <20220815105419.4df1005b@canb.auug.org.au>
 <20220831091654.45d5ed41@canb.auug.org.au>
 <20221005114841.4540d325@canb.auug.org.au>
 <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
 <CACPK8Xecn8ZREAqcLcuZHjA=NhaanRMKu4W39okAkBFX4aaOnw@mail.gmail.com>
Date:   Wed, 05 Oct 2022 09:21:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Cc:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022, at 8:02 AM, Joel Stanley wrote:
> On Wed, 5 Oct 2022 at 03:01, Florian Fainelli <f.fainelli@gmail.com> w=
rote:
>> >> I am still seeing these warnings.
>> >>
>> >> The above commit is now
>> >>
>> >>    61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller pro=
perties")
>> >
>> > Has any progress been made with this?  This commit is now in the
>> > arm-soc tree.
>>
>> Yes, I was hoping to get some feedback on this patch:
>>
>> https://lore.kernel.org/all/20220920210213.3268525-1-f.fainelli@gmail=
.com/
>>
>> but I suppose being the ARM SoC maintainer I can just go ahead and pu=
sh it.

Sorry, I unfortunately missed this patch, and forgot about the
original issue.

> I'd send a revert of the change. Rafal can then re-submit a series
> that fixes the dtc warnings as well as the yaml warning once they have
> been tested and reviewed.
>
> The yaml warnings aren't seen by other developers, as they require the
> tools to be installed, but those from dtc are.

Agreed. Alternatively, we could just remove the pcie@ nodes from
bcm5301x as a hotfix, as they are clearly not usable in the
current form, and none of the three versions (5.19, Rafa=C5=82's
patch missing ranges, and Florian's patch with incorrect ranges)
actually conform to the binding.

I'll tentatively apply the revert for now so I can send the pull
request tonight. If someone comes up with a better fix, I can
use that instead.

     Arnd

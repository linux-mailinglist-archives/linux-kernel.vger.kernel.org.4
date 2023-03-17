Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C876BEA05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCQNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:22:40 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A47301F;
        Fri, 17 Mar 2023 06:22:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 783D55C00CB;
        Fri, 17 Mar 2023 09:22:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Mar 2023 09:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679059356; x=1679145756; bh=IiuIkC1zEw6QkmK0uIff30q3Fvs8CngwrEt
        lD2Jw2JU=; b=TZBOL3r1hB9jjltsHwaApyTplgqLA29nd0L3SVZ1PC0J/EY4BaS
        NrPGdSPWGrAUeqg5ab0dvvNmwsJbfaQU1v4+FHyUGvR6Jf+nkvHWuJKmRz3Q3qri
        5aZxuL/0CG0SVtwY9cG7k6IvhbTbjXLAty9/bBo7I2DEG727A+j1V6g5AUB42yhy
        O+BNbvqELjbEeDZb39TXH5oN2Dw8kMs7g+gr54JMjJ/pBFFwnneGF0hEiuMv4nM8
        v+rMopV/G9y3NkHoQgyWQRaK9lj1vDb9KUxrg2BdLyr1l7ChPqiqF+hIQO6ZqcrC
        p96GKRQmSpFDVMlbFlNsvn7pMKOSxD5CFxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679059356; x=1679145756; bh=IiuIkC1zEw6QkmK0uIff30q3Fvs8CngwrEt
        lD2Jw2JU=; b=MRXm3Jyhv12HRzCsBLFo2D8Rngs135b9pfCdj4UhXlOurlOlPi/
        +iBcoml4ndcl0cIz9oDCepOjHLjrdFrYioIr5nGp4oCoFB6sIdn0ca/ZAbdfOF1g
        YE043VD+6smRlLoTQoTZ2tt0OJ846z7wEaAji4jyk+rosuP82V5Njcs2NaVgUyps
        antZBOY2ngNVtBbkAGvhnejrSVwk4ssMV3vTMFCwzfKGvjiuPWjBliN/FtPSkZQT
        RYfb5xIfd5hg3oP97bkWQJBiLJSejKOp2pVAzB+xU9ImKScWE5T89nRABt+vq5Ha
        cXN0kOIvxxHXUd54LYJa+jNDF7ZLoTyYrdA==
X-ME-Sender: <xms:m2kUZKGOF46BwguJUhRdIDLrFRUJrHRFo-KVNLKPPL2sozMyK3GiHA>
    <xme:m2kUZLV8jgz7KnW_yyCiSeSct6z9jvVdcxOBVY3Bg4v0mWhMKZA6BfRvadqstbLAe
    1qmHY0jbDE5Z0o9J4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:m2kUZEIP8kAaBYgwEtrxmaN_3lQAUMR5P5xmOjIyvTnf0dWLXyUbEw>
    <xmx:m2kUZEE3gbI7AfNuw4NYJNKi01-DOp_oyVtHhPpRCaN2mCJ18qq-tg>
    <xmx:m2kUZAWx2KKS7y0oFKsFOoMNRA8G65DAquceXsokU3uGuBfagUVJCA>
    <xmx:nGkUZBvzqx1HSUt_98kkxrX83mpwTW4aC0kKem4Nz_UkOfcP30Ly9w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B830FB60086; Fri, 17 Mar 2023 09:22:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <6ed7e89f-2d2c-4134-9c6f-a9d18e2fc8a8@app.fastmail.com>
In-Reply-To: <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
 <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
Date:   Fri, 17 Mar 2023 14:21:56 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023, at 07:30, Jacky Huang wrote:
> On 2023/3/16 =E4=B8=8B=E5=8D=88 10:05, Arnd Bergmann wrote:
>
> Thank you very much for your kind help. You explained it so well,
> I have understood the process. We got a lot of suggestions for this
> patchset, and there are a lot of issues to fix. When most of the
> problems get solved and acknowledged by the reviewers, I will
> add you and soc@kernel.org to Cc.

Ok, sounds good. Two more clarifications from me:

1. I expect you will have to go through two or three submissions
that get more feedback before everyone is happy. Please include
my arnd@arndb.de on Cc on all the submissions, but only include
the soc@kernel.org address when all patches have an Acked-by
or Reviewed-by from the respective subsystem maintainer.

2. I think the series looks very good at this point, and most of the
feedback was about minor details, so I am optimistic that we can
actually merge it soon.

I only now saw that you had already submitted this several times
at the beginning of last year, and this is technically 'v5'
of the series, and it would make sense to add 'v6' to the subject
next time and link back to the previous [1] and this[2] submission
on lore.kernel.org.


    Arnd

[1] https://lore.kernel.org/all/20220510032558.10304-1-ychuang3@nuvoton.=
com/
[2] https://lore.kernel.org/all/20230315072902.9298-1-ychuang570808@gmai=
l.com/

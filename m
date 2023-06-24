Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7367B73CA2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjFXJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjFXJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:30:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149D1728;
        Sat, 24 Jun 2023 02:30:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EDAB5C015B;
        Sat, 24 Jun 2023 05:30:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 24 Jun 2023 05:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687599027; x=1687685427; bh=pWdS1Pf7rNxsgUXrSdamMs345ibx9lD496N
        qTwZSDZc=; b=MpXRcqq4KJujRKw3mCRuXO4tOJ5ZqbBOObe1kpJQsENnYYXADDt
        mrL0N2liwMCXMxEBN0FFhbgx1O2g7Xeee/t/tbuoYB3+VI/+N7g/YW+qou3jSkEH
        mqLBAzqo6IDgus6bQzi4UnPO24HJ9hdu3DfR6wcMomApVB4bm91TEaBT98F43Ap9
        1/CCpUg4+n93lGiKuzCSTwYk82NCdwE1zfEjeZAoxVjCty0cAqxMQ4769Ajo/eTV
        p8nGbcDcmro0181hFsFZQFm4DupHrpNqKo/nppcnmiTQ11McsceTmqGEgSoC6ENo
        Vcho+9EsiR/jFktMR7nZmfTjshcMuCmDtwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687599027; x=1687685427; bh=pWdS1Pf7rNxsgUXrSdamMs345ibx9lD496N
        qTwZSDZc=; b=YkotbRV3NuFAshgjmbvW3ybbrfoEi9qDKokD8wpFHGFnla4XQue
        6J3kyELWBqs1FWXmzJA9brtXHvEfxNX8paXpCeXzdMp7SErMwNe2IsWx+/KrhDQm
        65oE5kz/NBl4p93rZcLLKXCoBh6HBbheQicCKnOIZr81qUnZLruv+LKAsq5STmPW
        FA+K/wMs9cAQEvJmvpSSL3cvrbBqr3RuMJs1b7ZgEA41+xQ8Yzsr4oEquWWO5leH
        BK5Vo6Mt8XNkMjf+Fh26oQYLBNXe7oQydiSQijc30ba5YmpJnNK8OZU+8XPkRbTz
        sBpE7dyCvL7MivHWgJ3UK1OQrymzybwvfyQ==
X-ME-Sender: <xms:sreWZO3A6jHpW6QGgLD-IZmLdEnqEqe5Am-xSXgDMONxW8osZ0NhRw>
    <xme:sreWZBEvu9JYkOZi9tFFtPh7hOJ0JL9fdbKwwvFmMT8dJ2UNzS95RpyrwtCax2hVt
    uTXZlcKPmNj0tO76mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpedufffhudefteevfffgudetleejtefhgfegveehgfeigfeiteffieevffeh
    geegudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohgusgholhhtrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sreWZG6oCP-KUAzyy55M0QblHXwBN9iBXqJpXDEVRfjAJYM7kFziGQ>
    <xmx:sreWZP32TUz1rqGbvtgolDn8oZLxi-EnOo_ibSkBkM-qgXDtMf8iZg>
    <xmx:sreWZBE8mdy75O2ZJzduOztUBLyUS9izymEGwflqmEz0iPpNv5w8Uw>
    <xmx:s7eWZHaICpyn8ZbTiPMnr_auqPoVSv7AHeF5UrZ4VEshbeNBJg2DVw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BEDCBB60086; Sat, 24 Jun 2023 05:30:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <d33a248c-c7ac-43d3-b602-3c801d697922@app.fastmail.com>
In-Reply-To: <20230624105023.146d99e0@barney>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <20230624105023.146d99e0@barney>
Date:   Sat, 24 Jun 2023 11:29:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Regressions" <regressions@lists.linux.dev>,
        "Linux Wireless" <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        "Simon Horman" <simon.horman@corigine.com>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        "Kalle Valo" <kvalo@kernel.org>, sardonimous@hotmail.com
Subject: Re: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jun 24, 2023, at 10:50, Michael B=C3=BCsch wrote:
> On Sat, 24 Jun 2023 08:44:15 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> > I suspect change introduced when addressing a compiler warning
>> > cased the error.
>> >=20
>> > https://patchwork.kernel.org/project/linux-wireless/patch/202305161=
83442.536589-1-arnd%40kernel.org/
>
>
> I doubt it.
> This patch affects the device initialization code. But the crash is in
> the transmit path.
> Can you please double check by manually reverting the patch?

I'm travelling at the moment and can't easily check it, but I would
expect that my patch has no effect on the generated object code at
all. If the compiler output is different with and without my patch,
it's probably wrong. I double-checked the structure layout in
https://godbolt.org, this did not produce any changes, as size,
alignement and offsets of the members are all the same.

     Arnd

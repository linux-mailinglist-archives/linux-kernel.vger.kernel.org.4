Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290F37133D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjE0JpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjE0Jo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:44:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A4DF
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:44:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 11A2932005CA;
        Sat, 27 May 2023 05:44:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 27 May 2023 05:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1685180695; x=1685267095; bh=nvA2vDZl2SPGXHo2WcXVIlS7D8yrJkcG6w5
        G5u7QuH0=; b=xKiKoalyfPGPXoBmx++UjYO72Wv8YBGJDNP3t7VUVI3GwCc5fyu
        wSJPYhmeAbNj6Pz/oVQxdZSqWeuHh3J5kwJ6l4T8ssAgCXey1vkoVYznEdg5JVGh
        M0rI2HVhOME+gX/w5xrhdikIYICSZSuIP27pT0IVzs4yJ7+Abk1u1/wwrtwKtY3x
        z/uiYv9Sz1T/rOgeRNSamkNC449Jmn9XZlBlpsdOVgEE2j2MG71Ed14OmchRYxi5
        AVp+OBP0qKFJx4vOUzLoYpY4wHCJNz6drlBofVDyydA82WephYl0LmuiRT1pzHDT
        z9oIpNhX+SXCToE29N+iu5likvnfwZHvy2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685180695; x=1685267095; bh=nvA2vDZl2SPGXHo2WcXVIlS7D8yrJkcG6w5
        G5u7QuH0=; b=LBBICecVPWl7kqAfIpN1WToWoH37RE50Ef3U54SZaY119uBVudT
        AbLPCFmflByUyP2/ux1N3QfS3tBpvttvFbzPc2Numba/SjPI8PnLpme9MBhr6bPZ
        XviGHTdedsIAdZYcXAVh7fzxQmUijhZmVfDoymaCirHEyLzimAF8QWazO9OkQR6N
        HJ6CtMZZKCNa3f3ACzc6lZLkcxjuL8uybhvAQCf41zXKSbPfvcGCM23aD8fACQ3E
        lZprxKOdR1FYyfy7O34GlYJfSsV/0GLjWwMAMLHIrs9uhyzGaa0zmtQJN1wFCZPn
        DZrIKgfi1fTk5LZc3CTGckFSvbUBcUndCOA==
X-ME-Sender: <xms:F9FxZJKi66mIyp4kv4fjd7iL-bNP3Gres_4Iz8rzkwXWCNGblbN1SQ>
    <xme:F9FxZFKA8c_QbaAzpR2PzCU8c1UjccdtUfSTsSL6p7hZyyZbxcdSco7UBXIDiNvsv
    8Ld2jT2m3rU78xGOaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekuddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:F9FxZBunFeJ1WU4vkWBYGwx_SPzNJoNJAFw0Lti7-l6ur9S0DR_FPg>
    <xmx:F9FxZKbUIXOeTTZa8-0yrSH3hzEDXD3aZn0cQRabIYrk4Bx5YBoUBw>
    <xmx:F9FxZAZzwKOxodnInd1NOAlkgM13NNJR81G5j_XvkIFyXowJYD-ybA>
    <xmx:F9FxZLyOxMvDJYGZPdaDhh7jAoRLJLzQDdwfQ-iEVfi0hvPTZm-q3g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B357B60086; Sat, 27 May 2023 05:44:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <b1435818-2cba-4270-9933-282029f5449c@app.fastmail.com>
In-Reply-To: <20230527005539.5b06df24@mocarz>
References: <20220605224347.481e2fb4@mocarz> <20230527005539.5b06df24@mocarz>
Date:   Sat, 27 May 2023 11:44:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Aleksander Mazur" <deweloper@wp.pl>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH] /proc/modules: honor kptr_restrict even without CONFIG_KALLSYMS
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

On Sat, May 27, 2023, at 00:55, Aleksander Mazur wrote:
> Have you had a chance to review my patch?

I don't seem to have the original submission from you.

> Dnia 2022-06-05, o godz. 22:43:47
> Aleksander Mazur <deweloper@wp.pl> napisa=C5=82(a):
>
>> Commit e4a8ca3baa55 fixed building without CONFIG_KALLSYMS by providi=
ng
>> dummy kallsyms_show_value(). Unfortunately -- due to hard-coded "fals=
e"
>> being returned -- access to addresses in /proc/modules became permane=
ntly
>> disabled.
>>=20
>> My proposal is to change this unconditional "false" to !kptr_restrict.
>> This re-enables addresses in /proc/modules even without CONFIG_KALLSY=
SMS
>> unless restricted by means of sysctl (kernel.kptr_restrict).

I just looked at the original 516fb7f2e73dc ("/proc/module: use the
same logic as /proc/kallsyms for address exposure") commit again,
the intention here was to use the same logic for /proc/modules
and /proc/kallsyms.

I agree that this means my patch went too far, but I'm not sure
about yours either. Maybe we can just move kallsyms_show_value()
into a different location that is always built and rename it
accordingly. Then it can be used by both kallsyms and /proc/modules
regardless of which combination of these two is enabled in the
kernel.

     Arnd

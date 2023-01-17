Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDD66E847
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjAQVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjAQVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:14:40 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07D6F31C;
        Tue, 17 Jan 2023 11:37:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6096C5C009F;
        Tue, 17 Jan 2023 14:37:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 17 Jan 2023 14:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673984238; x=1674070638; bh=6qTvR3PDhn
        oUYLcG1+3Ef1oVsOr21YY18FaKs3AynEQ=; b=Un2YZGCDSBcX/QXd0YvaFhFIKj
        cDc59GZPym4Gh++p7j7m6ROoxzr7lbNvlrPmeG3C4vY3+BFZLPVr4VW9YNGhA3Cc
        akPkaCWqo7n6KM4Iv+4jt2zb5CRBBH7LRWqpcn+uYQORIAkwAdgQ/7CR8SiMQ9Xb
        TZwHWAaU1FHebqMyY45jowMQz8QDlSAN2xpmzmwad04gNHIvkTH6mwZVNnKdB4Ld
        d8mZusR+ylTkl7bo89CFvC4u9uSCxN7kY7uqeBXK4KyRXWtfR0Y5bJFK/ojunCsg
        mKwbciOaVbTwVyuHv+n2q+T3bFPmuwa/zznGZNBfjjIu/gXYGG3hnD0CbLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673984238; x=1674070638; bh=6qTvR3PDhnoUYLcG1+3Ef1oVsOr2
        1YY18FaKs3AynEQ=; b=bDq62dTj7/XicQ7Tfoukhyx1ykWSJR+P0heWqfZcRhFI
        l2t7Js/x9eXQeu4hXqR8csOZOBhx2u/Su8ED1V4h06o9dashPt7DyMTgqTVHKK/q
        YFGCQOjqRXEycCWY+vkweG6jAMPbZR7EUMNh1lzykyshpgPTcFEn8SIBY3W/a0MO
        +qMnDXx9W63BkBWVuFgSNtxS/O2sUfMx4M6Q1VVjOefj03xY7Fq5Jq0jwjkC6fF5
        ixbgWXRxYZWmQfdsrQY38brtVwvvqaDaHtoXdOMTbrBOK1Ag3bPmowQzQqhltbS3
        QFok4uEieeMvYhGl3KGtrxGN+vPP4vu0GwpkCQuozw==
X-ME-Sender: <xms:7fjGY95g9tehiPTytDmi118ibq2qppod_XSfJ7_2wfI2KpCxC4PtTw>
    <xme:7fjGY67OjGcp4IX9Ji1YkNRi2DfIYwKX188AiZJKAJxWamjqm8JCsGC5jN8V_PYlU
    z75FuqLrev7IA5AV7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7fjGY0esbPwOgNiYKTjv9b2ktvpn5bVbbrqtD08uG6XKUpYmQZdhbQ>
    <xmx:7fjGY2KQZMX4Po0CbCMmjAF4_udzsPMqy9hrgsabhNsDhX2pJY-2OA>
    <xmx:7fjGYxJKJbgXUBWciSjlEhOGMqmLY5ObDumg7KaNfQL-Se6f1Mpnhg>
    <xmx:7vjGY-EYUayoVQgzOU0MDFyCw0F-pPMzVNacUpsAVVk5eUUWoALW-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BC2F1B60089; Tue, 17 Jan 2023 14:37:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <589415b2-ddf2-44e5-bca5-5971f8ab9576@app.fastmail.com>
In-Reply-To: <54f13745-bec5-8777-4212-6f093947f146@infradead.org>
References: <20230117172450.2938962-1-arnd@kernel.org>
 <Y8bhApoC4Bmgtjoq@mail.local>
 <54f13745-bec5-8777-4212-6f093947f146@infradead.org>
Date:   Tue, 17 Jan 2023 20:36:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Vincent Shih" <vincent.sunplus@gmail.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sunplus: fix format string for printing resource
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023, at 19:24, Randy Dunlap wrote:
> On 1/17/23 09:55, Alexandre Belloni wrote:
>> On 17/01/2023 18:24:44+0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
>>> causes a compiler warning:
>>>
>>> drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
>>> drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>>>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> The best way to print a resource is the special %pR format string,
>>> and similarly to print a pointer we can use %p and avoid the cast.
>>>
>> 
>> I got this one this morning, which one is more correct? :)
>> https://lore.kernel.org/all/20230117054232.24023-1-rdunlap@infradead.org/

Both are equally correct, it's just a preference.

> I prefer my handling of res->start and Arnd's no-cast handling of reg_base.
> IMO using "%pR" prints too much info, but that's more up to the file's author
> or maintainer...

Right, I could have equally well picked the %pap version, and just
went for brevity in the source. It's only pr_debug(), so very few
users are going to actually see the output.

     Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252D1686BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBAQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBAQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:32:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB487AE7A;
        Wed,  1 Feb 2023 08:32:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E30DA5C0134;
        Wed,  1 Feb 2023 11:32:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Feb 2023 11:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675269139; x=1675355539; bh=J4VuC4EhAC
        6bFSy0Xp6o2qjAby74OC2dp2uMCVpqr8Y=; b=AFcfILYeFeJgc9+/jvAYM3rmm2
        JSo3XNjQ3fJuoP4+ntd6zo9a4AC/xN4bZUZThtO9UMi8aFpwhCAnlsWNyxlPf5gK
        K7bHmCbyMKpdcxUkHx1UDuWH3tVRV7hXYTdO8btf56vZLw/TPRj/eVxBp5EMZqPD
        Pv+/FqE+aeHpbhyoGEMniZVxkRqDplcezSyEvhAWaGKcNR9/rQZq2T3gz9k3yKx3
        Wpd6gfwoGoZL0U6TA9b2uSKbchuq9dk9GIGynK33S8yPWeBtQfK+Kh4BaYuweMW8
        u3bwSFfyir50l4SPAgbYfNwrW+HkFGAtltCOKLRS3YCIx+uYYlUn8R8WZtpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675269139; x=1675355539; bh=J4VuC4EhAC6bFSy0Xp6o2qjAby74
        OC2dp2uMCVpqr8Y=; b=an0XtC/dwIuSh255nxNIAo370Ez3mJZHsS9HGhlY0mty
        MYND8ezc/+MvuvFox/rSM1koTrPuLP/5IxJd5EpOSDmfQvo+ywSyceB6K0sAr99Y
        VppG3KMopgc0fYMHb/NArE0pZIaaWIZYn5tqYQzwTNcisTX4hEWWJ0WAno3gnXoZ
        FlBTbQh4wRujcuakllR77FSBGqLhdjuZezefSluNsuqT+KEICrVZPVmr0FWosoyw
        MdVjSrB38VFsrOz4btObECCoBaeBH7l9GBFucrVbNrdWGm0XnLlY1FQnC2Oh18NF
        Vf6gAujQY/oYv+iXSLvj6LjPv9XC/3+Ivh3HNePedw==
X-ME-Sender: <xms:E5TaY50s__ct9wg3tyz1jDuUZRE31CA8FbfKnBKZepGAfz-RQbXD3A>
    <xme:E5TaYwEpbWjsYLDrCnkelb0RIE9NAiXuPnuayL8U0A2Pt_Vk0_LUUZIwt0XxeG_aN
    DK-PaI2rX2NLHGVv2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:E5TaY56znSs2_NVnMNW6pEDpmasxp240YwgdLOh9hka4nU7bb36TVg>
    <xmx:E5TaY23aECBMuoOnaau9NydhfROUM6L9d5oqE7XoZKQYDZvWeqIZiw>
    <xmx:E5TaY8GyKuqLcb_ZxtZk9k_3dRjRck6Y9bUVALhCwwrTUzb7yJVhug>
    <xmx:E5TaY3315kRfkoGlag4aUGvAtm8v6-Pmw781H42yRDt-34xPZujunw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 449B5B6044F; Wed,  1 Feb 2023 11:32:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <8540e4ac-462d-4c4b-87cf-4a50ab4cb4de@app.fastmail.com>
In-Reply-To: <Y9jaQNFZGJTMWQxi@google.com>
References: <20230131144626.13019b79@canb.auug.org.au>
 <Y9jaQNFZGJTMWQxi@google.com>
Date:   Wed, 01 Feb 2023 17:31:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the leds-lj tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023, at 10:07, Lee Jones wrote:
> On Tue, 31 Jan 2023, Stephen Rothwell wrote:
>
>> Hi all,
>> 
>> The following commits are also in other trees as different commits
>> (but the same patches):
>> 
>>   0ca222c81977 ("leds: Remove asic3 driver")
>>   227e9611cd74 ("dt-bindings: leds: Document Bluetooth and WLAN triggers")
>> 
>> They are commit
>> 
>>   fe24d8a40292 ("leds: remove asic3 driver")
>> 
>> from the arm-soc tree, and commit
>> 
>>   ef017002b93b ("dt-bindings: leds: Document Bluetooth and WLAN triggers")
>> 
>> from the bluetooth tree.
>
> Luiz, please could you remove these from your tree.

I removed the fe24d8a40292 commit from the soc tree now.

     Arnd

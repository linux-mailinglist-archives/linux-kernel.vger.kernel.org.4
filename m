Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A563B3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiK1VLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiK1VLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:11:08 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487EDBA5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:11:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A6D4F5C0101;
        Mon, 28 Nov 2022 16:11:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 16:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669669863; x=1669756263; bh=6RBUw3E6ih
        QFVucWv3bsdKi3UPanKCTBwtYJTDbK2/Y=; b=Duhc4hPxIwfbi+1YPSdimxFFcQ
        L9Wvs4B7UKqGjF0GDO4hk07TI/CJPtktREqdY3ZtQu6c8cd0gejBLP0/m1nVLbEC
        EhfcsA/tFmxxdSnIE1aksHLF7aDD6AsRyWojT+b5exmhhpXkbzN8rukKkco4Z0JY
        CF+Wpi7oxDBDd3ubsdlHNGTJACeEwZ9N4Ui4Ma4z85Jfo9QVUq9A69RYiuYWjGbS
        8ZJSnorUZFL+Rb2s8yDhD+48XBuWRyVgrAYLaptovDzAOhr8WsTZ1ujOSU0a8IY/
        DcplYcnmzJ8LVPWml4FXkhXR9Bq1kctDATgo7vCqciwYUJhlaq8fvwl+I3GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669669863; x=1669756263; bh=6RBUw3E6ihQFVucWv3bsdKi3UPan
        KCTBwtYJTDbK2/Y=; b=R8Zixyvk5W0JJabSuNoK0keNNcoYw5D4KDf7oIMTbU2d
        nc2O+9r/nZr2UUHs32QRl8Y6gQ4CJ1Q7mm/o7fjU599tCGJmmx0sBP/QJt+1Z5p8
        9TvnrF/TEe4Q08ICuoIJ0hdqmRshtpsRqkhcNtmeFE19EGkpDmU9IFzig/Db+T9F
        MNtxpQvIyVqsU92fP6npJt8lQHFHQgNtqllh97J0+3TVNZqRJxSOVouc4Zqf9Gmo
        9CZPcmR4TxkMv2gll0elHCjv49Ce1N9X/LdvDaWElaCoLy0QaA8ip/gg/ntBytom
        oqTLJYuV9Hq2q/Xv8c0233ENKmJwYHeRx9vD2mVU4w==
X-ME-Sender: <xms:5yOFY5bryQy8JY-o_mnKli2oYMDNPRqeqSaohCrkgZrBkzei6jxlcg>
    <xme:5yOFYwYv4GWg0CiJMZdw8yBylHTMaCD7yjxMgr96t-7tYj9fyZLpYUgu-WOu6JXyn
    YeWa11iMXGQsk5Ygc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5yOFY7_Bm0-QXwOCcFEayNXK-Q-Y0AxT0CRo806UJLUg_CbyrtM3Vw>
    <xmx:5yOFY3qEWliUFtTSM6z4MQNJVxRJU4RvusoQUCKYeu4SevVGukkO6A>
    <xmx:5yOFY0rISxoANaujVdobD2QiEeGLXtknwyS7StGDjbfLFXgwfWGKzg>
    <xmx:5yOFY7S3Ucqurh9VDYD3qigz3ClE2MmkKeqVTP35uYTfb9t8mSk50A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71ECFB60086; Mon, 28 Nov 2022 16:11:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <6358eb8f-a3ef-40ef-9d3a-842d9ff34709@app.fastmail.com>
In-Reply-To: <CAHmME9oO=8hsc4zt_oBrRoGm3sMU03W7cP5PksfC-RFmZumGLQ@mail.gmail.com>
References: <202211290400.IuVDsFIm-lkp@intel.com>
 <CAHmME9oO=8hsc4zt_oBrRoGm3sMU03W7cP5PksfC-RFmZumGLQ@mail.gmail.com>
Date:   Mon, 28 Nov 2022 22:10:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [ammarfaizi2-block:crng/random/vdso 20/22]
 include/uapi/asm-generic/unistd.h:890:34: error: 'sys_vgetrandom_alloc'
 undeclared here (not in a function); did you mean 'sys_getrandom'?
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

On Mon, Nov 28, 2022, at 22:03, Jason A. Donenfeld wrote:
> Hi Arnd,
>
> Please see below. It would seem that I can't so easily get rid of that
> #ifdef __ARCH_HAS afterall?
...
>>          | ^~~~~~~~~
>> >> include/uapi/asm-generic/unistd.h:890:34: error: 'sys_vgetrandom_alloc' undeclared here (not in a function); did you mean 'sys_getrandom'?

No, this just means that some architectures require you to have the correct
prototype for the system call in include/linux/syscalls.h, without an #ifdef.

      Arnd

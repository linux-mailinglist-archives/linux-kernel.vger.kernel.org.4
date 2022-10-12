Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989505FC20A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJLIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:32:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A510B40CE;
        Wed, 12 Oct 2022 01:32:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E4D293200ADD;
        Wed, 12 Oct 2022 04:32:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 12 Oct 2022 04:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665563547; x=1665649947; bh=drXjAnf5EG
        6LY0d4rMqtLwe0Q0qL+1NyMM0xSAeom8o=; b=kvJMB0HKsf3T3tnF246Uu0lBHE
        H5IxuchGk+SXM+cfd/bySjSbJZs9MezJPl/fUeyJID4HJnwUCK3rWOCSjabi3Jsx
        42SqO07dJ/dpkHQPqpfM1ErVkE/WvTkB6C94v0uAgCSBI38PsGcpLtBjZBozWJJS
        WqL9I8qAEUXnvsXAnKzvlsJX9BOdThWd5F9R/ISsWgutlnYG3HPjGRyUwjvUSTCm
        K/bglNEfdJSKVoE82TNxrTptEDCEVh8hdEoXdNHZwUyVPKxdRUxdbKXigfIhE0ma
        408PwV+rDTsc0Vy1hKf8arqh8Ey9i3VrOunCiZzd6x2ldwWWY5W8xdgvbz+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665563547; x=1665649947; bh=drXjAnf5EG6LY0d4rMqtLwe0Q0qL
        +1NyMM0xSAeom8o=; b=VbWX1YJ1vJxQ7Vl4OkXAnG94vCvudl/0SQGVEcRxBN2F
        6a1isiyHEYlQ6d8EwOpJOWkKYjGKeWE4l7rrqIWesJDuPKQa+Aj4y0p/JsTef9Y8
        muu+cTLCM04OA/B3cnHdV/DWzX6l64HlwheLqg/TCu/MLSVFN33jBjgjFCA0w1aC
        9fVunCz4SVEhHxpHjLZurj1qWw80dN6q4l2a9fIfnk+lEWg6ByFhk318uGSGuCYQ
        tWGZpF54HXQ1OYsR4/kOwbY+kuek4wV7+COiMELxczUL6eS/hk4PpDWVJezrEtJl
        fMMk3B0x4e3ujf+U+ahoYUUOuAV7l9gaXPuuA2iGNA==
X-ME-Sender: <xms:mntGY397JwN9UJtXR7rce5mX1q2K94oRw56NbOOb3ULnQEo7IYtjbQ>
    <xme:mntGYzvLzRPy0Nq4soBbNWdktCppbu0EjcuK5q3QM8q5Dc9LN1ZlzM9_0b8C30iZC
    HW2VrLjDkZs7MaFa9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mntGY1Di-s4erkgfLTBZzFQM0wZ62J7JEhi5y2i6phuNL2VJjtSryw>
    <xmx:mntGYzeoyc5jOjJu0VUYYNtSZ1m8gUXHuUUwm_CPBtnYOBjAxkkXQw>
    <xmx:mntGY8PN9Tm5EZHYCK06K4rFExmFvoiJcj-aT5J0rUfpB0lcJjxXVQ>
    <xmx:m3tGY4mATT-vASwsyhylUrfNYRngSDvk23n0imsjp7-fLYT-aHO4Pw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CBF50B60086; Wed, 12 Oct 2022 04:32:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <60a2cb70-bde4-4423-9a54-7abc1ba466f8@app.fastmail.com>
In-Reply-To: <20221012055602.1544944-2-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
 <20221012055602.1544944-2-uwu@icenowy.me>
Date:   Wed, 12 Oct 2022 10:31:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Icenowy Zheng" <uwu@icenowy.me>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andre Przywara" <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 01/10] mailmap: update Icenowy Zheng's mail address
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022, at 7:55 AM, Icenowy Zheng wrote:
> Due to the SMTP provider adopted by AOSC applied some more restricted
> rate limit that is not suitable for sending kernel patches, I switched
> to a mailbox hosted on my own domain name now. In addition, there's a
> single commit that is pushed to the mainline kernel tree during my
> internship at Sipeed the last year.
>
> Map two AOSC mail addresses (both aosc.io and aosc.xyz domain names) and
> a defunct Sipeed mail address to the new mail address.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

I don't see a patch for updating the MAINTAINERS file here, if you
haven't already sent that another way, you should probably change
both at the same time.

As a driver maintainer, you can also apply for a kernel.org account
[https://korg.docs.kernel.org/accounts.html] and use that for
sending patches and forwarding to another address.

     Arnd

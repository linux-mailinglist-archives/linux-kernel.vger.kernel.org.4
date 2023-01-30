Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93616680F16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjA3NfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjA3NfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:35:18 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62174193F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:35:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 395595C00C7;
        Mon, 30 Jan 2023 08:35:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 08:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675085714; x=1675172114; bh=Ty8vD7SQBN
        N8QJaQoKAlcsGzPbn8Lw6uXT4IGiInb+Q=; b=ESY1kz/R0WL+DL0+0qNaVRKsEO
        e9Yye5P938gblGrplD9xg1oiSKugYpTZTdoHT+vECXrA/tQ141yET8DpFPvay9de
        UCoaP3fr4lElM+AIIGY6Zs1cbuudSTH/IvzECcZlTHJzEjaDnfPa3Ciqw4B3NzbD
        f/hYfDTvSEHrbJaR34kNGVKTCAfikxjp121fRGQA/amz4L1yMEIdT2nCeC04xcjN
        an1CpTE+dvjUziGYS0+D6Laq8kbzSBuIU+OkNzRAtHvXMNDL4Wu+reQ5tyQo28cs
        jHVpE4XhJqVDi5rLaDrsSAVWn9jn4yU+liX0d1Bb20HGTnspce9davSFUZYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675085714; x=1675172114; bh=Ty8vD7SQBNN8QJaQoKAlcsGzPbn8
        Lw6uXT4IGiInb+Q=; b=Y438wPORy4pkHLjNwB/F4y4rBqnK4oQoLicrg1CR9LRg
        eJGJ9KNh43ybGJM9VBJkespNozAbjD1Me88sXHjzBmolfUqiZvx0onWqBBqD8Kq8
        PAy9eaDYc9JpYDWO2iA7WF03N4/onuFFxjtNpUwOK8skYPZtbX+C1E5OsHlSMl2c
        7U8XTBfRR8XNMmxvQ4WfeO5slpZjNLhx1qs4lgAVhNMwL/N42gI3MZLsrXL8F2Rw
        qThCmuXKPn6Xt/BR63Mte6h0D3ne87sl72Kg6vMZPKE3Uya23hSZyfufXQ2ryPQ+
        moLlZy1JdLe5IjER9JNdtbfgnQXrGYhGe+/oPnqgQw==
X-ME-Sender: <xms:kcfXY6AUrDfx-anfYqa4hDHMC8o5taud2d3gXr-tFt18fi3bt1BwSA>
    <xme:kcfXY0ikQlpFvNZrtKHuAb8BO2uimPekhHS_0qzwoqn5-WyPjvREEuEzeQEj86q2V
    AfnS6MQQ8CHUUmoT2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kcfXY9n6uCeCoxlUDkxi9wFdG-GG44aqxQYEOhZENIovblBZtgmtvA>
    <xmx:kcfXY4wwEc5GKUKCWKshh6Ng1n3VPMN6TgOV0SGLOtvDN_VI590PqA>
    <xmx:kcfXY_Q3Q5Sw3A1Jb-8Houmz70zeO8NAiLdgRw-yZuMA8YKXy_navA>
    <xmx:ksfXY4TQPdMeAbdKMXuzvdNlW9nIwZBCb4QIg1LnR02sx9DIaplL0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 91D50B60086; Mon, 30 Jan 2023 08:35:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
In-Reply-To: <20230130073324.GA590@lst.de>
References: <20230126163719.3585002-1-arnd@kernel.org>
 <20230126103811.56d71351.alex.williamson@redhat.com>
 <20230126174044.GA15999@lst.de>
 <20230126104515.3fcb3abf.alex.williamson@redhat.com>
 <20230130073324.GA590@lst.de>
Date:   Mon, 30 Jan 2023 14:34:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>,
        "Alex Williamson" <alex.williamson@redhat.com>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Tony Krowiak" <akrowiak@linux.ibm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Finn Behrens" <me@kloenk.de>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023, at 08:33, Christoph Hellwig wrote:
> On Thu, Jan 26, 2023 at 10:45:15AM -0700, Alex Williamson wrote:
>> The culprit is already in my next branch, we just need a fix that
>> includes all the cases.  A respin of Arnd's patch would be preferable
>> to keep the fixes in one place.  Thanks,
>
> Arnd, do you plan to resend the patch, or should I take care of it?

I sent the v2 last week, it looks like I forgot to add you to Cc there:

https://lore.kernel.org/all/20230126211211.1762319-1-arnd@kernel.org/

      Arnd

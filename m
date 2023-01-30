Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C02680A66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjA3KG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjA3KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:06:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B730B27
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:06:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D4395C012C;
        Mon, 30 Jan 2023 05:06:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675073200; x=1675159600; bh=DzCynmJzDJ
        BsJr4TPTwVJFXYpQYfrCi6entST/qT0lo=; b=HreAV8/dz/Osn8r5rU0CQmFCeB
        dxCjKnkA1XkQ/feo3wdhQy3CfwqwarGRTjMb+UULSwV9WAS6lEh5bRe5VMwT27YT
        0IrQ9b1JasVJ47ZmyQF8ZtgdC510+Vx5DA2MXbgebHkxcOROGOYcTwPSXw50WR7F
        TuxCqPRthpzrZSkWChH8uTWN3CJINGL49h46V8aI/31BXb2MzS/oAnYYqpcrckKd
        lVcor8JvngZ8SKE+uI/YkDfVD4+6u5HABQNmRVW4QK36VDpg8ch5RKXc3Zu4v+su
        4JMdDOm+ik7H9ShSidGWHpZ3RgnMe+u3jKK0qd1DL/boxiPxQ/12FsY5y0NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675073200; x=1675159600; bh=DzCynmJzDJBsJr4TPTwVJFXYpQYf
        rCi6entST/qT0lo=; b=g7gyNDo7PWY6mJkGsHEQmqKozXaO5GebOnFT1FODitar
        KBKNvZq0/DmhC2jZY6cXRMhw4XJvsPcyB2YawHQQ429EkKoL1F7GBGuq55LaCzDy
        W5SUQqrIyHgUIK9ZlqkQIIdnT9O91BWPias+c7yLzrooFb7rnUpw5PaVa9cWizfS
        8mj6T1U7s7UYmyQn0X0YxHSQYHthDAVzGbqgbq6XAf1zoPk2vm9bHRYDEkjKNVqe
        TohaoELNMRVSEapT3YRevjWI9xSl1AM50vyU5PiEWYdYx6ocgcpZN1kO545YzppF
        uYw1cEtBD3Q2wfAPoHyOXDbzFEmo8QKpRLp7uG+nQQ==
X-ME-Sender: <xms:sJbXYziIViw5SLi14qPIXVNqZZRg2D1rirBL3qm4Tm8aJcDY1CXhCw>
    <xme:sJbXYwBs0AqlalZqC0oF0Vk_7SyiHvKbyeuUu1hD95HghBPUTk9kWJpKk6nAC7Wne
    OO5raXDfJYe2skA8W8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepueejfeefvdefhedtgfdtkeekfeelgeduteejgeetvdeiudeivdeuuddufeei
    iefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sJbXYzFUJmNCbKgJMH-54yqCYARQyjwJMpCZO9RTWAaq25MeUJ8JYA>
    <xmx:sJbXYwRLBQfjva6YCwErnxHimRlXS8rukTXhCi4LFtr3Ag2vzHH4vw>
    <xmx:sJbXYwxNmpo-fYMxlYagru55yvIwgEMvwooNK7KuBBAfPxkcNzSiOA>
    <xmx:sJbXY6tceBmiau9ObecTycfhCceRjuHEuJ1F1K9eUVmT4JCpe5ssKw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC90FB60086; Mon, 30 Jan 2023 05:06:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <7c25f24f-4acf-404e-88d0-65b55c017f34@app.fastmail.com>
In-Reply-To: <202301300732.QfTDtiab-lkp@intel.com>
References: <202301300732.QfTDtiab-lkp@intel.com>
Date:   Mon, 30 Jan 2023 11:06:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, "Vinod Koul" <vkoul@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>
Subject: Re: error: Undefined temporary symbol .LBB5_-1
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

On Mon, Jan 30, 2023, at 00:48, kernel test robot wrote:
> Hi Christophe,
>
> FYI, the error/warning still remains.
>
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   6d796c50f84ca79f1722bb131799e5a5710c4700
> commit: a9f17d0c0778dd971dc9770fa0a2085a41d8c5e4 phy: ti: tusb1210: Fix 
> an error handling path in tusb1210_probe()
> date:   10 months ago
> config: arm-randconfig-r006-20230130 
> (https://download.01.org/0day-ci/archive/20230130/202301300732.QfTDtiab-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 
> 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
> reproduce (this is a W=1 build):

I reported this as a clang-16 regression, the tusb code looks fine:

https://github.com/llvm/llvm-project/issues/60346

     Arnd

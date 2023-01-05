Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1B65F696
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAEWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAEWS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:18:59 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F0967BFF;
        Thu,  5 Jan 2023 14:18:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DEFA132007CF;
        Thu,  5 Jan 2023 17:18:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 17:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672957136; x=1673043536; bh=TCaP7y5pzb
        RmEVCDjX4if25GDRs9o9AP2CCvuXdY0Rc=; b=PIcSr8fYa2Ax3wFTq+g4lz8Egp
        wYqg/YGdva+cVwXt9uZTfsZxQ27iGq06akBW3eOl9ixhfehTWB3WrkYUFvKlqjGX
        fkDHxuUKwRqhFU1fJZSEY72aKgS7wK2oGkZR7hPZvBR0TXrRwI0DErsLhfuXL+wq
        1LLFWpIgTcG0jicVeuyuEbB1QIEb5MjM9WGhT/ubOkKMCkLH0Ecwpw4LJeu0yVym
        8hYV59utE/civUmOmUnpquSOzbUyoK9wysJUWv9vnspWvw5sfzU5Ag4wm6ReiNln
        hAHk2M9XwcRNPpdW5VxqeC2pxe4BoWnEcm5XB9ErG77SnAx9MeaFEfDCqnIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672957136; x=1673043536; bh=TCaP7y5pzbRmEVCDjX4if25GDRs9
        o9AP2CCvuXdY0Rc=; b=KMsvE1ioZEJTW+IdbA+3wGtpwUfjL4X5vYLLsXNwgRnF
        kJNW9lSFH1mTj5y2b1o0Pf7/+uQWyAWHH6Tt3czXMXjWK5TPdyOUBX3D1X2xuLah
        VoopmZ/WCRH2kgGIVVD8aF3Wtz2E1wtxUtfdwq/Ls6K5VKY5EnInSGSxnQhHrZKj
        Njf8/2KyYFpkQooJ/i7iA4cPqzLRHOkl3u4tqFogRRJPF9lA9ecv/v7+MTio1Lh0
        9qrlhlSkboVbAeyPPCvPquI0nycez6ygf4E3uP0mHa4LqxzGu0XMO10xmMwYihJE
        /oTmRbH/NzOFpIh+ovc2x83PqXBVKej9uuxjxn4sAg==
X-ME-Sender: <xms:0Ey3Y-N9OIa30Ll-O0fn6BQt1edYAiQecStmo9eRbf_bE0ocd_Tpaw>
    <xme:0Ey3Y8-nYRa5KFIlQKnDj11hBYzEX2cbhtnVcgKH88s73q_5vcRzZMHV920RPpAK0
    zCC3CIafHqmLRWOldI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepudeiffeghfdtueeigeeljedvfeeludffkedtkeeuvdeifeefudeiteefffev
    gfeunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0Ey3Y1TFjHCzrZ2JaGGMwVbtgyXn7sd4iaiuXTWXh5qFZMUTRdMWcw>
    <xmx:0Ey3Y-vojGuC9-6fZRpSlURSXNeCG0jVb64p7noARUjoj6nrMK4aeg>
    <xmx:0Ey3Y2cSKiNDTsmyL3QQIXUndMdjQUSDDWXZW7HyP2T7YVnjjFE7mg>
    <xmx:0Ey3Y81ofk1jtNnS7fQq4IK9qdJxpsx_hJ3kTP1jYmHzhwlQlYJZlA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B0ECB60086; Thu,  5 Jan 2023 17:18:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <8b50ce1d-59d8-44b6-b330-d2ab56fb85a7@app.fastmail.com>
In-Reply-To: <202301060326.qh0NHlzm-lkp@intel.com>
References: <20230105141231.2006353-1-arnd@kernel.org>
 <202301060326.qh0NHlzm-lkp@intel.com>
Date:   Thu, 05 Jan 2023 23:18:36 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Ajay Kumar" <ajaykumar.rs@samsung.com>,
        "Pankaj Dubey" <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: samsung: remove s3c24xx specific pll bits
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

On Thu, Jan 5, 2023, at 20:49, kernel test robot wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on krzk/for-next]
> [also build test ERROR on linus/master v6.2-rc2 next-20230105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>
>>> drivers/clk/samsung/clk-s3c2410.c:123:9: error: implicit declaration of function 'PLL_S3C2410_MPLL_RATE' [-Werror=implicit-function-declaration]
>      123 |         PLL_S3C2410_MPLL_RATE(12 * MHZ, 270000000, 127, 1, 1),
>          |         ^~~~~~~~~~~~~~~~~~~~~

For clarification, the order in the patch series puts this
patch after the one that removes clk-s3c2410.c, so there should
be no bisection problem.

    Arnd

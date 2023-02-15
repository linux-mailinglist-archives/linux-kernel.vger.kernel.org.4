Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AA69795D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjBOJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjBOJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:57:14 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD0BB9C;
        Wed, 15 Feb 2023 01:57:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E2DD25C00A6;
        Wed, 15 Feb 2023 04:57:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 04:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676455030; x=1676541430; bh=nFeJxTBUgb
        5KP8tqA7gwc+SzCIoEFi7EP1xam7CPn6o=; b=R9VV2G0tfo+W5W7Uiqf9dCwN9b
        vsYcgDxJE703unAhmKnCEqaH71+qjJHLmgCCjaX2W4qs+pPw74ORN1PiduTiH4Qg
        0qtvN1kHBbRgueC9lB4Wzbrh6PI7EsIfOCUrgK5lkCXX5ZYIgvowRt0KvCSIlX5P
        OJb9XikC1JyUNFbjuWhJ0DbreEU9k+AkOoSWSrJ/hj9fQXksTPn0Tl4ZveI8yKsT
        8wpYkBE/O75Pg2dXbGgKs24iVGfnQKYfO9YJvspbyBTHLK3kX0tHjGwCAXhqOMGG
        mS3AfxwndT+qnrEV2CL8yCOTqYZw/iYSznp0LPE4oWUoKzdZ8wkOxPwSkkzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676455030; x=1676541430; bh=nFeJxTBUgb5KP8tqA7gwc+SzCIoE
        Fi7EP1xam7CPn6o=; b=E4a9qktWux3mPni6zVoGt+uu5niuAJB5bINwihUQe86n
        PBB8NzKFY6AYNg/U8B4QcDVBQl7RsbjGslvf5JvoH6kqfM5w0MXKZQllzee5PMag
        ml7TSzl9klsGnjE2alLtVmW8QgfygxVMfcdqyzgiE3kUHFOPh3aDs/lJbPl2CEy0
        ghy7ghuunNr56uLJcHcu9XsxuybExcsXb+yD+vaea6qPA3biasz/CociMsEjSkoH
        bStjSeH8rdWP2vaCZ/pBz0iKcWSfS2au+OpppLEF2df8L0gMSWf7snmodcboaFaG
        iqCd93lU3acCUusPmWjMvh2ivBh7cDfxyeZAXXGuJA==
X-ME-Sender: <xms:dazsY9saUYDQ2qWStjqUaF9Tw7k-YAzGvPeEWItGkuExjRvcsYW3YQ>
    <xme:dazsY2dNg3RNnF9YYdfDm0MHwiEktN8tDX-ZLZmWFZrAdc0X5TccxE6zpD-Zx5XSu
    b4Wko863cwMym6hfCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dqzsYwzXxjfjPI2WSX94sA35YSIy3j0b8V0z_hyz_ygC94BXhRqoCQ>
    <xmx:dqzsY0PE0VAfDdGEVNZFpiCR6cVls7cEmSegAoKNymENW1yO6gvDwQ>
    <xmx:dqzsY9-GrCPt-cfnwBr9K6FOlkpG6B_3Zagh9A0yAij5t3fna0HR7w>
    <xmx:dqzsY9_8VetotDc0fnuqrHl8p8ckU0b-GKvBCLurvsFw-4ANZS3nSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E8F24B60086; Wed, 15 Feb 2023 04:57:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <ded4018d-c90f-41c7-9e54-da954bdef49e@app.fastmail.com>
In-Reply-To: <20230206201455.1790329-3-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
Date:   Wed, 15 Feb 2023 10:56:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Evan Green" <evan@rivosinc.com>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Cc:     "Conor Dooley" <conor@kernel.org>,
        "Vineet Gupta" <vineetg@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        slewis@rivosinc.com, "Albert Ou" <aou@eecs.berkeley.edu>,
        "Andrew Bresticker" <abrestic@rivosinc.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Celeste Liu" <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Dao Lu" <daolu@rivosinc.com>, guoren <guoren@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ruizhe Pan" <c141028@gmail.com>,
        "Sunil V L" <sunilvl@ventanamicro.com>,
        "Tobias Klauser" <tklauser@distanz.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
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

On Mon, Feb 6, 2023, at 21:14, Evan Green wrote:
> We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> system call that quite does this, so let's just provide an arch-specific
> one to probe for hardware capabilities.  This currently just provides
> m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> the future.
>
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>

I'm not sure I understand the problem with
AT_HWCAP. While the bits in AT_HWCAP and AT_HWCAP2
are limited, I don't see us running out of new
AT_* words to use for additional bits. Presumably
the kernel would already have to know about the
name of each supported HW feature and could assign
a unique bit number to them.

      Arnd

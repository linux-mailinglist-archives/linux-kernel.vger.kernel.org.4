Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018F70E10A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjEWPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEWPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:52:46 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418F8E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:52:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 82F165C010A;
        Tue, 23 May 2023 11:52:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 23 May 2023 11:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684857165; x=1684943565; bh=zw
        CjvXn53rcaO3Y1t4OkLX7eScSqHORtEFyq3yn/8kI=; b=MbLkHCgetIrafdPdgQ
        0ZQbl61Tin0qDctxV4gw+14zHIHhiZV3q6uOpN/GZF+AFCk+9BmNZWLkwq6+d1Ub
        L2gW/ViVfHOGcTIJ4V3g+4M6dfZuLQSgWDOyxhq81lSZkwUjnnWaW2QHFqQGsYuw
        7fbIni8sgQAwisIkVZm7vu1WC3f8C5o95hT78//FIKymPVXHtZvigFGFN6F83yCa
        l7HS/rTLJlC0wKEm+UELgTdk/shK5BvfI2z72JLmfhesqDOvAa1hCdsgLzUgLoZ9
        6iqlnzTou7liQGqUtietwzpnzqLcdAjy+UAnW2VismYfg/RPjtUSUMXRXarZs69D
        wRvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684857165; x=1684943565; bh=zwCjvXn53rcaO
        3Y1t4OkLX7eScSqHORtEFyq3yn/8kI=; b=iOVHXOMCdEwIi26GWNXZNX1Xh25AS
        QDx9AiORNWxqW5X+l+Z8bmpq7GBTsFwUE5qcQgdFT25LBNizeITOwcIxI4282NnO
        wwbps7EFeDYmWuQVoIadEpbde2ZZhEXowmaPRefEM3u4/2K8fz1wZFt1CoHP2DAJ
        gwUha4aV5nENl9GfspeRa07vVCY+/e4bNq4FyCF+GwWTllcQB7tFEKg7pzXPmBbD
        ZdmnPxDKgJEdKOFVB71bndkAKY8LTZqLnxrrdP4yUw5IcSZc2XxEBOj8KvO5ZPt9
        QZnELJDWbCsfzb7VMzHhOrCq6Z2cFUVqh4ZV7Vf/LrueioqkdmZJE4L/A==
X-ME-Sender: <xms:TeFsZK-RGTOp4S3wXCbS33THBxVUkiHDCD93DNzshDhtfKWe2jiapQ>
    <xme:TeFsZKtdEBKVdkwCvsVhr0pzVlamKaYMJj05AK8T1xDjKOCyT779ytqH3S9RVkHH0
    OMov4lgp2QctvL4hU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TeFsZADcIwBU2m4OTIQ2FUD48_cZ7RVRqjOplz26-5M-J-VwhgLN3A>
    <xmx:TeFsZCcY0Ft_hsNr3R6E4wTVhEE8aYGYOzYZcx0sFb3DYp2q2Tfcmw>
    <xmx:TeFsZPMWhV8IoRnJdKoRfNHWhreYqgyFoVghVlnlfUGQ610WBtwugQ>
    <xmx:TeFsZLDAWntuJd5K8DyWeY4Z1wW4Q9q7dBfDXCp46gu2WHDBlwtIYg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5F4FFB60086; Tue, 23 May 2023 11:52:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <d651c1f2-ce77-4876-bbc4-88e014a83f35@app.fastmail.com>
In-Reply-To: <20230523073952.1.I60217a63acc35621e13f10be16c0cd7c363caf8c@changeid>
References: <20230523073952.1.I60217a63acc35621e13f10be16c0cd7c363caf8c@changeid>
Date:   Tue, 23 May 2023 17:52:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Doug Anderson" <dianders@chromium.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Only HAVE_HARDLOCKUP_DETECTOR_PERF if the PMU config is
 enabled
Content-Type: text/plain
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

On Tue, May 23, 2023, at 16:39, Douglas Anderson wrote:
> If you try to enable the arm64 perf-based hardlockup detector but you
> don't enable CONFIG_ARM_PMU then you'll get an error:
>
> arch/arm64/kernel/watchdog_hld.c: In function 
> 'arch_perf_nmi_is_available':
> arch/arm64/kernel/watchdog_hld.c:35:16: error: implicit declaration of 
> function 'arm_pmu_irq_is_nmi' [-Werror=implicit-function-declaration]
>    35 |         return arm_pmu_irq_is_nmi();
>
> It doesn't make sense to enable HAVE_HARDLOCKUP_DETECTOR_PERF if the
> PMU isn't enabled. Let's add a dependency. HW_PERF_EVENTS is a synonum
> for ARM_PMU and makes the most logical sense here, so add the
> dependency on that.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/r/20230522114922.1052421-1-arnd@kernel.org
> Fixes: 02ea35ee19d9 ("arm64: enable perf events based hard lockup detector")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Still build testing it with randconfigs, but I assume it's fine.

    Arnd

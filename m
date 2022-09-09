Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC35B306E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiIIHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIIHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:40:21 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17512F227
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:36:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 2230B2B058D2;
        Fri,  9 Sep 2022 03:36:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 03:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662708972; x=1662712572; bh=DL7ygxzLrl
        gjFceREV0rSGNkAZXz4IRTULK8AU3epH4=; b=qBlp0P+HvgN677U3dxEP8fPAFV
        Z7QJ3fgzc1doU5SD0F2v6126ZtZLuVTEAOnPbBuOX3h53p8+X8mx5J1C2C8T7BIl
        IFmdW0DB1oUD8klTUif25EFgcCNEXZHdM97B8RgMXzikEsWM0kpfcjswi5wC6Ofh
        K2IwqrYvR083SXx6eNLaFH6+ZnELxTTYbGEuA4yG4LUyatyJTJieSg5yhwjp50yA
        DZ3wpIVDDGRwumnb1z1cBj6L6ie+3/HJg9fJu5dfigXWElYquJ5M7Vrczo8mZTlq
        mnhO4mdzxnC4b8ns36vMtZbHPHI2b3eePZY5/fgMThJWoG3OtuIlpmnhOdow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662708972; x=1662712572; bh=DL7ygxzLrlgjFceREV0rSGNkAZXz
        4IRTULK8AU3epH4=; b=gQqypgT38k+45jaLTaZUKBp1DeDJadnGaxBr1vtccBne
        wdJp8fCDUYkf0/6MwVYpgpj7w76IQ6zt2n45rgM0FirPIzCnWDZmWN8reKEugOSc
        IIWt5rHeNslvXQN/vjTsC6z8jJe7bD+7ko3r3ib2hZu6YGqmJbVOk6QAHsLvYgP2
        A+z9XfIbcljPAZbXQYGoC5Glq7cDZ1M9+JhjIJfziSmZYgV6XW4oxOnDp3DMZXCW
        /8GXI8F2e4UY+Y68qEaV/H5oDvYpKtUmnJBwR6vHcaPT2RWr3HWitbQCB+1tH+fN
        OUllIbGo0bWE/smQhoTOqtKw/7KciMDaBal4QYbRfw==
X-ME-Sender: <xms:6-waYySxYAv2Gd4YpMZtPw5rf-NRGtvh4X5zUa4tDhxbWdCeFtFIEA>
    <xme:6-waY3zgd4SDHqLM15FRiO6An5UX58XDLVUi055xS_CD6hXlizuKe2c8l9ZnYsL9i
    qSOeSd6uqsWRxib-Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6-waY_1Uaoy9HtNU5udztZJcvb0Vs2Q9yXEXcono4WO-rGLzucZk2Q>
    <xmx:6-waY-DpwFXaFwA1SdfNfBG__4TT6OQzakhHsRU8mGE-vdOs9saZ-A>
    <xmx:6-waY7iYBuyhPpbSGJbTUs3Hr56bSm-x_pDty2z02JkVt8ogh419Vg>
    <xmx:7OwaYxY1ikoR5ygGz5cWHvh9MxJ8ypyC2xOdP4GfCbiKPKyyFLVHC434oXI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0B5EB60086; Fri,  9 Sep 2022 03:36:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <23cde275-613b-4895-a05c-48a0ec55ff6a@www.fastmail.com>
In-Reply-To: <69409ea6-6daa-7973-c950-c6ca9ad96f50@bytedance.com>
References: <202209091157.akimiv18-lkp@intel.com>
 <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
 <69409ea6-6daa-7973-c950-c6ca9ad96f50@bytedance.com>
Date:   Fri, 09 Sep 2022 09:35:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Qi Zheng" <zhengqi.arch@bytedance.com>,
        "kernel test robot" <lkp@intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Ammar Faizi" <ammarfaizi2@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function
 'do_softirq_own_stack'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022, at 9:07 AM, Qi Zheng wrote:

> BTW, when I just compiled the kernel with W=1, I found a lot of
> compilation warnings, which is somewhat unexpected.

Correct, the kernel test robot only sends emails for newly introduced
warnings, but it will keep nagging you about them.

       Aarn

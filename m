Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48836A9EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCCSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjCCSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:34:34 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3876212C;
        Fri,  3 Mar 2023 10:34:29 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 30D615C00DC;
        Fri,  3 Mar 2023 13:34:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 13:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677868469; x=1677954869; bh=nZ
        CPA5lDqSTiO1PrEbtSrr4/t4PoOG3TeZqRQGni5oI=; b=uVYRZgICOnSYC6csVt
        AuZLVqLR/YuZbWo55GgGCiiIRAsUR4djUEtwcjCG6rs8MgDNV7lUT8uV+z3A1G6U
        Q9Du5U25iWP/OHeJ5cp+IQnAcjd6Ohpw92Mi0mc3LVkfX3DCXxQy5KbRD2Bfeeak
        qUwiTZuu4/o/BJKWQ39KbOPxcjwmOj0DR/U2XtXFmNZkzeqthkXT6VJtYicAYs4w
        zktiWE44plG7CraQPl/CAw4I/m1Ox8X5Yr6I/8cqjufHdGvO8dtIHWjzrcYpy/pC
        5gwxPriT35TTv3cjnbvCQYJ179afdzcfG0UqVPONn8da/2jTuf0gTRCkCkfGF2we
        NJ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677868469; x=1677954869; bh=nZCPA5lDqSTiO
        1PrEbtSrr4/t4PoOG3TeZqRQGni5oI=; b=msDFoYk/5XEewEsZaKpeSa8jTgsMD
        7dbcqyGW+RylNy50/m9u4iCMqgc23CtZU1StkX+vjM4Ed8+T2M7HFRDQfMYQLYos
        4FUQmrq/yGlOZTQ5ZKiDgtGrpTLgMQXOizDMI73PGBhQgIJv6nSTrEgt/gZo+glF
        ls+IgPpqjbm9qyLfeVHujvRstWPtEYwxUsP27hfwJg8C/LPRn5VxpscIlyBRLJlN
        UYs1DmKVq6pxtG0LT5o+ajEqt9m77LrroLIUeW29dCCs9gw5ji5yywtZoOQEX+Dx
        EijZ2s9b/GmvlWONnRzE0qjavlXlK+K/LL8gZ5w4u9f3nTa7NWDru0ayw==
X-ME-Sender: <xms:tT0CZE9A825YndbnKQFDkUDCurRhtxBOl5abvQ56geAziVuOZimJTg>
    <xme:tT0CZMt3I9z60O72z5U_fZJfg0TP1UsEaGJM2_JVPy4rkt4m5TpgD9goVVpc8hDHS
    NwmKdBWjCNvvnh_SRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tT0CZKC7PgmjAd1PhJDxJ6r5zdyQ7DXHMd4ChcVGb2z4bECPIClJsQ>
    <xmx:tT0CZEcPq0gnXbwwfEGIVrFwloOpw7LgSgJ_zwpOMhf0YE7xPb6JVA>
    <xmx:tT0CZJMPR4QoJE_0zqXIXbSfj0NUNRi8LLkPpWdcSckP48_rDno6pA>
    <xmx:tT0CZCjMkxJ2KIwlBj6isPCkh6Xe5Bgiimr-B-FvG2O6PpvqyLlmvg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0888EB60089; Fri,  3 Mar 2023 13:34:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <85a162c5-2cc4-401b-a92d-892a0d8caadb@app.fastmail.com>
In-Reply-To: <20230222200838.8149-7-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-7-casey@schaufler-ca.com>
Date:   Fri, 03 Mar 2023 19:34:08 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Casey Schaufler" <casey@schaufler-ca.com>,
        "Paul Moore" <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, "Kees Cook" <keescook@chromium.org>,
        john.johansen@canonical.com,
        "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH v6 06/11] LSM: wireup Linux Security Module syscalls
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, at 21:08, Casey Schaufler wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_module_list
> system calls.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-api@vger.kernel.org

This looks correct, you successfully avoided the various mistakes
that are frequently made when modifying these files.

Acked-by: Arnd Bergmann <arnd@arndb.de>

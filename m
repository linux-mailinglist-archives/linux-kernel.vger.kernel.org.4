Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC76A9F55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCCSnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCCSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:43:06 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969C618A1;
        Fri,  3 Mar 2023 10:42:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EE91A5C017D;
        Fri,  3 Mar 2023 13:41:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 13:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677868883; x=1677955283; bh=Ng
        3KaGBt9FfhSdxDKWomRYkYp7ZCZFAwvA7XAxQUyIg=; b=eEIcntwJziW7el4D+T
        UcHYKEc/VsIHWB5lobP2j0DoyREGbsUZOSto5K6k2HW75Rjly+bE7l38JPkZgqIk
        P0ts9Wp+99gehuY8rLkZInrb+iwIMH8sfUbSbvkkiubm7LnOa7EwulHJQbpEXqp3
        nnQtoWvmypuYGW/pByhVO5plLfzZDAZrKLqhpPv3lKtdFpF4aRcjQuU0103I/uxs
        IzA/WD3nnAQsO7WjLXlC0oVyHX8jUtW32BtDKL32D9rIpyNy1wJgMHSX9Ev8IgOi
        Q1LAQV29AoM3rqpuU+HhMO5iW1jmzWDR487seuruRqRk01SJgLAZGoiV1B/gpzsC
        XQlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677868883; x=1677955283; bh=Ng3KaGBt9FfhS
        dxDKWomRYkYp7ZCZFAwvA7XAxQUyIg=; b=URsbq6yRSTfJOH5jyD/TNvfWvYhEl
        FGgkqd0j1vZr/+HGsa8zYpLh/VrJhAY+j+qet6C0nT1dfVJ3XQfkGbpzi6drn0Bw
        3Rtr/eNslftW2bjODew0ZeO/RcCZypKmTLnBePESx7iwMuIXIX2LV8AGRwRdV8+e
        8TtRF+aIppVNYSIRqcK/2tw0P/hASB8xwv6GCqIRgBrtgFSb6gOiGWCTtx8kpbdl
        iIvM+HZ3MPu6fe/21d5mtLJ6mExecogyoNZPvq/VXgEcnjbNVVKrktngyAQWeMdL
        qdG0AMlvJvjWtUZXbDtKQlW9KVCFAvBHRvCgO0HzYdYh8FHyhAhTN5UNA==
X-ME-Sender: <xms:Uz8CZNENF2Ay1zQkvxZ3x9kd2GKcjqPmCFXnipbr4KQppNTX-JvrJA>
    <xme:Uz8CZCXE3OK7oprcL7jGQaNTG-cXRZsb_h4BI5XgSSlLkh_TjWFukc-gP_SD27nl3
    uPJb5piJi_ruxADrYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Uz8CZPIZtc9X0TnB943YrmDV89pSd3lD_ghLt7XwvxWoVzt_9KoWbA>
    <xmx:Uz8CZDHkZjF5gxN6J_PKV8OwZZByt2Pu0XASTDOFqxdr576hqdPcXQ>
    <xmx:Uz8CZDXzQpF5GVEKlSANwsyRTRtPJDmj8R1o1G3z55-TMEa_pHtrgw>
    <xmx:Uz8CZPpihuCd7N35FpeYDFJSky5l01GKWEfI8Ljw0pZioTP2y1XAUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C669B60086; Fri,  3 Mar 2023 13:41:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <902422c3-504f-40e8-b530-5e72e9fd5863@app.fastmail.com>
In-Reply-To: <20230222200838.8149-5-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-5-casey@schaufler-ca.com>
Date:   Fri, 03 Mar 2023 19:41:02 +0100
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
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
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

> +/**
> + * sys_lsm_set_self_attr - Set current task's security module attribute
> + * @ctx: the LSM contexts
> + * @size: size of @ctx
> + * @flags: which attribute to set
> + *
> + * Sets the calling task's LSM context. On success this function
> + * returns 0. If the attribute specified cannot be set a negative
> + * value indicating the reason for the error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_set_self_attr, struct lsm_ctx __user *, ctx, 
> size_t __user,
> +		size, u64, flags)
> +{
> +	return security_setselfattr(flags, ctx, size);
> +}
> +
> +SYSCALL_DEFINE3(lsm_get_self_attr, struct lsm_ctx __user *, ctx,
> +		size_t __user *, size, u64, flags)
> +{
> +	return security_getselfattr(flags, ctx, size);
> +}

As with the other patch I commented on, I think it's better to use a
32-bit 'flags' argument here, to make this work for compat tasks.

      Arnd

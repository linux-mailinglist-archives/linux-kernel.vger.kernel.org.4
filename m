Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6D6A9EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjCCSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCCScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:32:55 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8D5FE8F;
        Fri,  3 Mar 2023 10:32:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AC365C00EE;
        Fri,  3 Mar 2023 13:32:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 13:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677868360; x=1677954760; bh=88
        mL3IEgMyvoRHpAQGnK4mfuhVeZb8v/+mjUwgsZxdE=; b=BshbPyMhHN0ngCAYfI
        aQFjGibiKd88UbRm3O2oQdVjYrf6uEpHz0oQ21INL1ftRArqyfyrgKQq+2cAgOkp
        8nZgnJYCsmz602AMR1CxLbGhuzYxhDDPDkNZOS9iW38gtOYwqL3J12AJZtFyu5VT
        YXPTWz4VoPRF0WKdsITyWqTUhbX1LcPhybMwp9bAs51SEld5aEKiKTYhdRywRn/H
        byeNcxC9Fifw/exhMLZEBvgeRVXLu3bo3zbU0var27valbz/omAtOcKDB9hf/dWq
        fN3yJ8USWLbs3fh/TELfQXg3mUAn+Bpr9P+I+JWXy7TypW6IKKGPNUno6O81y8xG
        lrzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677868360; x=1677954760; bh=88mL3IEgMyvoR
        HpAQGnK4mfuhVeZb8v/+mjUwgsZxdE=; b=QZxILJzscUZffk3goCLnn3corqJM9
        GF7UKE360qXYBSwqTb/2zDut8SnEMdF9u/pH1p1qwEkXy1TPUrmic9gQ4zOSS8iy
        q0k0hEm7CthvmDkNiR0hluWp4OnNkCkPL8wH/kLK1TJ5ahNgGUihtmRT56ihwf5a
        aay3Hsy0jKYZtesP+fpA+F4F/ERaVyASnmG+ZIBjda35rFKHwibEpZZC3obDG0Nb
        zy1lnKdX8PSuNd2pBLxAiSqeUoP8nkVe6ZicZmHqgerL0Lx1E/dRDUUAAd+RX0ra
        cXBTzZMJbs2dJxq4gKIAzBXouD9HWxcLaWU1jSWcxJK2XsMo1jL3c04fg==
X-ME-Sender: <xms:Rj0CZFZBMDZr0wsSxAr1e1X1rqMssN4hOOpWRdKwW48NjMbsyAt6gg>
    <xme:Rj0CZMYxfYSoN2oAjxsgJCz0tHSD__VBr_P4YCVQotLPPBaH7iXROqjmqgmvDSUEe
    Hhp_WqDmfKbh1rknFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Rj0CZH9t7nEQiBFO2Sya9U8XwppVhDQKdr2yBdzVp_YHurldNSuY_w>
    <xmx:Rj0CZDol3BCHJ8-CqVPkJVgAYk2S_22GeBM2Ppytqm98nsAhCMh_pA>
    <xmx:Rj0CZAq66dCM_hc0FY8dOQn6dS9wnD2OTHKteERhFMiIt8nPKuA2sg>
    <xmx:SD0CZMeznz_KrUPxDzHPN0jOE-9X5q2f93zrkzCkdV8C7NUM-JlKVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 807C0B60086; Fri,  3 Mar 2023 13:32:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <ae739199-9e9e-4afe-bb32-be1e6ec28e76@app.fastmail.com>
In-Reply-To: <20230222200838.8149-6-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-6-casey@schaufler-ca.com>
Date:   Fri, 03 Mar 2023 19:32:18 +0100
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
Subject: Re: [PATCH v6 05/11] LSM: Create lsm_module_list system call
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
> @@ -1062,6 +1062,7 @@ asmlinkage long 
> sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>  asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t 
> *size,
>  				      __u64 flags);
>  asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, __u64 
> flags);
> +asmlinkage long sys_lsm_module_list(u64 *ids, size_t *size, int flags);
...
> + */
> +SYSCALL_DEFINE3(lsm_module_list,
> +		u64 __user *, ids,
> +		size_t __user *, size,
> +		u64, flags)
> +{

I see that the prototype does not match the definition here,
which really should raise a compiler error, but I suspect that
broke at some point.

Since none of the flags bits are actually used here, can we
please make this a 32-bit field as in the prototype rather
than the 64-bit one in the argument list?

Passing 64-bit arguments through 32-bit registers would make
the calling conventions incompatible with compat mode tasks
on 64-bit kernels.

       Arnd

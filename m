Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D266678A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbjALPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjALPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:10:28 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC763198
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:58:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 245AE320091B;
        Thu, 12 Jan 2023 09:58:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 12 Jan 2023 09:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673535503; x=1673621903; bh=BJKnVjLTuK
        g8ZHwYlLPscpEYK/11PD76bQbR8qaXqRU=; b=qRATFfxXifs7XVDv90cl4lSAgK
        EQ4+fGgidsbP01cOSeo88T5GReWNckiNOYGQGEdXGFD+3oYsk84hakXoFMa5s8ah
        2X5PddFuZeJv8tKSPLAY/HXWinxdJvcE1sADmFS+m3YsWiJafG2SFxGMOp2GN7Mj
        sJmSCnlI9fI77jzC6oj55fdJPcTiU7lkBbwGo1L4ZBGPz7i9z+T9aEUOcH0dibPv
        CcdiUJvCpCXTc6NISb/eIXD+6T5i09QCqrEIa/lq3/qz7Jh0qNdO5+J43JGjLen7
        C7BXEbkIWH9z3O9BJm1/fJh9BLy/DUYGV82KZt5EAGzvJIQ9/HNYTBQrVUFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673535503; x=1673621903; bh=BJKnVjLTuKg8ZHwYlLPscpEYK/11
        PD76bQbR8qaXqRU=; b=oMxrYznBcp5hQ/d2ECIAw9Jqed3Z1gJJRbjMTPriz6XB
        suSzOpxy15bvg0hctCYbsh6aet4XyLV4K73ZpFin/sexoLUZxPgBQUgAWdrfYGJw
        vbNgW8qfVvHqOk0byy8EXuSYKnQ5U9V3T/Za8gtiAqXWpAerGEIGFxWxvQLysu+k
        emFqC5TSRLETVuhgyr18gFBBvZ+gsb26nfoLCud1aUWFUBcgN6yozXCbUj31aFTo
        aVHsF8H96SNAXe5pS//51jnZjG+9WztIZ4Giid4FyJGED0wgpfvdeWdJSJwIHxkl
        X0otSNorLxtn2jBbKukO4B6njrpBsEUlkryo5NBn+w==
X-ME-Sender: <xms:DyDAY-CIq3lCxHwTMd1l4Irz_Un52f2aaU2f7Obl5kGHpbuICcGHyA>
    <xme:DyDAY4ijeKFr0TdVZBNAt0P3SzBnjwx09U38KwuzkHMA1IYS0OSOokGp-j0rMyCpj
    CyjhF_4VXzKwJSDKtw>
X-ME-Received: <xmr:DyDAYxkpCsyJYxp3TC0igqmIdthq_A7SLihGgGZ6EWpenOXNG2tKTDnGnyaj6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:DyDAY8xhL9cvJZ_prXZiO5w6IOsg3jmCE1oqhroOBx8bZDXeA0z1Ag>
    <xmx:DyDAYzSwXX0iYisy-6RweUEtiQ0oG7kOO7qIEr3BajAXZHDAES8tEg>
    <xmx:DyDAY3ZaCZaRU-4Gt_c0NVhWg5-EwePqS5lnihI4worK4CTylzeaYg>
    <xmx:DyDAY7b2Iqe5NH-1j6cbNjDybOKWTQgo2y2GNHJQzu2Nl1pjfC4pjA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 09:58:21 -0500 (EST)
Date:   Thu, 12 Jan 2023 07:58:19 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Andrei Vagin <avagin@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
Message-ID: <Y8AgC99AUeMjFWKt@tycho.pizza>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-2-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110213010.2683185-2-avagin@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:30:06PM -0800, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> The main reason is to use new wake_up helpers that will be added in the
> following patches. But here are a few other reasons:
> 
> * if we use two different ways, we always need to call them both. This
>   patch fixes seccomp_notify_recv where we forgot to call wake_up_poll
>   in the error path.

[snip]

> @@ -1515,7 +1546,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  			if (should_sleep_killable(filter, knotif))
>  				complete(&knotif->ready);
>  			knotif->state = SECCOMP_NOTIFY_INIT;
> -			up(&filter->notif->request);
> +			atomic_add(1, &filter->notif->requests);
> +			wake_up_poll(&filter->wqh, EPOLLIN | EPOLLRDNORM);
>  		}
>  		mutex_unlock(&filter->notify_lock);
>  	}

I wonder if this shouldn't be a separate patch that you can send now
independent of this series?

Tycho

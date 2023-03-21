Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AFE6C2875
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCUDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:01:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729028E45;
        Mon, 20 Mar 2023 20:01:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bz27so4716838qtb.1;
        Mon, 20 Mar 2023 20:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679367705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUeTqlT+uQhL5Y4Ta7X0GRGlBXcZKLGLuPrr6IlFCOM=;
        b=SEGLR6yrz+WuX2d8u9uF7st+4ulUd5gptqWoiwh/onYIY/dE+saQEdX5/KU5xT2Ys1
         UNR19YfgqixrN7+UczG6lvX6x9PFJH8P4Jvu4/zuBA+a1hYtRKEATao8NG2TDRiQbUXJ
         xl/Dj3acT3XKHZNSESsU3kyofXqYxDfjUK9TRK0xuD/e3DZXoitIiUIh2u3S2MPXBtQK
         WUiHhKK90OMliM6NLO3r0pc+TqQTX4dRG6B3LNpL3FzdrZJYSMDHslDHKvhJa4g/iTkO
         ismOsbWIywT0rIJbOa5YDn2GZ8D2fWQfHnQ65kbZzXuL4UBx3KXL3p9pkO2C95ht+4tL
         3+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679367705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUeTqlT+uQhL5Y4Ta7X0GRGlBXcZKLGLuPrr6IlFCOM=;
        b=U9h2wz7nOiEcRB+gV8C+f6Rn53918mNol/mLxDeRbV3YFsVpxY/c2TSdOqIDfJcD1l
         WqTZWGjb+KSSjyQ+lyCor0TOp7mBNf2Z2LYKxPXTEEQHzok8JFtLd7NEGQWbrxk45HcR
         BVtvGqm26H3xqCQDEatRsvyS4cX2UVYEJm1XedXdG1xhCi6vBFWcUE2yMuitaunrrKMX
         KGmWHu0ESnjk252oDaIEzJ6ES3esH6NRVdTRCAJJZCZRaGz+GHrGwiLRPDI7gfORijlk
         X0MdXuISmAwTJy7Nnx2ZTDEJTNKtz0qPA66hyEzZeEZpMxiWHN5HuVZks346PG6Xj3tC
         /RRw==
X-Gm-Message-State: AO0yUKWOPpfaOqb6LzBKcbE07ddTzO61thi4rkigdC531htC/2AbRtRT
        0f95uQnyqQfuEhz9vTHR2oQ=
X-Google-Smtp-Source: AK7set+4raXdmZbayEP/ta0TphjQ6E3T0ARmrWVMUhzSkR8ns7FT69VIF3d+gCaEcATCO5CsjcEQkA==
X-Received: by 2002:ac8:5941:0:b0:3df:6b5:d12c with SMTP id 1-20020ac85941000000b003df06b5d12cmr2368366qtz.32.1679367704838;
        Mon, 20 Mar 2023 20:01:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a288900b0070648cf78bdsm8487718qkp.54.2023.03.20.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 20:01:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E9F8A27C0054;
        Mon, 20 Mar 2023 23:01:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 23:01:43 -0400
X-ME-Sender: <xms:Fx4ZZII79lekXOBTR821GrbHZMPuJRCMi3U86dgxtcTEDkFjgSRIyA>
    <xme:Fx4ZZII-HI3_o4aNoCzCLL_syowKpPhxBZE9vW8Nx9XRWukCzC68BJVlQrn92gRVJ
    G9EAVJKvxxs7QQK8g>
X-ME-Received: <xmr:Fx4ZZIvBZ8gOaO1ddT0px0cwsj9WRbVsjA8eR_8nSRhkoJ6e03Ql61hhgoFTLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Fx4ZZFa2F8dUr9sUw6epik-FmJzh003yMDxfp6UZoHWk90nx61N8Tg>
    <xmx:Fx4ZZPaqdfo_QoVHCW7EXbJ6mif3gNXjIanEbp-g0OZGrPKu-jPhPg>
    <xmx:Fx4ZZBBrYctBC_irFOU20tgnrrJ0KOmB3hQ0jOjgS1tz9UR8UeMcnw>
    <xmx:Fx4ZZLEiBgguWnMgLGbAYpDrGMkzvozn7jBPeViQtVw1mGnT6Yfqag>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 23:01:43 -0400 (EDT)
Date:   Mon, 20 Mar 2023 20:01:27 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <ZBkeBxz26mCvWnq0@boqun-archlinux>
References: <20230321135047.740fbe70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321135047.740fbe70@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 01:50:47PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/srcu.h:106: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Annotations provide deadlock detection for SRCU.

Thanks for reporting. Fix it locally.

Regards,
Boqun

> 
> Introduced by commit
> 
>   57e98b73317b ("rcu: Annotate SRCU's update-side lockdep dependencies")
> 
> -- 
> Cheers,
> Stephen Rothwell



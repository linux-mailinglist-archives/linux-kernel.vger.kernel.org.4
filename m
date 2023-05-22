Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445270CD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjEVWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjEVWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:06:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612BAF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:06:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75afa109e60so120026885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684793166; x=1687385166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKNb0wzEdbd8UkBqpMJLkx1dAS9GDnLkmyS23eqNEjY=;
        b=IPYHiZK+Ap1esJr9QKsLHUqIOnEif1TZgRCX90qs8jXxZWnlRGsK4iiavFAR+Tmdkf
         /pPDx9DNxnmlt7cvGSMWMht2Gi1YLWQ8H8QeOxye6PzuTq1nh+IobwDSUpnFXRILfaLU
         ST15vuhdWIp2NXQBJtK1HBED0YZGYxsrvmDH0kVQN1WVYOiRu7SEKStd5jxZCeLM+0ZC
         i9PEoaJ6EDNw9JHByeccI2c7DSCdOykdtmOR16OyK4RPZ+kAkqyEsDZjJ2i6xGR/Y/Yg
         TCpujb8xRuVHXbOPafN/OddRRDInjUf4aalDBtkAy3VwIKLZgw3e5cdWgexQrWOLmaqE
         NDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793166; x=1687385166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKNb0wzEdbd8UkBqpMJLkx1dAS9GDnLkmyS23eqNEjY=;
        b=L/Q3ILy4EoppSnX73ySIb21cvUNQGL2WchYqYRCA9RQeOLQpfHH43vOyHcC7Fvdh0F
         HGpmaRghYHoXbwa0ajmvFIK/tXAN5l3sfOwMeZuhSAGPlq7SKM0xvBDQsyfW6iwnMhJR
         em30ymSiJWShqcLgTKdxYqthut/F6lTgl0Q1qVMcVofcTeNId+LiafAM+1wOrG6giO7c
         ePdyquAsTlTEo9Ugai1JCajcR70yzlLZ+646UHuwTUJGeuwKxINSt9/b8di9QnYY954S
         3c/ZZmW1NwRxnozjSRhrK3HK5ZHn4yeQehP78f0sa/VxMTX2/bze5rgOCQgR4qB51cXf
         EN9w==
X-Gm-Message-State: AC+VfDwr4PKeCBEcj7lp8VI81tplXAGEj2ogXvsP1ndouiegaHQ9qfMR
        9w3puMYFdbXj4XI3wlCKOOM=
X-Google-Smtp-Source: ACHHUZ7uqO1ZWd5ggMciq8vIN1bb9FwLO7PLRpKvW8PEWbnnwGigQeriA85RWF4kbhjMBz1zA/OGqg==
X-Received: by 2002:a05:6214:2a47:b0:624:3af6:21d2 with SMTP id jf7-20020a0562142a4700b006243af621d2mr15370822qvb.13.1684793166657;
        Mon, 22 May 2023 15:06:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id cs6-20020ad44c46000000b006238f82cde4sm2251807qvb.108.2023.05.22.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:06:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 73C5627C0054;
        Mon, 22 May 2023 18:06:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 May 2023 18:06:05 -0400
X-ME-Sender: <xms:TOdrZN5pgSug2rWC9GG7Ehd4-l9EA-BFp6s-w8o-GFQ4Ic1SS3jh6Q>
    <xme:TOdrZK6j1S-wC3tOBONfmb-BH8uj4_X2yX79eFiXGArWk5tXgSw2_PE96YQmuPYsi
    aWuiRYFWpIBUM8-9w>
X-ME-Received: <xmr:TOdrZEddzQ4ORkiFwMY6Mdbkb0EYR6mSAsQcPS4JzhDlmm3xhQAENVDXWSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TOdrZGLtlaPskhMfxu_pfPdYZR2aFpbQexfbKUOfa5l-Y6B5iwv0Dg>
    <xmx:TOdrZBLjt2i7GBRavU3VaOFw3cOZ3qlRIMJ57XF9UtLEUN2d8d-YMw>
    <xmx:TOdrZPx2zD3ou4bAj1cl9H1zvVAzCEqxJt_byo2zlYUBXYKAor1aXg>
    <xmx:TedrZI8lunitKRPgb2dUDsSulmay-Qnjn_KEEedX9h-p35pLfILp9g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 18:06:04 -0400 (EDT)
Date:   Mon, 22 May 2023 15:05:25 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZGvnJZYQfAmgdsqr@boqun-archlinux>
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522171314.1953699-1-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:13:14PM -0400, Kent Overstreet wrote:
[...]
> +/*
> + * bits 0-26		reader count
> + * bits 26-27		write_locking (a thread is trying to get a write lock,
> + *			but does not have one yet)
> + * bits 27-28		held for intent
> + * bits 28-29		nospin - optimistic spinning has timed out

Still reading to understand the design (and try to find where are the
first five locks ;-)), but this comment seems to be wrong, because..

> + * bits 29-30		has read waiters
> + * bits 30-31		has intent waiters
> + * bits 31-32		has write waiters
> + */
> +
> +#define SIX_LOCK_HELD_read_OFFSET	0
> +#define SIX_LOCK_HELD_read		~(~0U << 26)
> +#define SIX_LOCK_HELD_intent		(1U << 26)
> +#define SIX_LOCK_HELD_write		(1U << 27)
> +#define SIX_LOCK_WAITING_read		(1U << (28 + SIX_LOCK_read))
> +#define SIX_LOCK_WAITING_intent		(1U << (28 + SIX_LOCK_intent))
> +#define SIX_LOCK_WAITING_write		(1U << (28 + SIX_LOCK_write))
> +#define SIX_LOCK_NOSPIN			(1U << 31)

^ NOSPIN is the 31st bit.

Regards,
Boqun

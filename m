Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591AE6871D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjBAXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBAXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:22:54 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021025FE3;
        Wed,  1 Feb 2023 15:22:53 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f10so219388qtv.1;
        Wed, 01 Feb 2023 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e9T8fet1CUQmVg3snpX3iSNOAS+cmwVNSWuh5ppSIfo=;
        b=a9Lw7+SwX7wcvGyay6W1ThB79WXKHKJqNwLOGJ/M8yeuBJo6fgX0UvCYpJfjNFCE5X
         4WjR70CLNuM7AFd8xm/lgCfz19cf4HCowAsa67F6d0a1QdG9nFQcg/hi+LI0Ix4pSJz+
         PtUvlRIpGfgH6l44GBy9jc+8loO4MCMR6L+fFcELJUOYdEPaJoUJF+NYj+DJU0LxIIko
         Riu35P0TU0LdVf4EhAkIrDn2uD/wzUKd71RXi5UZhUxiC6QbjzRkH09gv46IpR8FxVIk
         PF4eLqmgheBW+7tnD8+L6tYb0qly7CE26mjbIkMLqOqJD2Z1/rDm1LaxU5+GYNy181Wm
         ev8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9T8fet1CUQmVg3snpX3iSNOAS+cmwVNSWuh5ppSIfo=;
        b=CBDiq7/cvK8DyL7leR369vudvUuyPsIJ0Dh2Mgtz5hDeUD8ti8Nu0L9XwYtrhuQ8+7
         UpW8GXbQzlAEBjcjFLy+1W6Y+qAeUC2pQ5qYlM8FoyYBx693PPD4qRb9t9UTQnTnZlnk
         PLmgWlEJDalr4xAXgUPwkfUCq55CfmFd2XzXc/+x76+sqh5O86VxXLmW+GWr1Z+FE1yh
         QdRmM0yi3vHpE5AJbg4eSsMNfPoeoR/SwWAx3hhThKaKuu9DWKmyFO4DiHxqIzWUnlZr
         a9603f8WmcCEsYlVnuiV0pLzVvfa0hmv8esn55bA4QN6C/8a6wNQxklj10cQRaMXVUnq
         Kjmw==
X-Gm-Message-State: AO0yUKVmTEnDwmNLXaWeHWjle2XmytRH8XSAMiVLmjDIjgRgqKoGWADs
        eFloZcCCFRx2OXJMPOWIhfQ=
X-Google-Smtp-Source: AK7set8TDl0PIeRDInoWh2RQ+i3sE6uMlw6xh1Ex/su1FVjBn5s4MJJzL3Hc+Tcl54YHhrEQxRPbRg==
X-Received: by 2002:a05:622a:1303:b0:3b8:52fc:2c31 with SMTP id v3-20020a05622a130300b003b852fc2c31mr6377745qtk.62.1675293773113;
        Wed, 01 Feb 2023 15:22:53 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 136-20020a37068e000000b00719d9f823c4sm10564820qkg.34.2023.02.01.15.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:22:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 87C6827C0054;
        Wed,  1 Feb 2023 18:22:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Feb 2023 18:22:51 -0500
X-ME-Sender: <xms:SvTaYwS-uBwq3RO9PM_nLlYe4aPsvdvA_VpmHmQ5CDyEQmkYINgAww>
    <xme:SvTaY9ybBiENlOyWGiada07q-tgFGTdxQ4frKMU4YYpXqZmUXEXbKNFvpIc3NRX5_
    MFgSzGVnTwkXSE6qA>
X-ME-Received: <xmr:SvTaY91cCG5oj0f4RK6SL20k7VBtGh-RVwMnQGbGK5P1K8tPwtcs2RvmsiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteffhfehjeegtdduieffudetfeehgfegudejudfhieefgfeigfevueduledu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:SvTaY0CEnePu6Q3obf90-b8eJKglAqAETSNGM5O46y6ztzn7yXvLww>
    <xmx:SvTaY5iTJhayOVnBhXlwcbeIRP1OABRqqvjywBy-jG4jXHkHoS4JZQ>
    <xmx:SvTaYwoEDnheUAmUpARtUlqL8UVo4uSMMSZAU3j0hKxBN5Glc7l2ig>
    <xmx:SvTaY-Y7OV56oICq0rreKvIuo2n5Nhl1UOLdYf6yeSZ9ZNvpHhv0LA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 18:22:49 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [RFC 0/5] rust: sync: Arc: Implement Debug and Display
Date:   Wed,  1 Feb 2023 15:22:39 -0800
Message-Id: <20230201232244.212908-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that our Arc doesn't implement `Debug` or `Display` when I tried
to play with them, therefore add these implementation.

With these changes, I could get the following print with the sample code
in patch #5:

	[..] rust_print: 1
	[..] rust_print: UniqueArc { inner: Arc { refcount: 1, data: "hello, world" } }
	[..] rust_print: [samples/rust/rust_print.rs:34] c = Arc {
	[..]     refcount: 2,
	[..]     data: "hello, world",
	[..] }
	[..] rust_print: Arc {
	[..]     refcount: 0x1,
	[..]     data: "hello, world",
	[..] }

Note that I make the `Debug` implementation of `Arc` also print the
current reference count, which I think may be useful: myself sometimes
wonder "how many references exist at this point" during my own
development. But I'm open to suggestions and changes.

Wedson, I know that you are considering to get rid of `ArcBorrow`, so
the patch #3 may have some conflicts with what you may be working on.
I'm happy to wait and rebase since this series is not something urgent
;-)

Suggestions and comments are welcome!

Regards,
Boqun

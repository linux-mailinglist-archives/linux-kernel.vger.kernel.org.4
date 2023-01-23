Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445D678BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAWXOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAWXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:14:29 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB0B22796
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:14:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B6A725C01EE;
        Mon, 23 Jan 2023 18:14:24 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 23 Jan 2023 18:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674515664; x=1674602064; bh=wJGVOVt/uj
        SEWyLvw0hzGlE/QWLNGWdfnk+AykWDgxs=; b=EpshgA7iogLUehYMkUDZDgM0ZP
        iw6iLg0dIiPIjC2XKjbCsgvsLfnt1YDCCCjCfUHw7RamloVVNwHpb2053eHPqHYs
        g9FM+QJF/zoI9wGUsm+/5V19B83KHpi/Tdfqag2SOujMK28QiGrEKEsF5VbXsUmu
        J+FUGDf07uhKj/a72l6gAXTKNaR04aJwV37RIS6IZCYFozw9NrUmN31yobYdTFde
        3U3zRkMYF5fr67kgR57XtJ1p0agv9oXwM6oKFLHnHm0eU2QwaQx/sSWsomsR/h94
        eKZ2/X/5spZ5HhDBrVMvxYzwGCmrm8k/q+fiUEh3gihQDaKTmgCw0M42vltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674515664; x=1674602064; bh=wJGVOVt/ujSEWyLvw0hzGlE/QWLN
        GWdfnk+AykWDgxs=; b=R+6PMwId3FiUT1leKU/qBUHp7rqGmd+EhSiIkSC3tSm8
        C4trrSDXvKXpUmM+s02wiD/9pfPfreNWCs1HnMkKqWLPumV6fTJo7bKQKSuJXc5p
        vw8dvjO0aF4Au1A84RUa3xPRIa0xcI1BtbvaZbmfDBnu/pRqIHO27fcmeqciP0Tz
        uS6oJuVT/qWl8ySu3Yq2MUA+OKQC59DI/tBJLulZZPIYLfsbSXQIcX0PV2y3H7l4
        vovA+UzRSFKcjDM07o5b62qfbaRQCxnKdyAv18yYrHrOeJdNEBRtv6//A0AETktA
        wcklyUvmznbL/H1qlXkhEL31X9fxh6po3rKj+NfgbQ==
X-ME-Sender: <xms:0BTPY2y7oTOajlyeehrIykkW7pN4VvLP5yUrvKjwtrjZMjPz3Apk8g>
    <xme:0BTPYyTxxQFICTla9mdJHf1jgTOn0g_WjMvQ5lc5K1AvYKL7IiHiocyUpBQ1438pn
    IY-wfx33VeY9_cp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhjedutdehtdfgueeuledtkeefkedvgfevieefudetkeehffej
    gfeiheehkeegteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpeifrghlthgvrhhssehvvghrsghumhdrohhrgh
X-ME-Proxy: <xmx:0BTPY4VcfhS4EZg0WdDqa856RBI8QfsO_aDVXn5lr2fQrZ5-STIsZA>
    <xmx:0BTPY8hObCZ9xdHkJUlzsYKu7urzPMHkF-LJ-VjJmcLvEQ1UfXJJJQ>
    <xmx:0BTPY4D_iPfXps8Du1-wOywDFFpfm-c6yvKQkgGG4rul6ThWl-AnKw>
    <xmx:0BTPY01wwTQit6EfX4LB33ZGuw3zgOOGAlR61vQfVtTERDkIwNl2Jg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3AC762A20080; Mon, 23 Jan 2023 18:14:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <70950159-11e4-40c8-a498-04971b7a4ada@app.fastmail.com>
In-Reply-To: <87mt68dfpb.fsf@redhat.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com>
 <874jshdpl3.fsf@redhat.com>
 <3839bced-74f7-4afb-8068-c1cdde7b61fe@app.fastmail.com>
 <87mt68dfpb.fsf@redhat.com>
Date:   Mon, 23 Jan 2023 18:14:03 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Giuseppe Scrivano" <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
        bristot@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        brauner@kernel.org, "Aleksa Sarai" <cyphar@cyphar.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
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



On Mon, Jan 23, 2023, at 5:54 PM, Giuseppe Scrivano wrote:
>
> I realize it seems like a one-off fix, but it is done only for backward
> compatibility.
>
> Other paths under /proc/self/map_files require CAP_SYS_ADMIN in the
> initial user namespace, or have CAP_CHECKPOINT_RESTORE in the user
> namespace.  Sure, it is not future-proof, but it would look weird if
> after CVE-2019-19814 there will be more ways to access files from the
> host without requiring some capabilities.

I think a way to rephrase what I'm saying is that it feels like this should be about making /proc/self/exe and /proc/self/map_files consistent.

> With the prctl a runtime would just need to do the following and live
> happily ever after:
>
> __attribute__ ((constructor)) static void hide_self_exe (void)
> {
> 	if (prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0) == 0)
> 		return;
>
> 	/* ...reexec as we do today... */
> }
>
> and we won't have to worry about what mount options are supported or
> used by proc.

Yeah, OK - having the logical operation be on the process and not the view into it (procfs) definitely is more robust.

But how about calling this PR_SET_PROCFS_RESTRICTED or so, and then *also* changing the /proc/self/map_files lookup to deny if this is set?  Yes, it'd be mostly redundant, but it'd help clarify things for any future changes since it'd be clear that the logic *should* be consistent for /proc/self/exe and /proc/self/map_files.  And actually as a bonus, it would make the case of e.g. `podman run --cap-add=checkpoint_restore` secure right?  (Though honestly I don't know how common that is or whether one can practically use checkpoint_restore without other caps)

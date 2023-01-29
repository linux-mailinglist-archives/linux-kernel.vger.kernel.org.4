Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DADB67FF76
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjA2N77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjA2N75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:59:57 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1176BD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:59:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 416505C0D7D;
        Sun, 29 Jan 2023 08:59:54 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sun, 29 Jan 2023 08:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675000794; x=1675087194; bh=9gmuhR3Nhw
        T7VjgqTF9oUFiadUzAlgY8oim5juKRNdE=; b=Pw++e6H5ZsL+ywwuATLnRo/4cD
        sxG+fWs0etxtRQYJM86t9swsTId0ESm0sTaAalgF53xtEF46/dI9IoBMSEF1CFg9
        WFKarsY6qrQg/wYrDRF0RTOOkpEQRZHI+hhU1wzchnFIckCpOMNcaNYiZgLFawzj
        BDPjbXsTff91XqoESm9RLxb0uz0PFvjt9DkmHsxPd/PIEzsa3LabXUYXkcj94hNF
        87R7ksA0FBfJMWxYCOrvul/pbsUoOIQW3wOGJfMELJvZ1/6RlguaKAcHGTP7ZBut
        XCJ3kgAbmeYF1KZ2ftGCelYm/PvA4yOLeniLPjJsORoUTzhG8iqQXvwRfQww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675000794; x=1675087194; bh=9gmuhR3NhwT7VjgqTF9oUFiadUzA
        lgY8oim5juKRNdE=; b=mv2g9v4kKYwOJyTSAXL9lIVb9vurMakj958liUYFKnW8
        Xh7zvBV+21VkbxLUP/IpjqeHfm9tl9yinaMxLtsLZcJOaIpIGkWaYhK8GkH/XWJx
        1xUFJBXXxsyldtCUEkFML4/DJTgPzlBCfBq1LXuyQcb209pRiqWXjzbAvx9abh4m
        PcQZUYUum3fOWVQQL7MtD+vJLU9RpMwv6KocyI+Oh0bckd5+1xLlzFkxqcZ/hnpc
        ZQkc2ln4ybTrJQuguVKyv09JJq0J/6WOPds1vpCF4ROz5FT7J28MZagV/kcpX9wc
        CGNZk+xwyivj9RzVSrjaCkOpVcJm0hhxauEwHkUfqA==
X-ME-Sender: <xms:2XvWY9cSdTHXo1VZoN3R2IKj9JyTXblTk1QSe0pTXW4Cq-8dGf7B9Q>
    <xme:2XvWY7NL8FWF9Hi826onU2ZpS2AKCRfZGZrzSclqw25RU3gKz93TIu8BXv_ptd023
    D-BeGiTa0sf350a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeffteeugeehlefhvddvleeljefgheegudehhfdugeffffejfeef
    gfduhffgueejleenucffohhmrghinheplhifnhdrnhgvthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdr
    ohhrgh
X-ME-Proxy: <xmx:2XvWY2hlt3VvXMykNe9rtkfK3WqcsHfU7IFZHR3zu5MFduBuR4d-wg>
    <xmx:2XvWY28J9dR9IIWQ0M6ELT4EB5JMqWrDrJflhWQu7TumdE2L8Olz7w>
    <xmx:2XvWY5uCZgOhEnNt0jJ1DQoqDE6KaWkEtgi46NnM5AjUEsz8fuXmng>
    <xmx:2nvWY_B3Kn29HPASWDC3zaq3IU-AlNzSUkvY7Qce_I255yff1o-kCg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3EFAA2A20080; Sun, 29 Jan 2023 08:59:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
In-Reply-To: <871qnibmqa.fsf@redhat.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku> <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku> <871qnibmqa.fsf@redhat.com>
Date:   Sun, 29 Jan 2023 08:59:32 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>
Cc:     linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
        bristot@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, bmasney@redhat.com
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



On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
> 
> After reading some comments on the LWN.net article, I wonder if
> PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
> namespace or if in this case root should keep the privilege to inspect
> the binary of a process.  If a container runs with that many privileges
> then it has already other ways to damage the host anyway.

Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.

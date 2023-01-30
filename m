Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86A681D69
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjA3Vxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjA3Vx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:53:28 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F61815B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:53:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6BCE03200907;
        Mon, 30 Jan 2023 16:53:26 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 30 Jan 2023 16:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675115605; x=1675202005; bh=1XKg+Z/4M4
        CsxP/X7lFM7Hqn1f3t0iIehbPq7o2x3Zo=; b=kkik7kSPQ65Xu+d/xlKBOriwUE
        1Refz3a9hxyy51tVmduHKS1uVWq6cXa2N4AqSkbX6WUbxLJsH2/jA5e0TKeKMIOf
        5n1XM/Sabfp2uHCjXC9+DnfXAoyprvPvMYlbsBLCf4tmMZ8+6SRDY3AgKw2A7d0i
        NeZMbOxhaeTo1n/taOoVY4UY6m/rm7ZO9tcQgan7H33z20YtuOUNmumP31GeNFrU
        eGc/erCZWgITH1yYAhpJyLQUdwXkPIUkEXczjG9sY5jzo5z+e6xSlJvSJaDVH0tf
        NxouTWsV0KBUjzW2KygY6cmGvYMu8tm5+f+LpyTmLl1dY0WJcTgFgcGjCZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675115605; x=1675202005; bh=1XKg+Z/4M4CsxP/X7lFM7Hqn1f3t
        0iIehbPq7o2x3Zo=; b=hhmTVTEko0Scvzb0ksrF7+MUAh08So+TA6/B6UoJ0DTM
        V6enfm7I6CMEdGu/eE4XCR9TQav7Tq122SS8L/bh6Qg3JcvKWwnVrdiNssWGZucy
        OaumP/dCfa8cLPQT/XTvUU8RB6aP+Syaa7OpuvJ2zImfVpkm/7sEyRnv4jeMnRel
        V0opqIVQrt4Hbqd+xQlD9+P+W1dSaXp1F4DRg2eOfuXpouUv6g4IM1MPP5vmZP1k
        gXOfeM+i7GhsELF6VByObNXti5/D0NOgcA5lWolHi4dsLrhmhZUm3nf3uxSZeSST
        8yvKvQTn8pHryAzJf3jI30x8gGGjYJf/s7gniXbv3Q==
X-ME-Sender: <xms:VTzYY1iLvD0xSoU7kbhul1WPKoSPBPOCVZzv99E4YcMq6eZSvbwTGA>
    <xme:VTzYY6CAjrsAsbwJNxKd1TWIQeECmJQwGrYcFwE3YUI3RUmASK4dsUTtmtoObiNfo
    8KT_SjbLd8sQAiZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhepleejueevieffuedvfefhkefgueffjefguefhkedtuedvffdv
    geevvdegteelleefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghr
    sghumhdrohhrgh
X-ME-Proxy: <xmx:VTzYY1HcHC6NDxg_UIHCP2YVEUT3BzxhSPS4IK_XbnYaQdxLibHFnw>
    <xmx:VTzYY6QAyi0FBJSvJoqCWBUF0-t8mG5_JKwih4R8hwu-WvKpRyGqiA>
    <xmx:VTzYYyxiCQf_w7ZqnOnaLGpa0TKDqG6ffRixL4DTrs1bNgGIRTNcgg>
    <xmx:VTzYYxl7b1ufLnpdMjCEX6vKpc4CtU4ZiGCKHOm3CtJG0FKLAcTlwA>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61EF52A20085; Mon, 30 Jan 2023 16:53:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <1557ec53-2d9b-4f5d-b144-01ed0dd3c7a6@app.fastmail.com>
In-Reply-To: <20230130100602.elyvs6oorfzukjwh@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku> <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku> <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
 <20230129165812.sqypj6nzam7o33lf@wittgenstein>
 <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
 <20230130095324.p2gnsvdnpgfehgqt@wittgenstein>
 <20230130100602.elyvs6oorfzukjwh@wittgenstein>
Date:   Mon, 30 Jan 2023 16:52:55 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 30, 2023, at 5:06 AM, Christian Brauner wrote:

> The good thing is that - even if it will take a longer - that Aleksa's
> patchset will provide a more general solution by making it possible for
> runc/crun/lxc to open the target binary with a restricted upgrade mask
> making it impossible to open the binary read-write again. This won't
> break criu and will fix this issue and is generally useful.

Had to go back up thread more carefully; looking at the referenced commits now in
https://github.com/cyphar/linux/commits/magiclink/open_how-reopen
I do agree that that direction is the most elegant.  The main downside I can think of is the potential blast radius is larger, and more nontrivial code.  

But...in practice I guess today for the runc/crun type attacks today there are commonly multiple mitigations (e.g. read-only rootfs, multiple LSMs, and finally the memfd copy fallback) so we can probably wait for that patchset to land.

In short: agreed!



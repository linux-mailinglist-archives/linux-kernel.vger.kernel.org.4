Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41A68F81A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjBHTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBHTcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:32:16 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535128233
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:32:15 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2FFDC32004AE;
        Wed,  8 Feb 2023 14:32:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 14:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675884733; x=1675971133; bh=0Ww7YIi+8S
        zE/Xk29Ed4NjK6FpaU8TbVKXVoUGQbitM=; b=gKMIAaKc4tk4nyOq7kE0n0Gc1L
        4gZIXkHjjKaa4h6ilQICZfLA2+NXc6ojZd5aXOZxGUKOpMgvWw7QdCSuJKfa5kvr
        LMMFVhFv7kcqtRcO66SvMf1+s4c+hn6RBnDhJZYt//G6moMpBeeTIYuur/P5ESOU
        XrVBheU+cQStxtO7CTX7JVNr62LMuRZ/t+ahwFtD9OH8mtbZ8O0txm9DFdppwUXW
        2fHT/9ReWItbr4iT7ryLdGsC35S4RVEVxYgmg7H1TtdGDjZmaqsMYmWHdDgTBrJm
        wpYKl2AhUiVa+AEriM90GfNXuNataQ++A8ccPOW6CwfZ2DUvSrs1u6LQe/iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1675884733; x=1675971133; bh=0Ww7YIi+8SzE/Xk29Ed4NjK6FpaU
        8TbVKXVoUGQbitM=; b=XLiYR35H5CjMRFsF4oJGhylpImRA90muskLE5Ic8X5vZ
        32t0JiwD3dvDeVg4eGvoc11wVAmt8TtrHV9t0sl7y+8V3pyMP2qFqd88iGB/QJ+c
        kpaS6gfPKvm7nnI8zP+92eC1JkvPDLIpKEef8Vc9k/cqQY+4lAmyVfvxfyLBEdtp
        F3+tlp/yWe9StiARLgQdRKq/WGGe9vEri46VZPks8twx6YuF8SKg7qjUlIHINZ6O
        JVvot0hV1E8Z8XxrHBTdcQRKsl4U2IQNsxyITYOC/1g4q4kCn75TckTc7LN4vAcq
        e+mF6V2ksztIdBCHr/48ml2/3vN2V3rjNqaaBF/pXg==
X-ME-Sender: <xms:vfjjY5Eg1hdqVcmvOVVeGWlCVY8z2Q53HC_owr8EGqh8tzMtK3Y1YA>
    <xme:vfjjY-U_EJPYwu6baP2Cnso94SV8adNDuNvpEqWDeK3dTTIA47vMQ8GXNEhG6GLcA
    _N6yYVSxDTB8EohZNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vfjjY7JKz6uULfTO4hAbSXHDHiGB_sE9l7NEKpuC6F1p4KV0_qd7MA>
    <xmx:vfjjY_ElWuERIAJPPWJxfCS0qvE-RJx23SEdrUuCWrfc-XOYyr2TSg>
    <xmx:vfjjY_Vx6CW4igWk2c6vconYp9IobXIF27hn52FaeXxswCF9blsZWA>
    <xmx:vfjjY4NrU4T61TPaCOAyigKl_HZdKvyhX_JSmlOG4XEeDT4iLL0F4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B860B60086; Wed,  8 Feb 2023 14:32:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <7a62bc92-e062-4d33-9c3f-894b49452f1c@app.fastmail.com>
In-Reply-To: <CANpmjNNYcVJxeuJPFknf=wCaapgYSn0+as4+iseJGpeBZdi4tw@mail.gmail.com>
References: <20230208164011.2287122-1-arnd@kernel.org>
 <20230208164011.2287122-2-arnd@kernel.org>
 <CANpmjNNYcVJxeuJPFknf=wCaapgYSn0+as4+iseJGpeBZdi4tw@mail.gmail.com>
Date:   Wed, 08 Feb 2023 20:31:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marco Elver" <elver@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, "Dmitry Vyukov" <dvyukov@google.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] kmsan: disable ftrace in kmsan core code
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023, at 18:00, Marco Elver wrote:

>>  CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
>
> That means this CFLAGS_REMOVE.o didn't work, right? Can it be removed?
>

Ah, I missed this. Adjusted the patch and description accordingly.

    Arnd

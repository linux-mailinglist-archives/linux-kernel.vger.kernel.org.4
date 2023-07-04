Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB567478B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:31:22 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA83E5B;
        Tue,  4 Jul 2023 12:31:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 340195C0134;
        Tue,  4 Jul 2023 15:31:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 15:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688499072; x=1688585472; bh=4g
        tsow0D+6yhLzOvQoS00QH+q8wj07ePGtJBPslxxVE=; b=Z/zEueicl26u7FqUVb
        mbPwqzwjoyiNO9yEIwFbm3natpL4IVRYgk/1+HpJgxR1c2A1jrCS79Kq0L4CE2Ma
        n1jhPHiJMwXSajp/lxqvY2pk1NEFxvkdAGqBKPx62iRm/eUUQYGEdr8H3LToWv4b
        T+MsdftC3j+Zg4teuE0oz2ezUq4BQqYAaEW7g8QqTDC5SxleG6djm6EkLwLPgXR0
        2NkYBXKiAKyV/fdqi86pt/w1ZSw/lUCTvI4ywLLVNJAhNeBm0JL7V5PO7VzfgI/e
        XchefDS9JXzz42kY8mhsWTl+zCOOQgx1y0qrFc0KfWaH9ML2tZGmsurxYySJr8ys
        MeYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688499072; x=1688585472; bh=4gtsow0D+6yhL
        zOvQoS00QH+q8wj07ePGtJBPslxxVE=; b=KhOWL4jLB0DfevwUQ6W4EaDb+mwkK
        ObWP6pIfKAyDYRjtLiZHrZPRNtRzfuSB7Rr3Gjz9k//NIc7hTcB9jLV/P5epK7Qm
        QXb7TN5dr+gR/N0+gaEVxzKBrjSRbnPDNEnVTS4Ymb4gNdLtq4L5iX/lMG2Bziow
        7Snzpx2A9gHY9jwpznAXZ9uUso+ewM0wNzqbMaebCzZ/ev27fL6+xnD4jizBmSv5
        UU6Xy19vAjCPXkOJwIc7cMaK5npYMWpvAprXZ1TfoXO0wlDoK2p1hcqt7k30pUvN
        +TdgcOgewnEeGomjVuggW9I1lDdli4SnmDi4wxhwO2cJwboeo/lqBZ1vg==
X-ME-Sender: <xms:f3OkZPV1bcpR1t4UTJWGcOEk4u_fSNgwzJOAnH-YKv-gF8MToZX2GA>
    <xme:f3OkZHlzZwSaZGygnao2xmkvsK5glhgGvCTZyq7LRmsC1YXvtIxzTSuBOWAB59J8W
    W8gHoWKlRMN5kznqXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:f3OkZLY4tyqDeo3P1FlDN4zJJZ_7yVpFO6AY5WNEMzdvmrQEhiU4Ew>
    <xmx:f3OkZKUVoi1uQiP48MGvUcwdPbGCsglF7ZaDzFJ7-7K5cLNLe9-aTw>
    <xmx:f3OkZJk51VP3ri5pq1nIcRZT0maQIveE1WZuh5fjf75G4fEBJ5EEiA>
    <xmx:gHOkZPj1e5YDwK2Lxi8-ia2LuFHGd-emnrOd0grZihTpqE8LIYoHrA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77386B60086; Tue,  4 Jul 2023 15:31:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <72cd95c0-318d-49cd-9a0b-e0a3a227c693@app.fastmail.com>
In-Reply-To: <20230704190144.2888679-1-linux@roeck-us.net>
References: <20230704190144.2888679-1-linux@roeck-us.net>
Date:   Tue, 04 Jul 2023 21:30:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>
Cc:     "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: provide unxlate_dev_mem_ptr() in asm/io.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023, at 21:01, Guenter Roeck wrote:
> The unxlate_dev_mem_ptr() function has no prototype on the sh architecture,
> which does not include asm-generic/io.h. This results in the following
> build failure.
>
> drivers/char/mem.c: In function 'read_mem':
> drivers/char/mem.c:164:25: error: implicit declaration of function 
> 'unxlate_dev_mem_ptr'
>
> This compile error is now seen because commit 99b619b37ae1 ("mips: provide
> unxlate_dev_mem_ptr() in asm/io.h") removed the weak function which was
> previously in place to handle the problem.
>
> Add a trivial macro to the sh header to provide the now missing dummy
> function.
>
> Fixes: 99b619b37ae1 ("mips: provide unxlate_dev_mem_ptr() in asm/io.h")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Ideally, we should use the asm-generic/io.h header here, but as a hotfix
this should do.

Acked-by: Arnd Bergmann <arnd@arndb.de>

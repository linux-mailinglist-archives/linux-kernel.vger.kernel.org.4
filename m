Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00A63B40A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiK1VNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiK1VNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:13:07 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CEFDB;
        Mon, 28 Nov 2022 13:13:07 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D22B5C008E;
        Mon, 28 Nov 2022 16:13:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 16:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669669986; x=1669756386; bh=saJdYblUQM
        ubkBKneHxz9xq/v51yMrwW6TpKBNrxMUc=; b=VNuOzTuWUe4xzXZd1+bVz+AXpG
        isIWoZxNVSarVwznQVEUr1DB8YcCV8l91Nl+ZYLvHzty2SkT8U+kj0/hKp7O9v4X
        5XfHiQWDKf0QSPSqsI1R9QsF30O8FdTMwQ4pk0C1oIkJ8jsg8S+Perp9fnrUXDUu
        J7rhWFbbp4VDCWPrnTRVSIiNRga5HmtksExV75LqtQGIIjkvmY6z9bflKq668RHK
        OEfiUwzPn+bCUEe0Cyf6/SziB/clx98nHOip/M0bocISbsR8LEOrH5/TWO4Y6iSo
        cJpd3rghYnHyZ80DCsFjzDGMa0aC2RPQjPyeIiUOCl2ZpsuQYjVOzscMehBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669669986; x=1669756386; bh=saJdYblUQMubkBKneHxz9xq/v51y
        MrwW6TpKBNrxMUc=; b=dg4mdK3ypwpaf/P+1QvaxO1OOdXhg/7PvTl1klu5UC4D
        dgYclGaLJqXuaWZg+bWxxPcZGsbv8PA82hx/LaajCzrwP7qrGprohi2Tljmm22Iu
        8NLSH5EePfdqgtWt3kziPeOEIRQOH9wkLzJrt4ATB2uLqqBLGIW7XbcdEXSCpiia
        rxW8XUsgwPBH+gsf+YPkiL2AKgsd13jrgwZOZqj8cWOjSexi4fIjfS2+n+3oSIMS
        Jb7DuKtuuyhofj9bXWOINcTP3CGA9v6x5G7veJu5AaPbDyhw7NilH/3nCX7msSe4
        vD8rIyvgSFmnltjr3Ax/TUMJMDQ7oCcwgoKOELicmQ==
X-ME-Sender: <xms:YiSFYycuprpWWHuR5rUIurZNGq984gCwmPwPdOibr966lxxE6HhKnA>
    <xme:YiSFY8PMImz5UCV5NMoGY9VR8UI2VSAj3cCCvnCx189FmlhcaryDjnvN-ShjQUcNh
    bItd1HFZ967tsd_ntk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YiSFYzi57CPnWDMf2ru1BURcvDRsDQmcL5EGeICDF8aNTMzAuh-_uw>
    <xmx:YiSFY_-Yto5zpTMKO5bIPpL9KlRKDa4AWZ0TYAEh6XR35Vhz2kewfg>
    <xmx:YiSFY-sCjDr5rOjb0YxI_1mYCa0Rj77H1-7Zy3sOdZZR-aZLV58cng>
    <xmx:YiSFY_kldfgFsLHciyaYrp_XVR28m-BClyR9D9ZBTQKkXX8yo2j7uQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02039B60086; Mon, 28 Nov 2022 16:13:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2cb4b4a7-1d39-4f63-aee0-b4fc43efa68d@app.fastmail.com>
In-Reply-To: <CAHmME9rp+Nx_S8OgABzadc1+j_FrSRbUvGu2r9W_svrr+HMjSg@mail.gmail.com>
References: <20221128111829.2477505-1-Jason@zx2c4.com>
 <20221128111829.2477505-4-Jason@zx2c4.com>
 <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com>
 <Y4UKpP7/NOwPIkYe@zx2c4.com>
 <cd01e0b4-579f-48fc-995f-6e1acebd02af@app.fastmail.com>
 <CAHmME9rp+Nx_S8OgABzadc1+j_FrSRbUvGu2r9W_svrr+HMjSg@mail.gmail.com>
Date:   Mon, 28 Nov 2022 22:12:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Samuel Neves" <sneves@dei.uc.pt>
Subject: Re: [PATCH v8 3/3] x86: vdso: Wire up getrandom() vDSO implementation
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

On Mon, Nov 28, 2022, at 21:02, Jason A. Donenfeld wrote:
> On Mon, Nov 28, 2022 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Okay, I can split it that way. If I gather your meaning correctly:
>
> 1) generic syscall C code
> 2) #define __NR_... in asm-generic/unistd.h x86/.../unistd.h,
> x86/.../syscall_64.tbl

I mean all syscall*.tbl files, not just x86. There are currently
eight architectures using asm-generic/unistd.h, the rest use
syscall.tbl.

> 3) generic vdso C code
> 4) hook up x86 vdso, and select the right Kconfig symbol to start
> compiling the code
>
> Is that what you have in mind? If so, I'll name (2) "arch: wire up
> vgetrandom_alloc() syscall number".

That sounds good, yes.

      Arnd

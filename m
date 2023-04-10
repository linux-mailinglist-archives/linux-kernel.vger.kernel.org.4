Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7557E6DCCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDJV0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJV0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:26:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63FD1724;
        Mon, 10 Apr 2023 14:25:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 47996320005D;
        Mon, 10 Apr 2023 17:25:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 10 Apr 2023 17:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681161955; x=1681248355; bh=cr
        TAf9yOGTm4ffk3dkC8Fr9jQPKpoUJV7Nw6WJRp4fI=; b=ZMWHI6FKcSv0sCDgFi
        uPZrQ1mKE6+TX8kfNP7LfiZnT3/NpXwJU0rxlPterjMJmKoQpmBr05aSjwjSW0Nw
        wZ8Nd+FwosARAgsTybYy547MeXFcpnoaK0bWMwV6pXKPDObgoSFbaN+3rcQZ3jVu
        bqgLDARwkwRY+lpPsLJ4hJiCBeumV9+rEOBOFnEnR1111j8qxfwurz6hl0x6C+8S
        gxUWCaMe4cunKcEBtuGdFpb4/BQ4nibFosDd/YmDJdzGol3ZUJbBHpSN9FcgppuC
        aCfSkoLD1Lgn5yHPaQdMGPJtaxSBMFZwiAfdwmiNrQYYJZcm5wyp8EjIFIqN6j1n
        nV5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1681161955; x=1681248355; bh=crTAf9yOGTm4f
        fk3dkC8Fr9jQPKpoUJV7Nw6WJRp4fI=; b=GGuMnoQcq0Yms+h3gZFnXpEAtQSmf
        hS8hh1TlPT22Or3+Lsz6ZeIwgXOtPBsHnPEIKKhIsStZwA6yQp9QtlFEwPCX1Mir
        ajopvaLPpy3R1hnH8fdVl62MO3qfIyTBYXa9iNOR8jozv0AbfBLY7DV8auBX55KQ
        RnLemdDzFStISulRMlPg1hizZcPm4y683TKTUbC6Mjun5BcsLF/RVWofaSfNj11P
        ZPgNRCYVB+jja74ymrqVP96NOQRlkotqNkDC5gUWFzTfhz6/F73mXAEk3MGMW4vN
        UOnVP9Ce00fD1emrHq9UZukPwxgQulpMkYVDgyqaoQKWT99AoF0uVnwGQ==
X-ME-Sender: <xms:4340ZGoSPHbEjgF66C53lpbVX0885I86ngifQnhgCrQYSX1w2LJOHg>
    <xme:4340ZEovzX2jd3yslFO-0IPCCEsO9FguqrCQ8KpCvjNdjYEjOsGXbcvVJriQ0Vk1J
    -w7TgnGo98HJ66pwiM>
X-ME-Received: <xmr:4340ZLP2caSw_jwecVD8gkLNSLMStsztUI1M_Le_Jmst3sDIC0XN8xGI1vojIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:4340ZF5IElT4BWljqMlWfF2mXm7ADpwfR0Qsd-RPiAGQ3lcjnoo63g>
    <xmx:4340ZF4Iua-nECCv6X9y4NnNcwr0J41QIIUTEwLVY1kkM4w3pRFhBQ>
    <xmx:4340ZFig28qwYamX-F2CUlnSAY_HbBTZIJPzj48QhyhPJReu3C5qUQ>
    <xmx:4340ZPm4RknNUuIvm7ZHQW4f9SxRLKj5531W9iXktcFZxkd5Pz8iGg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 17:25:54 -0400 (EDT)
Date:   Mon, 10 Apr 2023 15:25:53 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Per-process flag set via prctl() to deny module loading?
Message-ID: <ZDR+4R4AKfnBcMOu@tycho.pizza>
References: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
 <ZDQQ0B35NcYwQMyy@tycho.pizza>
 <4017c904-9918-3e0c-b687-f55cfc5c4f4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4017c904-9918-3e0c-b687-f55cfc5c4f4d@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:47:16PM +0300, Topi Miettinen wrote:
> On 10.4.2023 16.36, Tycho Andersen wrote:
> > On Mon, Apr 10, 2023 at 01:06:00PM +0300, Topi Miettinen wrote:
> > > I'd propose to add a per-process flag to irrevocably deny any loading of
> > > kernel modules for the process and its children. The flag could be set (but
> > > not unset) via prctl() and for unprivileged processes, only when
> > > NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, but
> > > unlike capabilities, there would be no issues with namespaces since the flag
> > > isn't namespaced.
> > > 
> > > The implementation should be very simple.
> > > 
> > > Preferably the flag, when configured, would be set by systemd, Firejail and
> > > maybe also container managers. The expectation would be that the permission
> > > to load modules would be retained only by udev and where SUID needs to be
> > > allowed (NoNewPrivileges unset).
> > 
> > You can do something like this today via STATIC_USERMODEHELPER without
> > the need for kernel patches. It is a bit heavyweight for a
> > general-purpose system though.
> 
> So the user mode helper would be launched whenever there is a module request
> and it would check whether the process is allowed to load modules or not?

Yes, exactly.

> Does it know which process caused the module to be loaded and what were its
> credentials at that time?

It doesn't know which process caused the module load, which is kind of
unfortunate. It looks like you could stick it in the environment in
kernel/kmod.c:call_modprobe() without breaking too many things,
though.

Tycho

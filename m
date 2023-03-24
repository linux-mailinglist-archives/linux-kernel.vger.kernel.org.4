Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4716C7452
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCXAFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCXAFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:05:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D302C668
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:05:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D39E35C014F;
        Thu, 23 Mar 2023 20:05:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Mar 2023 20:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679616325; x=1679702725; bh=9IrX4z/UdW1Ba
        0pPp1nLJ/nsHq8lILtqoylag3vMAoI=; b=upPW+bWfOdrT4AqrxHPXa6d86dEvk
        Cv5+uGOS57ALL3vgFb9ddlgCKKyEfi3ZsXYZwvyc/CImh+UDL592BrF245JVA8tT
        hwf+sEpSs4W/0kOQV4462TLGu1nUXvf8o5tdPS0rC+bWmzprJN6RU0FYBGfiy7cZ
        FFnyhea2Lqgw9d9HAr/a41jJO0/EMc8YxACtWcuzz/3HE7eDwCzEHJNW/qEHdP+4
        I9Rdoe34eu7ZCK670mcpeqd1/K1atVngfye1R7aVo056L7S2FlEmc27Cw2L9/LyP
        F0FwfB1w79Gx3gRHG8qXv7B/2SlDlzfGIpUT7do2NsZ0Nt+4Wypu3mTnQ==
X-ME-Sender: <xms:RekcZPR8YBhQ2p9BQclCp0-Ca5wrgG4SjIczBOnHW0QOIZI2b4kUuA>
    <xme:RekcZAyIPiKO9lIQrz6xFzCC47aojAvUSw299PpkC2kzHmOhP6PUF7GCH7mn3Kww6
    gwOKmshUdCpuaPxPuM>
X-ME-Received: <xmr:RekcZE0NS407uPUEr6OBY4aesYcATz-HswUvDQyaBHk-_z-XJeImyK1ma8HXdiPNKU7TOfqKjzFptRfibazHHffAFlDy9A1YINE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeghedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:RekcZPBDx-S0m0boTclE2myO7d6RRSAU6w4ZtVQj1OgEkLSCNDsEnQ>
    <xmx:RekcZIhRZW3Y_AsF2NbWscsmggmPPB3aVrxnRWDt05wjUKcnGeWqUQ>
    <xmx:RekcZDqDqjXf8LnGj9asg3voYOnRw5IalX8BRjSuNVlGo1HLz_7iIQ>
    <xmx:RekcZEbd6D3X9n-UMBeZtn5QTD4bjd9xecXYgZekFEhG84ZW74ui5w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 20:05:23 -0400 (EDT)
Date:   Fri, 24 Mar 2023 11:08:21 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
In-Reply-To: <CAMuHMdUQ3+OUKZ-6DqcJfMgq8_90Cejzc=onhUmbaYTWJkZHRw@mail.gmail.com>
Message-ID: <c882ca59-e75d-7ca2-d63f-70aab1b46ade@linux-m68k.org>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org> <mvmttybx3ng.fsf@linux-m68k.org> <CAMuHMdUQ3+OUKZ-6DqcJfMgq8_90Cejzc=onhUmbaYTWJkZHRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-1838988264-1679616501=:26267"
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1838988264-1679616501=:26267
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:

> On Thu, Mar 23, 2023 at 9:39=E2=80=AFAM Andreas Schwab <schwab@linux-m68k=
=2Eorg> wrote:
> > On M=C3=A4r 23 2023, Finn Thain wrote:
> >
> > > Checkpatch says "externs should be avoided in .c files" and if this o=
ne
> > > appeared twice I would agree. But as it only appears once, I can't se=
e
> > > any advantage to putting it in a new .h file instead of the .c file..=
=2E
> >
> > Anything wrong with declaring it in <linux/nubus.h>?
>=20
> It's not meant for NuBus device drivers (at least in its current form).
> So a drivers/nubus/nubus.h would be the most logical place.
>=20

I think Andreas is right inasmuchas the existing prototypes shared between=
=20
drivers/nubus/nubus.c and drivers/nubus/proc.c are found there, and this=20
extern is another one of those.

But I take Geert's point that much of include/linux/nubus.h could be moved=
=20
to drivers/nubus/something.h. But is there anything to be gained from=20
splitting it up that way?
---1463811774-1838988264-1679616501=:26267--

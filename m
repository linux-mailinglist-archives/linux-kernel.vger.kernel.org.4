Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D866C0977
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCTDst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCTDsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:48:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A68222C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:46:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A8A2C5C0077;
        Sun, 19 Mar 2023 23:46:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 19 Mar 2023 23:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-id:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679284013; x=
        1679370413; bh=YoDrgW8HBLCTKf6J828TBvfQ8Ee86nddBfnpkbHLMs8=; b=R
        vh66DggqmTOyxzvD66nhCDf/usA7eHDFtpiUyf2ZxeD3W/eFd6YsVS7/b2hGKMeD
        FqdPYkwqGpa3Q3eEBDPwgEmxVRl2hbhzsBMH/eE6RXyW3mhngy9Kvg0IaLJhlA9c
        OhpBBtRbSBAAqbJe9+JqqDaMDwKb6VmhXApPiV38OEVvZJBV7UaiZpGgF+v0MwlU
        HBQX+mOH879XVC83C8cvCJLbLqi+6EYytEHVQqTgNLxdJmI/mm6aiZ6wxhyZ40n9
        e7ePf56Eck56gRlNmY2/1KD+dofblkroSAlj4xr7PUgN+5IK5k13CYljMzNyxgoR
        IgRiObZwRXHt313nCeN/w==
X-ME-Sender: <xms:LdcXZMjyItaCWQdeFvZtC7cCxfsUPdRa0KXpT3ClU8xTVvh_Zypo4A>
    <xme:LdcXZFArVxsah6Ljz-27gYWbhFf-fGc4mglDUxkgD6FhzDNTkhGUFdXM3von8O5Nt
    ovCoLha1yaYk5Gyxe0>
X-ME-Received: <xmr:LdcXZEGpJzrZOEk4UdGbWC2BLjPX30Q2Vik_j-qainlrUTODyyKBuoKdQTBBMMYhWfPjbp2KpMnu2LDzetlwGf71sJ8FK6HtvD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefujgfkfhggtgesmhdtre
    ertddtjeenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhig
    qdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepleefkeelgffgteekudekveffgf
    dvueehteffkeeltdefjeetleeijeetheegleeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdroh
    hrgh
X-ME-Proxy: <xmx:LdcXZNTiwg_JiFu1jGDNTIzrfCsy_tfPpvrTZoyEnoEBloAddavMlQ>
    <xmx:LdcXZJzQeP3Pkc71r2-cFHd7MZcYNZDQkqM2fOr6xXClkuDo-qD_bQ>
    <xmx:LdcXZL6Wk5BhdF62f2eilKwqnp5FBIgzbykk-0O-kh6pn6kZJ7OHyA>
    <xmx:LdcXZKr0-6IuEft0Cli1nlueb9RqOHos5vxXGrJGLoOeo-_44Eo9kA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 23:46:50 -0400 (EDT)
Date:   Mon, 20 Mar 2023 14:49:41 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     lizhe <sensor1010@163.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nubus: Remove redunant driver match function
In-Reply-To: <20230319142058.cfu3ftjfaut3pqzt@pengutronix.de>
Message-ID: <04bd0e13-d866-22f4-2b7a-200a31722a46@linux-m68k.org>
References: <20230319040816.232446-1-sensor1010@163.com> <3d77744b-ea67-a5bd-8126-f3d56e608add@linux-m68k.org> <4cd5783e.1665.186f9882231.Coremail.sensor1010@163.com> <20230319142058.cfu3ftjfaut3pqzt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-994210957-1679282745=:6715"
Content-ID: <2c633905-9ba2-a0de-7fcf-a609ba600d77@nippy.intranet>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-994210957-1679282745=:6715
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6e204fd4-4344-00bd-640a-efd735356461@nippy.intranet>

On Sun, 19 Mar 2023, Uwe Kleine-K=C3=B6nig wrote:

> On Sun, Mar 19, 2023 at 07:01:33PM +0800, lizhe wrote:
>=20
> > u.kleline-koenig, please
> >       delete the path you submitted, this patch does not belong to you
>=20
> Even if I'd agree, I couldn't. That's up to Finn (I think) to drop this=
=20
> patch again from his queue and then accept a similar patch from you.=20

I leave it up to Geert to apply Nubus patches that pass review. There is=20
no git tree for this subsystem and the only arch to make use of it so far=
=20
is m68k.

In my opinion, there's nothing novel about deleting code so it's quite=20
meaningless what "git log" says about authorship. That's doubly true for=20
redundant code, which compilers elide as a matter of course.

If some developers are receiving incentives to do juanitorial work (like=20
running coccinelle scripts) then I'd like to know whether a line added has=
=20
the same price as a line deleted.

Maybe some developers are deleting redundant code I wrote so as to make my=
=20
life easier as the maintainer. Maybe they are not getting paid for that.=20
I'm not aware of that having happened here, but if it did, thanks a lot.
---1463811774-994210957-1679282745=:6715--

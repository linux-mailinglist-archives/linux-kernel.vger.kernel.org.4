Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4873624B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjFTDsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:48:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC6610C2;
        Mon, 19 Jun 2023 20:48:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 77DF05C012E;
        Mon, 19 Jun 2023 23:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 23:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-id:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687232895; x=
        1687319295; bh=xI+HWMRw7XVVtgixtdwauRUMQmYd0Nzo4WiW1Ge+RQw=; b=W
        QjDDOrisyOq1KjmhI95oLLAwm8yWKfG63eZKVJHHEwbnz6ZcnRP21WiFsKu+hKiL
        dBAHZiPs4FYNu6cbFKrCovGdTMNo58g/X6fX/AfCYYog28yjig8nJz/L8pum+BQy
        dSTi9iAtmW1Wq2yJv1RNPc1iVkZuahvJwq7Py8MA8XF2yr97HeEuHXBTV19yLHpz
        A5UGbOm9bnjRsmHcQibevWCDsMeoZTHJACRb+5jB1/tGHpNllM292hH3+4rutwJc
        IJPVA5+izBZyTWJMSPlFLw7nCgrKDnHW7pUQA5+zTOGRqD7goWT6TZqbKsoGyMqv
        u85jPPsFHumFxkKF7sXnQ==
X-ME-Sender: <xms:fiGRZFqAB2H_osqEQGK7Kl-0thqY9R2NiWTr_WExr0ZoYjW--vQXKw>
    <xme:fiGRZHqecLQbOyjYvZuAJAwdXRGlxBw2hoi1lk0_bbzIqqv0y9Ct8Y6wVm9GXv6_-
    UfI5n4HTObGFyJWiDA>
X-ME-Received: <xmr:fiGRZCNuLd6UDEwS1cwBbHmy9rMY1ikoWNIVIGkmb5UKPkT0dwXWzgX_5IniM3UAtASyMXUU94VwGnZKWzchnTjGsThg1jem-Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:fiGRZA7DcpEG7nSOGaGLRuqftwzk6V0lfxREBBATr8J1JwSSehT9vQ>
    <xmx:fiGRZE5lRzou-Zxh6-4ng1uxxKVtfbeDHFkYO7GaVe8Gx0Zyyzndsg>
    <xmx:fiGRZIjSOH6o6gpq4-flKW5q5QE1EeTd2IbaSCIETsErj_eUeXaFTA>
    <xmx:fyGRZOQmGsoep7SnWtrqXnq3L8fYxg8rqztUeMcP1Qdsu8LuX8ckrg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:48:11 -0400 (EDT)
Date:   Tue, 20 Jun 2023 13:48:59 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <2023061946-latitude-negligent-e4ae@gregkh>
Message-ID: <99b5fc04-798d-a235-c001-fb444e78ada9@linux-m68k.org>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org> <2023061946-latitude-negligent-e4ae@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-175744949-1687222626=:26354"
Content-ID: <b2582ffe-b281-b640-07f7-4a96b2d11ccf@nippy.intranet>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-175744949-1687222626=:26354
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9cbc14d3-d22d-85c2-f488-70e94b9d5dfd@nippy.intranet>


On Mon, 19 Jun 2023, Greg Kroah-Hartman wrote:

> On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:

> > @@ -103,7 +103,6 @@ Level 5
> > =20
> >  * Upstream kernel development is considered a formal job position, wit=
h
> >    at least a third of the engineer=E2=80=99s time spent doing Upstream=
 Work.
> > -* Organizations will actively seek out community member feedback as a
> > -  factor in official performance reviews.
>=20
> Why are you removing this?  I write more performance reviews now than I=
=20
> have have in my life, all for companies that I do NOT work for.  That's=
=20
> a good thing as it shows these orginizations value the feedback of the=20
> community as a reflection on how well those employees are doing at their=
=20
> assigned job.  Why are you removing that very valid thing?
>=20

I'm not preventing that. That's covered by level 4 and my patch only=20
alters level 3 and level 5.

Bonuses and salaries are tied to performance reviews so the hazard here=20
are clear. Level 5 compels companies to seek feedback and naturally they=20
will seek it from companies who share their goals. You ask too much of=20
employees if you expect them to put aside the corporate agendas and pursue=
=20
the interests of the wider community.

Countless lawsuits over the last few decades made it abundantly clear that=
=20
the goals of companies often diverge from those of the wider FLOSS=20
community.

Consider all of the open source code thrown over the wall, the binary=20
blobs, the binary modules, the built-in obsolescence, the devices shipped=
=20
with vulnerabilities now reduced to e-waste because they cannot be fixed,=
=20
the vendor lock-in strategies, the walled gardens, the surveillance etc.

To my jaded mind, it is obvious that such reprehensible strategies can be=
=20
advanced by co-operative employees given inducements from colluding=20
companies. My patch won't prevent this sort of behaviour but it does=20
remove a directive that would help facilitate it.

Greg, if you want to see more performance reviews, the maturity model=20
could compel companies to provide unsolicited feedback, instead of seek it=
=20
from an arbitrary source. Would you be amenable to a revised patch along=20
those lines?
---1463811774-175744949-1687222626=:26354--

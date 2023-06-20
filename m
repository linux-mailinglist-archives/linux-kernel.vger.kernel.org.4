Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8D73625C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFTDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFTDyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:54:23 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0112710D2;
        Mon, 19 Jun 2023 20:54:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 624D35C01BF;
        Mon, 19 Jun 2023 23:54:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 23:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-id:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687233261; x=
        1687319661; bh=R9f3a1o9mdbc+HYYy6GLvEOqJb10bmncA9C0HjKJ42s=; b=B
        S+tlmoB+GwsMwSq396SS8fRfAsjI0qmSAkvr/azBgDpPofSkvogMGqbPRyr6n+F+
        eHcw+GBwrayo8FPEJb4MzGCPE2/wSuGPcFNZ2g6DrrkFGUfqPMBPXQ9CBflv0Ex3
        L0DG3UibXmPWMutojuN3RWGFONaz57VMBYr1TRM9Bnp9vItEU6w3R2ju23kBledF
        Z4yMXCjIbe1WLhsG9sUxOzzTFFEnPcEp5mvxsCHiTMJdbX/tkSmH5CDKVwgPMGTh
        cNhENQe1k2gcAhGAV46mqFrWJj0v60dxqVwlxPXoTLAJUc+YcVeCS8nVdg8EZiRX
        ZxGKiih9aUmAoxXQVKtVg==
X-ME-Sender: <xms:7SKRZH1RBCtAMKdls3DWggc8R31oFrvhOoMpBFCpEE7MUrOggpJhTQ>
    <xme:7SKRZGEcP_8pEIAEpvWzkGtmccPhvqU7zWYA3VK86m5-1VuUyqPh1EmU-3atbzofU
    -vNWizzABxXM8wJF68>
X-ME-Received: <xmr:7SKRZH6TKqCcUO1QDWOBeRnHtPJPLcVl6CRfzj3EH8oIz6tHiDdLUjZ5Xh5WaKZc7pyrYx_VlXwpDzZ3K9kGLBMVjgyd3FT41Wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteeh
    geelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:7SKRZM1sr_OnX-UrUf_9lydv1iDuOULhFu3D7HbdFksINiT-UjGz8Q>
    <xmx:7SKRZKFFsax4v2bjVyiLwkhTaSEYX61hycTsGMtqPGIjJqZlLzoMaw>
    <xmx:7SKRZN_nWxtihZ26sxei_y_RAZONw02wnPToUNw-ffbeXi-A1e1Stw>
    <xmx:7SKRZHPUacvy4ZhTwH97vH4f_YeDwx_du-RlSBLIHnjMrH5K7eW7BQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:54:18 -0400 (EDT)
Date:   Tue, 20 Jun 2023 13:54:37 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <202306191247.3CA085BA64@keescook>
Message-ID: <7f26d19e-2aed-c03f-e59c-c36164cdfb19@linux-m68k.org>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org> <202306191247.3CA085BA64@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-526003913-1687231289=:26354"
Content-ID: <f58cfba7-0db2-e714-a931-aa5b02c72b9e@nippy.intranet>
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

---1463811774-526003913-1687231289=:26354
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <833f7255-6cf7-1760-8087-49cb24a6c819@nippy.intranet>

On Mon, 19 Jun 2023, Kees Cook wrote:

> > @@ -103,7 +103,6 @@ Level 5
> > =20
> >  * Upstream kernel development is considered a formal job position, wit=
h
> >    at least a third of the engineer=E2=80=99s time spent doing Upstream=
 Work.
> > -* Organizations will actively seek out community member feedback as a
> > -  factor in official performance reviews.
>=20
> This really cannot be dropped -- companies must factor upstream work=20
> into performance reviews or it will continue to be seen as "free time"=20
> work, and employees won't be recognized for their upstream=20
> contributions. If an org has no perf reviews, this item is already=20
> nullified, IMO.
>=20

I believe that I've now addressed this in my reply to Greg.
---1463811774-526003913-1687231289=:26354--

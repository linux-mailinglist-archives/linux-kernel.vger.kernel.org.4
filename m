Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EC644DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLFVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:03:00 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F946167DD;
        Tue,  6 Dec 2022 13:02:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3A9BB3200916;
        Tue,  6 Dec 2022 16:02:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Dec 2022 16:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670360573; x=1670446973; bh=O9LowNv7Tt
        p6oS8aiZUbddfsOjLqyuslyKaWKZkNyKI=; b=wDpYiRrFN0zv3w0K8BPhTJJknB
        whSsrh+f4mjjdUph9NJDNzvUJi78iFp23qY/BfCg0PC32donkELnnYRJ+0MtoO1H
        y+yhwsR/WNrkxJo/DiYJ/4Kt+7W9lspzycdfeZOavnRr/cf5cVAg6F8t+Fl3megx
        0D1JNG3An/Xge6NVSjL3agXAuCj9y2WfZZSti1wY/BudempbpF054zm0PiT+HAYZ
        BSk0E5XUcPFqlrf6I/ZFyHCynh6Z/LSVTMgsRy37m2xzH+Q1uIdIL2Rg73pVngHQ
        PSvfRLn5CfOAI5x6UTtUrI/YlwbWc0oxAXdCRr21nQb9jhL9D/6L2hLbAENw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670360573; x=1670446973; bh=O9LowNv7Ttp6oS8aiZUbddfsOjLq
        yuslyKaWKZkNyKI=; b=pDNuJSVZNK/VASCmeIRn4p8eC2ie0noKNGEZzsdXJruV
        UI7I7qpslBAYsyjpNE2cTcHhBpZEdUj7vnlXAcgEReGtxCpHf9aXMug/wltFkHZz
        po1d/l4CqK3XSmHiiQR8BLXUPwAc5KjkQoUVzEPxTrY1KSMkQ//ScAZP+zRqXES9
        P2Gh5zeWbm3MTDO5uxnfDnBfdvKcD582Hda3vL5Tw51tkoYEoYmuRdMt5zhVXZXj
        fP+kyzhJKyn1PjIbhpb0520J6OLZOnlTMnyuejgYaDSqSWdpf9lqi6F1H0k0lIxy
        X57h2j9t2QyPG8h2WkXYf6OkySb9WevWzAwh28u43g==
X-ME-Sender: <xms:_a2PY8ZwZSfm9MRS6z0Txk84ut1YX9bG4UV0V8fvoMruZYoSqXrlQA>
    <xme:_a2PY3YEAdwSCt30fD2UBbU7MxTE1irJzRexgHB8eElWsKZ2aSCG-f0yRdB1Vyt1I
    lPKqYbs9F03k3uBV4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_a2PY29Cmf7veQnMQ7FYPnEGPzu8zSt8iRuxVDwRTgw-DTrsuNCCUA>
    <xmx:_a2PY2pvKN5PUz60MY8d7QYjTjzQndppupJgb2ymUwk5srgaZ9Q3dA>
    <xmx:_a2PY3pwTMmEpQyHUSWmQPU2VJPwwGcSjHj6qOCtbeIzPDOtbzn92Q>
    <xmx:_a2PYzKYLBa-r2blCGgtnIdk9OU6nwcqc74dwdpZuN8ObXwcBPJHJw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 00F3BB60086; Tue,  6 Dec 2022 16:02:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <5f0a5ea7-2d48-435f-aaa0-82b6ef8cfcc5@app.fastmail.com>
In-Reply-To: <87mt80l2py.fsf@esperi.org.uk>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20221205163157.269335-6-nick.alcock@oracle.com>
 <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
 <87mt80l2py.fsf@esperi.org.uk>
Date:   Tue, 06 Dec 2022 22:02:30 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nick Alcock" <nick.alcock@oracle.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v10 05/13] kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION in
 non-modules
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022, at 21:03, Nick Alcock wrote:
> On 6 Dec 2022, Geert Uytterhoeven uttered the following:
> Only MODULE_LICENSE invokes MODULE_FILE and thus ends up introducing a
> KBUILD_MODOBJS entry that triggers things going wrong iff not a module:
> so only it needs to go out (or be replaced with a variant that doesn't
> invoke MODULE_FILE, if you want to keep the license in too --

That sounds like a better alternative

> but if the thing is no longer a standalone entity at all I'm not sure
> what meaning it could possibly have).

As far as I can tell, the general trend is to make more things modules,
so there is a good chance that these come back eventually. If the
information in the MODULE_LICENSE field isn't wrong, I would just
leave it in there.

    Arnd

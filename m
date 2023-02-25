Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A56A29B8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBYMmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:42:37 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB28149A9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:42:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 55EB35C0089;
        Sat, 25 Feb 2023 07:42:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 25 Feb 2023 07:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677328953; x=
        1677415353; bh=Izlq7GJvIZYKMQ2vXJDJuy9U6xU3dEpHgXToMZ98+t4=; b=o
        jxn2sRXB1u3i+gNKQodhwGwkobmlJaCZ9ntxdT5z2+/G1vtIPpj3OmR/dvMK3UnO
        0i1ZMxTqAaT3/72EsnRwvRMEwzOaLov9f5eUvVuVqoMyNJFP2aL0fFOhNeNEa5by
        /LQGjiRJdiDBy6l6SCd4SeH9+4WQPLEvISDNKp/vpDhYPdE6RsfEh/IxLdI2qOgd
        xzFYmv0ixJec52VvpulbpKqUqBSVixXl8qnlk5EH38eRhRGTo6xDBZNauBcgR0pp
        uXDONOLqVbXsb1qcEjfYTTBK3+ODkY4WuycRO3eYQws1DSWHi/ljXmwvh2eOgYtp
        yk3DC7+nM8DJeSwrk+k2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677328953; x=
        1677415353; bh=Izlq7GJvIZYKMQ2vXJDJuy9U6xU3dEpHgXToMZ98+t4=; b=g
        0lEiEwZ1s8l6Anbs+TtwYLYW3H4v4BiVVo4BtAA/6MdpGkU2fdXPDszwtaUf4Rnv
        awd4og41HyfCKVEbmlbHLpcHmskw6AndfO9dgQKpn8RwT1s/7rEjPhjeBRHuJVEz
        TBWaAzXnYgVox/rMXdAiIJdihQ4JXmO10IFrF1VzDjhiXVHUQtUtzr87Tjlad/p1
        CIPrQcf0tXBjxkckJQsY66t8gMLvH/vv8U8xmPbtu67Cr/XjOeb5D13acAt8xK+F
        F2wVO1UvWx9obLj/gVZojeGjOF0xX2qXpjiPFXSFMN3OWbyX1RaHRxc2ZzYnYdWj
        dbLT2U3d7UcJ6gjXAN9FA==
X-ME-Sender: <xms:OAL6YxHA_Vhtp5D3IXfI-ldnC3YkxnBxGt0930hWgl9E-DL46ZfVIQ>
    <xme:OAL6Y2UpPPQScMwvAsdfjlTW7vw06y5_GaJoq5RkGqJ74--CiIL5ojJJdI5OcQba0
    MROxH1moM_XUmbgXwM>
X-ME-Received: <xmr:OAL6YzK2SsENoNYeZcWK4N5cJGyOr2yW5iKByisXl1nOqnnYFe6t8M4GoAjAo0e07Uq1x_04O4Ji4qAClwznH_EtizmRlu33Kx9dbf_XY1VI9y2gPpfSJDF7YTK9prbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekhedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdejnecuhfhrohhmpefuvhgv
    nhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvdfhtdduuddvueejueffgfdukedvfeevgfeuieeivdeltdehgeeivefftdet
    kedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:OAL6Y3HrewNJsgW81Fbz8dNrNh98woFrw1Xz50eLLk26QartykPjxw>
    <xmx:OAL6Y3WJuheddgGm0q_MG-FZ-5auUUWJSSxlIlQa5HJKKXZByedrtA>
    <xmx:OAL6YyNBrmAYUG49idrU9tdRs5j_tGdYbNRpQZP9Wbu0O5mh2_1xBw>
    <xmx:OQL6Y9zuR1ZmXIABQzAIVEHc5W-M_WCfNAlOAlVrn5EZGqpICjIqHw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Feb 2023 07:42:32 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sven Peter <sven@svenpeter.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] soc: apple: rtkit: Fix buffer address field width
Date:   Sat, 25 Feb 2023 13:42:19 +0100
Message-Id: <AE9570F8-6D5E-4314-AD21-21DD8B38D7F1@svenpeter.dev>
References: <20230224-gpu-up-rtkit-v1-1-671178cb2a5e@asahilina.net>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230224-gpu-up-rtkit-v1-1-671178cb2a5e@asahilina.net>
To:     Asahi Lina <lina@asahilina.net>
X-Mailer: iPhone Mail (20D47)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 24. Feb 2023, at 07:50, Asahi Lina <lina@asahilina.net> wrote:
>=20
> =EF=BB=BFThe buffer address field is missing two bits. This matters for th=
e GPU,
> which uses upper-half 64-bit addresses on the ASC and those get sign
> extended from the mailbox message field, so the right number of high
> bits need to be set.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> --

Reviewed-by: Sven Peter <sven@svenpeter.dev>




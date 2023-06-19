Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C1735A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFSOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjFSOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:50:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03385C1;
        Mon, 19 Jun 2023 07:50:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ADE525C02DC;
        Mon, 19 Jun 2023 10:50:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 19 Jun 2023 10:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687186204; x=1687272604; bh=Ox0mGgHLkp5N/Da4WUkUcZFzC5y5KCU3DdU
        4cU5s0Zw=; b=uBukndHQGWLUkt5Elnl5NgRUP7VADlbyByjzxpYFPTCu6ZQkXkW
        EuO6nRksRTSITxAS041IgShdDE/C8nTnzCS7s+KZ4sgX6fv6hI2se4CxS3f76Cel
        P4ZqwZ2nOukWFZcSdwaDdraA+vnJ1lG0EYHRF7+UXlzs90o5yeMkfrs7nMAAZEK3
        X3Pd/FoSMQ/gIs5V+CHZCfBNZdcNzQ5SwsRMhOJ9/JciE/N6W9hfB33m7yfbtupm
        9H+jHbnWngZ6Rn/8sSIBLubLAbe59dNfS4uFYJ2GJnNy68mS1j7tEA7MtrS6Equz
        x1kQ67rUB17ZXrv0EkRvrnlrLXmZMNDbu8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687186204; x=1687272604; bh=Ox0mGgHLkp5N/Da4WUkUcZFzC5y5KCU3DdU
        4cU5s0Zw=; b=BlQIjlC4NmqbmqO/N50HX0TO6aj3XPhHGD7M9YlMcqHrSp+rasA
        HsYFM3OHe592/b0g5KK9mszRBYFpelGzdavoUPRhfMLRRbYFj0QEc2vqC/OAicj6
        k+vRxIuu6wlDRpXXi3opAdHsWh3CGny8wP/7moaXopic9tdQhKXtAmHJ8vVVZTAf
        VZ6Z8ss9uvYbSipcfWyx/j2V51PwTCM7ilQUkrjJnZKfqY6v3uR2+u1GwOTrlkOL
        FY5YX1ZFR0waug0Knym4rss67fjXHFFdn4ZAWHOpAb49Xxx//wdmeRtVp7BLueus
        64bMxkkTpglzcGdQP7EnXj0ahq7qRiH8lMQ==
X-ME-Sender: <xms:HGuQZFgGOAhuUZ4CKNgTny7qdd2QSQY5T65AhPpH_OtUQoQf8pAoZA>
    <xme:HGuQZKDfo0bl_ti3SX1Ai2pN33AvW9DTfaSARGUffcyYwD9W0XrPgKHZcI5YVdsww
    zsvn2-YHI0G60mzM3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HGuQZFFPkC1g4AxtOWHiKVCoutxonI8fb5p5FMcCuCJi2eDvuqzzQg>
    <xmx:HGuQZKT3Q682uKecNV6ASB1RYXERLp9xPObFiBF6sbUTsV5BosHdaw>
    <xmx:HGuQZCyN4W8k3O2ouLqLZXxIUD5jo4CMTfcEv7HaYaUskz9b1zX9lg>
    <xmx:HGuQZBmupTpROysgmBoVV2vahoAhxBiXsQC9ASt9WJXsIqsz_4HAgw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B2F9B60086; Mon, 19 Jun 2023 10:50:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <063a8886-fd31-425f-901c-fc830512eca3@app.fastmail.com>
In-Reply-To: <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
References: <20230616144854.3818934-1-arnd@kernel.org>
 <20230616144854.3818934-2-arnd@kernel.org>
 <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
Date:   Mon, 19 Jun 2023 16:49:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
Cc:     "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: verisilicon: change confusingly named relaxed register
 access
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023, at 16:41, Nicolas Dufresne wrote:
> Le vendredi 16 juin 2023 =C3=A0 16:48 +0200, Arnd Bergmann a =C3=A9cri=
t=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The register abstraction has wrappers around both the normal writel()
>> and its writel_relaxed() counterpart, but this has led to a lot of us=
ers
>> ending up with the relaxed version.
>>=20
>> There is sometimes a need to intentionally pick the relaxed accessor =
for
>> performance critical functions, but I noticed that each hantro_reg_wr=
ite()
>> call also contains a non-relaxed readl(), which is typically much more
>> expensive than a writel, so there is little benefit here but an added
>> risk of missing a serialization against DMA.
>>=20
>> To make this behave like other interfaces, use the normal accessor by
>> default and only provide the relaxed version as an alternative for
>> performance critical code. hantro_postproc.c is the only place that
>> used both the relaxed and normal writel, but this does not seem
>> cricital either, so change it all to the normal ones.
>
> In this text you spoke about potential performance side effects of exi=
sting code
> and your changes, but its left all very vague and theoretical. Have yo=
u done any
> measurement ? Do you need help with the manner ?

I don't have this hardware and have not done any measurements.
Obviously the only point of using relaxed accessors is to
improve performance in critical code paths, but from the way they
are used here it seems that this was instead just an accident
and nobody else did any comparisons either.

My guess would be that if one wanted to speed up the register
access, a better way would be to use a regmap cache to avoid
reading registers when the contents are already known.

     Arnd

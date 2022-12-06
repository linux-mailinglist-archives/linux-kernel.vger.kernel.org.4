Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD064456E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiLFOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLFOSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:18:53 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1ABB2;
        Tue,  6 Dec 2022 06:18:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 34E515C019C;
        Tue,  6 Dec 2022 09:18:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Dec 2022 09:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670336325; x=
        1670422725; bh=KnIFi4lsGwwhq9ip/nuZpXNlyToP5kN9dlCu/kVKYak=; b=P
        SDybsSPkDfYcnbP31mii6mSNVDtJw9ZKY7wtpeIgM3a3XWwS6c1Nue6K+1e2UXbS
        vJcRmB+EKHm/cAQ1qcIRaRsiaM9Oc8n5h1vOiUeSWsIcwr9+9Eq8vZUg1vTta40D
        h4/nHX1m0V1PJNccvJqE8wO0gRcTKiaseHbR6Sb/ZtXqwO3dY00KbOMKhnOfY/GZ
        ADGwTzdiFXcB4qgwRwFsLMm4YudZkX+NmN45EdPF7kDsKqnQRODzAXeAOZvzFWok
        JiuMD/V+3EyAVMLlN5QT8VQbuaH+xCeMTr83+6c0idij5UV5j6VhtF/izXnoHCVi
        fk9KgZDOSmnaPBdXwa/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1670336325; x=1670422725; bh=K
        nIFi4lsGwwhq9ip/nuZpXNlyToP5kN9dlCu/kVKYak=; b=g/LdCgYWpF0N4lUBy
        4cUKSRjDSGnndq0gqVOF5CzuJvDBvIQb4iL0UWVbF/NFiIPWBsMiPnq4uCL0f3PJ
        yrFBZWkq0wUq6tBw4O+rpjamaDaCvJr0UoinUnFbYqcOME5qLC47IDgTICO9iysZ
        OEx6C+NpIJlmMjvFS5FKvZCCuvqo0UcNRfHe427EDCw5A2dFfhem4Vc6COPrQNGv
        sWoEObd8B007SJSmrsv36I6AKz10Ie4vbyCbHZBLYMpKUEMBSpDYFZnPRWSZqbx0
        2jXawTDTv3905Cf9tMsSE/Xv160Z8sJ1izG2U6LZU73GcjR9LQJa6JOC01ZbWS2O
        hQG7A==
X-ME-Sender: <xms:RE-PY__HPY6Za9QAcj-Vq6ml5Ezn0XqrfloTsX-FcMM8AMkf9Q1QCA>
    <xme:RE-PY7tdB9ud0nhvPHXgZhnqVxt73giyiPa-rqSD3f1xl-0pm5_P0-20YuUMOTOpG
    ZcWwjmnLoJwuKR4Nwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejgefhuedtjeejheduveegheevudffjeekhfevfefgtedtheegieeludefuedv
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:RE-PY9BCHWoz4-FT2pPi1V05cMWQNz8KadOhvoxk0epVuL_fB_ryOQ>
    <xmx:RE-PY7e-H7XnexOwYPjguglSY6YpNNaMoKcXchwgxt-V2w_rkdBMOA>
    <xmx:RE-PY0Ni1GJGdtfoHmUw8un0yzJOZeUUFwEH3HhT_TmZGst4uwHzug>
    <xmx:RU-PYxo5ZQsqKSKNOCMyq0gsxWCZU1Vzm4rgrYiiyL8f9UQnM3-_Sw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A95BB60086; Tue,  6 Dec 2022 09:18:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <b29dceb0-a07f-4e12-9e7b-6fead4db826d@app.fastmail.com>
In-Reply-To: <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
 <20221206073916.1606125-3-jk@codeconstruct.com.au>
 <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
 <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
Date:   Tue, 06 Dec 2022 15:18:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Jeremy Kerr" <jk@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon devices
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022, at 10:25, Philipp Zabel wrote:
> On Di, 2022-12-06 at 09:41 +0100, Arnd Bergmann wrote:
>> Philipp, what is the earliest point at which
>> reset_controller_register() can be called? Is that
>> possible before postcore_initcall() or driver_register()?
>
> reset_controller_register() only initializes a few fields in the passed
> rcdev structure and adds it to a static list under a static mutex, so
> there's not much of a limit.

Ok, in that case I think we should at least leave the option of
doing the reset from an early syscon as well.

> However, reset controllers that choose to register early without
> creating a platform device may run into issues with devlink=C2=A0inhib=
iting
> reset consumers' probe [1].

Right. I think the is generally a problem of "early" code, so
device drivers should avoid doing this if at all possible, but at
the same time it makes sense for infrastructure to tolerate drivers
doing it.

     Arnd

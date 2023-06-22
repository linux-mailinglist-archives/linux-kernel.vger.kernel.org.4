Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED273AD31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFVXaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFVX35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:29:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D31FF7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:29:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DC3D85C01F2;
        Thu, 22 Jun 2023 19:29:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 19:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1687476591; x=1687562991; bh=wZHmmu6KvxmT8vFXqnS3eIjYDdZ0UuOzPPy
        195vr5vA=; b=upeRMZ/DZhxynCIhJkq0oh2TBP8tODn1Hk/riWnr6M9c2krUw4i
        +QxqyIX2RaPB+SfXIqnxm0zii+8OF6voZaFkYKR4JaCVJppBPfAISXwBvVeRDe4M
        P69Gqew1eTIoprENOmYqh4BazRLz/Q1wNOO5tPmo4K1t2jdQ0eDo6XJWbl/aozLY
        6gQeS29V6jUkigwMI2yF8iYfIEq8tNDVRZXf74BESw4kmD/TjIBsgGP2SbpnP/I2
        F1nu7yflv0SVfeH4lHRfy4DmopifkSJO6N3t/z1nmDh9W+TwQtLvtjdPjdbIyMJ5
        PbUx6HZYH3va+WZg2VhxPl6mPUDz/1MCQnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687476591; x=1687562991; bh=wZHmmu6KvxmT8vFXqnS3eIjYDdZ0UuOzPPy
        195vr5vA=; b=CGBpcC/WoW5bVKVXxwPR/ezoRUZECPBXl8CEf2feAQbT2Q26Vot
        2c97CtWD59vu2ln/883O0HPTkLB9muCdVL0R8FtSuDabIXNclEagiJMSQLoE9pTm
        CiUGSK6+PYMzrSqVEum4COyrtYphGOo/wyuzO1abVvj3jnGjKaGlHg9HV5BzAyhV
        AMXXIo2HfmKF8AEgsOIMrqr5OW03pQao7/b5+FUNb1rq8m0qfTlH/DSl8F49r2Uo
        dECxcbOnGFEB98LTJ4gfLuHn6MHZbYcWY7zYVm1lFLtCTUc0eNMP9fdl8VheWZpS
        F1oCXl2WJh+6eccS5lifhJHSQM+qVB59RLg==
X-ME-Sender: <xms:b9mUZAZGVf2OrKJuDLZ77o4mgfT_qro1RTNy1H2xMRvPiq66bAf5BA>
    <xme:b9mUZLZQtoPI8BppnlWCTxhYjrFLLyNbhERQ0FS1A9kDBrdGnKafaC0em_7ThrGu0
    78tzlz7mXcnC_wdru0>
X-ME-Received: <xmr:b9mUZK85TBS1GH7kboTNv3p5-k14-PgWJ8ubRq2Y1ItrbFnYCyTtoaMXlftWwFeLwMky2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvuefhveduieffledtleeuhfeuteethfelieejudduhefhveevjeeghefggeekveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhn
    vghsrdguvghv
X-ME-Proxy: <xmx:b9mUZKo1f1Q-j34veDBEYxJ9bcdIeUUfMHgMtP6e8klkFs_uytmlUg>
    <xmx:b9mUZLpZXGXKkqYA4C2-8fmA-n5flumiDWnrL1mw6oySzCBy0TRrBg>
    <xmx:b9mUZITsTaVkM0b5-Pigfc1tRs3lto5qLbnGks1uO8JYg8H6SVnH2w>
    <xmx:b9mUZMmpv4-0XnfTDyj3BWBazV2SFCR2PXYhwEqwLvRlC_jUv6-xYQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 19:29:48 -0400 (EDT)
Message-ID: <349dd967fd5c201619cea0c54e3a09e933bfd377.camel@ljones.dev>
Subject: Re: [PATCH v4] ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41
 audio
From:   Luke Jones <luke@ljones.dev>
To:     Andrei Matei <andreimatei1@gmail.com>, tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, perex@perex.cz,
        ruinairas1992@gmail.com, sbinding@opensource.cirrus.com,
        tiwai@suse.com
Date:   Fri, 23 Jun 2023 11:29:41 +1200
In-Reply-To: <CABWLsesOzR=Wpc1TTp3PLXAuWUfX-heUnUys7ffM=Jzn-mEbxw@mail.gmail.com>
References: <CABWLsesOzR=Wpc1TTp3PLXAuWUfX-heUnUys7ffM=Jzn-mEbxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-22 at 08:35 -0400, Andrei Matei wrote:
> Hello,
> Is this patch specific to the Ally, or does it cover other Asus
> laptops discussed in this thread [1]?
>=20
> Thanks!
>=20
> [1]
> https://lore.kernel.org/lkml/b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensou=
rce.cirrus.com/T/#m42ec3f3f4ceb610430587b916281b570fbb666df


It is Ally specific. Most of the laptops will require a set of similar
quirks, but for a different codec susbsystem ID.

Some others have now been submitted, if your laptop is not yet
supported please file a bug report, if it is a ROG laptop you can
submit something here https://gitlab.com/asus-linux/asusctl and I will
help plus submit any fixes upstream per usual.

Do keep in mind that the 2023 range of ASUS laptops are almost all
missing the _DSD properties for the Cirrus amp they are using, and so
you will be missing bass/midrange until a solution is agreed upon (or
you add an ssdt patch) - you also need the correct firmware tunings for
your laptop. It is very highly unlikely ASUS will add the missing
properties to a bios update for each and every one of the laptops + the
variants in the full 2023 range.

Regards,
Luke.

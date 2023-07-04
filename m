Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADC747A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGDXSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:18:18 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37EE72
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:18:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7FA383200974;
        Tue,  4 Jul 2023 19:18:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Jul 2023 19:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1688512694; x=1688599094; bh=hQsjQzYTf6onI5Se5FktyD4OeriP0PTfEu5
        0epn5iqk=; b=g2A2FTbSt1sss1dV5/n6uvwD8oGUVN4ZucR/eMH4PI19fA9SP5R
        oZWEHn6X/+0KJog11X3WYn1RkWkyVnQndGq1fvPSaL7EHJisIJNvltxzJAEZ8o8P
        MveHIYKxAASyl+GrDH6QW0EKaeVUN+k6IxotFyfHOPdil+z5PS7HZab/lWE4xTFW
        qDHtfw1rjgRb6NBrWNBNNm7XfYxQU4VLHCiPBtOdSnvHosm/QBlGsta3P5XnQwZF
        om2o4FVD1ty2x4AL7RWXPJ3Z29XJQssa11bLz4iYFXQB7ChalDmztttiQAd10xmb
        CPOqSv/jQubocoFlxeJn2HKlwzMXLvRnCLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688512694; x=1688599094; bh=hQsjQzYTf6onI5Se5FktyD4OeriP0PTfEu5
        0epn5iqk=; b=eRk5Asmqe4Q9qJPtd579Z2PmJ6OCiza104EGMLSp/8f0xqfem9Q
        UMMMd6GTXPwedQeZ/lX5ktLBF4Mmrz4GWz/VUf6C4JSeYj4onO+FJHAyh28YVZ6K
        iCSYeOyXv+6SgSPSm/Zyf1YzKvpE7QZsv+HxH36PunldHr9UUs4PpfpojKBOQ26k
        1XJz3Osj5/qvvbdjMVpn5hU4tkmU1nfmhAo1cFFyti5vpkTfd7ntvZwDya09+H6w
        6T+A1lNPRpm5sQV+CWgVFqQLDRSHqTIfbF7Gj2qDhiPt2FB/0kyx00isxEOdXTO1
        0gkl3u8jyu2cK6jDwbcmPbb0y9dEziWNOMA==
X-ME-Sender: <xms:tKikZEEBJ0ybAfMS7kkAUZuw18e7odZMYrb3Jqw_ChCEXOnQKqNXNQ>
    <xme:tKikZNUKnkXNA49bQk_mVJ6vPcS_DCVSs-xqI6_Mt1iMhI-aoCcuva36AM7xVc2zN
    8oXfSPJYXv8kN_XU24>
X-ME-Received: <xmr:tKikZOJSwkti3xrJKFSxBDXYNHQg0OPahYBqFGHb07tyAJb3RM3qWfCewAng_SHHXGexKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epkeefffeujeevueejueegleelhedtgedvledukedttdffhfeifeelvdduheefjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:tKikZGHCb4EhcgViQaGtflbhDKpveg3Hg7n5j0LL7o0BykVzoLpQAA>
    <xmx:tKikZKWt6BDsVFNxCPVkfRPai-_sN2Ij1cX_RopiUbTjRvI6nSGNNw>
    <xmx:tKikZJPJFuo7c5fkkuW4xs9MgTwD-BJbnrpM-ZheN0Smsmp0tI1SJw>
    <xmx:tqikZBNnjlLOS58R-mFj4BcK7R7CvMKODTLwTilu8cbu3ejT3YuxlA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 19:18:07 -0400 (EDT)
Message-ID: <ee2e1c4bfc888f4f3285ba0f94a48a5f8f1eca8b.camel@ljones.dev>
Subject: Re: [PATCH v2 0/5] ALSA: hda/realtek: add extra ROOG laptop quirks
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tcrawford@system76.com,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        yangyingliang@huawei.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Date:   Wed, 05 Jul 2023 11:18:02 +1200
In-Reply-To: <878rbw41ln.wl-tiwai@suse.de>
References: <20230704044619.19343-1-luke@ljones.dev>
         <878rbw41ln.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-04 at 08:44 +0200, Takashi Iwai wrote:
> On Tue, 04 Jul 2023 06:46:14 +0200,
> Luke D. Jones wrote:
> >=20
> > - Adds quirks for various ASUS ROG laptops.
> > - Fixes up a previous quirk
> > - Fixes up a whitespace error
> >=20
> > This introduces a quirk chain that is similar to the ROG Ally quirk
> > chain, but
> > due to the verb configs being currently tested these new quirks do
> > not use it
> > and instead add a new chain. It is likely the Ally quirk will be
> > removed in
> > favour of this new chain in future.
> >=20
> > Luke D. Jones (5):
> > =C2=A0 ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
> > =C2=A0 ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
> > =C2=A0 ALSA: hda/realtek: Amend G634 quirk to enable rear speakers
> > =C2=A0 ALSA: hda/realtek: Add quirk for ASUS ROG G614Jx
> > =C2=A0 Fixes: 31278997add6 (ALSA: hda/realtek - Add headset quirk for
> > Dell
> > =C2=A0=C2=A0=C2=A0 DT)
>=20
> Now applied all patches.=C2=A0 The subject line of the last patch was
> modified to match with the standard.=C2=A0 The Fixes tag was moved to the
> right place, too.

Thanks mate. I looked at the patch guidelines for that but I must have
misunderstood it :)

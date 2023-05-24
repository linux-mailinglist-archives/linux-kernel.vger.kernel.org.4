Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73388710007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjEXVaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEXVan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:30:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139C135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:30:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 699F45C0082;
        Wed, 24 May 2023 17:30:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 24 May 2023 17:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684963841; x=1685050241; bh=ZhxPI6yBtBdhZEiyO9wGhdKxon/G0xigzrP
        JMnA88c0=; b=DWK5uy3p54JIMLb4pxi5mpr2xZiEar2Cpd5CYlWYViJlq+uF+6D
        qg3aXRrXeRWU4JpJjMKc0L7LMtMbmOkd9qav5dqEfCpBQx8dNls71bK9ZlXDk5cp
        H2a1Ty/IpxStBE8hh4stAp+6rv6JBymlU1Ikh+B89ghrEPA3TStCLxHIXlpaJCSi
        H+wsi/KwYG4GSb3tHGLP9CPii6gI719zKPd7EiQCtO1jK9HkftpMS9V0il6aMct2
        PHopXRnpDSWQn8HozPuhjBcEWOsxa+ZcNwhGM52mVXn/dvrxPfjchg2Ak2f4LVMT
        n5jrmKpd0VM+zxT6wYTDSlDvTjFDnCUwRGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684963841; x=1685050241; bh=ZhxPI6yBtBdhZEiyO9wGhdKxon/G0xigzrP
        JMnA88c0=; b=bLAo2kdoO59YKVcSgOgM4af1cfzuoO7OXUG9yySmffhMrkcL7oC
        Izctj0E5u73uRYA4y/SnwskzPtcgNx4kzZUyFf78Kb0VH9zLKhnqYnZTutlP3A9u
        eB4JWpK/ndbiwOaJ3lzgGZwnXiWlxlY/IpehTLngfLbATL9VdQV7l1CQofvSrZL+
        lnDY3yV1FLXZaZV5CY6UdhPnk72pAT0XoVa+/RWzx2hDTi2JuEBezDP6eT0JXjUy
        EWLt//YcETuO3dBY3n9gSHsxOh7Nas0NLzvaELFHQTRKe04MVjjHaN09GyXz/55K
        VMDqRSeyRJDYr3WGRWDPUZ7qg9bxkFDYYlQ==
X-ME-Sender: <xms:AIJuZBxejtj57Iwne4G_CIrr32n0RAZklgidMPL6GbujRH_kBsoAkg>
    <xme:AIJuZBRW8W617XA_v7sKsUCO1jVwpgFjDnC51E18-5JpWOX3dHSP42hPDNRRaOLW1
    Rmj9DhE9cYaHB4ROMs>
X-ME-Received: <xmr:AIJuZLX257nVK25sdqSqyl-kEw6rN_GBIzwHytptB-Kw-DH5xkTTR0Wwye_IgnMi0Uofbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepkeefffeujeevueejueegleelhedtgedvledukedttdffhfeifeelvdduheefjeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:AIJuZDgVKjnhh2jOeeUTPNItVzYy5S81lWGsnPh-jMdh5yHb4C-UFQ>
    <xmx:AIJuZDAd34FAY0EkC9RPRy-fb2O6aWt6uEAmwjtljrcyIdEqryf4Ig>
    <xmx:AIJuZMIpX8ldk79re0AM4ZSk9ltkXUIsqdj8Pr6ckJi2FkJJF9QHSQ>
    <xmx:AYJuZFzTE28zX4JjF_IRMg7S6JFIE0fQPWQKxnQWNrh3WrkuJsquSw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 May 2023 17:30:32 -0400 (EDT)
Message-ID: <19d69a5da8f1d4017ac14ed87f927ab82278073d.camel@ljones.dev>
Subject: Re: CSC3551 and devices missing related _DSD bits
From:   Luke Jones <luke@ljones.dev>
To:     Stuart Henderson <stuarth@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        sbinding@opensource.cirrus.com, perex@perex.cz,
        tangmeng@uniontech.com, andy.chi@canonical.com, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com, armas@codux.tech,
        ealex95@gmail.com, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, tanureal@opensource.cirrus.com,
        rf@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Date:   Thu, 25 May 2023 09:30:24 +1200
In-Reply-To: <b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensource.cirrus.com>
References: <1991650.PYKUYFuaPT@fedora> <87jzx3zaf8.wl-tiwai@suse.de>
         <b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (by Flathub.org) 
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

On Wed, 2023-05-24 at 17:36 +0100, Stuart Henderson wrote:
>=20
> > The problem is that this can really easily blow up your machine if
> > some incorrect bit is applied.=C2=A0 And more easily applicable, more
> > chance to break by novice users, simply by believing what a chat
> > bot
> > speaks :)
> > That's the very reason why this kind of change should be via ACPI
> > table officially set up by the vendor.=C2=A0 That said, the question is
> > only who and how can be responsible for this kind of change.=C2=A0 It's
> > no technical issue, per se.
> >=20
> > If BIOS can't be updated, at least, the configuration change has to
> > be
> > confirmed by ASUS people.=C2=A0 If ASUS still ignores the inquires and
> > requests, we may put the quirk but with a bit fat warning (and
> > maybe
> > complaints to ASUS) to be shown in the log as a very last resort.
> >=20
> > Let's see what happens.
>=20
> Thanks Takashi.
>=20
> Just a note to say we're not ignoring this and are investigating the=20
> best way to support released laptops with ACPI incompatible with
> Linux.=C2=A0=20
> We're hoping this is going to be less of an issue going forward.=C2=A0
> Please=20
> bear with us while we look into this.
>=20

This is great news, thank you Stuart. If you need testing done at all
on a wide range please reach out to me and I will enlist the help of
those with the affected laptops I mentioned.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A460F67C78D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjAZJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjAZJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:39:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077205CFE4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:39:01 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 29D4E3200979;
        Thu, 26 Jan 2023 04:38:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 26 Jan 2023 04:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674725936; x=
        1674812336; bh=G2swqMT0vVr/RxeIkV3CkXIFX9WTobaEU+Ba9jbwnhE=; b=a
        JNRa0FOsNmeLyl/gouQ4G8O9jJSaXs04Lwtv2iQe6HiiMM2Ub1g7xEJls21tZkkv
        6gG2QXh/y9cJ/w0SbVC7L3eQnaXv+22AbNEYhYamxsI4POF+DlvPc/imnNsub9zT
        3C2/B7xjG+oqinDNyQp0dTEqN/D/TyeX9yLnaRok39Ym8dJTvndY2LYoOJHvUgQ/
        TDesSzrTFti6C3V4bL8ko2Xz81GHVCQre75TB5LsKkrGnEZcomrqiPcjY/r76vR+
        9COapY8KE9nj+bzmqC5eVOAqMe07ysEY+nxtcWQaxz0dzKagfqGYWrNwAIkhw6a8
        lq0a6ECxUKYgrAcwT1CjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674725936; x=
        1674812336; bh=G2swqMT0vVr/RxeIkV3CkXIFX9WTobaEU+Ba9jbwnhE=; b=P
        +p9ebGXd7z5I+ofKoB31Z1m+lQkW/172RX+4BR1rjKWwErmkyPfFdLscrsNLkB1S
        7Jq7NuX5AjemRSTi+S33ro9DENQuK5BaOJ1a+w30DAaTevPdTf4qLoMkuKUlnkHD
        Zk09Q/4QQynIZGM6+kVD/aF3vPkmE3We2djCK1dNNxLblv5JZ8a4rsCwLrVJfcNq
        9B7DCJj7wZ/qckibq62Wn1oIe+8v5l9q73rGj3D/FWPONDduLdY3yz/tWAIGjS16
        K+Fhw87nz4AhESHkcAa9ZbjtFtA0KIHc1OSJAQBx5fZzTvakf1B34ke9dLXhYM95
        FnQFvc1NiZKO0c/RYZvmQ==
X-ME-Sender: <xms:MErSY_wg7s126wQDdbr124iScCv0mNkrRJ6JqJqbkOE4MOBlMHTfhw>
    <xme:MErSY3SPTNjXO6_Sd5J1nY0HgcrhIS8IH3IRkk75HHFgrmYBLPTHCz-yEjCk5nsBV
    pakQO2kjqRyf_QnwEk>
X-ME-Received: <xmr:MErSY5Wky6_8rb6XjLyDmiKZ6CpJHqbb-a066UE9Ol4oPt_bKj1Xl9pNI0denEjnbSZO4yIfsSijkBMy425o6EclpDnMfCEi3clurVdKs0sifw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MErSY5hd0gNhEh3ovtPcLO-7A-j_DNZXLVol0lzcRWyxSgAP7cfdnQ>
    <xmx:MErSYxAuDPVe1rM-oNvGsMUnUFTWK_nkyZAh4yR3O8IRM4MmjbmTAg>
    <xmx:MErSYyKZOB-ch4Xz1Z4qvttN1SJWh52IV9_IhD1iPHVqF5u6A20ptg>
    <xmx:MErSY16RxYipKp5oopBR2HrWhew5rANfnreWlsUznlLhYemkaLDEIg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 04:38:55 -0500 (EST)
Date:   Thu, 26 Jan 2023 10:38:53 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 3/9] drm/vc4: hdmi: Add Broadcast RGB property to allow
 override of RGB range
Message-ID: <20230126093853.kqjhswl27kelywov@houat>
References: <20221207-rpi-hdmi-improvements-v1-0-6b15f774c13a@cerno.tech>
 <20221207-rpi-hdmi-improvements-v1-3-6b15f774c13a@cerno.tech>
 <fe6945e9-f873-a551-8b10-d655077a5dd1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fe6945e9-f873-a551-8b10-d655077a5dd1@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review

On Wed, Jan 11, 2023 at 03:11:51PM +0100, Thomas Zimmermann wrote:
> Am 07.12.22 um 17:07 schrieb Maxime Ripard:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > Copy Intel's "Broadcast RGB" property semantics to add manual override
> > of the HDMI pixel range for monitors that don't abide by the content
> > of the AVI Infoframe.
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >   drivers/gpu/drm/vc4/vc4_hdmi.c | 87 +++++++++++++++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/vc4/vc4_hdmi.h | 15 ++++++++
> >   2 files changed, 102 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index 0eafaf0b76e5..488a4012d422 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -154,6 +154,11 @@ static bool vc4_hdmi_is_full_range_rgb(struct vc4_=
hdmi *vc4_hdmi,
> >   {
> >   	struct drm_display_info *display =3D &vc4_hdmi->connector.display_in=
fo;
> > +	if (vc4_hdmi->broadcast_rgb =3D=3D VC4_HDMI_BROADCAST_RGB_LIMITED)
> > +		return false;
> > +	else if (vc4_hdmi->broadcast_rgb =3D=3D VC4_HDMI_BROADCAST_RGB_FULL)
> > +		return true;
> > +
> >   	return !display->is_hdmi ||
> >   		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_RANGE_FU=
LL;
>=20
> The existing code is now the branch for VC4_HDMI_BROADCAST_RGB_AUTO, AFAI=
U.

I'm not entirely sure what you meant here sorry. The existing code path
is indeed the VC4_HDMI_BROADCAST_RGB_AUTO case, which is the property
default so the current behaviour should remain by default.

Is there anything you want me to clarify?

Maxime

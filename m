Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C27C63F3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLAPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiLAPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FBCD9B1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233DD62020
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B016C433D7;
        Thu,  1 Dec 2022 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669908231;
        bh=12sVLJi1eV03nDA+i/p257FYeSwqbJxoO6cnJV24q0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jibOnvj+ceP+BR55o6l9sQb1r8X/aMrdlpGQOisuZrWI+9WRbIhyylj+kTZFfYlvp
         hNGiLmS9l2xxf4fif7DL8ttkIl9exc9XMydLUEKvtGaFge7cHgtYyVALiK4S3x9f4o
         Gs4i+gzT4cS/dUW9koQ9VPgpSC6PSh9B6CXmXTFIFDvniE1wJjsWxP7xiBEoQXf5DF
         Z/mYIB+yybJptD2yMIELxwqgd2Xst42X0OumPYHkleZk2z/on9OjZnlP0orCmE7XgZ
         BXnkX1uV/88dBrZr3qN651U5LdpGE6+aRW7Hye2gsi9gVtqf+EBKwFjDnsLhaCnWp2
         8HGX6KLuok7WQ==
Date:   Thu, 1 Dec 2022 15:23:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        Chunxu Li =?utf-8?B?KOadjuaYpeaXrSk=?= <Chunxu.Li@mediatek.com>,
        Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Message-ID: <Y4jHAJgmz/P58Q/C@sirena.org.uk>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
 <20221125094413.4940-2-jiaxin.yu@mediatek.com>
 <Y4Cysgk5Gic5ae9B@sirena.org.uk>
 <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
 <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
 <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3piYtER9tAyOK42"
Content-Disposition: inline
In-Reply-To: <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3piYtER9tAyOK42
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 03:06:04PM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=E9=
=91=AB) wrote:
> On Tue, 2022-11-29 at 17:22 +0000, Mark Brown wrote:

> >  static const struct snd_kcontrol_new
> >  mt8186_mt6366_rt1019_rt5682s_controls[] =3D {
> >          SOC_DAPM_PIN_SWITCH("Speakers"),
> >          SOC_DAPM_PIN_SWITCH("Headphone"),
> >          SOC_DAPM_PIN_SWITCH("Headset Mic"),
> >          SOC_DAPM_PIN_SWITCH("HDMI1"),
> >  };

> Which operation should I use to inform bridge driver to control audio
> on or off? I'm curious why I don't see .trigger in the structure
> hdmi_codec_ops compared to the structure snd_soc_dai_ops?

You'd need to add a callback that the user of hdmi-codec passes in which
would be triggered by an event on a DAPM widget added in the audio path
rather than trying to shoehorn this into a PCM operation - a big part of
the problem here is that you're trying to add something that doesn't fit
into a PCM operation.

--w3piYtER9tAyOK42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOIxv8ACgkQJNaLcl1U
h9Ar2Af+KORDgtT/ighVT+gTBJm3oFdl9XsZhX6jFBIroRtVZqlgV0n2nL7IWrfL
oJQg0v/yecie2DMkQ5waSBz5RuFJktM6GkBBS21lztK1l/SpikqkDgNVAdiAEz10
FUldzHAK0zmjpp+jLHkJrATrzeMkJWDqyKXc7CVR6z8pStwYFJ9Ag6fkuKR7Y+CX
schrnd9I3hhtjcEfIG861/h8N9zVv2sRsG65nM4zjHFTMCWqxPwN8h2Ds7JialV7
gygMUpRaIdyoN79I/RllLk04yYtzQS3iVAS4KJevkYI/T9+zP3RLcuwSbzQJYdya
l5qY5/GtaQ3DiQVkOzLSxa4KfxCOmQ==
=fvZ3
-----END PGP SIGNATURE-----

--w3piYtER9tAyOK42--

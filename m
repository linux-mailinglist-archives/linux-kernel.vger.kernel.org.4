Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215F36F3909
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjEAUMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjEAULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:11:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E742122;
        Mon,  1 May 2023 13:11:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E938366031D1;
        Mon,  1 May 2023 21:11:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682971869;
        bh=E9+JAVIKOHUI/bC6kIDQQn55ysbLwtpFNYyDx0fneP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BhHXgX3o5ZSyzRWSJ5h07HbeIb+zUisczD5d39AM5bW85PBAIY9nd/57+HxVKCfYp
         c6dDkozSKoYu6YWaxk/I2/CZLTL8Ktbo0215IDromeXgp1qNXXJD+u+ldVwb8F4ItD
         MQUS9e3FaW92dhhqwWxb6hKToSDeadtGsq4fAuEIBSEBOE99cH5UlnR2Iz1PwIBqhu
         44UYzqvt4x8c3kTbiEHbdH7ZAu9PhRptO+EuRgK0LkfWEb2P1hgjQnCur0kBRqhshc
         TMdTVhdBGT9e6kMNl/CGpU1xDeSNFpv4ITUaGvGn6sWP40zpRD6LhSgMiwtgG7HoZm
         193YfHz8tvmMQ==
Message-ID: <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Mon, 01 May 2023 16:10:58 -0400
In-Reply-To: <20230426172539.GD2326@pendragon.ideasonboard.com>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
         <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
         <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
         <20230426003210.GA31260@pendragon.ideasonboard.com>
         <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
         <20230426163512.GE18120@pendragon.ideasonboard.com>
         <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
         <20230426172539.GD2326@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 26 avril 2023 =C3=A0 20:25 +0300, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> Hi Daniel,
>=20
> On Wed, Apr 26, 2023 at 06:14:33PM +0100, Daniel Almeida wrote:
> > Hi,
> >=20
> > As I said higher up on this thread, I can maintain the Rust bits and=
=20
> > help out with the issues around it.
> >=20
> > IMHO, we should at least try this. Who knows, it might work out :)
> >=20
> > Laurent, maybe we can take a piecemeal approach? Right now there are no=
=20
> > bindings for MC, but I wouldn't complain about fixing some of the C cod=
e=20
> > when the time comes.
>=20
> The lifetime issues affect plain V4L2 video nodes too I'm afraid :-)

Everything under the bindings is unsafe code, so it does not prevent doing =
upper
implementation and have other things be memory safe. It just make Rust less
helpful in some cases (I guess everything across ops).

There is low hanging fruit if some folks are interested. I see legitimate
benefit in rewriting in rust the JPEG parser, the H.264 reference list
generator, and maybe VP9 probability update lib. AV1 driver will need a lib=
 to
reduce duplicates, this could be done straight in Rust (offering a C interf=
ace
of course, so it does not matter if the users are written in rust or C).

Nicolas

>=20
> > Just FYI, I am writing some more bindings, just enough to write a=20
> > stateless decoder driver. I hope to finish it in time for the media=20
> > summit. It will give us a more in-depth idea of the pros and cons here.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20


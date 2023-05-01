Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5136F3913
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjEAUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEAUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:19:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B810F8;
        Mon,  1 May 2023 13:19:46 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAF8366031D1;
        Mon,  1 May 2023 21:19:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682972385;
        bh=pbrESEfekhsjMPolhasTcArmhhrFw3yLtkwB4eep2Ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RMZMcaTlhP2lDPfA/lTZbV/PM/UFX+xtS+iOz+gSZmo2XFfEBRQIevK2tEX1ASUxX
         ANv85eA8Bh+NAN8bpFuD+E2BuszL4xqToCqLbtCEyvsnfrmeG9+e9LJHI/MzFz7LTK
         uMt831pr7IIBUYFMQHC9qlDuhAkR5uApJ6wpwilHe8m4hDB9SUght+LLs+txr/Y966
         0JjSFzZZF/wNa/mBB03zKrf1h5kQLraG56XMBLMeiwiIF5J2qaThG1FmXKVF3LYvC6
         oz4erpCGrDc92fPnE6U6TpjEhgO/DYpS6zYQKacwVZFPPU6AvbSv4lIz7E1m8eN7LC
         Q/IYe4zMhY9Kw==
Message-ID: <75d9d50fd0e6858ee05a3f2799028b8dc846ec93.camel@collabora.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Asahi Lina <lina@asahilina.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
Date:   Mon, 01 May 2023 16:19:35 -0400
In-Reply-To: <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
         <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
         <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
         <20230426003210.GA31260@pendragon.ideasonboard.com>
         <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
         <20230426163512.GE18120@pendragon.ideasonboard.com>
         <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
         <20230426172539.GD2326@pendragon.ideasonboard.com>
         <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
         <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
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

Le mardi 02 mai 2023 =C3=A0 05:17 +0900, Asahi Lina a =C3=A9crit=C2=A0:
> On 02/05/2023 05.10, Nicolas Dufresne wrote:
> > Le mercredi 26 avril 2023 =C3=A0 20:25 +0300, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> > > Hi Daniel,
> > >=20
> > > On Wed, Apr 26, 2023 at 06:14:33PM +0100, Daniel Almeida wrote:
> > > > Hi,
> > > >=20
> > > > As I said higher up on this thread, I can maintain the Rust bits an=
d
> > > > help out with the issues around it.
> > > >=20
> > > > IMHO, we should at least try this. Who knows, it might work out :)
> > > >=20
> > > > Laurent, maybe we can take a piecemeal approach? Right now there ar=
e no
> > > > bindings for MC, but I wouldn't complain about fixing some of the C=
 code
> > > > when the time comes.
> > >=20
> > > The lifetime issues affect plain V4L2 video nodes too I'm afraid :-)
> >=20
> > Everything under the bindings is unsafe code, so it does not prevent do=
ing upper
> > implementation and have other things be memory safe. It just make Rust =
less
> > helpful in some cases (I guess everything across ops).
> >=20
> > There is low hanging fruit if some folks are interested. I see legitima=
te
> > benefit in rewriting in rust the JPEG parser, the H.264 reference list
> > generator, and maybe VP9 probability update lib. AV1 driver will need a=
 lib to
> > reduce duplicates, this could be done straight in Rust (offering a C in=
terface
> > of course, so it does not matter if the users are written in rust or C)=
.
>=20
> Unfortunately I don't think actually replacing the C implementations=20
> will be possible until Rust architecture support is on par with C, which=
=20
> probably means waiting until gccrs is ready...
>=20
> We could have both implementations until then (and only use the C one=20
> where Rust doesn't work), but the code duplication has an extra=20
> maintenance cost so it's not free. That's why people are mostly focusing=
=20
> on drivers first instead of core code.

Didn't know that, let's postpone this idea then.

thanks,
Nicolas

>=20
> ~~ Lina
>=20
>=20


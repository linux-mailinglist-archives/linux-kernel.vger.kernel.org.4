Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D832F64EB58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLPMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLPMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:21:59 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CBAB7F;
        Fri, 16 Dec 2022 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671193316; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REiZSsUqtIjm8SFyqWxbMTgSG0022DL41CRgq8WVFdw=;
        b=taa4hIlYqn7MLmaXHu1vURaZAmYN/Z4nCFJxJbMyR963j7DDT9rTE/nzL9rpCj3J1Ys/OS
        64s9MPE6g7Gxw1CIIjdZbE2DeiJ3kzfpnAMuaLX5ecqHCrnz9K/u4xM6+PIyaVZLCUa8wx
        2EehLkok5/6lrjXczYp5yJ3PG7/aiT0=
Message-ID: <d1f6d19d3218d9f1acc9b38e44af413f72f8a824.camel@crapouillou.net>
Subject: Re: [PATCH 01/10] dt-bindings: display: bridge: it66121: Add
 compatible string for IT6610
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Dec 2022 13:21:54 +0100
In-Reply-To: <bb2b5b72-42b3-3a6c-d865-9e338e34aba0@linaro.org>
References: <20221214125821.12489-1-paul@crapouillou.net>
         <20221214125821.12489-2-paul@crapouillou.net>
         <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
         <c78e92ae3cbea037abdd31ecd64e997c8dd1def2.camel@crapouillou.net>
         <bb2b5b72-42b3-3a6c-d865-9e338e34aba0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le vendredi 16 d=C3=A9cembre 2022 =C3=A0 12:21 +0100, Krzysztof Kozlowski a
=C3=A9crit=C2=A0:
> On 16/12/2022 11:46, Paul Cercueil wrote:
>=20
> > > > =C2=A0properties:
> > > > =C2=A0=C2=A0 compatible:
> > > > -=C2=A0=C2=A0=C2=A0 const: ite,it66121
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ite,it66121
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ite,it6610
>=20
> These should be ordered alphabetically. What's with the tendency of
> adding always to the end?

I'm too used to the "inverse christmas tree" sort :)

I can send a quickfix patch if you really want alphabetical order.

> > > >=20
> > > > =C2=A0=C2=A0 reg:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > --
> > > > 2.35.1
> > > >=20
> > >=20
> > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> >=20
> > Series applied to drm-misc-next.
> >=20
> I wished you give DT maintainers a bit more time than two days.

Noted. Sorry about that.

Cheers,
-Paul

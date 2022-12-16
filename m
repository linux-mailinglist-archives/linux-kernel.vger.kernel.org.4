Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54764E9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiLPKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiLPKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:46:34 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA0614E;
        Fri, 16 Dec 2022 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671187590; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csXYHnw/KgLTki+mcBGYXSrGC78KzWSKoY0JKsxj6gc=;
        b=KSdYCNv6j6I7YSsfN07giHrg/o64EqcwqsHYSX5BNtRbZfZLbtg5EY+ztrNOlGovwoyyuO
        kVZ2amMCSBnE4/TRjIYQgsEgiSHmJBNqNIpQBKVU9fJvFgFvfBfnEOtdvE89hiPxSeR0Vj
        jlRz4XfqGW+UNQCwRStXdzJ5zIpCKCk=
Message-ID: <c78e92ae3cbea037abdd31ecd64e997c8dd1def2.camel@crapouillou.net>
Subject: Re: [PATCH 01/10] dt-bindings: display: bridge: it66121: Add
 compatible string for IT6610
From:   Paul Cercueil <paul@crapouillou.net>
To:     Robert Foss <robert.foss@linaro.org>
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
Date:   Fri, 16 Dec 2022 11:46:28 +0100
In-Reply-To: <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
References: <20221214125821.12489-1-paul@crapouillou.net>
         <20221214125821.12489-2-paul@crapouillou.net>
         <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
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

Le jeudi 15 d=C3=A9cembre 2022 =C3=A0 11:55 +0100, Robert Foss a =C3=A9crit=
=C2=A0:
> On Wed, 14 Dec 2022 at 13:58, Paul Cercueil <paul@crapouillou.net>
> wrote:
> >=20
> > Add a new ite,it6610 compatible string to the IT66121 binding
> > documentation, since the two chips are very similar.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0.../devicetree/bindings/display/bridge/ite,it66121.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4
> > +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> > b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> > index 1b2185be92cd..72957be0ba3c 100644
> > ---
> > a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> > +++
> > b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> > @@ -17,7 +17,9 @@ description: |
> >=20
> > =C2=A0properties:
> > =C2=A0=C2=A0 compatible:
> > -=C2=A0=C2=A0=C2=A0 const: ite,it66121
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ite,it66121
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ite,it6610
> >=20
> > =C2=A0=C2=A0 reg:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > --
> > 2.35.1
> >=20
>=20
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Series applied to drm-misc-next.

Thanks for the reviews!

Cheers,
-Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDB62E076
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiKQP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiKQP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:56:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EAC769D9;
        Thu, 17 Nov 2022 07:56:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6DCE1929;
        Thu, 17 Nov 2022 16:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668700595;
        bh=KPO+OjnefHJI5WTgv+SZ55f7fYrJUjWGP+l48eabV7k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nptFuSPPTAVQ46xpdmJAI6lO2pltlzZeXouyRe/ZehR1pNs+CNGVcO4NHXQMMQ5pM
         gk8i7zpF0GjJP3QoY3zf0yq4RUJxlz+C84bJnqi7n3LrXoXXpd1JXUcwTXeh2bms03
         AgDFaZj1M3t7C01W+g9osa9aOiya5/HbQzXKdvT8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8d848493-24a8-4ffb-239e-9e7baa232a42@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com> <20221117122547.809644-8-tomi.valkeinen@ideasonboard.com> <166869996543.50677.17182739414507530884@Monstersaurus> <8d848493-24a8-4ffb-239e-9e7baa232a42@ideasonboard.com>
Subject: Re: [PATCH v1 7/8] drm: rcar-du: dsi: Add r8A779g0 support
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date:   Thu, 17 Nov 2022 15:56:32 +0000
Message-ID: <166870059260.50677.7640208301376893584@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomi Valkeinen (2022-11-17 15:49:36)
> On 17/11/2022 17:46, Kieran Bingham wrote:
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (setup_info->hsfreq <=3D MHZ(1000))
> >> +               ret =3D WRITE_PHTW(0x01020100, 0x01910170, 0x01020171,
> >> +                                0x01110172);
> > The <=3D1Gbps reads:
> >=20
> > <=3D1Gbps
> >=20
> > Set PHTW=3DH=E2=80=9901020100
> > Set PHTW=3DH=E2=80=9901010172
> > Set PHTW=3DH=E2=80=9901570170
> > Set PHTW=3DH=E2=80=9901060171
> > Set PHTW=3DH=E2=80=9901110172
> >=20
> > Is it clear why theres a difference here?
>=20
> What doc is that? Mine (R19UH0172EJ0054 Rev.0.54) says:

Hrm ... mine is R19UH0172EJ0051 ... So I guess I'm on an outdated
datasheet.

Which leaves me pondering if I should just wave my hand over my eyes and
add a tag ... (Or see if I can dig up the later datasheet) ;-)

--
Kieran


>=20
> Set PHTW=3DH=E2=80=9901020100
> Set PHTW=3DH=E2=80=9901910170
> Set PHTW=3DH=E2=80=9901020171
> Set PHTW=3DH=E2=80=9901110172
>=20
>   Tomi
>

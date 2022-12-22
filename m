Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B8653D44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiLVJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLVJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:03:43 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A3520998;
        Thu, 22 Dec 2022 01:03:40 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 29F8840010;
        Thu, 22 Dec 2022 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671699819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXGEgSRQtOF83p3PJb6wzT3SiQ4MMLvkHWipGGIuwXw=;
        b=OcJE8ze0QVLfDQunjRgATPRolml1Xl4LQzEsd5b3i8fl7y3eJ2Da15oo1hS+RRS+xRSnV2
        H7OCEdYPwWxUWk0lPxDDA+TeezJkck/Jh0aX1DNVEikjWghaRtzU2DH8lpW+9upLNHat0v
        RZmbcMS/WZrNYK4NaQZfCgxlzdc1RicTUGZtpFV1xbnYgzTIhnO5Vaf4A0NvzrWWBABcf1
        HUeWGqYTaAq9YyU+JgLSJkPx5fEccJ4a9J1WGODPhocNFv+hjNOhxL+86ICn+quCU28hB7
        jwXrN1+1by76KpLEMBfMVWEGShgRsW5YrYw5HBaAzVLZp0nhPBqo7GLpAod8fw==
Date:   Thu, 22 Dec 2022 10:03:34 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 01/21] dt-bindings: display: tegra: add Tegra20 VIP
Message-ID: <20221222100334.4ac85afa@booty>
In-Reply-To: <38c7cfe0-62e0-066a-d8dd-4ed4243a552e@gmail.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-2-luca.ceresoli@bootlin.com>
 <20221201231936.GB1660613-robh@kernel.org>
 <20221202091108.5f492d6f@booty>
 <38c7cfe0-62e0-066a-d8dd-4ed4243a552e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Tue, 20 Dec 2022 23:13:05 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 02.12.2022 11:11, Luca Ceresoli =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

...

> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-=
vip.yaml
> >>> @@ -0,0 +1,63 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-vip.=
yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: NVIDIA Tegra VIP (parallel video capture) controller
> >>> +
> >>> +maintainers:
> >>> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - nvidia,tegra20-vip
> >>> +
> >>> +  "#address-cells":
> >>> +    const: 1
> >>> +
> >>> +  "#size-cells":
> >>> +    const: 0
> >>> +
> >>> +  channel@0:   =20
> >> Kind of odd there is only 1 channel with a unit-address. Are more=20
> >> channels coming? Please make the binding as complete as possible even =
if=20
> >> no driver support yet. =20
> > This was discussed in v1 with Krzysztof and the outcome was that it's
> > OK because it's likely that other SoCs have more, but the documentation
> > is not public so I cannot add examples.
> >=20
> > Full discussion (pretty short indeed):
> >=20
> > https://lore.kernel.org/linux-devicetree/5292cc1b-c951-c5c5-b2ef-c154ba=
f6d7fd@linaro.org/
> >=20
> > Do you agree that the unit-address should be kept? =20
>=20
> It's doubtful that there is a SoC having a VIP with multiple channels.
> I'd expect it to be multiple VIPs rather than channels. There are NVIDIA
> people to confirm that.
>=20
> The "channel" itself looks redundant to me, i.e. the reg and ports
> should be moved to the vip node.

OK, will do in v3 unless there are different opinions.

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

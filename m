Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2D639E56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiK1ABi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiK1ABg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:01:36 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9313DFEA;
        Sun, 27 Nov 2022 16:01:34 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 654EFC000C;
        Mon, 28 Nov 2022 00:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VS89U/kypPFF3AxfqB+uzbXHu9s2vfd+iAIBGMEb/UY=;
        b=a7/61TvhnFiWXmQ1m6DP+dm/7FMStuTFd4VAZ3hhQSCptJpQBEzhdPloAg53KehXMqmbNI
        hxROxzeL316wH5ivVQfBffPmkG7OkwVdwVbmHUAdPMF/r0O1lacMBsY8db8Ji8qPiT19ac
        ie5Ie6M7UXqS3lCMoJFzG6GNqsvlxEO7ERIMRqSiJpnpRm2qsfeFA0UvQv1GK6YGzB3rMS
        oQ/pess5uX9Kir+0mtrHwV8AHWaUt17ftg4iZ6EKmTymfHh3CwxwSOjlSZXrHPaVOBVfKX
        Kiwhsb+yEc84oBxyDhcqpqhk/2g6idCS7HrFAc4hq04JwswfIi1869QXqSmTZw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
In-Reply-To: <20220825122102.18634-1-pali@kernel.org>
References: <20220825122102.18634-1-pali@kernel.org>
Date:   Mon, 28 Nov 2022 01:01:31 +0100
Message-ID: <87zgcc7xr8.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Switch port 6 is connected to eth0, so add appropriate device tree node f=
or it.
>
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boo=
t/dts/armada-385-turris-omnia.dts
> index f655e9229d68..8215ffb6a795 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -463,7 +463,17 @@
>  				};
>  			};
>=20=20
> -			/* port 6 is connected to eth0 */
> +			ports@6 {
> +				reg =3D <6>;
> +				label =3D "cpu";
> +				ethernet =3D <&eth0>;
> +				phy-mode =3D "rgmii-id";
> +
> +				fixed-link {
> +					speed =3D <1000>;
> +					full-duplex;
> +				};
> +			};
>  		};
>  	};
>  };
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

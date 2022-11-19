Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F87630CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKSG4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:56:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1767AF41;
        Fri, 18 Nov 2022 22:56:10 -0800 (PST)
Received: from pyrite.rasen.tech (KD106154145051.au-net.ne.jp [106.154.145.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8A0C749;
        Sat, 19 Nov 2022 07:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668840968;
        bh=sDNUAGAkIzCDcXCi7GBDq63kkMWjkvQ6ooJCMrOl114=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9OL/S1mgZQoTuD7xGMnC5I2CIxg412BXR+zhxh2kPzfQIOmvNG/oK8heedYw248i
         L3NKGcvJymVv4OxtsP5pkNWd9iB2z+bdpk+aHfgUqp10lJ2A/D/edtc/R2wquYvdvT
         GM6lgGCXU/Z3ZeIDJyk8rLUSKri62SeTXkQP08ck=
Date:   Sat, 19 Nov 2022 15:55:25 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Message-ID: <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
> On 18/11/2022 10:39, Paul Elder wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Add an example to the rockchip-isp1 DT binding that showcases usage of
> > the parallel input of the ISP, connected to the CSI-2 receiver internal
> > to the i.MX8MP.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Missing SoB.

I don't quite understand. I see an SoB right there.

> 
> > ---
> >  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> 
> I don't know what do you demonstrate there... usage of endpoints? That's
> the only difference. Such usage is the same everywhere, nothing specific

I guess...? Doesn't the same argument apply against the px30 example too
then?

> to this example. You already have two examples, so I don't think this
> brings anything more.

We do have usage of this in imx8mp.dtsi and overlays for the ISP, but
those patches haven't been sent/merged yet, so in the meantime I think
there is value in providing an example here for the imx8mp.


Thanks,

Paul

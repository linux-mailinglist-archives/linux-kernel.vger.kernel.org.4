Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8B630F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiKSQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:59:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CC11469;
        Sat, 19 Nov 2022 08:59:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82AE1749;
        Sat, 19 Nov 2022 17:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668877175;
        bh=5XR3sCqqEd6GXsl5hg+C3PS+jEEDwIW3YkQxbvVxj2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCmxTBRSYdoReX60CGoNzW4ohn53YH+q8JSuG6FI5bWL3JB6AP+yYOAm6VcSlPEmH
         VAtYy1JjCd/mfEdmIJO68PWEegiqp76oygvo1r4WPK1Sm/5siJ+6eKrmh7YDIJJZVM
         6hJ2earUZcyvIcy7IhVMCKC46nyx7QeGY1nngMZc=
Date:   Sat, 19 Nov 2022 18:59:19 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Message-ID: <Y3kLZ6nQ1VzN+2eu@pendragon.ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

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
> 
> > ---
> >  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> 
> I don't know what do you demonstrate there... usage of endpoints? That's
> the only difference. Such usage is the same everywhere, nothing specific
> to this example. You already have two examples, so I don't think this
> brings anything more.

The i.MX8MP is the only SoC integrating this ISP (and supported in
mainlineà that has an external CSI-2 receiver, as opposed to using the
CSI-2 receiver from the ISP. This patch this showcases the DT
integration for that use case. If you think it's not worth it, I'm fine
dropping it.

-- 
Regards,

Laurent Pinchart

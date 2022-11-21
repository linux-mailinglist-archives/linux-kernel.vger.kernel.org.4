Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351263195F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKUFJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKUFJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:09:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925C2BB0F;
        Sun, 20 Nov 2022 21:09:33 -0800 (PST)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53C3025B;
        Mon, 21 Nov 2022 06:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669007371;
        bh=vv1rZHG/fF4H9au2oTKj46t13Jo9FjmsThfxsJJVBT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYNntyABD1FshzHCGEeRY4rYzXD7jyuscNvi20SEFdpbFo/kG2YQrrBYuo8pyUhWn
         1Y8y99hGB9xsOOFpLBYi/iyNPd505Dm8I6yuvJFKE7eU7aPTsWRb2kYrOhdpbVkHqD
         viDX8BRMuIBqnDBUxb9h7plytGciuWjiXIBlsx14=
Date:   Mon, 21 Nov 2022 14:09:20 +0900
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
Message-ID: <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
> On 19/11/2022 07:55, Paul Elder wrote:
> > On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
> >> On 18/11/2022 10:39, Paul Elder wrote:
> >>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>
> >>> Add an example to the rockchip-isp1 DT binding that showcases usage of
> >>> the parallel input of the ISP, connected to the CSI-2 receiver internal
> >>> to the i.MX8MP.
> >>>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> Missing SoB.
> > 
> > I don't quite understand. I see an SoB right there.
> 
> Laurent did not sent it. Did you run checkpatch before sending?

That's why he's on the "From:" in the beginning. checkpatch says it's
fine.

> 
> > 
> >>
> >>> ---
> >>>  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
> >>>  1 file changed, 72 insertions(+)
> >>>
> >>
> >> I don't know what do you demonstrate there... usage of endpoints? That's
> >> the only difference. Such usage is the same everywhere, nothing specific
> > 
> > I guess...? Doesn't the same argument apply against the px30 example too
> > then?
> > 
> >> to this example. You already have two examples, so I don't think this
> >> brings anything more.
> > 
> > We do have usage of this in imx8mp.dtsi and overlays for the ISP, but
> > those patches haven't been sent/merged yet, so in the meantime I think
> > there is value in providing an example here for the imx8mp.
> 
> The examples are not for demonstrating imx8mp or any other soc, but this
> one given binding. Changing compatibles and few properties is not a
> different example - from "exampleness" point of view it is very similar.

Ah okay, I see.


Paul

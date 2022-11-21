Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D92631E95
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKUKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKUKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:38:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC476B9D1;
        Mon, 21 Nov 2022 02:38:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A18A74C;
        Mon, 21 Nov 2022 11:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669027127;
        bh=yeZSBCqwbYjMQuv/msGtJ0BPU2gfPl5QD+kMloVvPJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzRM0NU6+oZ8I4ezHpMzoAdmQFjm8BGJLwO876U/RwWp/hHZVcVlf4YtuDZWg/h4/
         I3EkriuBh4ME87KOy1ylOgkAZM1dJYZUVwhJPDBdXkBj/PH2fy4x1jHyOEon3/U9M9
         0RZkCcxC7D+cNMBfpuc+eualhISWokJARniGi18o=
Date:   Mon, 21 Nov 2022 12:38:32 +0200
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
Message-ID: <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
 <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
 <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:04:29AM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 06:09, Paul Elder wrote:
> > On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
> >> On 19/11/2022 07:55, Paul Elder wrote:
> >>> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 18/11/2022 10:39, Paul Elder wrote:
> >>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>
> >>>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
> >>>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
> >>>>> to the i.MX8MP.
> >>>>>
> >>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>
> >>>> Missing SoB.
> >>>
> >>> I don't quite understand. I see an SoB right there.
> >>
> >> Laurent did not sent it. Did you run checkpatch before sending?
> > 
> > That's why he's on the "From:" in the beginning. checkpatch says it's
> > fine.
> 
> Ah, indeed, checkpatch misses that feature (it's part of Greg's
> verify_signedoff.sh). Anyway, your SoB is missing, as Laurent did not
> send the patch.

I thought adding an SoB was only required either when making changes or
when pushing commits through git, not when forwarding patches on mailing
lists ?

-- 
Regards,

Laurent Pinchart

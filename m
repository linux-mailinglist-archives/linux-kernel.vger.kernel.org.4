Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B4063244E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKUNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKUNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:51:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280512AD1;
        Mon, 21 Nov 2022 05:51:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C063525B;
        Mon, 21 Nov 2022 14:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669038662;
        bh=XcBq95S/ocbQuYtsQHOYDFbxJwIk2fRPU1hrNjPp58I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGusc9FJWQGoQlouzveeNLYJT1esLk4+2LygTgaSF4PCQOADjMCo/lkh/ekneO5Xj
         gITFnM1s4tudLCGSP0mTi93dntA5ng8lK4FgOsFrF/8GWGEu6kONh7IaNn9z6NDyrk
         fYpK0ClzjsGO47wyoaxcgV1ixTCj7QtNoBSJO+Qs=
Date:   Mon, 21 Nov 2022 15:50:47 +0200
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
Message-ID: <Y3uCN59bBwTw6dc9@pendragon.ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
 <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
 <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
 <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
 <9389201b-22d4-1229-7e26-5f046d18e15f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9389201b-22d4-1229-7e26-5f046d18e15f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:16:41PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 11:38, Laurent Pinchart wrote:
> > On Mon, Nov 21, 2022 at 09:04:29AM +0100, Krzysztof Kozlowski wrote:
> >> On 21/11/2022 06:09, Paul Elder wrote:
> >>> On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 19/11/2022 07:55, Paul Elder wrote:
> >>>>> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 18/11/2022 10:39, Paul Elder wrote:
> >>>>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>>
> >>>>>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
> >>>>>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
> >>>>>>> to the i.MX8MP.
> >>>>>>>
> >>>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>
> >>>>>> Missing SoB.
> >>>>>
> >>>>> I don't quite understand. I see an SoB right there.
> >>>>
> >>>> Laurent did not sent it. Did you run checkpatch before sending?
> >>>
> >>> That's why he's on the "From:" in the beginning. checkpatch says it's
> >>> fine.
> >>
> >> Ah, indeed, checkpatch misses that feature (it's part of Greg's
> >> verify_signedoff.sh). Anyway, your SoB is missing, as Laurent did not
> >> send the patch.
> > 
> > I thought adding an SoB was only required either when making changes or
> > when pushing commits through git, not when forwarding patches on mailing
> > lists ?
> 
> Anyone touching the file should signed it off. You cannot send it
> without touching (e.g. git format-patch).
> 
> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L397
> 
> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L420

The second link states

  SoB chains should reflect the **real** route a patch took as it was
  propagated to the maintainers and ultimately to Linus, with the first
  SoB entry signalling primary authorship of a single author.

This series will (eventually) be upstreamed by me through a pull request
to Mauro. Paul's SoB will thus not be needed. Of course you have no way
to know this when reviewing the series on the list.

Adding a SoB line when taking a patch in a git tree is standard
practice, but when posting unmodified patches to a mailing list, there's
more of a grey area. Look at
https://lore.kernel.org/all/20221024113058.096628238@linuxfoundation.org/
for instance, posted by Greg, but without his SoB.

-- 
Regards,

Laurent Pinchart

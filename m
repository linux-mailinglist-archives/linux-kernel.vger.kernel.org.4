Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483496329F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKUQso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiKUQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:48:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9511A2A;
        Mon, 21 Nov 2022 08:48:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 748E774C;
        Mon, 21 Nov 2022 17:48:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669049315;
        bh=Buu4z2y6aKwKBfHAZWfbKpxETSilOenRkuojHxfPb3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebBdwQWygnOSxZ4W8qTskh6aD+iL0fW0xOVw57ry7V7zyy39hAsQWSP51EshnoGmN
         qyVLvmEoQUdeyMPaoBq7mjd+B/WZuxBPJEcRbWvF/lV3RU+F21aaBKpzZcfVowJsIk
         f1HStQ3B/DOd5xgNR+yOHm04U8zkAdZpzuh2soeI=
Date:   Mon, 21 Nov 2022 18:48:20 +0200
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Message-ID: <Y3ur1BAYGjU12UHG@pendragon.ideasonboard.com>
References: <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
 <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
 <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
 <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
 <9389201b-22d4-1229-7e26-5f046d18e15f@linaro.org>
 <Y3uCN59bBwTw6dc9@pendragon.ideasonboard.com>
 <bc9577d4-5aa2-625c-ec9c-e3db98130a46@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc9577d4-5aa2-625c-ec9c-e3db98130a46@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

(CC'ing Greg)

On Mon, Nov 21, 2022 at 05:37:33PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2022 14:50, Laurent Pinchart wrote:
> > On Mon, Nov 21, 2022 at 12:16:41PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/11/2022 11:38, Laurent Pinchart wrote:
> >>> On Mon, Nov 21, 2022 at 09:04:29AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 21/11/2022 06:09, Paul Elder wrote:
> >>>>> On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 19/11/2022 07:55, Paul Elder wrote:
> >>>>>>> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>> On 18/11/2022 10:39, Paul Elder wrote:
> >>>>>>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>>>>
> >>>>>>>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
> >>>>>>>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
> >>>>>>>>> to the i.MX8MP.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>>>>>
> >>>>>>>> Missing SoB.
> >>>>>>>
> >>>>>>> I don't quite understand. I see an SoB right there.
> >>>>>>
> >>>>>> Laurent did not sent it. Did you run checkpatch before sending?
> >>>>>
> >>>>> That's why he's on the "From:" in the beginning. checkpatch says it's
> >>>>> fine.
> >>>>
> >>>> Ah, indeed, checkpatch misses that feature (it's part of Greg's
> >>>> verify_signedoff.sh). Anyway, your SoB is missing, as Laurent did not
> >>>> send the patch.
> >>>
> >>> I thought adding an SoB was only required either when making changes or
> >>> when pushing commits through git, not when forwarding patches on mailing
> >>> lists ?
> >>
> >> Anyone touching the file should signed it off. You cannot send it
> >> without touching (e.g. git format-patch).
> >>
> >> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L397
> >>
> >> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L420
> > 
> > The second link states
> > 
> >   SoB chains should reflect the **real** route a patch took as it was
> >   propagated to the maintainers and ultimately to Linus, with the first
> >   SoB entry signalling primary authorship of a single author.
> > 
> > This series will (eventually) be upstreamed by me through a pull request
> > to Mauro. Paul's SoB will thus not be needed. Of course you have no way
> > to know this when reviewing the series on the list.
> > 
> > Adding a SoB line when taking a patch in a git tree is standard
> > practice, but when posting unmodified patches to a mailing list, there's
> > more of a grey area. Look at
> > https://lore.kernel.org/all/20221024113058.096628238@linuxfoundation.org/
> > for instance, posted by Greg, but without his SoB.
> 
> I have no clue what Paul modified here what not. I am not going to
> investigate and I have no way to actually perform such investigation. I
> cannot verify the source.
> 
> The case with Greg, is indeed surprising, but I could perform the
> verification, because the work is both public and in known place.
> 
> It's expected for submitter to certify (c) from the list which was BTW
> expressed also many times during many reviews by many people.

Given that this patch will be dropped anyway, it doesn't matter much in
this specific case, but for future reference, I've CC'ed Greg to get his
opinion on the matter.

-- 
Regards,

Laurent Pinchart

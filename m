Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC825BC58D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiISJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiISJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:37:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351425E83;
        Mon, 19 Sep 2022 02:37:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F652415;
        Mon, 19 Sep 2022 11:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663580247;
        bh=w1XptG6gnWG5qMJFr8lQ2cZDdLHVlAvcC5cflznsxfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNisYN/YVkoeYHIoAQ0NUs+nZb62EV63JbAzylzbuFNQkQTpIcIjM6MHoS7qxh3yO
         /RxA4jWl/GpiNRyMxh3ndQ6F+GoC8ISkP+lDWXO+y4Lcu0wr7Azda5gKAb4CmkZcTY
         WVpKGR1oJZMg3W5KFFUbl3wCHZVU5NpfH6FmLGbg=
Date:   Mon, 19 Sep 2022 12:37:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to
 video-interface-devices.yaml
Message-ID: <Yyg4SU7D5mClOvP/@pendragon.ideasonboard.com>
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com>
 <CA+V-a8vvNHFt818wryyuhWxPtay4czjWXiH=AWEKiJ1AzB46mA@mail.gmail.com>
 <fc1c075d-e20d-9395-d168-8cfe530f77ad@linaro.org>
 <CA+V-a8uMyU89rufmqWiGFqpVjFPvHBeVeSd1Wt07eWZo1X+Bgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8uMyU89rufmqWiGFqpVjFPvHBeVeSd1Wt07eWZo1X+Bgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:35:21AM +0100, Lad, Prabhakar wrote:
> On Mon, Sep 19, 2022 at 9:19 AM Krzysztof Kozlowski wrote:
> > On 19/09/2022 10:08, Lad, Prabhakar wrote:
> > > On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart wrote:
> > >> On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>>
> > >>> video-interface-devices.yaml isn't used so just drop it from the
> > >>> DT binding doc.
> > >>>
> > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
> > >>>  1 file changed, 3 deletions(-)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > >>> index 540fd69ac39f..ce99aada75ad 100644
> > >>> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > >>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > >>> @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
> > >>>  maintainers:
> > >>>    - Steve Longerbeam <slongerbeam@gmail.com>
> > >>>
> > >>> -allOf:
> > >>> -  - $ref: /schemas/media/video-interface-devices.yaml#
> > >>> -
> > >>
> > >> The rotation property listed in this binding uses the definition from
> > >> video-interface-devices.yaml. I don't think just dropping this is the
> > >> right solution. Changing additionaProperties to unevaluatedProperties
> > >> seems a better option.
> > >
> > > Agreed, I missed rotation was used from video-interface-devices.yaml.
> > > Agreed the changing additionaProperties to unevaluatedProperties seems
> > > a better option.
> >
> > The meaning of unevaluatedProperties:false would be here - accept other
> > properties (not mentioned here explicitly) from referenced schema. If
> > this is your actual intention for this binding, it makes sense. But if
> > the intention in this binding was to disallow these other properties,
> > then it would be wrong to change to unevaluatedProperties.
> >
> Thank you for the clarification. The intention is to disallow the property.

Why should they be disallowed ?

> > Therefore before sending patches and calling something better or not,
> > please instead focus on that aspect of referenced schema.
>
> Sure will do, sorry for the noise.

-- 
Regards,

Laurent Pinchart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984BC5BC9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiISKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiISKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:46:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF82DF1;
        Mon, 19 Sep 2022 03:33:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF22D9BA;
        Mon, 19 Sep 2022 12:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663583625;
        bh=SuwW1EyzgQFtHXnkLYtahgvyBMXNK3cFjQnbN2kJ/jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4/O/wcAZ+qraUEiBbOU/rymCJTkkfQ4cAj+iNBfH/hk0vtd/vp3c0CHepb84lLYv
         MkQGfJEqwQvg0rPtCLTmmq56WhZwXqnJoe4rNZ/DZ/bc5YScDJo+ghsBW4XGBAasPk
         +IiPU0AgyHrjBGQXvCYb3GgRgMFnj7Bz3zO36TmA=
Date:   Mon, 19 Sep 2022 13:33:31 +0300
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
Message-ID: <YyhFe+FW2C+R7nQg@pendragon.ideasonboard.com>
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com>
 <CA+V-a8vvNHFt818wryyuhWxPtay4czjWXiH=AWEKiJ1AzB46mA@mail.gmail.com>
 <fc1c075d-e20d-9395-d168-8cfe530f77ad@linaro.org>
 <CA+V-a8uMyU89rufmqWiGFqpVjFPvHBeVeSd1Wt07eWZo1X+Bgw@mail.gmail.com>
 <Yyg4SU7D5mClOvP/@pendragon.ideasonboard.com>
 <CA+V-a8uM=33jw_BE7S1G3DsvbUdvxUhkBty6VCWdAprQ288haw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8uM=33jw_BE7S1G3DsvbUdvxUhkBty6VCWdAprQ288haw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:41:00AM +0100, Lad, Prabhakar wrote:
> On Mon, Sep 19, 2022 at 10:37 AM Laurent Pinchart wrote:
> > On Mon, Sep 19, 2022 at 10:35:21AM +0100, Lad, Prabhakar wrote:
> > > On Mon, Sep 19, 2022 at 9:19 AM Krzysztof Kozlowski wrote:
> > > > On 19/09/2022 10:08, Lad, Prabhakar wrote:
> > > > > On Sun, Sep 18, 2022 at 12:06 AM Laurent Pinchart wrote:
> > > > >> On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> > > > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >>>
> > > > >>> video-interface-devices.yaml isn't used so just drop it from the
> > > > >>> DT binding doc.
> > > > >>>
> > > > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >>> ---
> > > > >>>  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
> > > > >>>  1 file changed, 3 deletions(-)
> > > > >>>
> > > > >>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > > >>> index 540fd69ac39f..ce99aada75ad 100644
> > > > >>> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > > >>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> > > > >>> @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
> > > > >>>  maintainers:
> > > > >>>    - Steve Longerbeam <slongerbeam@gmail.com>
> > > > >>>
> > > > >>> -allOf:
> > > > >>> -  - $ref: /schemas/media/video-interface-devices.yaml#
> > > > >>> -
> > > > >>
> > > > >> The rotation property listed in this binding uses the definition from
> > > > >> video-interface-devices.yaml. I don't think just dropping this is the
> > > > >> right solution. Changing additionaProperties to unevaluatedProperties
> > > > >> seems a better option.
> > > > >
> > > > > Agreed, I missed rotation was used from video-interface-devices.yaml.
> > > > > Agreed the changing additionaProperties to unevaluatedProperties seems
> > > > > a better option.
> > > >
> > > > The meaning of unevaluatedProperties:false would be here - accept other
> > > > properties (not mentioned here explicitly) from referenced schema. If
> > > > this is your actual intention for this binding, it makes sense. But if
> > > > the intention in this binding was to disallow these other properties,
> > > > then it would be wrong to change to unevaluatedProperties.
> > > >
> > > Thank you for the clarification. The intention is to disallow the property.
> >
> > Why should they be disallowed ?
> 
> my bad! "rotation" property is supposed to be allowed so the earlier
> comment to change to unevaluatedProperties holds good.

It's not just the rotation. The other properties are allowed too. For
the rotation property you need to list it explicitly in ovti,ov5640.yaml
if you want to restrict the values it can take, but other properties
from video-interface-devices.yaml for which no additional constraints
are needed don't need to be listed in ovti,ov5640.yaml.

additionalProperties and unevaluatedProperties are often misunderstood.
DT bindings are a set of rules, and validation will pass *only* if *all*
rules are valid. Let's consider the following:

allOf:
  - $ref: /schemas/media/video-interface-devices.yaml#

The allOf is valid if all of the elements in the list are valid. The
$ref will essentially work as if the contents of
video-interface-devices.yaml were copied in ovti,ov5640.yaml, under the
corresponding allOf list entry (with a small but important difference,
noted below). The file contains

  rotation:
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [ 0, 90, 180, 270 ]

so any "rotation" property in the device tree will be validated against
this. ovti,ov5640.yaml also has

properties:
  rotation:
    enum:
      - 0
      - 180

which is a separate rule from the previous one. Both must be valid for
validation to succeed, so this second rule essentially restricts the
possible rotation values.

The additionalProperties and unevaluatedProperties affect how properties
that have no validation rule will be treated.

With additionalProperties set to false, a property that has no
validation rule in *this* schema will be considered invalid, even if it
has a validation rule in another schema (either selected automatically
through a "select" property in the other schema, or imported through an
explicit $ref). So, in this particular example, even though
video-interface-devices.yaml has, for instance, a rule for the
lens-focus property, a DT that contains lens-focus will be considered as
invalid as lens-focus is not validated by this schema. One way to allow
the property would be to add

properties:
  lens-focus: true

in this schema. The contents of lens-focus would be validated by the
rule in video-interface-devices.yaml, and the rule in this schema would
always be valid ("true" is always valid).

Another way to allow the property would be to replace
additionalProperties with unevaluatedProperties. When set to false,
unevaluatedProperties makes validation fail if any property has not been
evaluated by *any* rule in this schema or any other schema. As
lens-focus would be evaluated by video-interface-devices.yaml, that
would be enough to consider it valid. This also means that *all*
properties listed in video-interface-devices.yaml would then be valid.
If you wanted that behaviour, but also wanted to reject specific
properties, you could add

properties:
  lens-focus: false

in this schema. A lens-focus property in a DT would be valid when
evaluated with the corresponding rule in video-interface-devices.yaml,
but would be invalidated by the rule in this schema as "false" is always
invalid.

To conclude, setting additionalProperties to false creates a white
listing mechanism that requires you to explicitly list in this schema
all the properties you consider as valid with "foo: true", while setting
unevaluatedProperties to false creates a black listing mechanism that
requires you to explicitly list in this schema all the properties you
consider as invalid with "foo: false". If multiple schemas that apply to
the same device tree include rules for the same property, all those
rules need to be valid for validation to pass, regardless of the value
of additionalProperties and unevaluatedProperties.

-- 
Regards,

Laurent Pinchart

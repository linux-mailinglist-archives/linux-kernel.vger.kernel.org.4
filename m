Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6176771D5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjAVTZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:25:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53DE113FE;
        Sun, 22 Jan 2023 11:25:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12223308;
        Sun, 22 Jan 2023 20:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674415542;
        bh=Oph7g8Jr3es8tneNymWiMud1KkYuS0t7BnGJ8J13xS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiJ+jZtxte8kYS3L1y9GFXK0N6rsXmil97r0shPyR1aHz5xicUpnzbpvtI9xNUGv1
         bh8Btg75s0xrXJE8hALH3uW9HIOj6Ii/wMdMsHmWOtceorHCrX1ewoKblAcEME37l6
         ZN44Tmx0/420IQLhYV2R/ygGFXXjOr90J4hMow/E=
Date:   Sun, 22 Jan 2023 21:25:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Message-ID: <Y82NtJCtr+CZgS9k@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
 <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
 <Y8bFjhHkbNAKQK3t@pendragon.ideasonboard.com>
 <c2740d66-b51f-efc2-6583-a69bde950c68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2740d66-b51f-efc2-6583-a69bde950c68@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jan 17, 2023 at 06:01:27PM +0100, Krzysztof Kozlowski wrote:
> On 17/01/2023 16:58, Laurent Pinchart wrote:
> > On Tue, Jan 17, 2023 at 04:42:51PM +0100, Krzysztof Kozlowski wrote:
> >> On 17/01/2023 16:26, Laurent Pinchart wrote:
> >>>
> >>>> +
> >>>> +          clock-lanes:
> >>>> +            description: VIIF supports 1 clock line
> >>>
> >>> s/line/lane/
> >>>
> >>>> +            const: 0
> >>>
> >>> I would also add
> >>>
> >>>           clock-noncontinuous: true
> >>>           link-frequencies: true
> >>>
> >>> to indicate that the above two properties are used by this device.
> >>
> >> No, these are coming from other schema and there is never need to
> >> mention some property to indicate it is more used than other case. None
> >> of the bindings are created such way, so this should not be exception.
> > 
> > There are some bindings that do so, but that may not be a good enough
> > reason, as there's a chance I wrote those myself :-)
> > 
> > I would have sworn that at some point in the past the schema wouldn't
> > have validated the example with this omitted. I'm not sure if something
> > changed or if I got this wrong.
> 
> You probably think about case when using additionalProperties:false,
> where one has to explicitly list all valid properties. But not for
> unevaluatedProperties:false.

Possibly, yes.

> > video-interfaces.yaml defines lots of properties applicable to
> > endpoints. For a given device, those properties should be required
> 
> required:
>  - foo
> 
> > (easy, that's defined in the bindings), optional,
> 
> by default (with unevaluatedProperties:false)
> or explicitly mention "foo: true (with additionalProperties:false)
> 
> >  or forbidden. How do
> 
> foo: false (with unevaluatedProperties:false)
> or by default (with additionalProperties:false)

I think we should default to the latter. video-interfaces.yaml contains
lots of properties endpoint properties, most bindings will use less than
half of them, so having to explicitly list all the ones that are not
used with "foo: false" would be quite inconvenient. Furthermore, I
expect more properties to be added to video-interfaces.yaml over time,
and those shouldn't be accepted by default in existing bindings.

> > we differentiate between the latter two cases ?

-- 
Regards,

Laurent Pinchart

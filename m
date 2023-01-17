Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E594C66E2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjAQP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAQP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:58:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0317151;
        Tue, 17 Jan 2023 07:58:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B262910C;
        Tue, 17 Jan 2023 16:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673971086;
        bh=XZE3G9TS80wVZg3WcP2Jc9pBzQBCofOPu3oK/7cnRi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYKgE+74M7XQ88YNoHabmqs+fJspvtKUSOiRaJfB4bZDZlv8yILd6nn5WtxzL1ksX
         rFac8u4C6Ut4hxbhXOn6ZVT7mHFudKYdt/1koTZmYqlQYNxrH2bvHzqhu+e0rz9/B/
         S0okyZhDYXsNgw+Df5GBxFlHXU8iUSHGLBunPJ0w=
Date:   Tue, 17 Jan 2023 17:58:06 +0200
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
Message-ID: <Y8bFjhHkbNAKQK3t@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
 <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jan 17, 2023 at 04:42:51PM +0100, Krzysztof Kozlowski wrote:
> On 17/01/2023 16:26, Laurent Pinchart wrote:
> >
> >> +
> >> +          clock-lanes:
> >> +            description: VIIF supports 1 clock line
> > 
> > s/line/lane/
> > 
> >> +            const: 0
> > 
> > I would also add
> > 
> >           clock-noncontinuous: true
> >           link-frequencies: true
> > 
> > to indicate that the above two properties are used by this device.
> 
> No, these are coming from other schema and there is never need to
> mention some property to indicate it is more used than other case. None
> of the bindings are created such way, so this should not be exception.

There are some bindings that do so, but that may not be a good enough
reason, as there's a chance I wrote those myself :-)

I would have sworn that at some point in the past the schema wouldn't
have validated the example with this omitted. I'm not sure if something
changed or if I got this wrong.

video-interfaces.yaml defines lots of properties applicable to
endpoints. For a given device, those properties should be required
(easy, that's defined in the bindings), optional, or forbidden. How do
we differentiate between the latter two cases ?

-- 
Regards,

Laurent Pinchart

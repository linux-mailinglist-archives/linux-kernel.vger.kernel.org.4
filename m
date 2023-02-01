Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C7686319
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBAJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjBAJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:46:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C73589;
        Wed,  1 Feb 2023 01:46:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (unknown [193.209.96.36])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 765BB505;
        Wed,  1 Feb 2023 10:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675244759;
        bh=ae5B3Tp2ry8b8G71s40ax+Ovn2zEm/amT6bkxrEQuxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foPZ/2HPjQSpoOqncY+pjjiigYN5eqgZ3CcVr/AHeSvrOVPPTbWYMDjX7G++JMu4L
         MB73dAt6eexFHleB/XQDlRNL0csmsQRoYpbmgpKxTVyKOKs1N24OFJzLIuLWpZ+re2
         xf9PLAxj3R38ar43TcZbh8wQrgcWZ1/H6oc/rybM=
Date:   Wed, 1 Feb 2023 11:45:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     krzysztof.kozlowski@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael.j.wysocki@intel.com, broonie@kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Message-ID: <Y9o01ctDujKRXw2J@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
 <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
 <d1bb1148-e273-f5bb-bccc-ceca82bb6836@linaro.org>
 <Y8bFjhHkbNAKQK3t@pendragon.ideasonboard.com>
 <c2740d66-b51f-efc2-6583-a69bde950c68@linaro.org>
 <Y82NtJCtr+CZgS9k@pendragon.ideasonboard.com>
 <TYAPR01MB6201BCC60149D17F59AD870E92D39@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYAPR01MB6201BCC60149D17F59AD870E92D39@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:06:25AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> On Monday, January 23, 2023 4:26 AM, Laurent Pinchart wrote:
> > On Tue, Jan 17, 2023 at 06:01:27PM +0100, Krzysztof Kozlowski wrote:
> > > On 17/01/2023 16:58, Laurent Pinchart wrote:
> > > > On Tue, Jan 17, 2023 at 04:42:51PM +0100, Krzysztof Kozlowski wrote:
> > > >> On 17/01/2023 16:26, Laurent Pinchart wrote:
> > > >>>
> > > >>>> +
> > > >>>> +          clock-lanes:
> > > >>>> +            description: VIIF supports 1 clock line
> > > >>>
> > > >>> s/line/lane/
> 
> Sorry for a late reply.
> I'll fix the description.
> 
> > > >>>
> > > >>>> +            const: 0
> > > >>>
> > > >>> I would also add
> > > >>>
> > > >>>           clock-noncontinuous: true
> > > >>>           link-frequencies: true
> > > >>>
> > > >>> to indicate that the above two properties are used by this device.
> > > >>
> > > >> No, these are coming from other schema and there is never need to
> > > >> mention some property to indicate it is more used than other case.
> > > >> None of the bindings are created such way, so this should not be exception.
> > > >
> > > > There are some bindings that do so, but that may not be a good
> > > > enough reason, as there's a chance I wrote those myself :-)
> > > >
> > > > I would have sworn that at some point in the past the schema
> > > > wouldn't have validated the example with this omitted. I'm not sure
> > > > if something changed or if I got this wrong.
> > >
> > > You probably think about case when using additionalProperties:false,
> > > where one has to explicitly list all valid properties. But not for
> > > unevaluatedProperties:false.
> > 
> > Possibly, yes.
> > 
> > > > video-interfaces.yaml defines lots of properties applicable to
> > > > endpoints. For a given device, those properties should be required
> > >
> > > required:
> > >  - foo
> > >
> > > > (easy, that's defined in the bindings), optional,
> > >
> > > by default (with unevaluatedProperties:false) or explicitly mention
> > > "foo: true (with additionalProperties:false)
> > >
> > > >  or forbidden. How do
> > >
> > > foo: false (with unevaluatedProperties:false) or by default (with
> > > additionalProperties:false)
> > 
> > I think we should default to the latter. video-interfaces.yaml contains lots of
> > properties endpoint properties, most bindings will use less than half of them, so
> > having to explicitly list all the ones that are not used with "foo: false" would be
> > quite inconvenient. Furthermore, I expect more properties to be added to
> > video-interfaces.yaml over time, and those shouldn't be accepted by default in
> > existing bindings.
> > 
> 
> I caught up with this discussion after some exercise on JSON schema validator.
> I'll remove "unevaluatedProperties: false" at the "endpoint" and add "aditionalProperties: false" instead.
> Furthermore, I'll explicitly declare required properties (required: ["foo"]) and optional properties (properties: {foo: true}) for Visconti.
> Is this correct understanding?

Looks very good to me !

> Are these changes also applied to "port", which is the parent node of
> the "endpoint" ?

That shouldn't be needed, as the "port" node should only have "endpoint"
children and no other properties (except for reg, and possibly
#address-cells and #size-cells of course).

> > > > we differentiate between the latter two cases ?

-- 
Regards,

Laurent Pinchart

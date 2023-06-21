Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ECC738872
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjFUPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjFUPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:09:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0A2973;
        Wed, 21 Jun 2023 08:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C416157E;
        Wed, 21 Jun 2023 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F92C433C0;
        Wed, 21 Jun 2023 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687359787;
        bh=cj5yhAR91nw7nDMe8iEdIFGq0BXDEvdX0cKkwZiJH5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQrPLPisoBCXb19q0a1hpjdHYog/qR2Y2LcZ91Gn1a9RBhQIHAVSkQckFcpCrPViu
         tLCynOMdssyJG819Z0DaQtiNoPz0hbpq+bfCLUQyFZsGGChpgZl4hkvfiejuoLqT74
         xAayz9v536UWtIBqzkoL0aPEaFM5qVD9GDINffI893IS5f//+5Eyc9xcyFG0hzcq2W
         YvBXdAHy+EbBHSau+FQvDfYbJo/U8BWkk0NsXHDw6IKGXFu2CMNxvRpEQr5rNJa4+I
         MmNVbX823dh3iK5aG+1kHLtf+/ql4fALSN8HIbXEHvr6L+DYV0Iu9QtNApBGQYd1yR
         z7KYeCwoE/MDA==
Date:   Wed, 21 Jun 2023 16:03:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033
 compatible
Message-ID: <20230621150302.GF10378@google.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
 <20230602131009.260239-1-raymondhackley@protonmail.com>
 <20230621150141.GE10378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621150141.GE10378@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Lee Jones wrote:

> On Fri, 02 Jun 2023, Raymond Hackley wrote:
> 
> > Add devicetree binding for Richtek RT5033 Flash LED charge pump used for
> > camera flash LEDs.
> > 
> > Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > index 4d2ffe5fcfc7..37d2a93780ab 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> > @@ -20,6 +20,7 @@ properties:
> >    compatible:
> >      enum:
> >        - ocs,ocp8110
> > +      - richtek,rt5033-led
> 
> Why is "-led" appended on to this one and not the others?

It's unusual for me to have to dump through a bunch of hoops just to
read and then subsequently reply to mail.  Can you consider removing
whatever encryption you have enabled please?

-- 
Lee Jones [李琼斯]

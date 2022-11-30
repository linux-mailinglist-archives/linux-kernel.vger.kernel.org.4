Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59B63D545
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiK3MJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiK3MJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:09:52 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A86659A;
        Wed, 30 Nov 2022 04:09:51 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p0LuK-0005r4-P3; Wed, 30 Nov 2022 13:09:44 +0100
Date:   Wed, 30 Nov 2022 12:09:41 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.or,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: mediatek: add compatible
 string for MT7986 SoC
Message-ID: <Y4dIBW4Kped5klgD@makrotopia.org>
References: <136157bd1f94c64504f87ee2db6b3ed0a8dcc3de.1667254476.git.daniel@makrotopia.org>
 <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
 <cdc79d9b-7afe-1aaf-3692-171370abaa3c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc79d9b-7afe-1aaf-3692-171370abaa3c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:43:35PM -0400, Krzysztof Kozlowski wrote:
> On 31/10/2022 18:16, Daniel Golle wrote:
> > Add compatible string 'mediatek,mt7986-thermal' for V3 thermal unit
> > found in MT7981 and MT7986 SoCs.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > index 5c7e7bdd029abf..efc16ab5b22b5d 100644
> > --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> > @@ -13,6 +13,7 @@ Required properties:
> >    - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
> >    - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
> >    - "mediatek,mt7622-thermal" : For MT7622 SoC
> > +  - "mediatek,mt7986-thermal" : For MT7981 and MT7986 SoC
> 
> Then recommended is to have specific compatible followed by fallback (so
> 7986 followed by 7981)

I'm a bit confused about the order you are suggesting. It may seem
counter-intuitive, but MT7986 was released before MT7981, the thermal
units found in both SoCs seems to be exactly identical.
Or are you suggesting to list MT7981 first to maintain alphabetical
order? Because in terms of precedence, MT7986 has been there first, and
hence I'd list 7986 first, followed by 7981, ie. the opposite of the
order you were suggesting.


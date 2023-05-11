Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA76FFCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbjEKWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjEKWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:31:16 -0400
X-Greylist: delayed 1802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 15:31:15 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585692738;
        Thu, 11 May 2023 15:31:15 -0700 (PDT)
Received: from p200300ccff36df0080088350021b55c1.dip0.t-ipconnect.de ([2003:cc:ff36:df00:8008:8350:21b:55c1] helo=akair)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pxDpi-0005dY-Fw; Thu, 11 May 2023 23:28:18 +0200
Date:   Thu, 11 May 2023 23:28:12 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230511232812.067440cf@akair>
In-Reply-To: <eb4cf82d-f523-d5af-be18-25c37678a95a@linaro.org>
References: <20230405161908.4312-1-andreas@kemnade.info>
        <20230405161908.4312-2-andreas@kemnade.info>
        <eb4cf82d-f523-d5af-be18-25c37678a95a@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 6 Apr 2023 10:32:49 +0200
schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:

> On 05/04/2023 18:19, Andreas Kemnade wrote:
> > From: Andrew Davis <afd@ti.com>
> > 
> > Convert omap.txt to yaml.
> >   
> 
> 
> > +      - description: TI AM43 SoC based platforms
> > +        items:
> > +          - enum:
> > +              - compulab,am437x-cm-t43
> > +              - ti,am437x-gp-evm
> > +              - ti,am437x-idk-evm
> > +              - ti,am437x-sk-evm
> > +          - pattern: '^ti,am4372[26789]$'
> > +          - const: ti,am43
> > +
> > +      - description: TI AM57 SoC based platforms
> > +        items:
> > +          - enum:
> > +              - beagle,am5729-beagleboneai
> > +              - compulab,cl-som-am57x
> > +              - ti,am5718-idk
> > +              - ti,am5728-idk
> > +              - ti,am5748-idk
> > +          - pattern: '^ti,am57[0124][689]$'  
> 
> I don't think my comments were resolved. I asked if it is possible to
> make a board called "ti,am5718-idk" with "ti,am5749" or with
> "ti,am5708"?
> 
I am preparing a reduced version of this without all that pattern
matches where I do not know the intention the original author had. 

> What's more, you dropped several variations and compatibles against
> original binding (all the "dra") and it is not explained in commit msg
> at all.
>
ok, time to better compare it by scrips, Did not notice
the dra stuff  with am* in the other compatibles.

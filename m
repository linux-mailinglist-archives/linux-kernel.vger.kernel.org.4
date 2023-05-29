Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A21715122
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 23:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE2VyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2VyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 17:54:02 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA179C1;
        Mon, 29 May 2023 14:53:59 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id F023641D13A6;
        Mon, 29 May 2023 22:53:57 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Mon, 29 May 2023 22:53:57 +0100
Date:   Mon, 29 May 2023 22:53:57 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Conor Dooley <conor@kernel.org>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mips: Add bindings for TP-Link HC220
 G5 v1 board
Message-ID: <ZHUe9RJfweNBAU0K@bart.dudau.co.uk>
References: <84b31c59-81d3-c83d-ece9-a120b1cdcdd7@arinc9.com>
 <20230529150833.526084-1-liviu@dudau.co.uk>
 <20230529150833.526084-3-liviu@dudau.co.uk>
 <20230529-unhook-alone-1b1bd6e6a226@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529-unhook-alone-1b1bd6e6a226@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:00:20PM +0100, Conor Dooley wrote:
> Hey,

Hi Conor,

> 
> On Mon, May 29, 2023 at 04:08:33PM +0100, Liviu Dudau wrote:
> > Add bindings for the compatible string used for the TP-Link's
> > HC220 G5 V1 board, a wireless AP based on MT7621.
> > 
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> 
> Two process things:
> - Please run get_maintainer.pl against the current git tree - you seem
>   to have missed 2 of the 3 dt-bindings maintainers. I don't mind my
>   omission, but omitting Krzysztof means you're submitting patches based
>   on a tree that is over a year old.

Appologies for that, I should have check get_maintainer.pl rather than looking
at the output of git log for the file.

> - Please don't send a v2 in reply to the v1.

Sorry, I'm not sure why that makes any difference. Reason for sending it as a
reply was the fact that last conversation was more than two weeks ago, people
might have forgot the context. This way it's all in one thread.

> 
> > ---
> >  Documentation/devicetree/bindings/mips/ralink.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mips/ralink.yaml b/Documentation/devicetree/bindings/mips/ralink.yaml
> > index 704b5b5951271..53c1f66353770 100644
> > --- a/Documentation/devicetree/bindings/mips/ralink.yaml
> > +++ b/Documentation/devicetree/bindings/mips/ralink.yaml
> > @@ -80,6 +80,7 @@ properties:
> >            - enum:
> >                - gnubee,gb-pc1
> >                - gnubee,gb-pc2
> > +              - tplink,hc220-g5-v1
> 
> For the actual change though,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Many thanks!

Best regards,
Liviu

> 
> Thanks,
> Conor.
> 
> >            - const: mediatek,mt7621-soc
> >  
> >  additionalProperties: true
> > -- 
> > 2.40.1
> > 



-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!

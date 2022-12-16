Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4D64F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiLPSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiLPSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:20:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F145EE8;
        Fri, 16 Dec 2022 10:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5536C621AA;
        Fri, 16 Dec 2022 18:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F8BC433D2;
        Fri, 16 Dec 2022 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671214803;
        bh=XJRSfk22JZgMqXQPH616mnIhKLshIHqsCy7W5QF7xdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFvzedjpvlrkahBFBC1rDla77a+0CMtwCZh65zXE3prE89ZyDdIWNj41/veGDPVpz
         WZArvKOOBfGtvr6GDnARlxX6w3LsgmpTcMhDiR7BLFpt/oBtzrESdRVXbe4D0BYF1N
         Z2qIRma6lvHT4laX1KHytki4cANnvamppuTctSGIteRhoC5TsaSRl/huUF6T1KOWVz
         swJA2Bv+anxBFDJSrVDmyRFGJ/0oLAoYNajx9m658M0JqHlWdD/p0t06X7+p39qDH7
         xTeBJ55V5AmOW2QclU8RqCZyrULfbOwroZ4uyv16jIcC7/wFc/L69wgj8+srPY20jV
         gmYdgGFWb20fw==
Received: by pali.im (Postfix)
        id 297E5711; Fri, 16 Dec 2022 19:20:01 +0100 (CET)
Date:   Fri, 16 Dec 2022 19:20:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20221216182001.4zmdtuxo2vausdkk@pali>
References: <20220713200123.22612-1-pali@kernel.org>
 <20221009115658.to3yu7zs5iu2goh7@pali>
 <20221101224300.eswknzbcdg2ekchr@pali>
 <20221128181829.jcupiqv43vz2rgsg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128181829.jcupiqv43vz2rgsg@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Monday 28 November 2022 19:18:29 Pali Rohár wrote:
> PING?
> 
> On Tuesday 01 November 2022 23:43:00 Pali Rohár wrote:
> > PING?
> > 
> > On Sunday 09 October 2022 13:56:58 Pali Rohár wrote:
> > > Gregory: ping
> > > 
> > > On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> > > > Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> > > > Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> > > > indicate SoC in example.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > index f6d6642d81c0..d2ca008de266 100644
> > > > --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
> > > >  Boards using a SoC of the Marvell Armada 37xx family must carry the
> > > >  following root node property:
> > > >  
> > > > + - compatible: must contain "marvell,armada3700"
> > > > +
> > > > +In addition, boards using the Marvell Armada 3710 SoC shall have the
> > > > +following property before the previous one:
> > > > +
> > > >   - compatible: must contain "marvell,armada3710"
> > > >  
> > > >  In addition, boards using the Marvell Armada 3720 SoC shall have the
> > > > @@ -13,7 +18,7 @@ following property before the previous one:
> > > >  
> > > >  Example:
> > > >  
> > > > -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> > > > +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> > > >  
> > > >  
> > > >  Power management
> > > > -- 
> > > > 2.20.1
> > > > 

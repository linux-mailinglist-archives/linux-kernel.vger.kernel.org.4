Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425FE676C58
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjAVL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAVL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:29:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923D83F3;
        Sun, 22 Jan 2023 03:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72CF160BAA;
        Sun, 22 Jan 2023 11:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF52C433D2;
        Sun, 22 Jan 2023 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674386947;
        bh=N2sXMWqnTnUFiANEu1OptUBn5CtSB0lqvR4+U+YD8kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilsmf4IrMWxzIKjTK0EpCKbVD8X53vJRy31OotwuthiYwkdGxtLny8SzNhY1eyZxG
         fINTPEVK7diXqCU6o7ze1LcmbYiSZQQLN15k9R2TQeLk7yCS2QcVVH+/TQU/TYtJ47
         +tF+BACbEc2RdiH1YItV4HTEmBzPlFE6wwIW/06pRyxnkPiYThE37/FfZe9QHEnd8a
         YSyx1trliVAagleA7/PKgLrY82blTbvhxzK2vxcXj4WqwthJQwvVDKT6P/ffcNoKrv
         l8FsOTtjspStpxOrb6/BdLMyvU8WlzvmNWsYneJ8uQ6eEJFA29DYrpq9GFrsmVU7HD
         9rvBRzQ6Jeq3Q==
Received: by pali.im (Postfix)
        id 50CE593D; Sun, 22 Jan 2023 12:29:05 +0100 (CET)
Date:   Sun, 22 Jan 2023 12:29:05 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20230122112905.q5vtej3x66exmtc5@pali>
References: <20220713200123.22612-1-pali@kernel.org>
 <20221009115658.to3yu7zs5iu2goh7@pali>
 <20221101224300.eswknzbcdg2ekchr@pali>
 <20221128181829.jcupiqv43vz2rgsg@pali>
 <20221216182001.4zmdtuxo2vausdkk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216182001.4zmdtuxo2vausdkk@pali>
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

On Friday 16 December 2022 19:20:01 Pali Rohár wrote:
> PING?
> 
> On Monday 28 November 2022 19:18:29 Pali Rohár wrote:
> > PING?
> > 
> > On Tuesday 01 November 2022 23:43:00 Pali Rohár wrote:
> > > PING?
> > > 
> > > On Sunday 09 October 2022 13:56:58 Pali Rohár wrote:
> > > > Gregory: ping
> > > > 
> > > > On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> > > > > Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> > > > > Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> > > > > indicate SoC in example.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > > index f6d6642d81c0..d2ca008de266 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > > +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > > > > @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
> > > > >  Boards using a SoC of the Marvell Armada 37xx family must carry the
> > > > >  following root node property:
> > > > >  
> > > > > + - compatible: must contain "marvell,armada3700"
> > > > > +
> > > > > +In addition, boards using the Marvell Armada 3710 SoC shall have the
> > > > > +following property before the previous one:
> > > > > +
> > > > >   - compatible: must contain "marvell,armada3710"
> > > > >  
> > > > >  In addition, boards using the Marvell Armada 3720 SoC shall have the
> > > > > @@ -13,7 +18,7 @@ following property before the previous one:
> > > > >  
> > > > >  Example:
> > > > >  
> > > > > -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> > > > > +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> > > > >  
> > > > >  
> > > > >  Power management
> > > > > -- 
> > > > > 2.20.1
> > > > > 

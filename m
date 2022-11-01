Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924C615538
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiKAWnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA965CA;
        Tue,  1 Nov 2022 15:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D521A61742;
        Tue,  1 Nov 2022 22:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA8C433D6;
        Tue,  1 Nov 2022 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342583;
        bh=U9tmwv/8BigNKrG1r2IvKt6wM1HzeetbXBq0lOGELtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8TLeHRrvCVtdJxuEABS3Ctxh1nxRQQv31GekRy0b9dT8MplaWUmfQCtHIUwfGSVO
         t84aVF9S4L0vCME447/p7oxc/GXTSDorQqfU7JIsYrR199BcxupJgooj158TDNRHE3
         7I0HAD0PnszNdGe6Ep38u4PYBLcxszn3rJkI2cJmPyJyfJIupBab8iTMtLOih9kPTq
         /HHLFR+sojFMHd6+nkz4viwx/bWXedtP9JrScObG6VLGb9o5YMVzCu/D+M50YfMDxf
         DJ+7mBS/0Wiv7wSMMef7IXZIeO0ynC+wpYFhADdKgalQPxaDoJn26UOFd8wSybnj0b
         zk1t0QL4i4x5A==
Received: by pali.im (Postfix)
        id EEE2A7F8; Tue,  1 Nov 2022 23:43:00 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:43:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20221101224300.eswknzbcdg2ekchr@pali>
References: <20220713200123.22612-1-pali@kernel.org>
 <20221009115658.to3yu7zs5iu2goh7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009115658.to3yu7zs5iu2goh7@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Sunday 09 October 2022 13:56:58 Pali Rohár wrote:
> Gregory: ping
> 
> On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> > Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> > Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> > indicate SoC in example.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > index f6d6642d81c0..d2ca008de266 100644
> > --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> > @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
> >  Boards using a SoC of the Marvell Armada 37xx family must carry the
> >  following root node property:
> >  
> > + - compatible: must contain "marvell,armada3700"
> > +
> > +In addition, boards using the Marvell Armada 3710 SoC shall have the
> > +following property before the previous one:
> > +
> >   - compatible: must contain "marvell,armada3710"
> >  
> >  In addition, boards using the Marvell Armada 3720 SoC shall have the
> > @@ -13,7 +18,7 @@ following property before the previous one:
> >  
> >  Example:
> >  
> > -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> > +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> >  
> >  
> >  Power management
> > -- 
> > 2.20.1
> > 

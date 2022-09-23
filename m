Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B85E8601
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIWWon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA45149D23;
        Fri, 23 Sep 2022 15:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E438261D9C;
        Fri, 23 Sep 2022 22:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E2C433D7;
        Fri, 23 Sep 2022 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663973029;
        bh=qFw3gtSI53rN1M0JK72nncdGr0DvdFASqEBfhhCRrW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2aGxSJYYUNXBIFgjgngGU5/j5vxv0jhrYJExOkfRL/TYkVdWf+nZaq+QRiKU5RoL
         sFCnw3BTnZ0uQNpe/HFYIQMMp8f3yMn2YNfQnp1cBGyqzqRxECCTq0h/PRsYQcoenu
         d9pJj6v9LH4VFXFHSQKHhp+W/GutH6IP0u/mCEC/QjnBe87crjMToMAT0/KR+2Lnyq
         z9PW3BJx2gdzu6TPsoKIGcrYX31wClYGl/QB8q8VPOOccrpraLtndfX0J7TbRo3IQS
         EYGHNGl2KzgkE7bClC3ZYq5nyJxsrxlOtZHknfecXmmAd1ueEEmcGQm4Ty5bGC6VXQ
         g+RqBJTUFPuYA==
Received: by pali.im (Postfix)
        id 2D847742; Sat, 24 Sep 2022 00:43:46 +0200 (CEST)
Date:   Sat, 24 Sep 2022 00:43:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Orion codenames and
 archive homepage
Message-ID: <20220923224346.tgws4gxd5daoz2rm@pali>
References: <20220719080807.16729-1-pali@kernel.org>
 <20220817231208.42emdluzead2hweg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817231208.42emdluzead2hweg@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 August 2022 01:12:08 Pali Rohár wrote:
> On Tuesday 19 July 2022 10:08:07 Pali Rohár wrote:
> > Orion codenames are extracted from menuconfig ARCH_ORION5X and
> > old Orion homepage with 88F5182/88F5281 was found in web archive.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> PING?

PING?

> > ---
> > In archived homepage are also links to erratas and other Orion documents
> > but apparently webarchive does not have backup copy of it :-( and Marvell
> > already removed all documentation from their web sites :-(
> > ---
> >  Documentation/arm/marvell.rst | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> > index 2f41caa0096c..8540437f6a79 100644
> > --- a/Documentation/arm/marvell.rst
> > +++ b/Documentation/arm/marvell.rst
> > @@ -14,18 +14,20 @@ Orion family
> >  
> >    Flavors:
> >          - 88F5082
> > -        - 88F5181
> > -        - 88F5181L
> > -        - 88F5182
> > +        - 88F5181  a.k.a Orion-1
> > +        - 88F5181L a.k.a Orion-VoIP
> > +        - 88F5182  a.k.a Orion-NAS
> >  
> >                 - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
> >                 - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
> >                 - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
> >                 - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
> > -        - 88F5281
> > +        - 88F5281  a.k.a Orion-2
> >  
> >                 - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> > -        - 88F6183
> > +        - 88F6183  a.k.a Orion-1-90
> > +  Homepage:
> > +        https://web.archive.org/web/20080607215437/http://www.marvell.com/products/media/index.jsp
> >    Core:
> >  	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
> >    Linux kernel mach directory:
> > -- 
> > 2.20.1
> > 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64545615536
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKAWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAWmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C471CB3F;
        Tue,  1 Nov 2022 15:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424A76175D;
        Tue,  1 Nov 2022 22:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BCFC433D6;
        Tue,  1 Nov 2022 22:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342552;
        bh=caDhOOkdw7z53f05vO/AU3UZzOHNogK6zUKVe9TIHWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9+ZoH3rLB8ompGkwnmJ258fNTx3GkBSrxm4TRaZiVujXyHZYKJTG3IkOxWWgupWl
         WyWRgjMppktx+/G534Zl1GAkatKvTYUG873rFYn6tYI4tUcCbP8gfZVwR8Bdv4LocT
         dYnWGX9lvznYciDJ1Lq2pCe9rx/5UbFByJ263pDGMvYJWeV28nqm09c1ilavf8aYFT
         lFD1wzhYZ573nP+/1354yh0+hHrhQpcgZSTASXK8TLmtmAthYJsE3czeepGj2kVAnf
         zT3YQ5fnMNKH00QFoNhHi4InCjmWyqv1nlL5e64Z0SlFdRIhO6uXV6ULtOSGjbVQX8
         0uLtNFA5ph1RQ==
Received: by pali.im (Postfix)
        id 175207F8; Tue,  1 Nov 2022 23:42:30 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:42:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Orion codenames and
 archive homepage
Message-ID: <20221101224230.wbd37f7zbaueevkn@pali>
References: <20220719080807.16729-1-pali@kernel.org>
 <20220817231208.42emdluzead2hweg@pali>
 <20220923224346.tgws4gxd5daoz2rm@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923224346.tgws4gxd5daoz2rm@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 September 2022 00:43:46 Pali Rohár wrote:
> On Thursday 18 August 2022 01:12:08 Pali Rohár wrote:
> > On Tuesday 19 July 2022 10:08:07 Pali Rohár wrote:
> > > Orion codenames are extracted from menuconfig ARCH_ORION5X and
> > > old Orion homepage with 88F5182/88F5281 was found in web archive.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > PING?
> 
> PING?

PING?

> > > ---
> > > In archived homepage are also links to erratas and other Orion documents
> > > but apparently webarchive does not have backup copy of it :-( and Marvell
> > > already removed all documentation from their web sites :-(
> > > ---
> > >  Documentation/arm/marvell.rst | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> > > index 2f41caa0096c..8540437f6a79 100644
> > > --- a/Documentation/arm/marvell.rst
> > > +++ b/Documentation/arm/marvell.rst
> > > @@ -14,18 +14,20 @@ Orion family
> > >  
> > >    Flavors:
> > >          - 88F5082
> > > -        - 88F5181
> > > -        - 88F5181L
> > > -        - 88F5182
> > > +        - 88F5181  a.k.a Orion-1
> > > +        - 88F5181L a.k.a Orion-VoIP
> > > +        - 88F5182  a.k.a Orion-NAS
> > >  
> > >                 - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
> > >                 - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
> > >                 - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
> > >                 - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
> > > -        - 88F5281
> > > +        - 88F5281  a.k.a Orion-2
> > >  
> > >                 - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> > > -        - 88F6183
> > > +        - 88F6183  a.k.a Orion-1-90
> > > +  Homepage:
> > > +        https://web.archive.org/web/20080607215437/http://www.marvell.com/products/media/index.jsp
> > >    Core:
> > >  	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
> > >    Linux kernel mach directory:
> > > -- 
> > > 2.20.1
> > > 

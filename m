Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860863596A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiKWKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiKWKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:11:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B78CBA9;
        Wed, 23 Nov 2022 02:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62219B81EF8;
        Wed, 23 Nov 2022 10:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D7C433D6;
        Wed, 23 Nov 2022 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669197697;
        bh=dZ68XrAsFIvw0c6zalixMEiSvin0wpXKWe5COOYdqmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEKW0y4TH5+riy0/SE36Gkn4SiiCEesPdezlV5G4QMWKFV1ZdQwM6eNrfsXhp86/o
         Mj54csBqxy6D+AKmUBolY3RD3KOIFP/YcVoskQAPEGyhyZUtFaJq1te2eQuthcpvlG
         nbcchtjaIdaMhnU8oDyTckhhMKbBE6WGGKfv5XDk=
Date:   Wed, 23 Nov 2022 10:57:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] driver core: pass a const * into of_device_uevent()
Message-ID: <Y33ukqDN93tnwHX8@kroah.com>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
 <20221121094649.1556002-5-gregkh@linuxfoundation.org>
 <20221122212209.GA583854-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122212209.GA583854-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:22:09PM -0600, Rob Herring wrote:
> On Mon, Nov 21, 2022 at 10:46:49AM +0100, Greg Kroah-Hartman wrote:
> > of_device_uevent() does not modify the struct device * passed into it,
> > so make it a const * to enforce this.  Also the documentation for the
> > function was really wrong so fix that up at the same time.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/of/device.c       | 6 +++---
> >  include/linux/of_device.h | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Looks like I can take this one?

I need it for later patches I have coming that clean this up more.

But you can take it in your tree as well if you want to build on top of
it.

> The same could be done for several other functions in of/device.c.

That would be good!

thanks,

greg k-h

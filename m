Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B2740B08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjF1IVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:21:24 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:55981 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjF1IOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B4461268
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF33C433C0;
        Wed, 28 Jun 2023 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687937880;
        bh=S8Wnx/IT53QAQo9RGL0gNfuOTAJVnB2EnEPC7R/HagQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFGRcm0Kj67QNtImxiaM+kTQ1XWszes516ZfSlzF4dslae807FJ+Aop9FTbLDTF+D
         WQnnJiT6+aaunudhBbFQ3oQck7XVz28hPkplN6HHT85HT7haR6OUzRPoWqTdTGga1X
         u+3AEdNwoIKnLzadlQ30S0S5K1Uifx8d4lvCHfkM=
Date:   Wed, 28 Jun 2023 09:37:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: master-ast-cf: Add MODULE_FIRMWARE macro
Message-ID: <2023062834-graduate-untreated-204c@gregkh>
References: <20230616122040.1035518-1-juerg.haefliger@canonical.com>
 <2023062852-spirited-excitable-dabc@gregkh>
 <20230628092946.00958b2c@gollum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092946.00958b2c@gollum>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:29:46AM +0200, Juerg Haefliger wrote:
> On Wed, 28 Jun 2023 08:47:12 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Jun 16, 2023 at 02:20:40PM +0200, Juerg Haefliger wrote:
> > > The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> > > information via modinfo.
> > > 
> > > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > > ---
> > >  drivers/fsi/fsi-master-ast-cf.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> > > index 5f608ef8b53c..1316bfd121fe 100644
> > > --- a/drivers/fsi/fsi-master-ast-cf.c
> > > +++ b/drivers/fsi/fsi-master-ast-cf.c
> > > @@ -1441,3 +1441,5 @@ static struct platform_driver fsi_master_acf = {
> > >  
> > >  module_platform_driver(fsi_master_acf);
> > >  MODULE_LICENSE("GPL");
> > > +
> > > +MODULE_FIRMWARE(FW_FILE_NAME);  
> > 
> > No need for the extra blank line, right?
> 
> Guess not.
> 
>  
> > And what commit id does this fix?
> 
> 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
> 
> Want me to send a v2?

Please do and properly add the fixes line and the cc: stable line so
that it will get backported correctly.

thanks,

greg k-h

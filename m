Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE26691E30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjBJL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjBJL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:27:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAAA6952B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED84FB824B4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4160C433D2;
        Fri, 10 Feb 2023 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676028428;
        bh=LTFbltocprWjz4sI8ilXNaLEZuvVmtB6/iLgSrSZkgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3hmQcVO+KNLRHkPSP/GwoiakSHzHbNTStBAgdo607kzpIomNTOmCRkn5mhjv6+ru
         vmxjmN24N9uWxvOsGggsPiRWRFYrZUhTQowcB571ODKadCXfDXFs9ikZqdlje+HJBF
         7LYxBZTi3Qk8KH30Zixyer+1yME9dghMEVOxZG0w=
Date:   Fri, 10 Feb 2023 12:27:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com, aahit.gaba@hpe.com
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <Y+YqCX0t254S/xza@kroah.com>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
 <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:38:12AM +0800, Matt Hsiao wrote:
> On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> > On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > > From: Matt Hsiao <matt.hsiao@hpe.com>
> > > 
> > > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> > > servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> > > for porting the hpilo driver to OpenBSD.
> > > 
> > > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > > ---
> > > 
> > > Hello contributors in the CC list,
> > > 
> > > Thanks for your contributions to the hpilo driver. Please kindly review
> > > the license change and hopefully you would agree and approve it. Thanks!
> > > 
> > > Patch v2:
> > > ---------
> > > - Change MODULE_LICENSE to Dual MIT/GPL too
> > 
> > As I asked for on the v1 version (delayed email on my side), I need a
> > lawyer from HPE to sign off on this change as well.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Add HPE attorney Aahit Gaba to sign off.

You are responding to a 4 month old patch, which is long-gone from my
review queue.

greg k-h

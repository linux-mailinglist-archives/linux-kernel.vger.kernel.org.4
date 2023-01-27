Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED867DFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjA0JH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjA0JH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:07:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5431CF51
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F1161A3F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49479C433D2;
        Fri, 27 Jan 2023 09:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674810446;
        bh=ggZ34Exn3VzcyVQyTe1ONqfzfK2fcKFLcF2csgbgeNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrAMO5Q5DWo43+o5RiLqEsZ2HITbLmXNC2YfI6MCiVz19EXOO6mLZo/BuKAqMdax4
         UvsOQL+ulP98hGLzWi3K3+ag6roaJVlecad/eOQ9joXAWeZqV+xiNsmAc++trJUajI
         rSY+vJyMPqRGvi8wkoTkZPF3kI8ru7nL7vvk7bco=
Date:   Fri, 27 Jan 2023 10:07:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
Message-ID: <Y9OUS7Y57t0y0gx4@kroah.com>
References: <20221222220214.3688774-1-tomas.winkler@intel.com>
 <Y6VV5d/V4MKDz2Te@kroah.com>
 <CY5PR11MB6366515D2A965EEDEC77AF63EDF29@CY5PR11MB6366.namprd11.prod.outlook.com>
 <Y8lt1gmo9smOMXD7@kroah.com>
 <MN2PR11MB409305204A36872FEDAD2B82E5C99@MN2PR11MB4093.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB409305204A36872FEDAD2B82E5C99@MN2PR11MB4093.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:05:19PM +0000, Winkler, Tomas wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, January 19, 2023 18:21
> > To: Usyskin, Alexander <alexander.usyskin@intel.com>
> > Cc: Winkler, Tomas <tomas.winkler@intel.com>; Lubart, Vitaly
> > <vitaly.lubart@intel.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [char-misc-next] mei: gsc_proxy: add gsc proxy driver
> > 
> > On Wed, Dec 28, 2022 at 11:46:36AM +0000, Usyskin, Alexander wrote:
> > > >
> > > > Why a whole new subdirectory for a tiny 200 line file?
> > > >
> > > All drivers for devices on mei bus have private subdirectory.
> > > This one just modelled on the existing examples.
> > > If you say that this is not a good thing - can put it in the main mei directory.
> > 
> > Put it in the main mei directory, no need to split things up for no good
> > reason.
> > 
> 
> All mei sub drivers are in sperate directories, this driver is indeed tiny, but I do prefer consistency,
> In my view it is easier to maintain that way. 

Ok.

> I believe all the bellow stuff you've already discussed in ths thread,.
> https://lore.kernel.org/lkml/YkXdgQH1GWCitf0A@kroah.com/T/
> I guess all that was explained there, so no need to repeat.
> 
> We'll try to see what can be done to make it more robust and your comments are more than valid,
> but as the thread concludes probably the component framework needs to be addressed. 

Agreed, something needs to be done, you can't make these random
assumptions about the exact driver and device topology as that is not
how the driver model works at all (nor do you want it to work that way.)

thanks,

greg k-h

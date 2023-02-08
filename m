Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE968F49A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBHRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjBHRca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:32:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3A3251B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:32:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5CCE6173F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B93C433D2;
        Wed,  8 Feb 2023 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675877548;
        bh=pqfBKmMIe9Jov3y/NBY+FkieCEppKLBCyvo3Y8Fcthg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spt+LJHWJbQhL/XlxxO6e1yLLNMngPvMHZqUwQlCe/7D1tG4dQm7zUlTyTz2QRRkO
         SLY9RA3e2xIFoodSWawuZhYOZFbWpex1Sbf5+/MVo0g+GaUhVZTIPE7umxEM0VsTni
         6KlHfiOVmMYlQEXn9OL4ZgPTWcJ6O6vUw/8cyfsw=
Date:   Wed, 8 Feb 2023 18:32:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: Re: [Intel-gfx] [char-misc-next v3 0/2] mei: gsc proxy component
Message-ID: <Y+PcqXbUWewBqiJE@kroah.com>
References: <20230208142358.1401618-1-tomas.winkler@intel.com>
 <Y+PZI/mfxwSNmy8R@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PZI/mfxwSNmy8R@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:17:23PM -0500, Rodrigo Vivi wrote:
> On Wed, Feb 08, 2023 at 04:23:56PM +0200, Tomas Winkler wrote:
> > GSC Proxy component is used for communication between the
> > Intel graphics driver and MEI driver.
> > 
> > Daniele, please ack so that drm part can be merged via Greg's tree.
> 
> Cc: Daniele, since he was missing on this submission.
> 
> He raise concerns on getting this through another tree since he
> has a pending series that uses this interface here. The propagation
> at this point will take so long.
> 
> Could we do the other way around and get Greg's and your, Thomas',
> acks to merge this through our drm-intel trees?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

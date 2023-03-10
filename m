Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950826B3713
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCJHGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCJHGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:06:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CEFFA090
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1435660B2A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A2EC433EF;
        Fri, 10 Mar 2023 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678431995;
        bh=5MOUFWSnqIo6NjaZfs8HYPeTVyUcf2oJ5jGXV/iGSYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrIssav4U5Byc0TJei5AgQATvlt9VFzxr5LI32HJvsTOnSXG9VPObWz1wAbwP39Gp
         n92V7f2hqW/bQAe3Ob7oVU2DKYqwpe8ClpxvULRjpuqWfiWEfbTYeqRonozPhtOoNX
         j30Wzr+fh42Yc2xz4vF0Tqwof4yHfDyVx8y28zpE=
Date:   Fri, 10 Mar 2023 08:06:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>
Subject: Re: [PATCH v2 2/2] misc: smpro-errmon: Add dimm training failure
 syndrome
Message-ID: <ZArW+JvLTLn796Wx@kroah.com>
References: <20230228092010.1863419-1-quan@os.amperecomputing.com>
 <20230228092010.1863419-3-quan@os.amperecomputing.com>
 <ZAoR9EnGBAwGaF0l@kroah.com>
 <57a36c86-3d17-88fd-2ef1-ee4adcea1ce4@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a36c86-3d17-88fd-2ef1-ee4adcea1ce4@os.amperecomputing.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 07:20:56AM +0700, Quan Nguyen wrote:
> 
> 
> On 10/03/2023 00:05, Greg Kroah-Hartman wrote:
> > On Tue, Feb 28, 2023 at 04:20:10PM +0700, Quan Nguyen wrote:
> > > Adds event_dimm[0-15]_syndrome sysfs to report the failure syndrome
> > > to BMC when DIMM training failed.
> > > 
> > > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> > > ---
> > > v2:
> > >    + Change "to initialized" to "to initialize"            [Paul]
> > >    + Corrected kernel version to 6.3                  [Greg,Paul]
> > 
> > Sorry, but this is going to have to be 6.4 now.
> > 
> 
> Thanks Greg for the review,
> 
> So should I send another version for the patch with 6.3 to 6.4 correction ?

Yes please, for both, so I can queue them up now for the 6.4-rc1 merge
window.

thanks,

greg k-h

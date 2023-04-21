Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F76EA73C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjDUJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjDUJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:38:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 494AEAD37
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:38:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95871480;
        Fri, 21 Apr 2023 02:39:37 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2658C3F5A1;
        Fri, 21 Apr 2023 02:38:53 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:38:49 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue()
 invocation
Message-ID: <ZEJZqYfNbyrFkqWY@e120937-lin>
References: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
 <ZEJNU1om5IhQHB2J@e120937-lin>
 <20230421092742.jjr4gnkswj22yt76@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421092742.jjr4gnkswj22yt76@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:27:42AM +0100, Sudeep Holla wrote:
> On Fri, Apr 21, 2023 at 09:46:11AM +0100, Cristian Marussi wrote:
> > On Thu, Apr 20, 2023 at 09:33:49AM -1000, Tejun Heo wrote:
> > > scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
> > > Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
> > > interface and using 0 for @max_active for the default setting.
> > >
> 
> Thanks, good catch, very hard to notice.

Indeed :<

> 
> > 
> > Hi Tejun,
> > 
> > my bad I messed up the params in the call.
> >
> 
> Hi Cristian,
> 
> I think it deserves the fixes tag, right ?
> 
> Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")
> 

I though so, but as usual I am not sure what to do when we are fixing something
in the middle of a cycle... Raw support went in v6.3-rc1 and we are now in
v6.3-rc7, so if you want to pick this up now (as it seems the case) it will fix
the above yes, but it is anyway still on an unreleased kernel...so nothing really
to have to apply on any early stable kernels...buh..I dont know what is the rule,
but the Fix tag seems harmless ... so why not :D

Thanks,
Cristian

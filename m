Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4256EA6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjDUJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDUJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:27:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7797013E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:27:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 103581480;
        Fri, 21 Apr 2023 02:28:30 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559A13F5A1;
        Fri, 21 Apr 2023 02:27:45 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:27:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix incorrect alloc_workqueue()
 invocation
Message-ID: <20230421092742.jjr4gnkswj22yt76@bogus>
References: <ZEGTnajiQm7mkkZS@slm.duckdns.org>
 <ZEJNU1om5IhQHB2J@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEJNU1om5IhQHB2J@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 09:46:11AM +0100, Cristian Marussi wrote:
> On Thu, Apr 20, 2023 at 09:33:49AM -1000, Tejun Heo wrote:
> > scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
> > Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
> > interface and using 0 for @max_active for the default setting.
> >

Thanks, good catch, very hard to notice.

> 
> Hi Tejun,
> 
> my bad I messed up the params in the call.
>

Hi Cristian,

I think it deserves the fixes tag, right ?

Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")

-- 
Regards,
Sudeep

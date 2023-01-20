Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42E67536F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjATLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjATLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:31:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F11C6E1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:31:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C8E2F;
        Fri, 20 Jan 2023 03:32:39 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4A73F71A;
        Fri, 20 Jan 2023 03:31:57 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:31:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] drivers: base: cacheinfo: fix shared_cpu_map
Message-ID: <20230120113155.nsq3ufwlel3lznfl@bogus>
References: <20221219105132.27690-1-yongxuan.wang@sifive.com>
 <20221219105132.27690-2-yongxuan.wang@sifive.com>
 <9cfb3356-3e3b-e9f3-1e16-ff02790e5829@arm.com>
 <Y8p6ns/XNrk/CDww@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8p6ns/XNrk/CDww@kroah.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 20, 2023 at 12:27:26PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 21, 2022 at 10:00:39AM +0100, Pierre Gondois wrote:

[...]

> >
> > It seems there are 2 ';' above (same in the block below).
>
> Yes, the kernel test robot complains about this as well.
>
> It needs to be fixed before this change can be accepted.
>

Just FYI, v3 and v4 was posted and I have pulled v4 which includes all
the suggested changes. I will send a pull request with all cacheinfo and
associated changes later today. They have been in the next for a while, need
to tag them and send it to you.

--
Regards,
Sudeep

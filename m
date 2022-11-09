Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678016225FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKII6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKII6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:58:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 216297650;
        Wed,  9 Nov 2022 00:58:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A042C1FB;
        Wed,  9 Nov 2022 00:58:33 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865D23F73D;
        Wed,  9 Nov 2022 00:58:26 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:58:23 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scmi tree
Message-ID: <20221109085823.qixqq47z2fr7wivv@bogus>
References: <20221109092901.0c748a3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109092901.0c748a3e@canb.auug.org.au>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Nov 09, 2022 at 09:29:01AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scmi tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "debugfs_create_str" [drivers/firmware/arm_scmi/scmi-module.ko] undefined!
> 
> Caused by commit
> 
>   4ccdc880f1bb ("firmware: arm_scmi: Add core Raw transmission support")
> 
> I have used the scmi tree from next-20221108 for today.
> 

Sorry for that, and thanks for identifying and dropping it in -next.
I will drop the changes until we have fixed it.

-- 
Regards,
Sudeep

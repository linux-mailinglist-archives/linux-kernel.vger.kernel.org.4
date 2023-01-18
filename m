Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3755671C71
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjARMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjARMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:43:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5243A82;
        Wed, 18 Jan 2023 04:07:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432FF1477;
        Wed, 18 Jan 2023 04:08:18 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9A33F71A;
        Wed, 18 Jan 2023 04:07:33 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:07:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Len Brown <lenb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <20230118120731.jgsq4l7htwizlsp5@bogus>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <167404285593.885445.6219705651301997538.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167404285593.885445.6219705651301997538.b4-ty@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:55:59AM +0000, Sudeep Holla wrote:
> On Wed, 4 Jan 2023 19:30:23 +0100, Pierre Gondois wrote:
> > v2:
> >  - Applied renaming/formatting comments from v1.
> >  - Check CACHE_TYPE_VALID flag in pppt.c.
> > v3:
> >  - Applied Sudeep's suggestions (for patch 5/5):
> >    - Renaming allocate_cache_info() -> fecth_cache_info()
> >    - Updated error message
> >    - Extract an inline allocate_cache_info() function
> >  - Re-run checkpatch with --strict option
> > v4:
> >  - Remove RISC-V's implementation of init_cache_level() as not
> >    necessary.
> >  - Add patch: 'cacheinfo: Check 'cache-unified' property to count
> >    cache leaves' to increase the number of leaves at a cache level
> >    when no cache-size property is found.
> >  - In cacheinfo: Use RISC-V's init_cache_level() [...],
> >    make 'levels', 'leaves' and 'level' unsigned int to match
> >    of_property_read_u32()'s parameters signedness.
> > 
> > [...]
> 
> Applied to sudeep.holla/linux (for-next/cacheinfo), thanks!
> 

I pushed the changes and then noticed some build warning report by
kbuild posted only to you and one list(missing this list). Please post the
fix if required on top of my for-next/cacheinfo so that it can be added
on the top. Sorry for missing that.

-- 
Regards,
Sudeep

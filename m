Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C196B060B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCHLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:35:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D8E39DE05
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:35:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE981042;
        Wed,  8 Mar 2023 03:36:01 -0800 (PST)
Received: from bogus (unknown [10.57.16.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD7A3F71A;
        Wed,  8 Mar 2023 03:35:16 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:35:10 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pierre.gondois@arm.com,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "riscv: Set more data to cacheinfo"
Message-ID: <20230308113510.fb6y2xhylavkrgtl@bogus>
References: <20230308064734.512457-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308064734.512457-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:47:34PM +0800, Song Shuai wrote:
> This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.
> 
> There are some duplicate cache attributes populations executed
> in both ci_leaf_init() and later cache_setup_properties().
> 
> Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
> to setup only the level and type attributes at this early place.
>

I had noticed the same and had something similar when we did some rework
around for v6.1 merge window. But there were lot of other issues to be
addressed at the moment and hence deferred this.

So for the change in general, but as Conor responded, it would be good
to do some checking to ensure nothing breaks and all the requirements
this patch(baf7cbd94b56) addressed are already handled in the core.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

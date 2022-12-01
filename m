Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA763F6AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLARrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLARq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:46:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302FBBBEA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 524FAB81FC7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC88FC433D6;
        Thu,  1 Dec 2022 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669916740;
        bh=xi727nDNhDZVe/pLE/3xYfRh/jN3YKblRfCd6X5uJoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDOMZl4gjnlzxDB5VdRKSxJBTvTvOCxUXl0/kbnRsZmdOSmaBVxO71raoOhTLea72
         ylTadXG8ssFsRA0kSQLujmGpAx2rJJ8iFb609pGjsRy/4uBBV+bj0llHIZHj0iUzXG
         Xj6N7cys0Kb/Vco4SyfxJTP5lAOuvba0oc0I+BgVcim2vo4BbtOcb9wwjwYqNqgP//
         RWd9zMkrUvotuekWlTD831c+9b3NKdkX/icuLyzVDTHQT+jsnUYhgDjUboYszZB4C7
         mgG0kIsL32J7CCr0zEae6rmcF6pJG0TemdPZihyVWsDZUhHCCPtIMQJ/O4ZVo+k6kd
         lYDTZf8eoaGmQ==
Date:   Thu, 1 Dec 2022 17:45:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: Drop redundant armpmu->map_event() in
 armpmu_event_init()
Message-ID: <20221201174534.GA28865@willie-the-truck>
References: <20221130083350.264583-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130083350.264583-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:03:50PM +0530, Anshuman Khandual wrote:
> __hw_perf_event_init() already calls armpmu->map_event() callback, and also
> returns its error code including -ENOENT, along with a debug callout. Hence
> an additional armpmu->map_event() check for -ENOENT is redundant.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc6

Doesn't apply against for-next/perf

Will

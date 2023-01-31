Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3C682C34
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAaMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:06:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F83D0B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB81B81C01
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AC3C433D2;
        Tue, 31 Jan 2023 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166788;
        bh=6NvZwOTnmGtu06OJClq79zLqlK+qMM997UIwtzBa1rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh9OsXz25PRCuBcixfjmARbHu83f0+Z5Mlvk51qOtyCUYRy9qysNBeUsCVIOWE+6O
         f5V5qY4KG+0dAwTIDKUkGY7j8qCyyTSOZG6oiMYn5f9oEwCd3DuYlUafab/aAzLlfY
         tzkF4qnT+sZ7QHueEzDi8DMsTRg2PfYHMiy7YPu7Ie1/JiPvnuQoUiTa4TkElU9D+I
         s1c0jUcbtq0Rlk8+wJO+162qmBZjtgdzfLDj/Ghpzf4abDsAtyw4Y2sV+fMI1dcCt/
         B5FATRTtAmUqXA4sio22nMcgDidtgI6jmSsi+FKO2rFcvwzGsUPLYAhPxbmeuCF6Gc
         7VBTHEnrcJIjQ==
Date:   Tue, 31 Jan 2023 17:36:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 0/2] soundwire: Remove redundant zeroing of page
 registers
Message-ID: <Y9kEP+ozg8eyYLbS@matsya>
References: <20230123164949.245898-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164949.245898-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23, 16:49, Richard Fitzgerald wrote:
> Writing zero to the page registers after each message transaction can add
> up to a lot of overhead for codecs that need to transfer large amount of
> data - for example a firmware download.
> 
> There's no spec reason I can see for this zeroing. The page registers are
> only used for a paged address. The bus code uses a non-paged address for
> registers in page 0. It always writes the page registers at the start of
> a paged transaction.
> 
> If this zeroing was a workaround for anything, let me know and I will
> re-implement the zeroing as a quirk that can be enabled only when it is
> necessary.

Applied, thanks

-- 
~Vinod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEA63621C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiKWOmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiKWOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:42:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9196036C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C3A61D3C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF7C433D7;
        Wed, 23 Nov 2022 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214524;
        bh=7SNmcq1yWdkIA0Q3jpHfksHLwFfvTlR32HWw7nBmwo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUfiUx1ej1qzFn9VEbIewkkyyGFGC0dEp3Cx6CUVm2zuld2a6OeDfUYsYgnJIl4r8
         MF2BnzEOlHV2ELlxDW+8NS2+petzIuyaKYOMpYjpC8r9V1CVVZao/TZLaZB9jL0EnJ
         /42qUkmLB7Tdyx9UZ2vEh/K6ayCpkjuFce3twDDUL7NeX8XXadDzOtQADtP1XSYe+q
         wah4X0As+SHJVKqbGOoICOA11A5vvMeXVqDqLsSR/BlTPpS8696wrt27qJarz5M6wu
         NqzT5TnAQg1tZZNcHjD2Ph0tXLXMozm7V3oGYs55EYJydshJ0krXxeEp2F6OTf1pfU
         kWuElHUoYfG0A==
Date:   Wed, 23 Nov 2022 20:12:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/7] soundwire: intel: introduce hw_ops and move
 auxdevice handling to dedicated file
Message-ID: <Y34xON3Vtfm53CB6@matsya>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-22, 09:31, Bard Liao wrote:
> This series adds yet another set of cleanups
> a) all the helpers are now exposed as hw_ops callbacks
> b) the auxiliary device code is now completely generic.
> 
> This will allow for easier introduction of new hw_ops implementations in
> the future without throwing away all the goodness of the auxiliary device
> handling. Since there will be a tighter coupling with HDaudio, it's likely
> that future hw_ops are implemented in the SOF driver directly.

Applied, thanks

-- 
~Vinod

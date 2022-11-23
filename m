Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7926263622D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiKWOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiKWOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEA30544
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9BBE61B29
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133EC433C1;
        Wed, 23 Nov 2022 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214771;
        bh=yaH550cdeNMLNbXJl+DEdZNkNMeJwd/85Dz+Y32n6LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CxN1IEEzW35m0QAQc+KOd1OreLmacMFoy8EFfAjlmHKj/ei5Gg6xuqkfA7SXP30QL
         EY44Od0F6eAI0mgNm21PY8gG8VaAAxPCv/i9/EFWEPTHvT+KrwG6tQuB8jYMlZDbkc
         UWuSV+irVLFmhBHB0NU8Zg+VW/vKKzQS1Ej1t9MQ09srt0Hd64Y2CvOCSsy+SJwbs2
         e9ZtFo0bnX8kieQ/7whau3vAapRTqVR9HNgbn1ZtZspvvDPvpd8cF2NPLEWQIPZEFa
         QK9MxFOZWrJVMtmt2BauBS3s34VSqn0hBuDGrkW+09Z8ge3a9gCo+6Cv4pp7YKf26k
         Ild0AGseXTwjQ==
Date:   Wed, 23 Nov 2022 20:16:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 6/8] soundwire: intel_init: remove sdw_intel_enable_irq()
Message-ID: <Y34yL5DbEpkBLU1x@matsya>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
 <20221111042653.45520-7-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111042653.45520-7-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-22, 12:26, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The functionality is implemented with per-chip callbacks, there are no
> users of this symbol, remove the code.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

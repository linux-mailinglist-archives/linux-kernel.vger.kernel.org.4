Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03CE62231C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKIEaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKIEaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:30:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C9186D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 20:30:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC566187F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E48C433D6;
        Wed,  9 Nov 2022 04:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667968198;
        bh=Y+wsi+hfHTwgv/jg3RZnAaB0QuEulD67yzWdyluHBfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHp4fncYj/791czgAy7Zhx63V4mczDfCQWyPLPgCNVPnFGyUziNBdraBtGZnqT2jA
         x1BYpiHDh2hjMVd5HK6hyoq6bYlqc05HK1jlOnR4r+iRQ8XLUjQNPzhVURR4LS16yb
         Q7YPyvR7urHFnNXDVP8lWGYbEA65Z3MDyXj4DCM0BiG6UPXPtvh4dmZJPP9/tHJcaG
         euc2L3hSxKtQiO3zYnG9jjybTla2vxYlTLQ/YfKaa90jsRQFqE12ZAwG3HhSUX3D++
         GBWlUBlV3DywOpR98WKA84TSwhmJC8Z/z7Yeeq5MgYQMe7p4zoMuNpxqSWSXPCNudn
         Pm/M7F8IYF/qg==
Date:   Wed, 9 Nov 2022 09:59:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/2] soundwire: cadence: remove dma_data
Message-ID: <Y2sswmYa4cBBCuwV@matsya>
References: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-22, 10:35, Bard Liao wrote:
> The use of dma_data is problematic for two reasons for the Cadence IP.
> a) the dai runtime data has nothing to do with DMAs in existing solutions
> b) we will use the dma_data for DMA-management in the future. We cannot
> share two separate pieces of information with the same dma_data pointer.

Applied, thanks

-- 
~Vinod

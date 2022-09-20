Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115A95BDC20
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiITFJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiITFJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB26DF49
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E2E620AB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CC9C433C1;
        Tue, 20 Sep 2022 05:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650577;
        bh=Sil5eD1N0yyHn03NzhhguSSPBgP4iKuTPRDtA52b9jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCBLY3avFi0/hVkoQ4ByXgrn5Hk5pxG/Zp+pZCEEfWUHGy1Rgpkk/gCvwhxXS5bFS
         gMLoG96cKKAvw3qLIR5BuhcefMWr1gdtmKOCJwWOtFikGJSmxQcJp07bZZXdifDbxz
         qhbT0kaEgyjuh+GG8LvzYbz3a4mEeSLwrScYbqkRxnhJX1df9FHeV17UKETYoHUovJ
         MDQsKPopezyqXoNdaT7VuUz5lPL4UoWkkGGjGB1ZQG9rK3LoEZvRKRsfS9WhXzGccc
         EQisX4XWCGUbdels1MOYDKdFgPtXTQ/pVvrPDQTB6XHAjuLHIJJrCDTRKtK2bx/dmI
         UHc8JbTwvP1vg==
Date:   Tue, 20 Sep 2022 10:39:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 00/11] soundwire: intel: cleanups/fixes before code
 reorganization
Message-ID: <YylLDSjQgqHFnKbr@matsya>
References: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-22, 01:57, Bard Liao wrote:
> This is a really big cleanup to introduce well defined helpers, prior to
> a larger code reorganization.

Applied, thanks

-- 
~Vinod

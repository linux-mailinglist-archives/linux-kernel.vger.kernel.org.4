Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D6742795
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF2NlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjF2Nkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC630FA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716C561554
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C997AC433CA;
        Thu, 29 Jun 2023 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688046020;
        bh=TxOavPXw+8POPkiDSt/eNo8WZ/YgJm9JsoHOlxWJYCY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fOyr7gHwteA20BDlO0GXWre7OPGnaGlWDIgkQvZiZUyCmFLicskorC/pRCqnSLrNV
         Da2pqGmWcLrGrp/j5MZsEUqcgZVu2CgVQDBdh846NLIn4wQl7cTr+ju6iHjQ86llcE
         nXbIhv2aoY8Oe0snNIh4DFBhQ3+Md0uAo9/mSNmeki2kd6oN4xvpD2yboqiNZPZd8A
         YOMzKyJ7CXa72WFmeZUwDvQTMFEyIGamFbcjPq+rvEvEgjU40Z87IHYaGjs2vA4mcN
         dDVf5+jJNKCRRQP1+u24UsFLU/QeU6/FLQ3cuGswqtQ9ZpmKztC32EQ8elZPEJozFl
         YGobldzaj9itQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD9D5C395D8;
        Thu, 29 Jun 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168804602070.32686.5893039361315012662.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 13:40:20 +0000
References: <20230623151644.GA434468@sumitra.com>
In-Reply-To: <20230623151644.GA434468@sumitra.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        fmdefrancesco@gmail.com, drv@mailo.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 23 Jun 2023 08:16:44 -0700 you wrote:
> generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
> The GFP_KERNEL is typical for kernel-internal allocations.
> The caller requires ZONE_NORMAL or a lower zone for direct access.
> 
> Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
> no need to map it with kmap().
> 
> [...]

Here is the summary with links:
  - [v4] lib/test_bpf: Call page_address() on page acquired with GFP_KERNEL flag
    https://git.kernel.org/bpf/bpf-next/c/da1a055d01ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



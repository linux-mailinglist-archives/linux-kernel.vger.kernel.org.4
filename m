Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919971170F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbjEYTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbjEYTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00448A4E;
        Thu, 25 May 2023 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC9D64A8B;
        Thu, 25 May 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA11C433D2;
        Thu, 25 May 2023 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685041322;
        bh=/nHmfbW2TjMXmkkNUUIeO7lCCKl2hqVyaBxBf/SbfM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBXVu7GEqd4G5papzgh/zjF/sYRdPT8tJ/+IRFxulE8jwhEGBKUt9ElsUJuESFIjF
         2aK0REOpS5Sjot0kwYX1AvwJp9dOW/RfJJgUiLYu14NnRZslOQ+my8zSo78gP20xMH
         CGCxbaDVmRaB1YraLbg8xt3+ta0t6UyTBYO/GhjW0q1+yV9zqANrRm/q995RUqlWcs
         cH02Ep28k1Bfb9sWSHa8pD91hLlI1lZWvsklV6MUVa7zFUeSTA0lHUy7ztP6T8DxZa
         0gaFi+GKrE1jIytyq7Y3qetJai9I9zG9j866rFhwLCllsyzzIjRVwsKS7/pOAcxkMt
         eVRnJLq883ZrA==
Date:   Thu, 25 May 2023 19:02:01 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Andrey God <andreygod83@protonmail.com>,
        Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.3 01/67] nvme-pci: add NVME_QUIRK_BOGUS_NID for
 HS-SSD-FUTURE 2048G
Message-ID: <20230525190201.GA1266801@google.com>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

This feedback is on the whole 67-patch series.  I'm replying to patch 1 because
this series lacks a cover letter.  Please include a cover letter next time.

This series doesn't apply because the following error happens on patch 35:

    Applying: tipc: add tipc_bearer_min_mtu to calculate min mtu
    error: patch failed: net/tipc/bearer.h:146
    error: net/tipc/bearer.h: patch does not apply
    error: patch failed: net/tipc/udp_media.c:738
    error: net/tipc/udp_media.c: patch does not apply
    Patch failed at 0035 tipc: add tipc_bearer_min_mtu to calculate min mtu

For the base commit I tried the latest linux-6.3.y, both with and without the
latest queue-6.3 applied.

As with any kernel patch series, please make it clear what the base commit is.
Otherwise the series is unreviewable and untestable.

- Eric

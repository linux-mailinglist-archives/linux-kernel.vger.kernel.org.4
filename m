Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33D272A9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjFJHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFJHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7CC3A9B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 00:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0DD66337F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D3C433D2;
        Sat, 10 Jun 2023 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686381296;
        bh=rZTHX692UfDQHCB5RcR/SsN4erGXYNxF+S+zHPxEXZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UcKiP2NzfEsMIrjqjOaew/P0AvVmHau+sWz2weaCAzzLZsfOPmW40Dohi5fLD7/4+
         9E8moZyqjGvUhWOdOa6KmaPfSi8x3M3+pv+n3dx5khy82MeM37LqPXxSImgc8pVCJx
         q1AUrgBXJKSZIsr/hdCDALv+owO7zeSZr88FeWA74fBY8kEMIKFik7umGVqlE7fhyY
         +7d855G26K8j6cqMLyuSWx6T5HFoNY3b3rbZdttZFLBCB4DKIvOA0JXjMq+9oFqV50
         U0y45YN6DGwFJ97+OYPyGg3Krwa5mEQzvxXgUVsiau57RzrOLvRW99OkSp4E1RUNRk
         8x5dSp/jX7ASA==
Date:   Sat, 10 Jun 2023 00:14:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Naveen Mamindlapalli <naveenm@marvell.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
Subject: Re: [net-next PATCH 0/6] RVU NIX AF driver updates
Message-ID: <20230610001454.6a6e9972@kernel.org>
In-Reply-To: <20230608105007.26924-1-naveenm@marvell.com>
References: <20230608105007.26924-1-naveenm@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 16:20:01 +0530 Naveen Mamindlapalli wrote:
> This patch series includes a few enhancements and other updates to the
> RVU NIX AF driver.
> 
> The first patch adds devlink option to configure NPC MCAM high priority
> zone entries reservation. This is useful when the requester needs more
> high priority entries than default reserved entries.

Doesn't apply, reportedly, please rebase.
-- 
pw-bot: cr

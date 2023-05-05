Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770E6F88CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjEESoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjEESot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437F203E0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D90863A37
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F46AC433EF;
        Fri,  5 May 2023 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683312286;
        bh=XMLU9Chg9nCGmsB5GqPhEvGzD7ENvye9j/2FzMvK1Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mYiEHsUvpnOR/j6nzoHoZO+ntSQe/k5FOTbc5iwMbkUKY/pkXq6uaXuX2eLrR1efx
         7rNL/2EGs3SwYb4BuekBZLO1dHmpRvSRkDbpBA5niQNqH3cDBxozRBmU2iYA4WJcsz
         sAg2jXfReszG2eeVc7C7byAe6jDYP8vvUHZSuYg4ptOpi1+tDwg7zCozJYEq272yo9
         l0lFNNnfV6khn2jQu1sQvbta7N3FSKeiufF7l825BnqjucPa2rX4qXpCkAyP6ytR7l
         VaT0XswV9G5+x/89IfTnUcuHLEP4+jP6ZW/pM6Cxes7ytehfzCA5bezjwVb6jKbrY/
         PRJtkRqyYahMQ==
Date:   Fri, 5 May 2023 11:44:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 11/13] netdevice.h: Fix parentheses around macro
 parameter use
Message-ID: <20230505114445.49082b62@kernel.org>
In-Reply-To: <20230504200527.1935944-12-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
        <20230504200527.1935944-12-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 May 2023 16:05:25 -0400 Mathieu Desnoyers wrote:
> Add missing parentheses around macro parameter use in the following
> pattern:
> 
> - "x - 1" changed for "(x) - 1",
> - "x->member" changed for "(x)->member".
> 
> to ensure operator precedence behaves as expected.
> 
> Remove useless parentheses around macro parameter use in the following
> pattern:
> 
> - m((x), y) changed for m(x, y), because comma has the lowest operator
>   precedence, which makes the extra comma useless.

Sure, why not. Can we take it via netdev, tho?
I can't have any dependencies, right?

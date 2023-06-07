Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83692726D73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjFGUmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjFGUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C1210E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2974464621
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B017C433EF;
        Wed,  7 Jun 2023 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170519;
        bh=V7sBdU5qW0cbepwfGbWCvfkWf1L9gYfiiKnVcHhktPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hcghqIFIS5PFaHYqlgjAD3tu6VSDe0KxS7Qe96zxvFQwoNPqSV7yvtiTBTZRMbxfQ
         6NZGMB89OgSLTVqwrPxEXB+0bloCweBviC+GaA8AI+voUq+7mXTFy6Xzn2xMJQc0rV
         EGIIUDxrdNLi7sZ8cWZPOEiEG2CMUK1Wl2pWVOhei4cFpMgC3KfLLDtVqjcRUJl9Ds
         ZrfV7w41jw+yhm3X/dOsi4ebsDfs+ibKcEpGFdlrkZAG212uX5yRvMcTLLsGVSgjcO
         EWdsMILeF8O7QVqoUtTz7B59lbWNxJoTCiwmGX6gUnYBKvfH9CqzX280jitJ5sK5D0
         KnozvBPgX6kGA==
Date:   Wed, 7 Jun 2023 13:41:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pch_gbe: Allow build on MIPS_GENERIC kernel
Message-ID: <20230607134158.5438d28c@kernel.org>
In-Reply-To: <20230607055953.34110-1-jiaxun.yang@flygoat.com>
References: <20230607055953.34110-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Jun 2023 13:59:53 +0800 Jiaxun Yang wrote:
> v2: Add PTP_1588_CLOCK_PCH dependency.
> 
> Netdev maintainers, is it possible to squeeze this tiny patch into
> fixes tree?

Hm.. probably a little late for that. The first version didn't build,
feels too risky. We don't want to break the build of Linus's tree at
rc6/rc7. The merge window is two weeks out, is that really too long
of a wait?

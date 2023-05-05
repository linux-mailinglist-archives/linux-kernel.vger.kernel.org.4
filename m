Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8D6F8634
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjEEPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjEEPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9715690;
        Fri,  5 May 2023 08:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2454E63F0A;
        Fri,  5 May 2023 15:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33141C433D2;
        Fri,  5 May 2023 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683301939;
        bh=esyJrzwkSGQWNXny2nF4USQbJ4A4dvrAVZjB18tgnGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ksNuYaJneF1n5GdsdmblG/wfMw4Ifmr9EjRhogMt0WJVaPYLKnBBHlCmNGlaweJHo
         Xet4li83H6Y7nlIag4d2jqyMORJnG91sBO28VfNI5aKzsMr609H3WjPuFv48m9upFQ
         i6jGbc9hm3XN790k14TmB4q9a2HmW7Lis/c2gkHig/5V/+Ev4xTYUIOldZW9tjtYyz
         Jefy/LVY1kLq8U1AVN43FSV2UDnJ7TU0DTAtwu5m6845dkjllnPeR5JbOFSEtKTPyH
         KlvSKXtF1b1aRIxD/GPTf49aU7uqlbtehfNdoHLzKqHNXmCVvONodENXnagMJYquuU
         nK/esnlwx9Oog==
Date:   Fri, 5 May 2023 08:52:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org, linux@leemhuis.info
Subject: Re: Introducing bugbot
Message-ID: <20230505085218.60c62d75@kernel.org>
In-Reply-To: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
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

On Mon, 3 Apr 2023 17:45:31 -0400 Konstantin Ryabitsev wrote:
> Hi, all:
> 
> Per our discussion last fall, I've been working on a bridge between bugzilla
> and public-inbox, which went live in the past few days. It's still a very
> early release, but it can do the following:

What about closing the bugs once they had been fixed/triaged/proven
invalid?

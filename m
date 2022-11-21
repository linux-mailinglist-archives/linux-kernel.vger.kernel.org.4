Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88A563191A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKUEHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:07:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52771177
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D128460EB2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF04C433D6;
        Mon, 21 Nov 2022 04:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669003657;
        bh=BYX4yNdQqDqqkGYlF7Z5qBUeeKSpc/N+NGo+YpGsZqk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tju3KT5mt52eWyno+7ZioxmG1OuFrEQJ4lkghjn1GKcdmr1nCiXwN9wCYzZo0CObs
         CeLbOiYH/BN3RR458e2Lu+vLSQ/paBaa2quZHpEu/ITnFlc+xUATQv7CHLeriwuaWR
         6gLJvV0TQeS4IOVruL2NJ7b1aC4H9oOqcO5PO9Rf5/iSER8foyOzzbqhlGotioOuvA
         dOWzrxIp5JczR2qJimkoamwNA055PQjotxCxDZmVsYSAYKNRItUB3zyFUtazCXL9E/
         qXuP0gswr2mnv+wKTGGVnhFmdXGJnHLeWMEF0+dQXabkOa6yKScfy5twgBuMMPCn/9
         hXHgMLPHG9uSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BEFA95C10CD; Sun, 20 Nov 2022 20:07:36 -0800 (PST)
Date:   Sun, 20 Nov 2022 20:07:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: objtool warning for next-20221118
Message-ID: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have started getting this from rcutorture scenario TREE09:

vmlinux.o: warning: objtool: do_idle+0x25f: unreachable instruction

Should I be worried?

If so, please let me know what additional information you need.

						Thanx, Paul

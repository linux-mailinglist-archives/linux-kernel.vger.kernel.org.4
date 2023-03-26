Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7346C9794
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCZTTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:19:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FD4212
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CB860EE6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2994EC433EF;
        Sun, 26 Mar 2023 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679858352;
        bh=QU4f8mKRUONRlKR1gt79hmXoHggc6+jveCx+NXYZGmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7XKOiQMC9SPDpHU2Nu9YCNX8yy4rGU7BWy6XGOGyyDARJNR6j1CQFsBhHgu53JYU
         c+n1Mc+N5NVRa30Cmu+TUkCJfKeAo2Ph3aLEEaBx7NU/BsoTmN0INIOsw17zcputUq
         nkyM5HE5MtncNTRoiWGI1+7oc9XnyFrRYr/eTMW2jeCuSneJ01b6nsGbdag1QI22ll
         x+f/r5hH+j7kKQQZ63U1oX2zOdgXM2QH4AWxtUhgMFgyviMJni8G/8TyMVmQT7NPT6
         2nzfp0VhMP9xTyLsxo7qfFbM6AoWWOKyHXDUmZC+IXXHyQAe7f3+doaHXTf4q2rEhw
         EafMrdYoruz1A==
Date:   Sun, 26 Mar 2023 21:19:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 01/13] MAINTAINERS: Change Joel Fernandes from R: to M:
Message-ID: <ZCCarBxJatlkZTZl@localhost.localdomain>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
 <20230325173316.3118674-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230325173316.3118674-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Mar 25, 2023 at 05:33:04PM +0000, Joel Fernandes (Google) a écrit :
> I have spent years learning / contributing to RCU with several features,
> talks and presentations, with my most recent work being on Lazy-RCU.
> 
> Please consider me for M, so I can tell my wife why I spend a lot of my
> weekends and evenings on this complicated and mysterious thing -- which is
> mostly in the hopes of preventing the world from burning down because
> everything runs on this one way or another. ;-)
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

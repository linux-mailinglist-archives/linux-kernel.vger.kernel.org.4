Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927166A394
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjAMTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAMTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:44:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EF288A3E;
        Fri, 13 Jan 2023 11:43:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69A4622F4;
        Fri, 13 Jan 2023 19:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535FBC433D2;
        Fri, 13 Jan 2023 19:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639029;
        bh=USJpVkAp3dnFqJKWRL7jmejznKaKKdpBUps313RjhV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dnuxzWpKmU7sSi9HikgScLMrEIUCuWgroqUXRqppIyzYyQEAos99neMM2fn54/hQV
         eEvCHICOzT3BcjMVpN0A4bXUXOOzb6jkI3Hs7ohECsaOYQ8/6ah9vTW/JZvT/L3hdi
         S+SZYtOgdHRX+/5S2QidDMX0Jotb5Jcfuzih74yg2SEC/a54kw4ry+LM5dIc1Hd5+8
         EMq5qxEkbqJAg0rcHojD8oGHn2BStSEsepfU0FtDThszE19/srm7bXEcF+7VKfIRCE
         BGVi5+9fg72l4MhVuydSPjhbA1tfvvUCjcNxo1J3CXAvbqZm2LqtDqdiGwJZFUZaz/
         1zDY5ll9bVuow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F14445C06D0; Fri, 13 Jan 2023 11:43:48 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:43:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rcu v2 19/20] tomoyo: Remove "select SRCU"
Message-ID: <20230113194348.GF4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-19-paulmck@kernel.org>
 <9d61c9dc-5cf0-134e-dd68-9e467bf67846@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d61c9dc-5cf0-134e-dd68-9e467bf67846@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:22:10PM +0900, Tetsuo Handa wrote:
> On 2023/01/13 9:11, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> 
> Applied to https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/1ed8a46256771de283772d482403691807214cf7 .
> 
> I will send to linux.git after a few days.

Thank you!  I will drop my version of this commit during my next rebase.

							Thanx, Paul

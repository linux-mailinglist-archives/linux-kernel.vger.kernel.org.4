Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48817671238
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjARDzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjARDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:55:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678A53E75;
        Tue, 17 Jan 2023 19:55:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E333B81B07;
        Wed, 18 Jan 2023 03:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4584CC433EF;
        Wed, 18 Jan 2023 03:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674014110;
        bh=7DWrnBn//OVAwvHvImM2tB1wb3Qc+mMz5fBmuvOUl6c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WRh46RXm2FsRLA8VvCm/r9zEwaHCil9omH8VwF83lEjGtHEMk0u9TAZrbqa72Hax2
         EPQ/OevIu01Fb2FS1Nc7cLEpN0fhsHPg1eDn3tKNaHzNky8HfVcT4v9p5NUSLI5XwM
         6StejBNVSFEsQaZUQIPvvaQZK154C8GuPI116uiiLqEXNYCmjgAHFh8YTDAy5N0vuL
         QaaifvpbzNc4UbONKR1UIGPgSt5nqfTQPAhWINQRMcbxgt/Nggxfc6985iUXQmXn8l
         t8ioxTQsxSltFWnNYhgFShXNli7Wg3kVqDtimEkO5cOTzbSEq7kao9gYTDIkUv8usY
         aiWgI0rPI2Zsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3AE15C1052; Tue, 17 Jan 2023 19:55:09 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:55:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Song Liu <song@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 06/20] drivers/md: Remove "select SRCU"
Message-ID: <20230118035509.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-6-paulmck@kernel.org>
 <Y8cqfvrfd3pL9ToJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8cqfvrfd3pL9ToJ@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:08:46PM -0500, Mike Snitzer wrote:
> On Thu, Jan 12 2023 at  7:11P -0500,
> Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Alasdair Kergon <agk@redhat.com>
> > Cc: Mike Snitzer <snitzer@kernel.org>
> > Cc: <dm-devel@redhat.com>
> > Cc: <linux-raid@vger.kernel.org>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> Acked-by: Mike Snitzer <snitzer@kernel.org>

Will apply on my next rebase, thank you!

							Thanx, Paul

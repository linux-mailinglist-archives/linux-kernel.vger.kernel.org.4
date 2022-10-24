Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E440D60B257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJXQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiJXQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0EDCAEE;
        Mon, 24 Oct 2022 08:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0840B81A88;
        Mon, 24 Oct 2022 13:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CE9C433D7;
        Mon, 24 Oct 2022 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666619247;
        bh=AKjH4fAqi5Znmca1BghqRj1ilG31XjeKgA7s9JNN0mU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L7ozeoSYhFF/jK8llEkKXapL+bdHTonvx1YyvAoM9OswAUsiWmxq5AQ/RRCWOPO8P
         CNBLH0fjtfMD2DA+zNOtqoJM0kylGCy0QPOFLuPxNET2uvniaKKl4FtnTaUdMxKkYo
         G5vxCksd4UJtufndkpybeya6hDfP+6wyMqXnz8ULgTdYRhtsiKvNiqT+xeEitDmfsP
         VTNsBcyVeU5lQHZY52M2Dtk4XvwGCozzDEbTG6mvtUS91+Q6XlOwE/RxGwc5GeguN0
         SaGCh52MeGYs4FPN5E6Bh79fVgrv80diEFvLw2Z9IeqNQXWdyXJbhbQstXIDFdhOIM
         AAcicw9pOFSTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3ED295C097E; Mon, 24 Oct 2022 06:47:27 -0700 (PDT)
Date:   Mon, 24 Oct 2022 06:47:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221024134727.GV5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
 <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
 <87y1t5zqzz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1t5zqzz.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:21:44AM +0206, John Ogness wrote:
> On 2022-10-21, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > And srcunmisafe.2022.10.21a diffs equal, so it hopefully also passes
> > your C-I.
> 
> It does. Thanks, Paul!

Whew!!!  ;-)

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC067A455
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjAXUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAXUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:52:31 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8DC385085E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:52:30 -0800 (PST)
Received: (qmail 183233 invoked by uid 1000); 24 Jan 2023 15:52:29 -0500
Date:   Tue, 24 Jan 2023 15:52:29 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <Y9BFDYUykYBqjfw1@rowland.harvard.edu>
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
 <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:15:35AM -0800, Paul E. McKenney wrote:
> Thank you both!
> 
> I wordsmithed the commit log as follows, but then realized that this
> depends on Alan's earlier patch.
> 
> Did I miss the official version?  The latest one I have is
> message-id Y8q9zjxA620GAFu2@rowland.harvard.edu.

I wanted to update the patch description before submitting it 
officially, but I haven't gotten around to it yet.

Alan

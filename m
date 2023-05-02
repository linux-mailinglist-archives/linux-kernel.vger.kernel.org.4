Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB826F3D50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjEBGVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjEBGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:21:03 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D38E49
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:21:02 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3426KoFM027662;
        Tue, 2 May 2023 08:20:50 +0200
Date:   Tue, 2 May 2023 08:20:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: Implement WTERMSIG()
Message-ID: <ZFCrwlpzPNbCpAJT@1wt.eu>
References: <20230427-nolibc-wtermsig-v1-1-6baf4219bb32@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-nolibc-wtermsig-v1-1-6baf4219bb32@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Apr 28, 2023 at 04:24:36PM +0100, Mark Brown wrote:
> Add an implementation of WTERMSIG() to allow nolibc programs to obtain the
> signal that caused the exit of a process, and use it in WIFEXITED() since
> the condition being checked there is that no signal was reported.

Thanks, but Thomas already submitted a similar one that's already queued
for 6.5 in Paul's rcu tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev.2023.04.26b&id=8c934d4822c77818d53f5f4c948c3ace6fda1505

At least it further emphasizes the fact that the patch is needed ;-)

Thanks!
Willy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF36540E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiLVMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiLVMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:17:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECB115E;
        Thu, 22 Dec 2022 04:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02784B81C56;
        Thu, 22 Dec 2022 12:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18883C433D2;
        Thu, 22 Dec 2022 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671711375;
        bh=sYMip5G6yp9/4sVHMu+AQ8rkK++fzeLWnmNjv4D2fD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLSIF3zsFsExdmlK7c/Aosy9Mrab+zVNWx1Fo62DlRee/fN5mlSbjE8IGQc1TqpYB
         Ok6FbBmgOy0i9cE1pgwHiFsc8UtqQGpbaKQKdv+jOjQF9hpb0AEOSJmGmUcd213wHr
         ndXVKRU03pTXxG0ty+uqNC5WU00Uecogc3XMNIWUuFdWbXNWQKLwCss3RI/JRxRWDV
         N3oRVSEoxrjSqK80h9VxfcMXxcAwxlpbIy1JooPI+oJuCy4lgfgR0LQxQ7YaCtrK3k
         jcrizJh8nybA4/xYhiIKIsdyPneSpl917ME1skM6q200kj7f+q3no/ViD6xQ0KkTy6
         mkw6SeruphCbQ==
Date:   Thu, 22 Dec 2022 13:16:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221222121612.GA44777@lothringen>
References: <20221221004957.GA29021@lothringen>
 <0B1950D8-9319-4F25-B14B-4ED949A57BE0@joelfernandes.org>
 <20221221112629.GA29427@lothringen>
 <Y6MuFH2ZMY7mV06q@Boquns-Mac-mini.local>
 <20221221173005.GB37362@lothringen>
 <Y6NqYydTKFEwJIqN@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6NqYydTKFEwJIqN@boqun-archlinux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:19:47PM -0800, Boqun Feng wrote:
> On Wed, Dec 21, 2022 at 06:30:05PM +0100, Frederic Weisbecker wrote:
> By "same effect" you mean removing E results in the exist-clause
> triggered? If so, then our environments disagree with each other ;-)

Nope, removing D :-)

(And yeah probably I misread your previous mail and we weren't talking
about the same thing...)

Thanks.

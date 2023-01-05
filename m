Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F365E9CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjAELYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjAELYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:24:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7A4E42B;
        Thu,  5 Jan 2023 03:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E60B61997;
        Thu,  5 Jan 2023 11:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C74C433F2;
        Thu,  5 Jan 2023 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672917840;
        bh=nS7/An3gAPnKAsG2kkYXAHXBBKZ+anq4EmfORINPbBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MywkGDUgzc30amWmJlhZ6MnBYsFEQ9JPPNHFVSRJXLj8B27nKlq9xjGLo8sAjrSNC
         2ET9TCZY+cfzvHY9YmSgNTIF4R+b7ZiOWOW6mehY0uJJIZI/rt3xLgfSiy3ENMHEXe
         xoaE8GIwIEZ2rLxHWpI0fBgIAAo1LQ8e8XFfjGPM=
Date:   Thu, 5 Jan 2023 12:23:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH rcu 08/27] drivers/base: Remove CONFIG_SRCU
Message-ID: <Y7azTf7LuVDU3M9s@kroah.com>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-8-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-8-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:37:54PM -0800, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in conditional compilation based on CONFIG_SRCU.
> Therefore, remove the #ifdef and throw away the #else clause.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/core.c | 42 ------------------------------------------
>  1 file changed, 42 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

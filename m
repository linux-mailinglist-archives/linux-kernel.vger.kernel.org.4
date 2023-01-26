Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E104C67D3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjAZSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:23:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376B564BF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1386CE254F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A4C433EF;
        Thu, 26 Jan 2023 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674757382;
        bh=pEwpiW4guLLdsNMjUQ3GuXE0GuZKd637ILJ7TX57xcU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kf8wlwf2UdcxS1eXojiMbqx5Udv7MNp8JZcvN3xq+1xBjHSNyqgQbY0102ZJXXDNB
         vlA5f8MuaDv4cq6P23K2MFmSdyvV3MuEPOOP0+l970tu1gSteXsGHnR7I2EVxck2zV
         FNPyAzvD3VI8ekHO14FcNajBAPU6fGJQ/MXf4k7VVh5+Zy78hpUSa/qUK/L9vQI1RS
         rNjpLXN/OS1lF7lAIoKIpwDzzNk8ESazl2zu/GxZhOBu67/PC7K305i6FI8GC9XUpR
         +U7gQ/VgUhLuQ34A6F3Q4zHdj5TJwujDTP0KUwfB+xU/VmsMbAy/1sStT41fWqC/hz
         gY0ApAJnOW3LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4326A5C0510; Thu, 26 Jan 2023 10:23:02 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:23:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: objtool warning from next-20230125
Message-ID: <20230126182302.GA687063@paulmck-ThinkPad-P17-Gen-1>
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

I have started seeing these objtool warnings from a wide variety of
KASAN-enabled rcutorture-related test scenarios in next-20230125.  It has
been awhile since I tested -next, so I am not yet sure where this started.

vmlinux.o: warning: objtool: __asan_memset+0x34: call to __memset() with UACCESS enabled
vmlinux.o: warning: objtool: __asan_memmove+0x4d: call to __memmove() with UACCESS enabled
vmlinux.o: warning: objtool: __asan_memcpy+0x4d: call to __memcpy() with UACCESS enabled

As usual, should I be worried?

							Thanx, Paul

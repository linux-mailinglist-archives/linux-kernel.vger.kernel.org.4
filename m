Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710971F5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFAWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFAWPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:15:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B7E4D;
        Thu,  1 Jun 2023 15:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C75D063772;
        Thu,  1 Jun 2023 22:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4685C433EF;
        Thu,  1 Jun 2023 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685657701;
        bh=Mz2D+VquIEbQurDxx66CaTe238DU4WUo7qh0rtC9tQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QehpPFezV3kqBz6wJ/s9stmno57cE6bHg9H6rg+LKSa7GKj2+WqijaS7ew6x5NSxi
         N7XLi8kVsQtDhGUtE2LD5QA8aRKG+tl9OLM48b2tAr7NxHm5PSo7vzsXLZNofSC6ZA
         3YaYFclotXT6IVfZQ9ZTTQng2OYhkItNl/41/M4w=
Date:   Thu, 1 Jun 2023 15:15:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] checkpatch: Check for 0-length and 1-element arrays
Message-Id: <20230601151500.b9937b28946c38ef186c1ce5@linux-foundation.org>
In-Reply-To: <20230601160746.up.948-kees@kernel.org>
References: <20230601160746.up.948-kees@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 09:07:46 -0700 Kees Cook <keescook@chromium.org> wrote:

> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Fixed-by: Joe Perches <joe@perches.com>

You didn't checkpatch your checkpatch patch!

WARNING: Non-standard signature: Fixed-by:
#248: 
Fixed-by: Joe Perches <joe@perches.com>

I'll do my usual

[joe@perches.com: handle __packed for srtucts]


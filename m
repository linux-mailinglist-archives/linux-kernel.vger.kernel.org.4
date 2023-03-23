Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D685E6C6128
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCWHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCWHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:53:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BD20077
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:53:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679558000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdiT2q7Hy04BQ8jRds0yRcjKia6dOP8kO33KIBN45yI=;
        b=HYZu0aShWYZELAGHg61TeFAD/sD5J4B2wnWJzQQh3m8ceGJtVr7tZkVaLP5XDH3XeT8+iA
        H+TT2UBqzu9leKY3GbRUFW2nxEo3YgUblZnVsAFTMD2w6auOzwnoGlq/xKms2IDrJ1FjZm
        qOARwMLQKSElsccweHnEE06e8a8PmJGU2GCdLyaB8Srfhv/EvzuxsGyuKK0vUEemJcluT6
        CGSnnm9vLIqJbNOvi7xG1oUAteZDG98daWa6Rpq/hbeCKKgs4XgRekCaVjwBWeJnrbXxSB
        4Rg+6eMsQiZELI7OMg7L1dOvE1vkFNk0Y2xxfpyxLKA+8zrf/T1O66nWRjdrfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679558000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdiT2q7Hy04BQ8jRds0yRcjKia6dOP8kO33KIBN45yI=;
        b=OR8FCVu/oNeB34883Eo9RM88w+FjU8wBuQX0Aw9DNG9qNzFpE5eOaXiwQwvMftw9MrOJWu
        T1i4XLwXT133nsDA==
To:     Schspa Shi <schspa@gmail.com>, longman@redhat.com,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH 2/2] debugobject: add unit test for static debug object
In-Reply-To: <m2sfdwnoi8.fsf@gmail.com>
References: <20230303161906.831686-1-schspa@gmail.com>
 <20230303161906.831686-2-schspa@gmail.com> <m2sfdwnoi8.fsf@gmail.com>
Date:   Thu, 23 Mar 2023 08:53:19 +0100
Message-ID: <87h6ub9a4w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2023 at 11:16, Schspa Shi wrote:
> Schspa Shi <schspa@gmail.com> writes:
>>  MAINTAINERS                    |   5 ++
>>  lib/Kconfig.debug              |  14 ++++
>>  lib/Makefile                   |   2 +
>>  lib/test_static_debug_object.c | 125 +++++++++++++++++++++++++++++++++
>>  4 files changed, 146 insertions(+)
>>  create mode 100644 lib/test_static_debug_object.c
>
> What do you think about this test case? Should we need it ? There are
> some platform compatibility issues here that need a little optimization.

What does it buy over the existing self test. Nothing AFACIT aside of
extra code.

Thanks,

        tglx

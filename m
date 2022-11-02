Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E6616F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKBVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:24:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E610B6;
        Wed,  2 Nov 2022 14:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4825B8250A;
        Wed,  2 Nov 2022 21:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DBC433C1;
        Wed,  2 Nov 2022 21:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667424252;
        bh=Z1YWUCPn+WkW4MoZOxjloV2tgHKo8RmJvg5EBSyhhZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0lq44JGCcfCvU5VVUQz4jM8QPWDC2fa48WJ4RYxUeQ9VDSnQMaqHGkCcnvLViUX5Q
         SzAR997mkOM0Rn/ttdwXj/s0ANdMVCR79YEpzoiaC+h1qd9sKBA7ubfUCJWlvS3COD
         FxdvxS6erxZT7oE2WiXsWDoCmRY9w0wjvrgm4GBY=
Date:   Wed, 2 Nov 2022 22:25:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: qemu-i386: perf: BUG: kernel NULL pointer dereference, address:
 00000148
Message-ID: <Y2LgMYsgj8c7Aj1U@kroah.com>
References: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsGFoC5TciCuijZXLx48TZnoTSkq=iUgb+vFdi9EYTucw@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:42:52PM +0530, Naresh Kamboju wrote:
> Following kernel BUG: noticed on qemu-i386 while running perf test suite
> on stable-rc 6.0.7-rc1 the image was built with gcc-11.
> 
> The System did not recover after the crash.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

What is this a regression from?  Does this happen on older stable
kernels?  Linus's tree?

How about 'git bisect'?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB66BA157
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCNVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCNVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359AF7EC1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E0761999
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E532C433D2;
        Tue, 14 Mar 2023 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678828727;
        bh=LxklN4FdggZ4PulSDJ3lafIgCXNs3zWjIbGe+ZmUX2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bxCOYrQLt9cdqJKXZ507AIB54dVw5gYB33dtxIViCwY8tL8sYmLVP4WBNsAEvDOl3
         xeOk9cCKBufrcCTZiOtdJTPOsWbJwbkNJz4/GNpDNCST8j+u7z/Mia5K04+0uIFmcN
         7fmKq+sP4ry5soN2nJ1ThSoGBHqKWfwkkozeNzRQ=
Date:   Tue, 14 Mar 2023 14:18:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        bhe@redhat.com, pmladek@suse.com, xiyou.wangcong@gmail.com,
        dmitry.osipenko@collabora.com, rafael.j.wysocki@intel.com,
        bigeasy@linutronix.de, valentin.schneider@arm.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH v4] notifiers: Add tracepoints to the notifiers
 infrastructure
Message-Id: <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
In-Reply-To: <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
        <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
        <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 18:08:37 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> On 14/03/2023 17:50, Andrew Morton wrote:
> > On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> > 
> >>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
> >>  kernel/notifier.c                |  6 +++
> > 
> > Perhaps the filenames should match, which means "notifier.h".
> 
> Hi Andrew, thanks!
> 
> Do you want me to re-submit? I see some emails of the patch getting
> added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
> top of that). Lemme know how should I proceed.

I changed it, thanks.

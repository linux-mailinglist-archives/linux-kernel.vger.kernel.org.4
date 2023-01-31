Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0B683859
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjAaVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAaVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:09:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309FF8A50
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:09:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D749DB81EE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD57C433D2;
        Tue, 31 Jan 2023 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675199381;
        bh=Tm1IkHgEuHwmAFiQVyifjp2n8Pl5xNEUo9KiuSOrqUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tbik8kpbarV1KV7UJ2qY/rFT6JWvSF4fTPKjQOZDQ5YwJSJqII27B4Du3yKbUbjtB
         GaqKtxSKOtH36tgYcaK4FpuOFBO0CR3qU9Mv5ftUYly94yxlRf8BNDsRDcBLr1ekSN
         oYa6MIII5NMElrZF0VMR0mZX/aykVy4QOlEGSIsw=
Date:   Tue, 31 Jan 2023 13:09:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v4 1/3] mmflags.h: use less error prone
 method to define pageflag_names
Message-Id: <20230131130940.94a7d42220857b4c75761b01@linux-foundation.org>
In-Reply-To: <Y9jTahuqsqID87aU@hyeyoo>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
        <20230130042514.2418-2-42.hyeyoo@gmail.com>
        <Y9e5qD2whT3+xDMD@smile.fi.intel.com>
        <Y9jTahuqsqID87aU@hyeyoo>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 17:38:02 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> On Mon, Jan 30, 2023 at 02:35:52PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 30, 2023 at 01:25:12PM +0900, Hyeonggon Yoo wrote:
> > > As suggested by Andy Shevchenko, use helper macro to decrease chances
> > > of typo when defining pageflag_names.
> > 
> > Suggested-by: ? :-)
> 
> oh, yeah I only wrote in changelog forgot to add the tag.
> I think Andrew will kindly add that when picking this series up?

Sure.

We're at -rc6 so I'm slowing down on the features and cleanups.  I'll
probably park this series for the next -rc cycle.

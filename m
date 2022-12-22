Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B638B653C73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiLVHOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiLVHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:14:39 -0500
X-Greylist: delayed 413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Dec 2022 23:14:36 PST
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF21ADAF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 23:14:36 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:07:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671692859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GA27Msw6p/zB5NqRtzleiY7vvKaWzvXonvXCWKB28rM=;
        b=hzihvZGRnTZFLZqzjUQZtDqhdxaKsk8cVLfHnl2DAc6HFg9mjgAXm27nCfxnTMAMdAz8tv
        AlUmg+XrccFrPItVs1suMKmKZdwKGkk+fFkK5ugHUxZSDCSOewqbPmtpVHIJ3QhrvH/7qV
        b3xJYDmw45+WjvUPB0PhyhCwAkNC8NY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     "David R. Piegdon" <david@p23q.org>
Cc:     Randolph =?utf-8?Q?Maa=C3=9Fen?= <randolph.maassen@indurad.com>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial8250 on tegra hsuart: recover from spurious
 interrupts due to tegra2 silicon bug
Message-ID: <Y6QCGuXXavQwnR/7@g0hl1n.net>
References: <4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org>
 <Y3tUWPCVnauLeuG2@skidata.com>
 <73C64EC3-3F03-426F-833B-CC9FBA9205D8@p23q.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73C64EC3-3F03-426F-833B-CC9FBA9205D8@p23q.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 22, 2022 at 06:47:39PM +0100, David R. Piegdon wrote:
> Hallo Richard,
> it's great to hear that the patch was helpful for someone other than us.
> However, I no longer work on that project, or that company. I have added my old coworker Randolph to the recipients, who, I think, still maintains that platform (based on colibri t20 from toradex). Maybe he can be of help. If you come up with technical questions, I might still have a memory or two.

Thanks for the feedback.

As I'd love to see this mainline: Does one of you (David, Randolph) have
interest/time to try to bring this mainline? If not I can try, altough
I'm not into the Tegra UARTs details that deep...

regards;rl

> @Randolph: Cheers & I hope everything is going well!
> 
> Yours,
> David
> 

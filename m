Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6396613A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 06:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjAHFR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 00:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHFRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 00:17:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4962F8FF5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 21:17:18 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3085Gtw0007746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Jan 2023 00:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673155027; bh=ACGOb0dUgAOC723GjWz0H4uxd2M3tqpR3WTGgmKtxfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KT6zlbKuLBKUM5QdQ97w2GV8t3mBMhfW05rwRO0LBbDIZW5I5VHgASm191Y4V4t2N
         hkwe9p8qgc/NNtUJ+T0c96YN1S6L+klvwBFeYPBZkD730wHcUiteuyTDAWE+Tf3Ahr
         MaerSWDDPkjamw8y0BXwSvhJpQGjPq1LOTWX2bcWg56RqOMy5xoKxeSek/bpdi9dnb
         lstL/cAuNNsN12DqDLz/jDz94THXWMa3u6ihyttnm9gxlEFDY7veSwLz38c85knD6O
         LIFSkLT702zBhfc3pO0aidMMp4H6U0DMGsX0xC15OiFRExzobNKmrjcsD5eQURPSVS
         EKIir9YnQYuWA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A974E8C01C8; Sun,  8 Jan 2023 00:16:51 -0500 (EST)
Date:   Sun, 8 Jan 2023 00:16:51 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        geert+renesas@glider.be, Andrew Morton <akpm@osdl.org>
Subject: Re: Dhrystone -- userland version
Message-ID: <Y7pRw47hidw+s6+g@mit.edu>
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7nyd4hPeXsdiibH@duo.ucw.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 11:30:15PM +0100, Pavel Machek wrote:
> 
> Distributions do not usually carry dhrystone, and I don't think anyone
> really maintains it. It is useful tool, and it seems we'll maintain
> it.
> 
> I'd like to add enough glue so that it would be runnable from
> userspace, too? Userland version is what is actually useful to me, and
> it should not be hard.

I don't see whatever message you were replying to, and it doesn't seem
to be archived in lore[1], so I'm not sure about the context.  But you
are talking about the Dhrystone benchmark[2], right?

[1] https://lore.kernel.org/all/Y7nyd4hPeXsdiibH@duo.ucw.cz/T/#u
[2] https://wiki.cdot.senecacollege.ca/wiki/Dhrystone_howto

If so, I'm confused what you mean by "add enough glue so that it would
be runnable from userspace" --- Dhrystone is a userspace benchmark,
dating from the 1980's, although what it benchmarks is often more about
the compiler than the CPU's performace.

   "When first released, the Dhrystone benchmark fulfilled a useful
   function – at least it gave an alternative indicator to vendors’
   literal MIPS ratings. However, more than twenty years later, there
   are undoubtedly better benchmarks available for measuring processor
   performance."

						- Ted

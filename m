Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C666718B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjALMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjALMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:03:22 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D264F11B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:58:06 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 130E392009C; Thu, 12 Jan 2023 12:58:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0C53D92009B;
        Thu, 12 Jan 2023 11:58:05 +0000 (GMT)
Date:   Thu, 12 Jan 2023 11:58:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Borislav Petkov <bp@alien8.de>
cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <Y7/vYry8Va+NJpxA@zn.tnic>
Message-ID: <alpine.DEB.2.21.2301121150480.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y72CByxvewQv78YH@zx2c4.com> <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk> <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com> <Y7/vYry8Va+NJpxA@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Borislav Petkov wrote:

> > Not to mention that we could use rdrand here if it is available (although it
> > is slower than rdtsc.)
> 
> Yeah, no RDRAND on 486. :)

 And not even in my 2009 copy of the SDM (the 2013 one does have it), so 
it must have arrived slightly later than just after the 486. ;)

  Maciej

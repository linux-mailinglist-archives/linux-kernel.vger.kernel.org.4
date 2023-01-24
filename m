Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009C678E70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjAXClO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjAXClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:41:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577543C291;
        Mon, 23 Jan 2023 18:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hJzZkQ5tXghkUUrzWChisLPF8Mi1gd4we1pNZEFybz4=; b=BNkeuaZKrQdLKO0JthXe6ioOVI
        /fGtObqN4ZTyFYEeLhwrbKiO2/Xs+4BWrOSxdEy3UYD/vOQmK5bUUP8M2z/Bug7Pc1W/VmkPpae8J
        ORg1G/CCKiFh2yjUtNovYGdAOzaSOS0390hQc8+cjj7CpXji0m/2WRx1WAf2hyuav/YmKHHyyc0F5
        EhmrHtS9CRiJcUDQdJ7eIjVpZE3IZAB8k5ini+ouo4Hu+5nnYVz6cYsTfarSzPdwz+xZi8nGgG/Qf
        xwAVbMuA1P5s8ktPbPl//v69czuYeTSGObdjMHwanxpvuIK7LHimAkr8sNzjlihGCnVaJ4+eJNnGd
        AGWn11HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK9E1-004i9u-Cj; Tue, 24 Jan 2023 02:39:53 +0000
Date:   Tue, 24 Jan 2023 02:39:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anton Blanchard <anton@linux.ibm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        James Morris <jamorris@linux.microsoft.com>, corbet@lwn.net,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, ndesaulniers@google.com,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y89E+S7TA6UwtNe2@casper.infradead.org>
References: <20230123183926.249601-1-mcgrof@kernel.org>
 <Y87X6tFlevIebcc6@kroah.com>
 <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:48:03PM -0800, Luis Chamberlain wrote:
> > > @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
> > >    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
> > >    Intel		Tony Luck <tony.luck@intel.com>
> > >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> > > +  Samsung       Javier González <javier.gonz@samsung.com>
> 
> I'll send a fix on v2.
> 
> BTW while at it, it got me wondering, since most of the emails on
> this hw embargo page are not required to have kernel.org accounts

This isn't the list of hw embargo people.  This is the list of
"ambassadors" who can help people work through the security disclosure
process.  My impression is that it's to tell me that I should contact
Konrad, since he also works at Oracle, to help me through the process.
It's not for people outside Oracle to contact.

If I have the wrong impression of that list, perhaps the description
could be clarified.

> not all of the folks on that page have a PGP key on the pgpkeys git
> tree [0]. Today we constrain kernel.org accounts to folks that send
> pull requests to Linus. Not all folks on the embargo list need to also
> be active kernel developers. Given the issues reported before by Konstantin
> on PGP keyservers we rely on our own git tree for keys we wish to get access
> to in our community. The below email addresses do not have any PGP
> key associated on the pgpkeys tree as of this day.
> 
>   * Tom Lendacky <thomas.lendacky@amd.com>
>   * Catalin Marinas <catalin.marinas@arm.com>
>   * Anton Blanchard <anton@linux.ibm.com>
>   * Trilok Soni <tsoni@codeaurora.org>
>   * James Morris <jamorris@linux.microsoft.com
> 
> So it occurs to me to perhaps modify pgpg keys documentation to welcome
> community related keys to at least include folks like the above for the
> hw embargo emails should communication via PGP be required. Thoughts?
> 
> [0] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
> 
>   Luis

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CA679E87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjAXQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjAXQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:23:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCFB6A56;
        Tue, 24 Jan 2023 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=hJtnfFyj9mQFKS9gYTdD9QF9mbnLj6wzdIlpc9Mzmtc=; b=QG8pY8TLbtbuk56ZwQ9ACeowgZ
        RYEHWeUSM8f12aPmM2OlD8gsF3D3iFgqw0YufCScZZN+zfauFhgCJxSBT2JFOlatxoWuvN2C0EJg5
        h5rahUsALpVAO4JUlhjXi0iQG0113hvKGqpzYZwREjrujIt7OgMy1FJqPw3txiOFGm04NEgeTZh6W
        jQvvdUapweDZQ0yp1gXs3ZEONsWgijuvReQxCDaxQ8jztox/ugqRFLOMl+IVoqqvOWaRcjM0a102i
        7f5Er6sFwo+ZPtW1aACbGQcs52h1mreJRszrMBsiD1Re3DYr91tiZ6Q3HJmW4sPDCI+Fneti1Sx/c
        ZhZuI0/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKM4L-004f0a-5z; Tue, 24 Jan 2023 16:22:45 +0000
Date:   Tue, 24 Jan 2023 08:22:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Y9AF1UV/ow7eP92L@bombadil.infradead.org>
References: <20230123183926.249601-1-mcgrof@kernel.org>
 <Y87X6tFlevIebcc6@kroah.com>
 <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
 <Y89E+S7TA6UwtNe2@casper.infradead.org>
 <Y89qrid7YOsIFbD6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y89qrid7YOsIFbD6@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 06:20:46AM +0100, Greg KH wrote:
> On Tue, Jan 24, 2023 at 02:39:53AM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 23, 2023 at 01:48:03PM -0800, Luis Chamberlain wrote:
> > > > > @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
> > > > >    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
> > > > >    Intel		Tony Luck <tony.luck@intel.com>
> > > > >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> > > > > +  Samsung       Javier González <javier.gonz@samsung.com>
> > > 
> > > I'll send a fix on v2.
> > > 
> > > BTW while at it, it got me wondering, since most of the emails on
> > > this hw embargo page are not required to have kernel.org accounts
> > 
> > This isn't the list of hw embargo people.  This is the list of
> > "ambassadors" who can help people work through the security disclosure
> > process.  My impression is that it's to tell me that I should contact
> > Konrad, since he also works at Oracle, to help me through the process.
> > It's not for people outside Oracle to contact.
> > 
> > If I have the wrong impression of that list, perhaps the description
> > could be clarified.
> 
> That is correct, but it is primarily a list that I use when needing to
> contact companies about potential issues in their hardware. 

That is the impression I gathered.

> For that I
> don't need a GPG key, that's only required if they need to get added to
> a secure mailing list, and at that point I can have a key sent to me, it
> does not have to be in our kernel.org keyring at all (and list
> participants usually are not there.)

That might be useful to explain in the documentation.

> So there's no need for any of these addresses to be part of the kernel
> gpg ring of trust for any of their activities.

Sounds good.

  Luis

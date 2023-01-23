Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4313E6789E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjAWVsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:48:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F444301A8;
        Mon, 23 Jan 2023 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=K/9vGjFd4fNNPyoi8XWbw0CMKmCiZt0iktOdUfenzOA=; b=ndlsJ5OljAcfngiPsMIKW8DG0/
        BxPvMsNvF7cDbzl117ofEZ9mMb+8DBW5xZO68gV5eU40QaJ90ZdXXQkFnPrhJ5vQuR2W8fShe7O1F
        eKEfBIpjhJhAV9KbvnpVfEi+nCeb+J18sgJxcYBFq0rVFGqRnYknN30ZSCnD5Zz6/AFAQ4xvJB6SA
        5s2LS8V1lLDAz9Sa4/d4VZgCz+3V1w3am+SnpgbLizPgaI5nUrCddKNJhZT+nCnZX6rl1j1n5YJRC
        b1eqfyOfrqztK9pEbT2N0+Ht3js1coyOnBS+TEnxDT21w30EsPoHGVS2J79keDA0qPBdVL9yLX7/Z
        /YXFqryw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK4fb-001ZY5-SZ; Mon, 23 Jan 2023 21:48:03 +0000
Date:   Mon, 23 Jan 2023 13:48:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anton Blanchard <anton@linux.ibm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     corbet@lwn.net, javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y88Ak8K5mD7tFItG@bombadil.infradead.org>
References: <20230123183926.249601-1-mcgrof@kernel.org>
 <Y87X6tFlevIebcc6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y87X6tFlevIebcc6@kroah.com>
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

On Mon, Jan 23, 2023 at 07:54:34PM +0100, Greg KH wrote:
> On Mon, Jan 23, 2023 at 10:39:26AM -0800, Luis Chamberlain wrote:
> > After discussions internally at the company, Javier has been volunteered
> > and is willing to be the embargoed hardware contact for Samsung.
> > 
> > Cc: Javier González <javier.gonz@samsung.com>
> > Signed-off-by: Luis Chamberlain <mcgrof.c@samsung.com>
> > ---
> >  Documentation/process/embargoed-hardware-issues.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > index b6b4481e2474..fbb754253cf7 100644
> > --- a/Documentation/process/embargoed-hardware-issues.rst
> > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
> >    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
> >    Intel		Tony Luck <tony.luck@intel.com>
> >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> > +  Samsung       Javier González <javier.gonz@samsung.com>
> 
> No tab?  :(

I'll send a fix on v2.

BTW while at it, it got me wondering, since most of the emails on
this hw embargo page are not required to have kernel.org accounts
not all of the folks on that page have a PGP key on the pgpkeys git
tree [0]. Today we constrain kernel.org accounts to folks that send
pull requests to Linus. Not all folks on the embargo list need to also
be active kernel developers. Given the issues reported before by Konstantin
on PGP keyservers we rely on our own git tree for keys we wish to get access
to in our community. The below email addresses do not have any PGP
key associated on the pgpkeys tree as of this day.

  * Tom Lendacky <thomas.lendacky@amd.com>
  * Catalin Marinas <catalin.marinas@arm.com>
  * Anton Blanchard <anton@linux.ibm.com>
  * Trilok Soni <tsoni@codeaurora.org>
  * James Morris <jamorris@linux.microsoft.com

So it occurs to me to perhaps modify pgpg keys documentation to welcome
community related keys to at least include folks like the above for the
hw embargo emails should communication via PGP be required. Thoughts?

[0] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

  Luis

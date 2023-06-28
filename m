Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282D3740911
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 05:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjF1D6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjF1D6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 23:58:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A32D7D;
        Tue, 27 Jun 2023 20:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MUXhoKmuZ1A/7U83BdMHC6l86XOAppMGGNlVJYVgIdI=; b=FPcVLapHiYti43T21UgqJy1Oe+
        BoJDCKJ6MwSyegnBvf0EUAGAh4YXeEcaIHNpPovln791WdOMk8tslF0klSgI362yRSF+YpKSo0/NM
        K8jgBamTr0XB2sE/wQ/ATLmrtU9g5Gr7hwkw1bhKY0mBb3MPSaVpHoL19SlSHulZBbAdACkFEU55v
        V/Cw3hdbrtnEwuC/gWwRgFQNT8VaL7mWvsqruAHZSIEkLo0CqSQ7Kh/jsBO24zmelssUkBkYPgoTG
        jUKXn+ipIbNMu9vxWLJj/EsVrzMV461mq8G5uZ5Ch+R1KimAnAOOxtkndGA0nqRoDG1v53ERpcqlg
        dCvHG2dw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEMJZ-000oXj-2S;
        Wed, 28 Jun 2023 03:57:57 +0000
Date:   Wed, 28 Jun 2023 04:57:57 +0100
From:   Joel Becker <jlbec@evilplan.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Anthony Iliopoulos <ailiop@suse.com>,
        Mark Fasheh <mark@fasheh.com>,
        akpm <akpm@linux-foundation.org>, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] update ocfs2-devel mailing list addresses
Message-ID: <ZJuvxQF4epheLig8@ZenIV>
Mail-Followup-To: Joseph Qi <joseph.qi@linux.alibaba.com>,
        Anthony Iliopoulos <ailiop@suse.com>, Mark Fasheh <mark@fasheh.com>,
        akpm <akpm@linux-foundation.org>, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230628013437.47030-1-ailiop@suse.com>
 <6d59ab08-070f-1562-2eaa-16b083f1a732@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d59ab08-070f-1562-2eaa-16b083f1a732@linux.alibaba.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, thank you.

Acked-by: Joel Becker <jlbec@evilplan.org>

On Wed, Jun 28, 2023 at 10:30:33AM +0800, Joseph Qi wrote:
> Thanks for this work.
> 
> Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> On 6/28/23 9:34 AM, Anthony Iliopoulos wrote:
> > The ocfs2-devel mailing list has been migrated to kernel.org, update all
> > related kernel documentation pointers to reflect the change.
> > 
> > Anthony Iliopoulos (2):
> >   MAINTAINERS: Update ocfs2-devel mailing list address
> >   docs: update ocfs2-devel mailing list address
> > 
> >  Documentation/ABI/obsolete/o2cb       |  4 ++--
> >  Documentation/ABI/removed/o2cb        |  4 ++--
> >  Documentation/ABI/stable/o2cb         |  4 ++--
> >  Documentation/ABI/testing/sysfs-ocfs2 | 12 ++++++------
> >  Documentation/filesystems/dlmfs.rst   |  2 +-
> >  Documentation/filesystems/ocfs2.rst   |  2 +-
> >  MAINTAINERS                           |  2 +-
> >  fs/ocfs2/Kconfig                      |  6 +++---
> >  8 files changed, 18 insertions(+), 18 deletions(-)
> > 

-- 

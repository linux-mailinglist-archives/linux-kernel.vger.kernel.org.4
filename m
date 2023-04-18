Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA36B6E6E99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjDRVtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjDRVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:49:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D7119
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNM/PoaKdJVang9WqsbIURXjXnMB7kVw7Og7DK0+y/k=; b=NPvn3Y8PNf9X253zeDEbvUCEMD
        gOA4qUsYzuP/RiqVYByAU8E1tcWRLyrDDPdWBL2v8THrJaQ+ArmYTwIZCrdc3rlybWppKyco44g27
        QFkSMiHR1g8AawhfyR/Ml8/HpQFb0HmIsBORD9Zvl7rcHItkbCjppHyLtGMXUIFJOXlzxHZfJ7Wbz
        1RU2UUvmvKQ1i6jgfcMJpZkfh+3gwGio3Rvb8cNGtgnT8dG4OUU9W1iFB+fPux3x5L8cyO8a+UcOK
        W7ipP9jQvBItWBIlWS9iv18T59zhMe832aQac7NWnsBI93CCWPVOgtyv+4h66HRM4t2N4eJ7Kt6yy
        zBFnjF+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1potC8-003RF5-25;
        Tue, 18 Apr 2023 21:49:00 +0000
Date:   Tue, 18 Apr 2023 14:49:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 5/6] shmem: update documentation
Message-ID: <ZD8QTOsWQ0SscOYz@bombadil.infradead.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <20230309230545.2930737-6-mcgrof@kernel.org>
 <a4afef5c-27e4-5e67-9771-374132db61f8@google.com>
 <ZD8JgfphE+HWCGve@bombadil.infradead.org>
 <6064b468-33fb-3693-54e-6f1f8d316f64@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6064b468-33fb-3693-54e-6f1f8d316f64@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:41:07PM -0700, Hugh Dickins wrote:
> On Tue, 18 Apr 2023, Luis Chamberlain wrote:
> > On Mon, Apr 17, 2023 at 10:29:59PM -0700, Hugh Dickins wrote:
> > > On Thu, 9 Mar 2023, Luis Chamberlain wrote:
> > > 
> > > > Update the docs to reflect a bit better why some folks prefer tmpfs
> > > > over ramfs and clarify a bit more about the difference between brd
> > > > ramdisks.
> > > > 
> > > > While at it, add THP docs for tmpfs, both the mount options and the
> > > > sysfs file.
> > > 
> > > Okay: the original canonical reference for THP options on tmpfs has
> > > been Documentation/admin-guide/mm/transhuge.rst.  You're right that
> > > they would be helpful here too: IIRC (but I might well be confusing
> > > with our Google tree) we used to have them documented in both places,
> > > but grew tired of keeping the two in synch.  You're volunteering to
> > > do so! so please check now that they tell the same story.
> > 
> > Hehe. Sure, we should just make one point to the other. Which one should
> > be the authoritive source?
> 
> Documentation/admin-guide/mm/transhuge.rst has been the authoritative
> source up until this patch, so I suggest it remain so; but good if you
> point to it from this Doc - unless in reading it you find that actually
> its account is wrong.  (Haha, it refers to fadvise too, never mind that.)

Yeah I'll make the tmpfs kdoc point to the transhuge.rst page. I think
that's possible.

> But the man page is more important than either, so it would be good to
> point to that too. 

Sure I'll have the tmpfs kdoc also point to the tmpfs man page.

> Mention the "huge=" option in this document, but
> point to elsewhere for the detail of its values.

Sounds good.

  Luis

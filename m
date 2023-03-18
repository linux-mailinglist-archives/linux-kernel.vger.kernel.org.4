Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046BB6BF6D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCRALd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCRALb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:11:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDEBBD4F0;
        Fri, 17 Mar 2023 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qjh02ll/N6tXv37eQ7ysFaXY+FLlkp6Qi3KhauBMak0=; b=HhmS5T3wRT/J2KDrPg5jWlYDiP
        3JABPNwZtBwbpf0MVm6NWDSFwqubVEuj+7PMqv+/YFsjb6Kohb2pGVYZ4Ezd6Iqqh2fJUmAuJBBYV
        2k4DvLEcbwDRVBa+pbWZZ2r3f6SBg2vBjDSwsLtLyEDwNd+09mVUtv0ruHyQZjFqzVCkiSuCt+VXB
        6ZnqqYYg6JVe6nWjbinwu/MA0839IUIPvp7iAgBSYfu9+MiZr6OTtX6KlNbc2VqOxPVHUHY/6wrsk
        KSCaV5bfY7x2ViXWLSZ+10WCc94JKsnWCB+8wTaZYnd/NsHscCbKNGFhTEIAvXHGONTw0hc3F7OsX
        DRQJr9iQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdKAT-003kwi-18;
        Sat, 18 Mar 2023 00:11:29 +0000
Date:   Fri, 17 Mar 2023 17:11:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
> > On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
> > > I expect to have a machine (with a crazy number of CPUs/devices) available
> > > in a couple of days (1-2), so no need to rush.
> > > 
> > > The original machine I was able to reproduce with is blocked for a little
> > > bit longer; so I hope the alternative I looked up will similarly trigger the
> > > issue easily.
> > 
> > OK give this a spin:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts

Today I am up to here:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts

The last patch really would have no justification yet at all unless it
does help your case.

  Luis

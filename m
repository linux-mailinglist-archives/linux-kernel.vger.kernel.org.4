Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61C6E2869
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDNQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:35:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE413E;
        Fri, 14 Apr 2023 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1UCbfNeo0PYl9cZDPYs2IwIaIuAlJgRFSP2KRabe9+Y=; b=SNUECSyS/wYFVVAx/O/SmvTXHb
        1PUJxB2FTbh6UnjvkEAw8gvJIYAsoS68EdgbD7y3IYvKUpdNaVTZVQbJYPwAgG7oKvEQOYeU45BEf
        SMpEvatAbDuf6gg8eiq+vs4voZUcvLAwzDAZl5D6JPpYmFlf5RxtAisE98gNUNxynovQ+cqRz1BV4
        TTT5lzcxapnOipNyJMWWrQbD5/dsPCq+NF+pTRexivsVPsO+kM3GSepS8KIIvfpHGiwo8ndIQPJGa
        gqXaMqG3OT6LsEWeRQ0bhqlYscoyaP1IliSfgtk850S0wcjpHbzVbVyye08F7GXachxL3ewmazjg+
        l4kOeFlg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnMOF-00A7bv-1P;
        Fri, 14 Apr 2023 16:35:11 +0000
Date:   Fri, 14 Apr 2023 09:35:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC 2/2] kread: avoid duplicates
Message-ID: <ZDmAvwi+KNvie+OI@bombadil.infradead.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
 <20230414052840.1994456-3-mcgrof@kernel.org>
 <ZDj0SVelrvh1xaEv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDj0SVelrvh1xaEv@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:35:53AM +0200, Greg KH wrote:
> On Thu, Apr 13, 2023 at 10:28:40PM -0700, Luis Chamberlain wrote:
> > With this we run into 0 wasted virtual memory bytes.
> 
> This changelog does not make any sense at all, sorry.  What are you
> doing here and why?

It's an RFC and the cover letter described the motivation looking for
ideas for an alternative, and it is the reason I was so terse on the
commit log.

  Luis

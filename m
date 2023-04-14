Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765CC6E28FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDNRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDNRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:10:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C915B4;
        Fri, 14 Apr 2023 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ti6cYdcZoKEE42acSDYdLZZ8XvUjNJ9ejinmTKxANOc=; b=4InsRRvRPC1aGBxCPZpgSSoMPY
        OAvGUEm0s8N1CDjsOEQHbh4bxagIo50k+E8anop6y8pKG+Bkpwx+4kHHZ2MW987Jop7xaBluBUFPz
        4qb765rlUELgMKnjJZkWPbez/wg9DHFF7O5WlAEFX1BFr8V33oIr+Au9sW4Lp8krQRKZBLpL7gRvz
        HDVgLqcQsjCHeUd2fFhNFmz8hYgFh2ABxoJr6rRkAjk2U5GRtv2kv31AENQtFecfQ9+iP/fyt3+Gy
        qbSh9X+mRUSGC+Hl/7I4OtP9k5tjcnJCb3jctZH4E+76SyPlxnGbLNQECO9pL/BmCvZ9/1wlNOwdR
        VVRHeevA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnMwY-00ACgB-2N;
        Fri, 14 Apr 2023 17:10:38 +0000
Date:   Fri, 14 Apr 2023 10:10:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v3 1/2] Change DEFINE_SEMAPHORE() to take a number
 argument
Message-ID: <ZDmJDq/9qU52TgMd@bombadil.infradead.org>
References: <20230414051349.1986744-1-mcgrof@kernel.org>
 <20230414051349.1986744-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414051349.1986744-2-mcgrof@kernel.org>
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

On Thu, Apr 13, 2023 at 10:13:48PM -0700, Luis Chamberlain wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> [mcgrof: add some tribal knowledge about why some folks prefer
>  binary sempahores over mutexes]

Jeesh, sorry I thought I had replaced the tribal knowledge tibit with
what Matthew had suggested before, will do that in v4.

  Luis

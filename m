Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A06E1278
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDMQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDMQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:38:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2A8A6A;
        Thu, 13 Apr 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SiAvXIwUCiDRn7X/zVCIOWNEa8hkl/f6/T4KHDaYrfA=; b=AtpOvMGl59YlIWsPr0KJLB/Rs/
        Arvbb+ogkRT7S8QPT5azeBWIJF6S6JAk4Sg6qh7aXkb8D4DncrDNgtMURvYpzWf0yLlbo6TzsLva9
        e9vln472OX3I384SfaVucMChr3bBar26vxbBbN5sDyUVCwA2OkV567jp4LbMXIelFK7c7YJfX9uRd
        MF5dqN82Lp2ZxYnBixPh8GQWEOL3435gzxRrLUQMnwaCkI4udtS6CkEv6FB4ZhdRnsuYH5skULX5y
        zD0METmT3EFAodInUnRrZpl52sYbjXFbyGkXPmhFPR5+IUyS5X9HLLrEDjov6F4p+jXCP1kIT/aYR
        Wn8Ind0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmzxq-006hJo-1o;
        Thu, 13 Apr 2023 16:38:26 +0000
Date:   Thu, 13 Apr 2023 09:38:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 2/2] modules/kmod: replace implementation with a
 sempahore
Message-ID: <ZDgwAiayuj0lCId5@bombadil.infradead.org>
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-3-mcgrof@kernel.org>
 <alpine.LSU.2.21.2304131136580.27633@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2304131136580.27633@pobox.suse.cz>
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

On Thu, Apr 13, 2023 at 11:44:51AM +0200, Miroslav Benes wrote:
> Hi,

<spell checks>

Thanks, fixed!

> MAX_KMOD_ALL_BUSY_TIMEOUT * HZ ?

Yes! In the end schedule_timeout() is used so yup, thanks!

  Luis

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30E70CEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjEWABk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjEVX2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 19:28:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302641705;
        Mon, 22 May 2023 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eCUDdFWO/x24L1UQwluZwvwivpq5/on0dcLWvhYbYSU=; b=lZg9alK4iixyEKRz/zYjW0Etft
        BvpnLZNHaUmP2SjnHqYfUnltKhJ49JkAOUPwY42FcdMxtx+EJinbmnZtqaFnwS8BA+3V5IEg4lcs0
        wGL+vJqnThSteKOHNraEkFv2tyLCHo1vSq8b72e26b5x3e9i5BrRWAGfcwWHeICXg/th+l4pP19AB
        L+MnpIoap5fDbWY3MLK8VEG9AOQCQWdqKJ2DfOlHYL5Ad7vcbUAJYuA1JZn5suMVl76QO0zznhRA/
        kR3YI/opWognhplXq77WASwnqhEZnGn9S4z4tB+DJBIuV9L1dUDh272uQSMQce0mybSg967fxDVr3
        D1Z8OGvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Eql-008L8p-23;
        Mon, 22 May 2023 23:21:59 +0000
Date:   Mon, 22 May 2023 16:21:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
Message-ID: <ZGv5Fy4nmFxH5bdN@bombadil.infradead.org>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20230508180653.4791819e@rorschach.local.home>
 <e6662717-61a1-3e3d-5804-66629a1691e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6662717-61a1-3e3d-5804-66629a1691e2@intel.com>
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

On Fri, May 19, 2023 at 05:50:35PM +0200, Alexander Lobakin wrote:
> FYI for devs: I posted RFC of kallsyms with file paths almost a year
> ago[0], but it went unnoticed =\
> 
> `file name + function name` is not a unique pair: in one of FG-KASLR
> discussions, someone even wrote simple script, which showed around 40
> collisions in the kernel. My approach was to include file path starting
> at the kernel root folder, i.e. `net/core/dev.o:register_netdev`.
> I'm not sure why no comments happened back then tho. Maybe you could
> take a look, I'm pretty busy with other projects, but if you find
> anything useful there in the RFC, I could join to a little bit.
> 
> [0]
> https://lore.kernel.org/all/20220818115306.1109642-1-alexandr.lobakin@intel.com

Petr suggested line number too, that'd fix it too.

  Luis

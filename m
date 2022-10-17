Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC11D601153
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJQOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJQOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:41:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370653D01;
        Mon, 17 Oct 2022 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qRP0t1fzx0+D6aB4K84CvuiMlWg5VJtwt3tYbeAR3Rs=; b=LNZCt0o5CmXos7ijnk/35sQRaR
        JMhQ6kHAgRj2JXM2il+tMaZIih8zsfl8XJecXMZsXUm+yukoT2N6RMtHSJlqENdhZ7U9r1e9usGCN
        AK3V7Cgbx379/Bp3zjXAp9uluOH0c7XtRZzFZhXW6+kCrDCtDyTpaQmB7yoX7abNLKcsUKmxGIozx
        fx/Hn5Sq8rwKnW9leaSxQyoDi7OssPpX4V/eBZqsQ7Bo9D6hNETJ7K18AQA28ULTm7mFb4A/1j4H4
        V8C8Ohzv35wj62yT64+I1dRmh3zVN7Ysw9bxUxVxrZhIFxjexApzKF6xWIR79QgAsGA32mHge9SH9
        i1SuyKow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okRIw-009uaN-Rr; Mon, 17 Oct 2022 14:41:22 +0000
Date:   Mon, 17 Oct 2022 15:41:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, bilbao@vt.edu,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
Message-ID: <Y01pkubcT7FOwCjL@casper.infradead.org>
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 01:06:36PM +0900, Akira Yokosawa wrote:
> Hi,
> Minor nit on language code.
> 
> On Fri, 14 Oct 2022 09:24:53 -0500, Carlos Bilbao wrote:
> > Start the process of translating kernel documentation to Spanish. Create
> > sp_SP/ and include an index and a disclaimer, following the approach of
> > prior translations. Add Carlos Bilbao as MAINTAINER of this translation
> > effort.
> IIUC, the language code for "Spanish (Spain)" should be "es-ES", as is
> listed at e.g., http://www.lingoes.net/en/translator/langcode.htm.
> 
> The other translations use directory names found in the table, with
> "-" replaced with "_".  It would be better to be consistent.

I don't know what standard we're actually following.  RFC5646 suggests
simply using "es", with "es-419" for Latin America specialisation or
"es-ES" for Spain.  I don't know how much variation there is between
different Spanish dialects for technical documents; as I understand it,
it's worth supporting two dialects of Chinese, but we merrily mix &
match en_US and en_GB spellings.  Similarly, I wouldn't suggest that we
have separate translations for fr_CA, fr_CH, fr_FR, just a single 'fr'
would be fine.

We do need to be careful here; people are rightfully sensitive about
being incorrectly grouped together.  If possible we should find a
standard to follow that's been defined by experts in these matters.
https://en.wikipedia.org/wiki/IETF_language_tag may be a good place to
start looking.

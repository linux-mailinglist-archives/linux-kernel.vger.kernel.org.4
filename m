Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7B602FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJRPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJRPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:36:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B2BD070;
        Tue, 18 Oct 2022 08:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C367B81F68;
        Tue, 18 Oct 2022 15:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9CFC433C1;
        Tue, 18 Oct 2022 15:35:57 +0000 (UTC)
Date:   Tue, 18 Oct 2022 11:35:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH -next] tracing/histogram: Update document for KEYS_MAX
 size
Message-ID: <20221018113558.73790f54@gandalf.local.home>
In-Reply-To: <20221019003134.cc24bd624cc6fca06a05206c@kernel.org>
References: <20221017103806.2479139-1-zhengyejian1@huawei.com>
        <20221019003134.cc24bd624cc6fca06a05206c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 00:31:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 17 Oct 2022 10:38:06 +0000
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
> > After commit 4f36c2d85ced ("tracing: Increase tracing map KEYS_MAX size"),
> > 'keys' supports up to three fields.  
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks Masami.

> 
> Steve, do you this this document fix should go into the stable trees?

We could label it as stable. Sure.

Jon, do you want to tag this for stable and pull it through your tree?

Should probably add a Fixes tag with the above commit.

-- Steve


> 
> Thank you,
> 
> > 
> > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > ---
> >  Documentation/trace/histogram.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> > index c1b685a38f6b..87bd772836c0 100644
> > --- a/Documentation/trace/histogram.rst
> > +++ b/Documentation/trace/histogram.rst
> > @@ -39,7 +39,7 @@ Documentation written by Tom Zanussi
> >    will use the event's kernel stacktrace as the key.  The keywords
> >    'keys' or 'key' can be used to specify keys, and the keywords
> >    'values', 'vals', or 'val' can be used to specify values.  Compound
> > -  keys consisting of up to two fields can be specified by the 'keys'
> > +  keys consisting of up to three fields can be specified by the 'keys'
> >    keyword.  Hashing a compound key produces a unique entry in the
> >    table for each unique combination of component keys, and can be
> >    useful for providing more fine-grained summaries of event data.
> > -- 
> > 2.25.1
> >   
> 
> 


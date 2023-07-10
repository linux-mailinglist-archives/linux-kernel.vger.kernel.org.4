Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C874D093
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGJItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGJItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:49:41 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CBC3;
        Mon, 10 Jul 2023 01:49:40 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso54785535e9.0;
        Mon, 10 Jul 2023 01:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688978979; x=1691570979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HwV3UkEkNArn08rHfYqKJNn2/lAt35vAipu5aJAzUk=;
        b=mITH3vE8NGXs0FXSEn00pMu+nbQcrHdz5CpI06wWwORbh8Z3QjYdFOXB6kUdFzqyqg
         4DoPfxVNS7+0uPBoutk09Uyuf2koimICX7BBdHyS9O3BZOwZbRLKArPcY+IaWUQ/YwDJ
         Hq26pAta9ynsTSslEg+TET0TYF+6eOzs7Qc7/iDcfXkD5wJS/wXbJ4gEI0po0WuRVidi
         tfVY1w2EJNFBYJgjKm8cTOjRKIgvrR2DSy0E0v14kmv1QS6SmQF5usBwrkKD8lqhT619
         aK8OOho77H5w/l4dZrpLFHeY/mnhlXCIoaUGz/3RqXaiiMx1q9EVgyR1stsFPXgkxkIP
         IBVw==
X-Gm-Message-State: ABy/qLbqUkbAYss7bc9iUB3Zn7l2K+J3JMMLa14wEdPrhN5GxNC0OtDn
        9o2lNBbVTo/PUv690YgbNcQ=
X-Google-Smtp-Source: APBJJlFY7RJWgradJGfKyfSbfVLRNaXYxUZsHNesSfxwHiaBLTtgBsoFXv6KKg6hrgaK9bGTcJutAA==
X-Received: by 2002:a7b:cc15:0:b0:3fb:9ef1:34ef with SMTP id f21-20020a7bcc15000000b003fb9ef134efmr16249506wmh.37.1688978978943;
        Mon, 10 Jul 2023 01:49:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b003fbdf8292a7sm9614997wmk.46.2023.07.10.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:49:38 -0700 (PDT)
Date:   Mon, 10 Jul 2023 01:49:36 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, tj@kernel.org, stephen@networkplumber.org,
        Dave Jones <davej@codemonkey.org.uk>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] netconsole: Append kernel version to message
Message-ID: <ZKvGIGbWa751sfTA@gmail.com>
References: <20230707132911.2033870-1-leitao@debian.org>
 <20230707161050.61ec46a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707161050.61ec46a8@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:10:50PM -0700, Jakub Kicinski wrote:
> On Fri,  7 Jul 2023 06:29:11 -0700 Breno Leitao wrote:
> > Create a new netconsole runtime option that prepends the kernel version in
> > the netconsole message. This is useful to map kernel messages to kernel
> > version in a simple way, i.e., without checking somewhere which kernel
> > version the host that sent the message is using.
> > 
> > If this option is selected, then the "<release>," is prepended before the
> > netconsole message. This is an example of a netconsole output, with
> > release feature enabled:
> > 
> > 	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test
> > 
> > Calvin Owens send a RFC about this problem in 2016[1], but his
> > approach was a bit more intrusive, changing the printk subsystem. This
> > approach is lighter, and just append the information in the last mile,
> > just before netconsole push the message to netpoll.
> > 
> > [1] Link: https://lore.kernel.org/all/51047c0f6e86abcb9ee13f60653b6946f8fcfc99.1463172791.git.calvinowens@fb.com/
> > 
> > Cc: Dave Jones <davej@codemonkey.org.uk>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Looks good! net-next is closed for the duration of the merge window 
> so you'll need to repost next week, and please put [PATCH net-next v3]
> as the subject prefix while at it.
> 
> > @@ -332,6 +350,11 @@ static ssize_t enabled_store(struct config_item *item,
> >  	}
> >  
> >  	if (enabled) {	/* true */
> > +		if (nt->release && !nt->extended) {
> > +			pr_err("release feature requires extended log message\n");
> > +			goto out_unlock;
> > +		}
> 
> This is the only bit that gave me pause - when parsing the command line
> you ignore release if extended is not set (with an error/warning).
> Does it make sense to be consistent and do the same thing here? 
> Or enabling at runtime is fundamentally different?

That is a good point, this patch ignores "release" if extended feature
is disabled in the command line, but, fails if "release" is set and
extended is not.

Looking at the other behaviours (netpoll parsing_ in the code, I think
the best approach is to also fail on both cases.

I'll fix it in v3.

Thanks for the review!

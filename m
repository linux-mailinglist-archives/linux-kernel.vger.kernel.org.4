Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2225864B8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiLMPlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiLMPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:41:14 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6517E13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:41:10 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h16so146861qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Booe6nI0TUEldGfErdQTOMrKdr1GReR42/ioyDdkr50=;
        b=cN9rJJhO4ti7h2fvMWbAqen4vauwfr8y5M6r2M60M3bZ9FmpWr4klBB9SxVOw4mtma
         T5HcjsT+wzq40iESZicRoUyGfqXenxlFhEFl+YFt5eI69Ov8BTu5wYo2CoY+bfUxtWwd
         1NpEykv1J4IfaF45qE2ALEeLUC6TCpkLAQqBTBEeIaYtT1z7S4klXwcb5D5LBCOTUXSb
         m4KjN7NjP7A9yeh2mALjfZPSEUQjvIMKETLbbZZPylTLIRN7eX052sHqGdc3geKIHV2a
         EWGSerNFAdBL/Jkh4MhKA2yR8F711fWEZ5xob//DNNAy/BWaTKwPlOXGIuOAWzsqcINO
         uCBg==
X-Gm-Message-State: ANoB5plot10YxAD+YYpNVY1wxg1ZUv/0kaaOnX1MEdN0hxWilhGUlud7
        MS7dTo7KL0HTsMXPYZbyWvY=
X-Google-Smtp-Source: AA0mqf5EfoHW7+I928rjGZkP/p706FUdT2q2RAImuoky/XrebSomQQPTlumg0X10xJKU+aOZBekwJA==
X-Received: by 2002:ac8:6654:0:b0:3a7:eb78:2836 with SMTP id j20-20020ac86654000000b003a7eb782836mr31074222qtp.38.1670946069491;
        Tue, 13 Dec 2022 07:41:09 -0800 (PST)
Received: from fedora ([216.211.255.155])
        by smtp.gmail.com with ESMTPSA id cf22-20020a05622a401600b003a816011d51sm67050qtb.38.2022.12.13.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:41:08 -0800 (PST)
Date:   Tue, 13 Dec 2022 07:41:07 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] percpu changes for v6.2-rc1
Message-ID: <Y5idE7pw3ZNtXhVT@fedora>
References: <Y5dhRrNFzNX1Z64/@fedora>
 <CAHk-=wifBA8qdHp8kySVq6=iyaYmKXfSON7=5s9aWyfpL=Yy1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifBA8qdHp8kySVq6=iyaYmKXfSON7=5s9aWyfpL=Yy1w@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 04:11:28PM -0800, Linus Torvalds wrote:
> On Mon, Dec 12, 2022 at 9:13 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Baoquan was nice enough to run some clean ups for percpu. There will be
> > a minor merge conflict with Vlastimil's slab PR [1]. This is due to
> > adjusting the PERCPU_DYNAMIC_EARLY_SIZE up for proper early percpu
> > reservation size on arm64 with 64k pages.
> 
> Well, the merge was trivial, but...
> 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-6.2
> 
> Argh, this is a plain branch. I was really hoping that we had all
> moved on to using signed tags for pulls.
> 
> I've pulled this, because I still don't absolutely _require_ signed
> tags for kernel.org accounts, but can you please try to start using
> them in the future?
> 
> The plain unsigned branches (and unsigned tags) are getting rare
> enough that I'm slowly starting to consider making them a hard
> requirement. Not this release, probably not the next one, but...
> 

Got it. I'll send you signed tags from now on. Thanks for pulling this.

Thanks,
Dennis

>                 Linus

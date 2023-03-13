Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855C6B8078
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCMS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCMS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:27:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33672838A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:26:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so8649469ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678731966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNpONYyMLc+O1cKJ44IbWyBUFtwAAv8E60RL7W04AJs=;
        b=TvMwO/eRVJjtB5Li/d+OdXqri6XouTMznM1hLlNq+N1QlMcq5ib4hDjeR8W2r/Bu6F
         husjX1IJLLGago3Ee0Sxi1ZJZVDJjno//1cZPO3pABr5lUDq6gvx0o3YtbRNXwLJgoFD
         f+tDflU1C3bidWnVdF9zqqx43WogpaF4CTL7czigncnO0AZquvqjQ4kXZayjWteAKO2+
         YZORJe3tr6kTIM3ubTaK4YxnRRZDhb7VxW5/WdqHRagLtCnyy8XVEUd62ma/1EY9TYVb
         6SAb6wY9mbbdLKi4xh8mDrDyY3BlN3tiJo1GshOnl46swXN+oHEFrQqd324xuJKNAfUD
         AAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNpONYyMLc+O1cKJ44IbWyBUFtwAAv8E60RL7W04AJs=;
        b=AbXjGV5apDumytTg8BjAqN0JCkHOkE4zUpLoP/wd25Kqba2SbDG2TmHJTGvXfSYYB9
         Do2w8qhXv3IszvFRnThewBmggtmC8l0GsnjIbGb2KonxgG3t0S/hBXtg7HlryPCfVEWN
         oCnzIn4AN3L4FuyZN+00YUZSDsXZ3Plvk4OFeH3S5YgMm31Cs/S6Bg3zv9pVSlpbOVD3
         jTQt1/0tqfj8N/oXVEtfOZyG3PYBaxKRW8v7PQ8k2ezMANTGvkryhfBxKv2ZOZ5O02sP
         6snrUixdSbLLiXnaVAO/nyEcfp+ZSbpiBCrcByx7KZ/gepvZDjz6/epkd1OXsfOCe2IC
         CR7A==
X-Gm-Message-State: AO0yUKUBW07vgZnFejxuBKKZUA26VB8+DigxJSYzr/hvNwrg6MiEJW3b
        wWaVjnv9gfllkXYJMUoI/sboI/HGQQnJBJer
X-Google-Smtp-Source: AK7set+Z8ronD1GN+O2t9fXb5cb2hJc2oxsGuVi0IlG9McCgm+whf9GReA9jIB1G/rvu3znojVY/3A==
X-Received: by 2002:a17:907:3186:b0:92b:dff4:f8e9 with SMTP id xe6-20020a170907318600b0092bdff4f8e9mr1804273ejb.8.1678731965814;
        Mon, 13 Mar 2023 11:26:05 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709064a8500b008e7916f0bdesm102538eju.138.2023.03.13.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:26:05 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:26:03 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA9qu+E/gPZ68mw4@khadija-virtual-machine>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
 <9938109.ZD9C4EEAuf@suse>
 <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
 <ZA9ZY91K8iQtn0ev@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA9ZY91K8iQtn0ev@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:12:03AM -0700, Alison Schofield wrote:
> 
> It sounds like the git commit hook for checkpatch, suggested in
> the tutorial, would have saved you here. Please look that up.
>

Hey Alison!
I had set up git post-commit hook following the tutorial. The script
showed the errors, but I ignored them before. I have submitted another
patch. I had 'trailing white spaces' errors in my code and removed them
in the new patch after consultation from 'coding-style.rst' file.

> Also see the section "Following the Driver commit style"
> And, there are sections on revising patchsets too.
> 
> Much of the info in the tutorial doesn't make sense until you
> need it. So, keep reviewing it to catch more useful info.
>

Yes!! No matter how many times I read the tutorial, I still end up
getting back to it! :)
Thank you!

Regards,
Khadija

> More on running checkpatch:
> - Add that git commmit hook.
> - The final checkpatch run can be on the formatted patches.
>   After you've done git format-patch and have a .patch file you
>   are thinking of sending, run it again. 
> 
> Something like this:
> scripts/checkpatch.pl --no-tree --strict --codespellfile=/usr/bin/codespell ~/my_patches/*.patch
> 
> > 
> > Also, I had one question. Is it okay to write a long subject as I have
> > used in this patch? 
> This is in the tutorial. section "Following the Driver commit style"
>
> > 
> > Regards,
> > Khadija
> > 
> > > >  drivers/staging/axis-fifo/axis-fifo.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > 
> > > 
> > > 
> > 

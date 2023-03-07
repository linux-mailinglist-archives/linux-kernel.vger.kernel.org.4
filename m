Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAFF6ADD7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCGLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCGLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:33:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4148C2721
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:32:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j11so31388483edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678188775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiDoMgPguVRDoOdt7v+G+rTfGrO+m61olXH7zbIH4gg=;
        b=iFp6JvQIixohY4/BBzT/zOyLGZW9lW4N2C2yWUC2OhMzjTEu3Q2rLkFueK7BhHkhpf
         OSQ3hd1hxQILHmcAnZfDBvZTWHDuJZNYAIKttqDqx2t9hGSeFjTV7jC2D2tTNHyJ3C+I
         X5PUiENl+95h17BecQuYnmoOXoDih9ki7GbJYtaLLWQECljE/jhVEWZZcv60aTorcix8
         D1HxASlDDsaaPRZ+ObDLYSUIN1BY96zjMhpk6ME2Vi4t1wV/FgzyeqLjGddLFsAsBKv2
         uhH2cDE8lHfDHET2NX8dF9bLRrskJHahIrAB6dr74e5St23xKdZxQVk6A2Nn8LoCSoMc
         naHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678188775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiDoMgPguVRDoOdt7v+G+rTfGrO+m61olXH7zbIH4gg=;
        b=z3fOIF6ZOSnaHhs4M4xFxhqJp/XHYIPRDcIyfRDLcl817rSqV1ducvq2RMpwxeSySP
         2NTJiAoraGBHGd6wOixkdoF3okjp4m8RMqzNsAiiljsPF5N47W356lXj8tnCskH5R5X1
         ww9J1JM8Dws9Htjl9X/x6QeX0ndK/nKuUrk9Q5sUCTFKUGL7tRljYxV4wEAsGM1uMbO7
         u7pRYuYZ1MpmXAMnV12rQsnGB730W1AIO9ncddlAsgUizRm1dXqrHZYyk+365GO454gZ
         bfm5C33uygjzM6xFkcqzhye1lM7Us4oRQDC2lDdSUft7VVt25t66PfCAQalNq74qTvnb
         22Rg==
X-Gm-Message-State: AO0yUKU3pLJ15fPmzYbt2yxVEwWL0IfG9x/ibfEas6piOBMg+jQywxBO
        kgkTSqqzWe6Lmi5k1GyXhW8=
X-Google-Smtp-Source: AK7set807sqE4Ga6zKjwdlnf+kCVQ++djtYpExWIUXBlspClRcIsCv0GxT2HdmAbLY8hXtqDkcAnUw==
X-Received: by 2002:a17:907:8a10:b0:8f8:7a2b:cc0d with SMTP id sc16-20020a1709078a1000b008f87a2bcc0dmr20457434ejc.47.1678188774897;
        Tue, 07 Mar 2023 03:32:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id rl10-20020a170907216a00b008baeb5c9bdbsm6016886ejb.141.2023.03.07.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 03:32:54 -0800 (PST)
Date:   Tue, 7 Mar 2023 14:32:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@ver.kernel.org
Subject: Re: Who is looking at CVEs to prevent them?
Message-ID: <4f8e6d29-a60a-47e2-bd7b-8c66bb9ee0dc@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307110029.1947-1-hdanton@sina.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:00:29PM +0800, Hillf Danton wrote:
> On 7 Mar 2023 12:51:14 +0300 Dan Carpenter <error27@gmail.com>
> > On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
> > > CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
> > > ksmbd_decode_ntlmssp_auth_blob
> > > 
> > > 5.15, 6.0, and 6.1 were fixed.
> > > 
> > > Fixed status
> > > mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
> > > stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
> > > stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
> > > stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]
> > 
> > Sorry, I have kind of hijacked the cip-dev email list...  I use these
> > lists to figure out where we are failing.
> > 
> > I created a static checker warning for this bug.  I also wrote a blog
> > stepping through the process:
> > https://staticthinking.wordpress.com/2023/03/07/triaging-security-bugs/
> > 
> > If anyone wants to review the warnings, just email me and I can send
> > them to you.  I Cc'd LWN because I was going to post the warnings but I
> > chickened out because that didn't feel like responsible disclosure. The
> 
> Given the syzbot reports only in the past three years for instance, the
> chickenout sounds a bit over reaction.

Yeah.  Really just posting the code and the results seems like the best
way forward to me too.  That's how syzbot does it and it's the only
realistic way forward.

The good thing is that static checker warnings are much easier to
analyse than syzbot warnings.

> 
> > instructions for how to find these yourself are kind of right there in
> > the blog so it's not too hard to generate these results yourself...  I
> > don't really have enough time to review static checker warnings anymore
> > but I don't know who wants to do that job now.
> 
> If no more than three warnings you will post a week after filtering, feel
> free to add me to your Cc list, better with the leading [triage smatch
> warning] on the subject line the same way as the syzbot report.

I've sent you the complete list just so you can see what there is.
I want to get out of the filtering business as much as possible.  I want
more people involved at all stages really.  Writing checks.  Reviewing
warnings.

regards,
dan carpenter

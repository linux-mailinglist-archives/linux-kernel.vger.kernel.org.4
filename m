Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6755867EBC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjA0Q7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA0Q7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:59:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30470213D;
        Fri, 27 Jan 2023 08:59:44 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r132so4673598oif.10;
        Fri, 27 Jan 2023 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuc3tclMngpgJkRdKqMDtEnHq9IobDeEAM5VzXHLDtI=;
        b=j4/PFguW9sg7XvpdGJgv3o0vcxMXINgw9XTS0bPmPDuyJUKeWTb5TvMtzHm86uUPOp
         Iho4vvr9aUVqwxy/fn7CetIMBh596Hkl2w3nPuFNn8UrUhkDAZi6gFOfQ+9LpqVXeNKU
         p2pZ2o3cAVgFbnOMbEHVQzJosvQkr6r5AxgrQbYCOm9m6p3KdH/DluTYA6/6Cw3RUAWQ
         YYy9E0+dgB3tX9r/6/YHycka4jDKb1D85IsA/ZaSdrGj8ivgcRvN7fmu8zy3Ms1Xploj
         9PNBtlLo47xLok7C3Xkp17bg+r1y6v6fqkqSEZGuAu7XGb4i+T2NQxJrdDZkragU4HYs
         cOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuc3tclMngpgJkRdKqMDtEnHq9IobDeEAM5VzXHLDtI=;
        b=kB36w71Y9EgQdwwqyQd/E+q0NBIoeK/Eixg5KbYZ51QS6rKPWC6GoMNxyjMC7r6+8o
         Msoluma4OGjrP/SdyhAYh8EyFBaEm/RE22eqmwK/dNPiJ+IIyd+Qco4OYnp+Kbu9zfCL
         bmy5WE1WQUUGbEO33BAf8KHPzXWSRhpkZe0bOLCuyMFk8Vu9rloHThArV+wJhcOd7ZNf
         dZoHCXelOtPQeMpwOWedtZx5iFnenQ14NX6vAbb5on36LRd5b7bhwQpD9Kcso3tL5nyz
         Ip2pvt6OMhOSpKgkZKc+ddM6D3cBXI6vRUaviiohlvoDdAYhvFf1hmuTeg+BsN+aFmfU
         r3Qg==
X-Gm-Message-State: AO0yUKWM+Q7j7rjzyR+0dKRyMootZPlRc2Ns1oOu02GLDnXr+RVp80My
        lDoQkavviYLTkVKM3qGMMjNi3cO5n5c=
X-Google-Smtp-Source: AK7set+FMo4TV/ejRDS/j54EnWPu1nFjcteSA16DMM+w8OhhaEd5qpIljIkvwOpJ8+M/K9iNfSIc6A==
X-Received: by 2002:a05:6808:1819:b0:364:a651:38eb with SMTP id bh25-20020a056808181900b00364a65138ebmr3801504oib.17.1674838783491;
        Fri, 27 Jan 2023 08:59:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b67-20020aca3446000000b00364e8f85c08sm1749676oia.21.2023.01.27.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:59:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Jan 2023 08:59:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Song Liu <song@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
Message-ID: <20230127165941.GB3962737@roeck-us.net>
References: <20230125185004.254742-1-song@kernel.org>
 <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
 <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
 <Y9Lp+5mqxP0bgvrM@bombadil.infradead.org>
 <20230127131351.GB3911997@roeck-us.net>
 <CAPhsuW5jyo7gHyfojZArWXp5rOMsR9xWJEE62GhABXKSWKK8VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5jyo7gHyfojZArWXp5rOMsR9xWJEE62GhABXKSWKK8VA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 08:42:57AM -0800, Song Liu wrote:
> Hi Guenter,
> 
> On Fri, Jan 27, 2023 at 5:13 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Jan 26, 2023 at 01:00:43PM -0800, Luis Chamberlain wrote:
> > > Guenter Roeck,
> > >
> > > Any chance you can give this branch a good spin on your multi-arch setup
> > > to see what may below up?
> > >
> > I assume I shoud test v3 ?
> 
> Yes, please. The one in the modules-testing [1] branch is already v3.
> 

I started a test on v6.2-rc5-52-gc96fb00e9ddf.

Guenter

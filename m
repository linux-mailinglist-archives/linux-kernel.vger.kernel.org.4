Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724F6DB9C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDHJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:04:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D8D31B;
        Sat,  8 Apr 2023 02:04:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qa44so1522312ejc.4;
        Sat, 08 Apr 2023 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680944681; x=1683536681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cdYqCPIoUBwqMVtJ32v9H7IHcMMjCChlDRtGHdvM84=;
        b=H1hS+9lMNiwLD/7qZjyewtlANwmbelhVraRQffgchW9ExWCI9Oo90AiltydgPp5GnB
         Es9GEFClUakcbwYH5PxHQf5t9hPTzTZxAPxw6zRdRl75tox/DngieYwIjkELN8WcIBKQ
         CfgcukZIf96748//lt+KLIpm+5exDKMuSXUOwvjsGYPr4CKhb9DF/TBABagzLPS5C5Bo
         uiMnSkSJ453fhG2cNKVYySEyR/0oPmt2VaSSHI/rz6+ZIk9sfrFwglybtn7QU3LZ9J1x
         ptbZUUDswyeLoyvT4uNYPz8lWYlL5VC/9KDf7hEZOND83AaKVO4EKyvfRlMzIeY+JdqI
         OIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680944681; x=1683536681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cdYqCPIoUBwqMVtJ32v9H7IHcMMjCChlDRtGHdvM84=;
        b=aSMhBsVb3iAHZmpss1FU71XFukV+uw/HibGZx8goH9YozPqFI0dEvoqoRHoAtVvCTt
         6mcwcwdovtvnEMSSNJENkcUMDSo8vJKEFfJbOkVxmKGty0MCAeuXpRP34yvT6GZtjygm
         9fvDQn7AKh7jBErn9cUTOE2u0j4zQhvGORKfCWRoP/QYVb65nzPuVAUj1Z97BbG375yP
         Wiqt+59i5e9prdpKTNBtZRuYXbtrQaemnGODp7l2SwHDZ3Afw/mEnH45phiGyT2N7xEu
         6yXpwA4t2CA+vz9+s0xXaD9S2ONGZuv7ox0yWXv2WbOxmuSJlPSmXgnouwae9a/Z+RuN
         bOVw==
X-Gm-Message-State: AAQBX9cz4LiIIYkDysdQfU4Q4ON0ztam/vea+Kav+o/KPnpY4gdvvxoY
        ZKmuBCmWBzQJPThjsZkZjBY=
X-Google-Smtp-Source: AKy350bvgfOMkvLG8lzYW9wWHZzd8o+/9WSLzBssMxgJwrDLvcPmebKbhOH43UoAdZ0p18POFbt5sA==
X-Received: by 2002:a17:907:3207:b0:906:4739:d73e with SMTP id xg7-20020a170907320700b009064739d73emr1152144ejb.2.1680944680602;
        Sat, 08 Apr 2023 02:04:40 -0700 (PDT)
Received: from pc636 (49-224-201-31.ftth.glasoperator.nl. [31.201.224.49])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906344800b009334edaed98sm2950076ejb.50.2023.04.08.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 02:04:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 8 Apr 2023 11:04:39 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDEuJwnkpkr717Fr@pc636>
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
 <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
 <PH0PR11MB58809B44F396B7C074BDC704DA919@PH0PR11MB5880.namprd11.prod.outlook.com>
 <9427c261-0395-4e03-8f93-2e0588fadd1f@paulmck-laptop>
 <MW5PR11MB5858999E104C21754DEB40F3DA969@MW5PR11MB5858.namprd11.prod.outlook.com>
 <c0fed568-db45-4302-b204-b4f707bba140@paulmck-laptop>
 <PH0PR11MB5880D0D946C20C4DEE3AEF99DA979@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880D0D946C20C4DEE3AEF99DA979@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 01:56:40AM +0000, Zhang, Qiang1 wrote:
> On Fri, Apr 07, 2023 at 01:26:39AM +0000, Zhang, Qiang1 wrote:
> > > >>On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> > > > On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > > > > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > > > > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > > > > page cache again in kfree_rcu_monitor(), this commit add a check
> > > > > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > > > > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > > > > cache growing.
> > > > > 
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 9cc0a7766fd2..f25430ae1936 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2907,6 +2907,8 @@ static inline bool
> > > > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > > >  	struct kvfree_rcu_bulk_data *bnode)
> > > > >  {
> > > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > > +		return false;
> > > > >  	// Check the limit.
> > > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > > >  		return false;
> > > > > -- 
> > > > > 2.32.0
> > > > >
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > >
> > > >Thank you both!
> > > >
> > > >One question, though.  Might it be better to instead modify the "for"
> > > >loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
> > > >of starting at zero?  That way, we still provide a single page under
> > > >low-memory conditions, but provide rcu_min_cached_objs of them if memory
> > > >is plentiful.
> > > >
> > > >Alternatively, if we really don't want to allow any pages at all under
> > > >low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
> > > >to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
> > > >flag is set?  
> > > 
> > > Hi, Paul
> > > 
> > > If the krcp->backoff_page_cache_fill is true, the put_cached_bnode () return false,
> > > the allocated single page will also be freed in fill_page_cache_func().
> > > 
> > > or it would be better not to allocate under memory pressure.
> > >
> > >That was my thought.  ;-)
> > >
> > > How about like this?
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9cc0a7766fd2..94aedbc3da36 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2907,6 +2907,8 @@ static inline bool
> > >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > >         struct kvfree_rcu_bulk_data *bnode)
> > >  {
> > > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > > +               return false;
> > >         // Check the limit.
> > >         if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > >                 return false;
> > > @@ -3220,7 +3222,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > >         int i;
> > > 
> > >         nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > -               1 : rcu_min_cached_objs;
> > > +               0 : rcu_min_cached_objs;
> > > 
> > >         for (i = 0; i < nr_pages; i++) {
> > >
> > >The other question is why this loop does not allow for any pages
> > >that might already be allocated, thus perhaps looking like this:
> > >
> > >		for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
> > >
> > >Or do we somehow know that krcp->nr_bkv_objs is equal to zero?  (I am not
> > >seeing this, but I do feel the need to ask.)
> > 
> > 
> > The fill_page_cache_func() is triggered when we invoke get_cached_bnode() return NULL,
> > this also means that krcp->nr_bkv_objs is equal to zero. 
> > But if can_alloc is set,  we will unlock krcp0->lock and allocated single page,  after that
> > we will reacquire krcp1 and lock,  but the krcp1 at this time may be different from the
> > previous krcp0,  if !bnode is true, also trigger work to invoke fill_page_cache_func(),  but
> > maybe the krcp1-> nr_bkv_objs is not equal to zero.
> >
> >OK.  Given all of these good points, what would be a good patch for
> >this issue?  ;-)
> 
> Is it possible to keep the filling of the page always on the correct krcp?
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3303,7 +3303,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>                         // scenarios.
>                         bnode = (struct kvfree_rcu_bulk_data *)
>                                 __get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> -                       *krcp = krc_this_cpu_lock(flags);
> +                       raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
>                 }
> 
I do not expect any contention if this is applied. From the other
hand it might be that it was done deliberately for some reason or
because we most likely anyway stay on the same CPU.

I did some test to see how many times a migration occurs during this
small window and according to my data it was negligible.

Anyway i do not have any objections as of now against this change
and it looks correct to me.

--
Uladzislau Rezki

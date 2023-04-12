Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE36DF54C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjDLMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDLMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:32:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE94C1F;
        Wed, 12 Apr 2023 05:32:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t14so14356634lft.7;
        Wed, 12 Apr 2023 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302753; x=1683894753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QYOiVGqE/0Wejv7bwdICXlN6AMo/RW9EAzcz7EIT7TU=;
        b=ZgPJctoM/017w1rVmRk5PL9SGgEsJGOe6y2KICzm5tSiZcxkWGMJ/Cmv6lhgmKR/Ex
         msndC04ICS9dH3gxGATnrGJdY9/ZOjoh0WD1u5s0QC7RUeG1ZPU3L20cf5gYo3OI0AZB
         Lo6hRtWMU+Ojba0MvWIg97M4olEr03dI0y6tS9aGwks0kXt3INxTzIqPcdanOxMmgI/p
         uSvXzs4QYS60a8CtJt3toFoVZy7XZ2W0GssuXIAhCVtDXdHbZqvUmgFXpLOVvMGwoDpw
         idnBsVmEG4e1IMKxCFX2X9Zt5HzQs7jXPp0vf+IsTC/VTWvPXUpW7Fqqc/bYi1ElEtDj
         kNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302753; x=1683894753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYOiVGqE/0Wejv7bwdICXlN6AMo/RW9EAzcz7EIT7TU=;
        b=tPeDi9AvgrgQJMfF2jf1AmKbwF5WrSg64tAw6XsRhYkgqdbeSvGR0f9GnLOzSC5AbA
         y9HjJt83jtdrKABK3A/9e98Qg5x0ksErorFqLWUJl3i9KCs8VEs8SnvRBD+fqi/5vP7E
         eMWcwYiHESc50NR03DNEMz6AY8PCXparnslXGcarbCZb8pNxzs36c9EY1yx+aTammafX
         fkbTeLcyvzzHBrFsMz4m11ErbCCqS+9JUzAqKoPcX7eLwI2psMG5P0G3KUcenfM0Xkn2
         KpvW/bWa5hW7xteTjQR7O2AXLNm4f3h0RtEvGjOKz1404lJc4wBSwrbgYSTEmeLE/Xhv
         4j8Q==
X-Gm-Message-State: AAQBX9dSFRZpBgQvck+s2eMXFSnGzQEfO94hMcSSPG5/VapU+ZeydAh0
        izGRhVCsncaxZiSC07YBoxY=
X-Google-Smtp-Source: AKy350b2sFb54xXOZARlqhbnV8XKgGakB/guHJv/4PVRwUAnHCtoIDjwg4Gtff5mUa3apJu45isIGg==
X-Received: by 2002:a19:7610:0:b0:4ec:a115:6e4c with SMTP id c16-20020a197610000000b004eca1156e4cmr481316lff.68.1681302753037;
        Wed, 12 Apr 2023 05:32:33 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24842000000b004eaf41933a4sm665135lfy.59.2023.04.12.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:32:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 12 Apr 2023 14:32:30 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <ZDak3oyPlHvMB+CR@pc636>
References: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
 <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
 <ZDWUgygOqJjs07pp@pc636>
 <PH0PR11MB588060C9B6BE6F08540E74DCDA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB588060C9B6BE6F08540E74DCDA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:14:15AM +0000, Zhang, Qiang1 wrote:
> 
> > On Tue, Apr 11, 2023 at 04:58:22PM +0200, Uladzislau Rezki wrote:
> > > On Tue, Apr 11, 2023 at 02:42:27PM +0000, Zhang, Qiang1 wrote:
> > > > > > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() 
> > > > > > is executed before kfree_rcu_monitor() to drain page cache, if 
> > > > > > the bnode structure's->gp_snap has done, the kvfree_rcu_bulk() 
> > > > > > will fill the page cache again in kfree_rcu_monitor(), this 
> > > > > > commit add a check for krcp 
> > > > > > structure's->backoff_page_cache_fill in put_cached_bnode(), if 
> > > > > > the krcp structure's->backoff_page_cache_fill is set, prevent page cache growing and disable allocated page in fill_page_cache_func().
> > > > > > 
> > > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > > >
> > > > > >Much improved!  But still some questions below...
> > > > > >
> > > > > >							Thanx, Paul
> > > > > >
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> > > > > > cc34d13be181..9d9d3772cc45 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -2908,6 +2908,8 @@ static inline bool  
> > > > > > put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > > > >  	struct kvfree_rcu_bulk_data *bnode)  {
> > > > > > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > > > +		return false;
> > > > > >
> > > > > >This will mean that under low-memory conditions, we will keep 
> > > > > >zero pages in ->bkvcache.  All attempts to put something there will fail.
> > > > > >
> > > > > >This is probably not an issue for structures containing an 
> > > > > >rcu_head that are passed to kfree_rcu(p, field), but doesn't 
> > > > > >this mean that
> > > > > >kfree_rcu_mightsleep() unconditionally invokes synchronize_rcu()?
> > > > > >This could seriously slow up freeing under low-memory 
> > > > > >conditions, which might exacerbate the low-memory conditions.
> > > > > 
> > > > > Thanks for mentioning this, I didn't think of this before😊.
> > > > > 
> > > > > >
> > > > > >Is this really what we want?  Zero cached rather than just fewer cached?
> > > > > >
> > > > > >
> > > > > >
> > > > > >  	// Check the limit.
> > > > > >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> > > > > >  		return false;
> > > > > > @@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> > > > > >  	int i;
> > > > > >  
> > > > > >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> > > > > > -		1 : rcu_min_cached_objs;
> > > > > > +		0 : rcu_min_cached_objs;
> > > > > >  
> > > > > >  	for (i = 0; i < nr_pages; i++) {
> > > > > >
> > > > > >I am still confused as to why we start "i" at zero rather than 
> > > > > >at
> > > > > >->nr_bkv_objs.  What am I missing here?
> > > > > 
> > > > > 
> > > > > No, you are right, I missed this place. 
> > > > > 
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2908,6 +2908,8 @@ static inline bool  
> > > > > put_cached_bnode(struct kfree_rcu_cpu *krcp,
> > > > >         struct kvfree_rcu_bulk_data *bnode)  {
> > > > > +       if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > > +               return false;
> > > > >
> > > > >This is broken, unfortunately. If a low memory condition we fill 
> > > > >fill a cache with at least one page anyway because of we do not 
> > > > >want to hit a slow path.
> > > > 
> > > > Thanks remind, please ignore my v4 patch,   how about the following?
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> > > > 41daae3239b5..e2e8412e687f 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3238,6 +3238,9 @@ static void fill_page_cache_func(struct work_struct *work)
> > > >                         free_page((unsigned long) bnode);
> > > >                         break;
> > > >                 }
> > > > +
> > > > +               if (atomic_read(&krcp->backoff_page_cache_fill))
> > > > +                       break;
> > > >         }
> > > It does not fix an "issue" you are reporting. kvfree_rcu_bulk() 
> > > function can still fill it back. IMHO, the solution here is to 
> > > disable cache if a low memory condition and enable back later on.
> > > 
> > > The cache size is controlled by the rcu_min_cached_objs variable. We 
> > > can set it to 1 and restore it back to original value to make the 
> > > cache operating as before.
> > 
> > It would be best to use a second variable for this.  Users might get 
> > annoyed if their changes to rcu_min_cached_objs got overwritten once 
> > things got set back to normal operation.
> > 
> >Agree. So we do not make it visible over sysfs interface for user that we manipulate it.
> >
> >
> 
> 
> The rcu_min_cached_objs is read-only, Users cannot be set rcu_min_cached_objs dynamically. 
> 
> -r--r--r-- 1 root root 4.0K Apr 12 01:08 rcu_min_cached_objs
> 
You can set it as a boot parameter: rcutree.rcu_min_cached_objs=XXX

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 41daae3239b5..0e9f83562823 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2909,7 +2909,8 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
>         struct kvfree_rcu_bulk_data *bnode)
>  {
>         // Check the limit.
> -       if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> +       if ((atomic_read(&krcp->backoff_page_cache_fill) && krcp->nr_bkv_objs) ||
> +                               krcp->nr_bkv_objs >= rcu_min_cached_objs)
>                 return false;
> 
We can eliminate the backoff_page_cache_fill per-cpu atomic variable and
just change a new one, say, min_cached_objs, if a low memory condition.
Restore it to a default what is the rcu_min_cached_objs.

I can post here an example if it helps to make it more clear.

--
Uladzislau Rezki

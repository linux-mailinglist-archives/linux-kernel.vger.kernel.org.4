Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08DB5F45EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJDOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJDOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:53:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6C631F6;
        Tue,  4 Oct 2022 07:53:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x40so4929992ljq.9;
        Tue, 04 Oct 2022 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=tb5CpuzxP6xt4+1sFoCHk1v84czst0av0IH4YCab41s=;
        b=j4uqX9bwVUNhbCI3EWfeakJCNaTw+7qy/isjwBex9FKKTvaPh5+hch7TsHTiKMgRa3
         0rZWg3Vy77IGp1Zi9ADDIjgC3C78N8JBj2j8JRepY7Yme6TS6iCdcaCN8O2SamPksWXS
         IqyEz8arLupHBE0C11X6JNggygGNgHv8zQ5ZMsiHYdXEhUpEcEDXOf8oOBgvjpQS6DKz
         eXwVWoavqKarWeUi3TJdCO6YPhXp73uh+XXiod4Y2Xy19SCBIjoyK8wPos5rdUvKjR7D
         wvSF2jAm/vonwWnED3x5UkH3F9ae4YH12DkxLLicG3O2yERcqCnIm75reyzhQb7Jg2HL
         1KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tb5CpuzxP6xt4+1sFoCHk1v84czst0av0IH4YCab41s=;
        b=UuuNx8OVtIHjHFY/fJ/4AfV9RcgdCHXfSQsbfjI725Gz4ghpegpn9puIkGNoF3yGc+
         Poy7DK10DtjQx8d1WMp2kjQHW/5xS9zb8uFUZDsZyzMcowN/tx2rhLuKJYzseHgvyeFh
         lB6pbD10Y3e9nwxWOTDIRVluj1NqB5Si+68Lli0KPdgcT74odsaLkA0o65ls2TfWVAez
         ssAq1OmGc+OI7pe0n2oKZVcdG+BXG0TtLZP1HHpAe9+GZewF5ujMRDuedh6qlktPuCX6
         HPlXAbQggvim8mlvt+I/kTnkyDTD7vH3F6WEzyTMrBNoM6G1keGfhdM3XJih48s6x0wo
         UCVg==
X-Gm-Message-State: ACrzQf0Zo/ubBPL8LLz+eJ4ipuIazTFI3e+kMY2PHKTGuhkbne2wTUD5
        ODyJK+lo2WHQ6L92Uz5VJeQ=
X-Google-Smtp-Source: AMsMyM7srvOQ65N9QqMGvKub3sS8+lAML89zP6iJl3l6HHajoP8en8sNU+FcpcyYVir7Bx63fZM3mg==
X-Received: by 2002:a05:651c:160c:b0:264:a5ae:7dd2 with SMTP id f12-20020a05651c160c00b00264a5ae7dd2mr8585579ljq.80.1664895192459;
        Tue, 04 Oct 2022 07:53:12 -0700 (PDT)
Received: from pc636 (host-90-235-28-118.mobileonline.telia.com. [90.235.28.118])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512304f00b00497a191bf23sm1929628lfb.299.2022.10.04.07.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:53:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Oct 2022 16:53:09 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <YzxI1frUjDnB6MOP@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
 <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004133004.GD4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:30:04AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 04, 2022 at 01:41:38PM +0200, Uladzislau Rezki wrote:
> > >  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > >  		rcu_nocb_lock_irqsave(rdp, flags);
> > >  		lockdep_assert_held(&rdp->nocb_lock);
> > >  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > -		if (bypass_ncbs &&
> > > +		lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > > +
> > > +		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > > +		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > > +		     bypass_ncbs > 2 * qhimark)) {
> > Do you know why we want double "qhimark" threshold? It is not only this
> > place, there are several. I am asking because it is not expected by the
> > user.
> 
> OK, I will bite...  What does the user expect?  Or, perhaps a better
> question, how is this choice causing the user problems?
> 
Yesterday when i was checking the lazy-v6 on Android i noticed the following:

<snip>
...
     rcuop/4-48      [006] d..1   184.780328: rcu_batch_start: rcu_preempt CBs=15572 bl=121
     rcuop/6-62      [000] d..1   184.796939: rcu_batch_start: rcu_preempt CBs=21503 bl=167
     rcuop/6-62      [003] d..1   184.800706: rcu_batch_start: rcu_preempt CBs=24677 bl=192
     rcuop/6-62      [005] d..1   184.803773: rcu_batch_start: rcu_preempt CBs=27117 bl=211
     rcuop/6-62      [005] d..1   184.805732: rcu_batch_start: rcu_preempt CBs=22391 bl=174
     rcuop/6-62      [005] d..1   184.809083: rcu_batch_start: rcu_preempt CBs=12554 bl=98
     rcuop/6-62      [005] d..1   184.824228: rcu_batch_start: rcu_preempt CBs=16177 bl=126
     rcuop/4-48      [006] d..1   184.836193: rcu_batch_start: rcu_preempt CBs=24129 bl=188
     rcuop/4-48      [006] d..1   184.844147: rcu_batch_start: rcu_preempt CBs=25854 bl=201
     rcuop/4-48      [006] d..1   184.847257: rcu_batch_start: rcu_preempt CBs=21328 bl=166
     rcuop/4-48      [006] d..1   184.852128: rcu_batch_start: rcu_preempt CBs=21710 bl=169
...
<snip>

On my device the "qhimark" is set to:

<snip>
XQ-CT54:/sys/module/rcutree/parameters # cat qhimark
10000
XQ-CT54:/sys/module/rcutree/parameters #
<snip>

so i expect that once we pass 10 000 callbacks threshold the flush 
should occur. This parameter gives us an opportunity to control a
memory that should be reclaimed sooner or later.

--
Uladzislau Rezki

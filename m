Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E517173B0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjFWG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:29:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBA1728
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:29:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b543f7e53aso2126125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687501783; x=1690093783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCEqJX5mm9cbUE56OVCDucRVQniQh/jh7QjO1tCYRyw=;
        b=VCN1cKAzYZWGpOm/hUHuPZp8plVnErZlG9G0OlFzhPpXaNGHYvVufkX79JUDsPqJVj
         SxdYAM9A9ivCYhtFxc3SyvMZr6s5SlnDngyF1CSlxpEdm/HUuOSGwHgmJomuuYgedrRX
         aqax0M2Dw9QUTGwitN8bpL0qLseKhs7EVUc6lepS488qyivLAQHSFGtevNE0LyqUhWPi
         NKkNR95/QZWn2OoaLsjXJllgmMFsp0mHDlbo5o60jR1YeUkdYXlMSdAiD7/jZsXdB48G
         reDdzoxXO5mM4WdQ8i9rMsSwtC5huiBFlnlMXvIXzYTlsiTrC5P7Z8F16npWgNIfnf8B
         ShDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501783; x=1690093783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCEqJX5mm9cbUE56OVCDucRVQniQh/jh7QjO1tCYRyw=;
        b=UCN6yZmpIrFMee31EO56+Axsk5Fqn15Bwy7dBv6Zzq1iUlGk2h0O1KTo7/KxUS3blc
         wY299grXkuWKPBL6DHuasYtoNYhzVacmMuWvCPhZ0husWFGT/B18UhObZYJfxs7qMwYV
         sbIv09cFVFz8H5o1+aTn7oI2IdF+DkswU5u07LaeASaVBRme1oaDdV5Rxr6pg2NqUEi2
         YtM2p8ghZPq9WFN/rqjrvnG5gkH+WUZaQkLHkmCXerZ4dRJ85tKCyxmk7GCaeWi88XhP
         4jgj1Db/xCSy3oYeFtsMBbqdZCUGL3BL34lu4BYMFfRv+QeDf0dfd455OTPuM+//AzPk
         74Gw==
X-Gm-Message-State: AC+VfDxsv/pphjCIbFcYZvnho/R0Ma61Mp0QVplin8GTCY9TJOqxXm8i
        mFyscFnfWwNSF3PZsLE5BZRdQg==
X-Google-Smtp-Source: ACHHUZ6xCu/M/0AOwG5LVLb8OX3DoTsqyFTeplRrHsUG1u2SLkBGduWAm9ZrSI41Zhf0Zeq1UunMJA==
X-Received: by 2002:a17:902:8214:b0:1aa:d971:4623 with SMTP id x20-20020a170902821400b001aad9714623mr18870991pln.38.1687501783228;
        Thu, 22 Jun 2023 23:29:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709027c0500b001b246dcffb7sm6311389pll.300.2023.06.22.23.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 23:29:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCaId-00F8x8-0s;
        Fri, 23 Jun 2023 16:29:39 +1000
Date:   Fri, 23 Jun 2023 16:29:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Message-ID: <ZJU708VIyJ/3StAX@dread.disaster.area>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
> On 6/22/23 10:53, Qi Zheng wrote:
> > @@ -1067,33 +1068,27 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> >  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> >  
> > -	if (!down_read_trylock(&shrinker_rwsem))
> > -		goto out;
> > -
> > -	list_for_each_entry(shrinker, &shrinker_list, list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
> >  		struct shrink_control sc = {
> >  			.gfp_mask = gfp_mask,
> >  			.nid = nid,
> >  			.memcg = memcg,
> >  		};
> >  
> > +		if (!shrinker_try_get(shrinker))
> > +			continue;
> > +		rcu_read_unlock();
> 
> I don't think you can do this unlock?
> 
> > +
> >  		ret = do_shrink_slab(&sc, shrinker, priority);
> >  		if (ret == SHRINK_EMPTY)
> >  			ret = 0;
> >  		freed += ret;
> > -		/*
> > -		 * Bail out if someone want to register a new shrinker to
> > -		 * prevent the registration from being stalled for long periods
> > -		 * by parallel ongoing shrinking.
> > -		 */
> > -		if (rwsem_is_contended(&shrinker_rwsem)) {
> > -			freed = freed ? : 1;
> > -			break;
> > -		}
> > -	}
> >  
> > -	up_read(&shrinker_rwsem);
> > -out:
> > +		rcu_read_lock();
> 
> That new rcu_read_lock() won't help AFAIK, the whole
> list_for_each_entry_rcu() needs to be under the single rcu_read_lock() to be
> safe.

Yeah, that's the pattern we've been taught and the one we can look
at and immediately say "this is safe".

This is a different pattern, as has been explained bi Qi, and I
think it *might* be safe.

*However.*

Right now I don't have time to go through a novel RCU list iteration
pattern it one step at to determine the correctness of the
algorithm. I'm mostly worried about list manipulations that can
occur outside rcu_read_lock() section bleeding into the RCU
critical section because rcu_read_lock() by itself is not a memory
barrier.

Maybe Paul has seen this pattern often enough he could simply tell
us what conditions it is safe in. But for me to work that out from
first principles? I just don't have the time to do that right now.

> IIUC this is why Dave in [4] suggests unifying shrink_slab() with
> shrink_slab_memcg(), as the latter doesn't iterate the list but uses IDR.

Yes, I suggested the IDR route because radix tree lookups under RCU
with reference counted objects are a known safe pattern that we can
easily confirm is correct or not.  Hence I suggested the unification
+ IDR route because it makes the life of reviewers so, so much
easier...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

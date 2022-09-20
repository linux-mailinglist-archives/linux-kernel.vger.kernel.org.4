Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4C5BE1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiITJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:27:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C46BCFA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:27:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w13so1792894plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=138IjAg8FELHzInvjsbFPKlTcrvjuLJXi6QY0IdyC9s=;
        b=mYpgHOS2UXARVYgXPgPsv7uXK5FNk1Hn7a6MtMG/+YHW1Nis2O/H6DWw700hAesdkv
         HyhUROVWGo20nnP5r4WF53L8eHo/F48m3awsXOHVodA8nEvKnnaqtXPkbPqFlW2jdiMJ
         SPwcEKD3E4HicTK3cOroLwlVnhttf+OlHRMWvGZd+s7c1+0eu9WQRKGeHItaB/k9UAOR
         YNrcfTlnNahKpeTdYAs+MvLvZZ2lDHz7fLctX3v4iu/qH1gHsUcAVYPVFuAN4IVxxNi/
         OMzFkLdJtT5g0ZYoueJMxWu3Z2YUhoqbgdBN93lN4djYLFalTnxLYAHKqdnsVVwalHJw
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=138IjAg8FELHzInvjsbFPKlTcrvjuLJXi6QY0IdyC9s=;
        b=kmqpvi2PMHA4hlSy/0qodUn4moKbazkf76KgIuGdVd5vZ/RkeEPrseCFO6iCI/kOuz
         +c+OKHnGrmQYeBGavqL8PGp3+m0ODW28R7uPx2cupW30zo1w6Qpvisw2yvuUQ9BLgREn
         YpWsbeQSFsg3AgNyGm1UtN5Ggv9a9g1KYwxUwfadgI9FD7ke6UhuqBFRDBh7/r+8PbF6
         ZG1mfMkXrUJAHsZOKkvzhz1qUTKG4LIUTgkQxizZy/LP2xv1lm9NjXpPFndf1Fwl45E7
         sH/UMkW0gJ0j1ereDm2s5xF7YGqcoQTv2WHymh5ohO3x8HfrYlxlBJIKQNmyDV8is5ip
         t/sQ==
X-Gm-Message-State: ACrzQf09bD/I+0oEEDmfciqPdi8wacItOu2tiKZDsFA8BTUtefsuX+tI
        wWBv+JZFop3hajXvRKfwxPY=
X-Google-Smtp-Source: AMsMyM75Lm84hqwlOxxJUd2zALFuMOj/L6Qm8eENlebmJsJ3K/QpAindEwA4TuZjVyex/yhbSTfeSg==
X-Received: by 2002:a17:90b:3803:b0:203:a31c:e2e9 with SMTP id mq3-20020a17090b380300b00203a31ce2e9mr2797280pjb.13.1663666063919;
        Tue, 20 Sep 2022 02:27:43 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b001766a3b2a26sm943369plh.105.2022.09.20.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 02:27:43 -0700 (PDT)
Date:   Tue, 20 Sep 2022 18:27:37 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Maurizio Lombardi <mlombard@redhat.com>, vbabka@suse.cz,
        linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <YymHiTyVrdrGYO/h@hyeyoo>
References: <20220919163929.351068-1-mlombard@redhat.com>
 <Yylv4TRbrhwCrCnR@hyeyoo>
 <YylyS7rKigh85sGa@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YylyS7rKigh85sGa@linutronix.de>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:56:59AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-09-20 16:46:41 [+0900], Hyeonggon Yoo wrote:
> > > @@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
> > >  		INIT_WORK(&sfw->work, flush_cpu_slab);
> > >  		sfw->skip = false;
> > >  		sfw->s = s;
> > > -		schedule_work_on(cpu, &sfw->work);
> > > +		queue_work_on(cpu, flushwq, &sfw->work);
> > 
> > Hi. what happens here if flushwq failed?
> > 
> > I think avoiding BUG_ON() makes sense,
> > but shouldn't we have fallback method?
> 
> You get an output to act on and fix. The point is that it shouldn't have
> happen in the first place. With the bug_on() that early, chances are
> that you never see anything but a blank screen. So with the warn_on you
> get probably to see the warn_on before you get here.
> 
> Sebastian

Thank you for kind explanation.
Makes sense!

-- 
Thanks,
Hyeonggon

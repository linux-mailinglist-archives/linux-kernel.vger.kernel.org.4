Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDB67FB54
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjA1WV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1WVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:21:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36C23121
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:21:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so22038833ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl5J8IF0UNMDD8D3GziaB4fqdX3NHGyUny50QfP+wPg=;
        b=WhZtk1FCMUYnUbQ1h/xNKX2OO6yUTcslHI9H7jV6vIZE/fpJgN5x6PmCES9jwDTRMY
         +Qre0VFSTTJDyNPrxQuIEjxbvkiTFATfblWECLSnbv1ZLfzI7jwGTGy8u1nYehC5y5PE
         qxfxk8RTSbuCAwh8PD8R3iI3AgZn0IM2DgSe9s8Bmfl2nFhZBacWXSioWJYdA+5/BYLe
         m5YfMxHl2tQpkzx4Bcv3slySTMe7+7tlvJnkADFvg8yg+FWgxvr1it6fo/3CTNyYEx9V
         vbOswhEYWPRtF8q51YgbHhJGVJqydzGf0spFo9ojhGipVOhsHYg5DPzECxYR0ksDYa6r
         Gb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl5J8IF0UNMDD8D3GziaB4fqdX3NHGyUny50QfP+wPg=;
        b=sGiYibFsnWdWdeh+2yrZbb9mDF2BpEixwf7undrcfkCE9LzfcsmRfsUdPmQvagVH9s
         IGa2EOC6ekXcBDW7atZEPZRu/8cC7THt9QdgSrgrXPF02OLn+5SDgeDCbeGFg6p/SZVF
         5v1NZvvgqEFbI07ygrh6aIHqeGPGKFset/ZcHjqoRbN5ruuFUylMtlduaqyr7jkURP2A
         qDSULLF+Y6qdHtPkanzaUoPzX+wgqv+If1NHYIlSq7lNepYUZrT2hrMUvC85EUl2SR99
         iwnOlUtgOkxWpVUOL4zn9m+Yb8WjOmc/6RilpwQPN5ynLbitdql3+jOjByZ36rLEe2eT
         Ycww==
X-Gm-Message-State: AO0yUKXRmJPoxhSv8Z9stDOUEsZgXHpP9omoHLNBkJDj3NV5TEU1lbXb
        YDP9Q6/HR95mq58N34I1XUc=
X-Google-Smtp-Source: AK7set+mp0T/Bn4w6svd/9Ya7cp9J+GNgTccE2ClSDl6cWpmBNju5hxNlakkmnR/eqxRPN94c+iBTg==
X-Received: by 2002:a17:907:3e13:b0:881:4d98:fe2e with SMTP id hp19-20020a1709073e1300b008814d98fe2emr5199135ejc.29.1674944511307;
        Sat, 28 Jan 2023 14:21:51 -0800 (PST)
Received: from andrea ([151.251.48.98])
        by smtp.gmail.com with ESMTPSA id fy15-20020a1709069f0f00b0084c62b7b7d8sm4372567ejc.187.2023.01.28.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 14:21:50 -0800 (PST)
Date:   Sat, 28 Jan 2023 23:21:43 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9Wf9/rF4cVNCKeS@andrea>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9WeOTmGCCfjMUtG@andrea>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:14:17PM +0100, Andrea Parri wrote:
> > Evidently the plain-coherence check rules out x=1 at the 
> > end, because when I relax that check, x=1 becomes a possible result.  
> > Furthermore, the graphical output confirms that this execution has a 
> > ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
> > to Wx=2!  How can this be possible?  It seems like a bug in herd7.
> 
> By default, herd7 performs some edges removal when generating the
> graphical outputs.  The option -showraw can be useful to increase
> the "verbosity", for example,
> 
>   [with "exists (x=2)", output in /tmp/T.dot]

This was meant to be "exists (x=1)".

  Andrea


>   $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis
> 
> 
> > Furthermore, the execution with x=2 at the end doesn't have either a 
> > ww-vis or a ww-nonrace edge betwen Wx=1 and Wx=2.  So why isn't there a 
> > ww-race edge?
> 
> And similarly
> 
>   [with "exists (x=2)"]
>   $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -doshow ww-vis,ww-nonrace -showraw ww-vis,ww-nonrace
> 
>   Andrea

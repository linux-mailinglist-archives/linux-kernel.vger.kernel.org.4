Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A855267FB4D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjA1WO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjA1WO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:14:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8F1E5E8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:14:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m2so22014655ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUpWjfWdfvJKXko+TtPVnC6rkvtuQqCNIQZpq5xvbaA=;
        b=fp6iVkzY5tLe1ym+HnbSNT2fiUJ/Sx5u0/79eX5ZYqh9xy2ouwW1Smndm3T4a+e0uB
         TlljUipWOOFYl1MjKDa7khbUrJoka4FDcjXkDpis/ot9T3Ueu7rtmerxcRaHQjXbOq5M
         E7cxK64RYnyz5L/1anthKCrBZi7W96wjBvpuExIZBiQJr+IsqDal1Uxp+uxPzDFqKSFF
         SBJqjhqtdW5v58ZkGKibSlZ2ePTQQBdcTEWgSMc6WXs6JAA/RI32P71f3RR04S1EyjSS
         7W5UUI7n4UB9mZIPFEndFPxNm4RN4YmUzFEF1YVIADbyDQlvrG0ySFGxgM6BBy/ldCZh
         HF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUpWjfWdfvJKXko+TtPVnC6rkvtuQqCNIQZpq5xvbaA=;
        b=6s/T2Z8yuecoUbCNJBrhLsuZYrMlTZGNwRqfnUSEgcIPbKWHrBSXTdgP5Xptqaygc9
         Fq53/Bn+8HSh0fzNa3kmb3+MyFUlLcRvnJGdoAz8orERXhJ4SwjBl0JS6tV/YGiOY2oA
         AYHw0pZVp1IFpnOahqfsplGC00tfFdlS9CMvJYY4cakyDwJ9Uxu9WKF7Lc8hVHPpFfEe
         3n1/+qw7PCJqq/SF60wbZ8RejyLnLLyUJOKyvoLexZG7nSvUMVLWWsX+Wd/+8iLFYToq
         nbXnlD3+gtQ7FdVFBwPzFDZG+AYSwLMb1lcG65U8s984FJnBf8rMq11juttmNy+219IS
         lVsw==
X-Gm-Message-State: AFqh2kqhb2qHsSHHvtgFjG0ux4qoGm3gbtUxpuTfgQhOqgikRtqOF4J1
        4/8VrJORqtZyICIOVDxJ5ps=
X-Google-Smtp-Source: AMrXdXt6IBDqGP05ps2V6U8QMb1QVpq+qWwM/o2meeEre9Fjo56hi+4IW7nTm0FmPEffvNE98lIuuw==
X-Received: by 2002:a17:906:1783:b0:866:6b08:946b with SMTP id t3-20020a170906178300b008666b08946bmr46320708eje.39.1674944063049;
        Sat, 28 Jan 2023 14:14:23 -0800 (PST)
Received: from andrea ([151.251.48.98])
        by smtp.gmail.com with ESMTPSA id xo1-20020a170907bb8100b0088550a1ce74sm593799ejc.120.2023.01.28.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 14:14:22 -0800 (PST)
Date:   Sat, 28 Jan 2023 23:14:17 +0100
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
Message-ID: <Y9WeOTmGCCfjMUtG@andrea>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Evidently the plain-coherence check rules out x=1 at the 
> end, because when I relax that check, x=1 becomes a possible result.  
> Furthermore, the graphical output confirms that this execution has a 
> ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1 
> to Wx=2!  How can this be possible?  It seems like a bug in herd7.

By default, herd7 performs some edges removal when generating the
graphical outputs.  The option -showraw can be useful to increase
the "verbosity", for example,

  [with "exists (x=2)", output in /tmp/T.dot]
  $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis


> Furthermore, the execution with x=2 at the end doesn't have either a 
> ww-vis or a ww-nonrace edge betwen Wx=1 and Wx=2.  So why isn't there a 
> ww-race edge?

And similarly

  [with "exists (x=2)"]
  $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -doshow ww-vis,ww-nonrace -showraw ww-vis,ww-nonrace

  Andrea

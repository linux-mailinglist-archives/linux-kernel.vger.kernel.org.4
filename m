Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B3615529
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKAWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKAWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:38:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60ADEC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:38:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 130so14784691pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thYz5QOD4hcEM7CHTtqZVPg6yh+uUZKrxyF0+TCRPZw=;
        b=N8aSZ8Cv2bU/JCfAgPf18G7JIZhk2VMtIhfyK0Fwitl+94q0MLBmq4MO3GuccGxWom
         wtKzmY0iCYZf+wbWoOG1ELeTzsg4O/+9cvTFykXgdpGtyBBOwX1rRJl9+hccyiZz6Iuz
         YchfG3zPRNRTIwKRAuoZNRoSSr+Du7TGOZYTYMJbF4tQV5k+XHOO3g7E3Sk/I0IwYPsw
         GXiULWA+v3iZSy6ULqv2Cu80tL9BSpMxwwIOT5ZkSg31hPTq3pfZaeSFPf4SPedjrvfp
         4XR3kQlHzzQv2IKOPlsr/QnWX0mIa2NXJTa2qGVsB1Cu04W1Yrn5Q9J97He93C5E4nqO
         xsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thYz5QOD4hcEM7CHTtqZVPg6yh+uUZKrxyF0+TCRPZw=;
        b=cGrotioicjEwVX0csSMgCTxaZuQoQFrzReKTy2qviObdUrXWEQUcMyHB3cWQRy8PcP
         3bNliLX7yRWxFzG9SguS0Mk2lsFtI/hfcaRYlLOUQn8jcw7SzJLVWmlG3+9dSeGsGVsq
         LBUL/iX0PmIERmn0dYghXyFA14H6dL3OGabJ6YhxYI31l9Gf5ijBH1gzNidM6S+0dMDF
         hehlnGhzx1b0e4TaX2guolY1MAhTKmppmqs873vurnk+iY8xLmyZYafM0qJMdNtvOOEO
         f6aWXAPQgCdYhMRXJe6lqlYwSALo9fJXYh8fgqS1yqNRRYQxU0Z+JvUnsmeGPd2lE/5Z
         tlsw==
X-Gm-Message-State: ACrzQf02p020xQWvhk59Alwzepub+WDCfG2/CQzWu9h9npu+nrtH8g7l
        5pD/5dhnS0qSOYSD8mK024Y=
X-Google-Smtp-Source: AMsMyM6GqVxGlHQzQOXFLvR/xw8weg4PlObupJbSs23+IGjDsaYASCGmT3aJ+ADHOdRRYlSG5ungig==
X-Received: by 2002:aa7:94b1:0:b0:56c:8da8:4e3 with SMTP id a17-20020aa794b1000000b0056c8da804e3mr21912511pfl.62.1667342305555;
        Tue, 01 Nov 2022 15:38:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f37f])
        by smtp.gmail.com with ESMTPSA id h75-20020a62834e000000b0056b932f3280sm6986486pfe.103.2022.11.01.15.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:38:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 12:38:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2Gf3zxJqxRnkVyf@slm.duckdns.org>
References: <Y2BDFNpkSawKnE9S@slm.duckdns.org>
 <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
 <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org>
 <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
 <Y2GUg8CiI68ZBznr@slm.duckdns.org>
 <CABk29Nvj8nRyD0HGo+gZ4CEr0kOJSsUbJnSNFs62D66EDTMGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nvj8nRyD0HGo+gZ4CEr0kOJSsUbJnSNFs62D66EDTMGog@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(cc'ing Michal, Christian and Li for context)

On Tue, Nov 01, 2022 at 02:59:56PM -0700, Josh Don wrote:
> > If most of the problems were with cpu bw control, fixing that should do for
> > the time being. Otherwise, we'll have to think about finishing kernfs
> > locking granularity improvements and doing something similar to cgroup
> > locking too.
> 
> Oh we've easily hit stalls measured in multiple seconds. We
> extensively use cpu.idle to group batch tasks. One of the memory
> bandwidth mitigations implemented in userspace is cpu jailing, which
> can end up pushing lots and lots of these batch threads onto a small
> number of cpus. 5ms min gran * 200 threads is already one second :)

Ah, I see.

> We're in the process of transitioning to using bw instead for this
> instead in order to maintain parallelism. Fixing bw is definitely
> going to be useful, but I'm afraid we'll still likely have some issues
> from low throughput for non-bw reasons (some of which we can't
> directly control, since arbitrary jobs can spin up and configure their
> hierarchy/threads in antagonistic ways, in effect pushing out the
> latency of some of their threads).

Yeah, thanks for the explanation. Making the lock more granular is tedious
but definitely doable. I don't think I can work on it in the near future but
will keep it on mind. If anyone's interested in attacking it, please be my
guest.

Thanks.

-- 
tejun

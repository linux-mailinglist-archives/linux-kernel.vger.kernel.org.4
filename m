Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA54E616A73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiKBRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKBRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:18:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC621E0A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:18:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l6so16902171pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snrHQ66Kapq/ZWiiSBrIoHl05h2OD4hJ55ZZgf0M290=;
        b=nxOwtdWEzd0ZVsgHhCASXj/ZAxcC+rK4cIv4IMDVx886VIpjGAikdUD7TwXgymSora
         2MEm/0hqDGWIjbLH26DUhPXp9USeqBt6D1duL+lhxHZDyU/G32ZnK4Cr4wl7IfTpNIiV
         m+fMXhgPR3IwLSwep21EqCj48erUiZINoDk5WziPmuJWqTxRc0Tk+QG4FQFLR+oITW8s
         SQoL5M9ciCvzLtLlPf31MdUoWc49cO8dPPmgs91kMGmjk9gJA0+QL60KK//QP+L6R7Qe
         R2jruRBaAgToAD39PRJq17AAi8WQ+II1fjPpk6l0kIcEuejUWqM5jFipk6lhSt5uyVqG
         Zd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snrHQ66Kapq/ZWiiSBrIoHl05h2OD4hJ55ZZgf0M290=;
        b=GSAWL0t3ifoUv69oOwDuukJVYCzDsDRqtI97xxw4cmchrYmkfY97uTpTpCLujbtxTv
         uJ0ebIEgh0hQCySJ/YWW7gc3Pz8aHOwR/ZXs+i3rhqydeIWoBXGp4EI9ae2H955h+Vd1
         pI0HIo9HA4z/l2UFNfSWayY85w9r9F1L2HypV0p+rcw0SHGF6C6eVcABo1byJoSgL6ck
         INXk/yMYUEM3dOzMgYKCzr2ii7HTYa5nx0xvWHL2k51t7eitLCqqyRuj9imM3iDT/JJX
         oqu4ICYF8CUmffvdzMjQwIP9wx3i4BcsppS7i7CMhoyE9W9rr4201bXJDNP6lbZ2Xd5r
         r0Bg==
X-Gm-Message-State: ACrzQf3ROZBNNzECaUoXuAfD8/4Hlwj4r03SX5ZeC1Yv/+c+CE9CsQwI
        +CKujc5N8lCs5gEG60jze8c=
X-Google-Smtp-Source: AMsMyM5pP4O5S6/QQUpy9FbQmUmxGsyTjwI4l8J3sd3dd3CMfbpipCnSQTrPaLIBe95oktz+qPoBZg==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr43300957pjb.202.1667409525308;
        Wed, 02 Nov 2022 10:18:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n126-20020a622784000000b00562ef28aac6sm8672246pfn.185.2022.11.02.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:18:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Nov 2022 07:18:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Josh Don <joshdon@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2Kmc1qiv7K9qpBh@slm.duckdns.org>
References: <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
 <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
 <CABk29Ns1VWEVRYENud4CW3JQPrcr79i_F2PBTANqt3t-LaYCfQ@mail.gmail.com>
 <Y2FwVX42LIKXSTz3@slm.duckdns.org>
 <CABk29Nua8ZsDfhY+x+VfYDkbkjfXLXTZ5JMVR9uiBygraxDM+g@mail.gmail.com>
 <Y2GUg8CiI68ZBznr@slm.duckdns.org>
 <CABk29Nvj8nRyD0HGo+gZ4CEr0kOJSsUbJnSNFs62D66EDTMGog@mail.gmail.com>
 <Y2Gf3zxJqxRnkVyf@slm.duckdns.org>
 <20221102171049.GC10591@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102171049.GC10591@blackbody.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:10:49PM +0100, Michal Koutný wrote:
> On Tue, Nov 01, 2022 at 12:38:23PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > We're in the process of transitioning to using bw instead for this
> > > instead in order to maintain parallelism. Fixing bw is definitely
> > > going to be useful, but I'm afraid we'll still likely have some issues
> > > from low throughput for non-bw reasons (some of which we can't
> > > directly control, since arbitrary jobs can spin up and configure their
> > > hierarchy/threads in antagonistic ways, in effect pushing out the
> > > latency of some of their threads).
> > 
> > Yeah, thanks for the explanation. Making the lock more granular is tedious
> > but definitely doable. I don't think I can work on it in the near future but
> > will keep it on mind. If anyone's interested in attacking it, please be my
> > guest.
> 
> From my experience, throttling while holding kernel locks (not just
> cgroup_mutex) causes more trouble than plain cgroup_mutex scalability
> currently.

Oh yeah, absolutely. Low cpu bw config + any shared kernel resource is a
nightmare and this thread was originally about addressing that.

Thanks.

-- 
tejun

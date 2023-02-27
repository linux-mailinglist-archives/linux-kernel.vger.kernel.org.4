Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123D6A4B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjB0Tk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjB0Tk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:40:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1BE26CF9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:40:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id da10so30467621edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RghMngOwlwE0UIHyAe26+VKy5fxUypVplAAfNB7AdWo=;
        b=JHjqy9oW7O91e58jpAg7pzCiowii5WfWha3c/+JAHdcaemModBaNw4LuToH20xdAfG
         JJnADpuescBUYNB8PT11gAOZWE2oAp1Tr3gxg1fRzs+22REvqp9/IN5qoQTO2O69Gn19
         UpiCFJKWcGK+WW/aXl5aqpNnfRNxOzsw1osrm3OHwqBzP3ky2BSXUspo0y7kKgTMTkbz
         iYhy7o0uhIh/F+S22Wiy2+IQOW9pu3aN4P3jbmM573CvGPLpa04JADMc11faBhTM5cDf
         Q1cwsqncGnGQBZWY6EfkYmovVDUHEHVzd2Ah825rDSrPsoZTv3OihNhh47vXaxY+/7dG
         K/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RghMngOwlwE0UIHyAe26+VKy5fxUypVplAAfNB7AdWo=;
        b=ny30M2Wer4pRVVlBmUhKDHSBN/zn9Y35PqaeCeD5jP12TaTbPiqjyxPx0ZRarogcs+
         PyarZL54w1VYQnyE042xM6Bo2xTVzUwIDRJl32SPwRUa+aqgFKQaaqkHLGF8lQIiQ4ef
         goxBtmI9F3sEvRAKnwAuU8QauCzVmGvSQguWsHuXdIBGlgyG1GwiCoHnDpppcgVQXuyL
         oiG4zf/83vLl3DMW7Tmsz7WNYK2kT4665Fg7zS07rnNDh5bDJtyki1CaI7BEoTJWscIr
         /Ho3UL+ExOWe0p+QFWt3pOjIir1GQgwIl2ER3vIWkzSuOrvfPwm98R7ahiy/hYB0aZ5q
         Pd0A==
X-Gm-Message-State: AO0yUKWvoXADp4q/kszI1hpkfkyMunHldo1UViOYPBIYzK2ZlRbkaApN
        bSo6oEXkQ4vnqvFPfgjRCdbfXT93PeSvrr1u
X-Google-Smtp-Source: AK7set81SFQf+c5by6sCf2RBSmnlygWurkWhAQzPb/KacU5xJHptAbNpCugr+dGdG9URjsmC56Q4UQ==
X-Received: by 2002:a05:6402:120f:b0:4ad:66b:84a5 with SMTP id c15-20020a056402120f00b004ad066b84a5mr730546edw.22.1677526803990;
        Mon, 27 Feb 2023 11:40:03 -0800 (PST)
Received: from andrea (host-87-18-14-224.retail.telecomitalia.it. [87.18.14.224])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906061500b008ea5f4fab5fsm3604049ejb.145.2023.02.27.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:40:03 -0800 (PST)
Date:   Mon, 27 Feb 2023 20:40:00 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/0HEESX2wDWtPS1@andrea>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The LKMM doesn't believe that a control or data dependency orders a 
> plain write after a marked read.  Hence in this test it thinks that P1's 
> store to u0 can happen before the load of x1.  I don't remember why we 
> did it this way -- probably we just wanted to minimize the restrictions 
> on when plain accesses can execute.  (I do remember the reason for 
> making address dependencies induce order; it was so RCU would work.)
> 
> The patch below will change what the LKMM believes.  It eliminates the 
> positive outcome of the litmus test and the data race.  Should it be 
> adopted into the memory model?

(Unpopular opinion I know,) it should drop dependencies ordering, not
add/promote it.

  Andrea

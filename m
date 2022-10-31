Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39BA613D99
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaSp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:45:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38513DFA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:45:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p3so11530492pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuI5G5ua8vA2tLMhe/g7vr6m23LWsMkCPGvoYh+Cmqo=;
        b=SeUMOOnRnDMWxcKb3kbS/oLHNJ7ZAosMTuiRZUtpiVQdjO/Xnrwxvi/xga+3OUfNz8
         i5HW5lXlRdeqFPBNPZTPNGMvnnSuqh44otMDXJqQel1P8L860wHJosb6z72UZiVjF9qE
         3CzoqKrnxrHDGcZL0gyy5m87WOBsWejDbvo6FzRfBunq9jJfRnSmmaDLVbPia9lmbo2l
         fO4v0PM+3wjAvGzGMmMymAvCky+nQpvVWRW689P8xj43iWr3i/dSWdCsf2lGOddWm3Oj
         7IpAnN53ezb6xP2Cs1Xnt8K3uW13aeOEa+595Jykd8ffiMVOhaZENCtA5N+hXo1ujxmA
         lnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuI5G5ua8vA2tLMhe/g7vr6m23LWsMkCPGvoYh+Cmqo=;
        b=D/2rt/Rpq0wkfCjaErhq5CLAMo1F1n9kw0OmM3iM3h4f4Pu9dvYPcnQuiyvZz5TNTz
         ABNXsL6HzjCz/6HOTqBs8YX6T1DlvzcOTvRYikINRxHMGPeLw1GwVBNME1nHv7RQQE9Q
         FIwawtDDQa0Khgs1QCMhmm2Ybw1EFMNnfdg4H699SMauq1j1YS+flsHGkwiWPKp+yVtY
         bp+UFMtf72DFUnOMpinwG3ZlwlVcoPlEzwO96VdC9FBirfJ4laF0SbhY3tStRDIgO/z9
         IUv++jYqoDZbiolnBWRCjCKl7jHAtP8jDL4NQixwMNCPUephG9DWZuBn9Njak8qt1BJb
         EdjA==
X-Gm-Message-State: ACrzQf0fRVJIlu2QyH9NvgWXynCIiYU8099xyf4wsd0udDVcVQz0xAVZ
        k5oMo90+tjfiBJVD05oQy/4=
X-Google-Smtp-Source: AMsMyM5i5atOXlWnqqDDTrP82UdNViKB+ad1+xEZbMtMcKrF1NOWIJ4nPRWTWffcR1v48TRdIGCBOQ==
X-Received: by 2002:a17:90a:4614:b0:214:219:b2ba with SMTP id w20-20020a17090a461400b002140219b2bamr1835363pjg.0.1667241922010;
        Mon, 31 Oct 2022 11:45:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090300c200b00186a2dd3ffdsm4782669plc.15.2022.10.31.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:45:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 08:45:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 0/4] workqueue: destroy_worker() vs isolated CPUs
Message-ID: <Y2AXwPEqqaVi45g/@slm.duckdns.org>
References: <20221004150521.822266-1-vschneid@redhat.com>
 <xhsmhfsfcw86h.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhfsfcw86h.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:42:46AM +0100, Valentin Schneider wrote:
> On 04/10/22 16:05, Valentin Schneider wrote:
> > Hi folks,
> >
> > I haven't sent an update for this in a while, but the issue has risen again in
> > some other environment so I'm getting more reasons to push this out.
> 
> Gentle ping.

The approach looks fine to me. I only have minor comments. I'll reply to
each patch.

Lai, you've been involved in this effort in earlier patch series, how does
this look to you now?

Thanks.

-- 
tejun

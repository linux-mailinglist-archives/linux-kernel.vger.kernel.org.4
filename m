Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86C64A935
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiLLVGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiLLVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:06:20 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB6101
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:06:19 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 67-20020a621946000000b00575f8210320so627168pfz.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWaneeqryBcsAibeUpKRK42zErCwxGtVc4ofyyE72VA=;
        b=iiWQpPuS8bWorh2jY+GSNXDDTP/zWKGKu1g1aADANQb/ront41FGJrPwGEj68n7oTH
         JhLcefPChU+DBSf2eitc6qktGBJiykCzFlFheFQzAFHq70qjy9RzppsKWe8Dfnxug0zb
         Q70m9u3uwa7SLcJteyOUz8XU2FUlLoA43iPv+mmQbKtdVYqNvB8eEU+SXnuoaPXL2gAA
         OsmvYR+38wi7kUJLbbH5jiWoUIZcCK0U+wYlnvmuzm7BEri1PuYsZEh4F2BPf6h56Hzp
         k6XF9LkHKgoGIe5yEiQbrINaKmhnNn24a1Io2T9K0dn29gAD0I9+Y2uFyE5U5/AA3BK4
         lsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWaneeqryBcsAibeUpKRK42zErCwxGtVc4ofyyE72VA=;
        b=X8+/InheQXpE5MsNzOTdb80nV9pgglam35kyIgltBmnG4maBtRKaCGrMZxbyhiJNk2
         fov2rklNtAkhxCa29YiLI35ZgffnE3Lnij/TFefEPxOTem0p8AtG9nAj09/AP183b/dr
         AEsEi1Ty2O6hweovyBsstHsNJcQWrmdMyrzV3x7OkGPb1kHH7mehAWxzrFI4h7Pm/6nE
         UJ2pHE3FNvIb2R1A1SQeecexV41k0wdxWKOJC04i9L4QlGbWJTah93ROgCZ4VKZqujJX
         xIQdR/ILkZn9wiBh5JcqZTjxLdGrG1zHguefLA6Zk27J4PLIE7eXqH3JsYcAMrJiJmqG
         mihg==
X-Gm-Message-State: ANoB5plqUYXLt8Tlk39H3yNi/yASu1oDgzX6XtuuIPvl0BgQbd47VS+e
        B4tscxXD+hxVEdKTQvdQz94XuRrA
X-Google-Smtp-Source: AA0mqf61TWGE3RV1QXljruCCMvtFtyrrtg1uTsEuaU+YxacSMmfGKi7aD7kEbD/zTJXdj0TabOoKiPtG
X-Received: from posk.svl.corp.google.com ([2620:15c:2d4:203:669:babb:2ed:33de])
 (user=posk job=sendgmr) by 2002:a05:6a00:26e3:b0:576:1b46:3ff6 with SMTP id
 p35-20020a056a0026e300b005761b463ff6mr35339034pfw.1.1670879178937; Mon, 12
 Dec 2022 13:06:18 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:05:47 -0800
In-Reply-To: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212210547.1105894-1-posk@google.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example scheduler
From:   Peter Oskolkov <posk@google.com>
To:     peterz@infradead.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        joshdon@google.com, juri.lelli@redhat.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        mgorman@suse.de, mingo@redhat.com, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org, tj@kernel.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

> I long for the UMCG patches -- that
> at least was somewhat sane and trivially composes, unlike all this
> madness.

A surprise, to be sure, but a welcome one!

We are in the process of finalizing UMCG internally, and I plan
to post the patches here once all reviews/testing and some preliminary
rollouts are done.

Thanks,
Peter

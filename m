Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F157110D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbjEYQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEYQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:23:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC741197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:23:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so833618a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685031785; x=1687623785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HdBiYHXb0t/eYfGc/stu36RyqTGN6i7PmYRLl38sM4=;
        b=Ms1EfGgkWfjHyAEkYKEt1EK1c0RFGrAyO7YlB5VADfKnqvkE/3Q90TA52bwGi+C54/
         4z+1IXDYFa69QOgk9+iEezTtPmTRTiYRMdTcWoaEhiekfJZ5qanq/KVZ93a35S65Jy1j
         WpqPDkqSkNnqysAT/nWNmhFVZwb1W5f3wWjc82SXAd7yE53jFxhChegmF2f1mZSgvdYT
         2PjlMucBTIcEebTxQCHwZcOH/9IqHQZmKPDhGcGs2h8YJtbrrgclLGN8ttUXYsVvTJky
         PZgij3I8YJ2FZ/t6PC1NhWFH/yMM80DI+lHqqpwW/F0KchdCmxRw0s/1euxOMEabHbgj
         fvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031785; x=1687623785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HdBiYHXb0t/eYfGc/stu36RyqTGN6i7PmYRLl38sM4=;
        b=imrDvtTVRhFDqOi+B9xZZFkRdbmAs+3HrlCIUMn8settZBjs3sYo61Q4CGszCmZt0B
         OQTF3YEN4T9wo/xTCM2usDSxfznok/rxFv1HljICSoQMsiXkXmgstFf1N6ACbw+biZjW
         3xpjhox1XqjBnA1eupwM4SLrJaN1dwCADRLsddd36ZqUnvnZodel4M65SY3Xb7cWKUAB
         2YcEbXj/eKzUEV7m6t776e3GSMKVGs7TZ5pNsnuBHuC45XZq0KA30cbh9l2gQKMULFQR
         ya42k1ecgwY6q4PE67YhqTZhGxfeJW1SDxFAaLpoPhamnkzuyikJyBfPMwCTEiejqQX5
         5xTQ==
X-Gm-Message-State: AC+VfDzjeEXst0ZtfoRyVJqMLiABCx2tcjU1vGmmAF6cXAxzCdpG0Lf4
        o/Z1wGi+Vdp3H56VzLIVWRrMzJBJqpg=
X-Google-Smtp-Source: ACHHUZ4eMNRNmPGVNI0d/g62J6qYg9y69eF3HSc+XqALVPDfQutlySlqNuJtdiVOrOZz4FeES2slvW+AmvQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e847:0:b0:524:fba4:fd51 with SMTP id
 a7-20020a63e847000000b00524fba4fd51mr741353pgk.3.1685031785184; Thu, 25 May
 2023 09:23:05 -0700 (PDT)
Date:   Thu, 25 May 2023 09:23:03 -0700
In-Reply-To: <20230420104622.12504-2-ljrcore@126.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <20230420104622.12504-2-ljrcore@126.com>
Message-ID: <ZG+LZ4rATc8elt38@google.com>
Subject: Re: [PATCH v2 1/7] KVM: selftests: Replace int with uint32_t for nevents
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Defined as type __u32, the nevents field in kvm_pmu_event_filter
> can only accept positive values within a specific range. Therefore,
> replacing int with uint32_t for nevents ensures consistency and
> readability in the code.

Not really.  It fixes one type of inconsistency that is fairly common (userspace
passing an integer count to the kernel), and replaces it with a different type
of inconsistency (signed iterator comparing against an unsigned count).  There's
already one of those in remove_event(), but I'd rather not create more.

Passing an unsigned int to track what *should* be a small-ish, postive integer
can also make it more difficult to detect bugs, e.g. assertions like this won't
work:

	TEST_ASSERT(nevents >= 0);

If this code were being written from scratch then I wouldn't object to using
uint32_t everywhere, but I don't see the point of trying to retroactively change
the code.

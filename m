Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD4728659
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFHR2l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFHR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:28:39 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AB9E;
        Thu,  8 Jun 2023 10:28:38 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-565ba2c7554so7636127b3.3;
        Thu, 08 Jun 2023 10:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245316; x=1688837316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukFo/mzaJtMm9NEOqRAOU0pEFyqxCrPdzo2ZbG7FqxE=;
        b=IaBP9TSW+dgCFpdxrta5/k5cztQ8hT37kGbOEHwcWOS+wwO7HmdbNKYNI+T0xiVw0E
         nvSoKyHYMcHCZFWVEoD9MHXmjyDHBE8pim2JAfL0c5SR8cpMUBn2q0a5NB00vlOdFAQx
         ilvfZ5bGA5IU1cNEg6qWXZB6VUtqiVZDZn3eRXdvQ7dDEUHJ/kT/EEQlzHSBEKDxDTFH
         5ZV0klUCyLkLJvlfR7yCOAJaduy0f/bjjI1VaSejPsZqhz/Nx2tbujm8PRJMnmHpGeRm
         kF8hNm9tW6tMbdH5xte4kdSnHpaOwXLzZU8cbU+Mxi30mseidEU94M3euLFqXM4Xu7EH
         xxkw==
X-Gm-Message-State: AC+VfDxALD5WYcF5LahL2p8ebBVE0jkzBy8WFJdpli/2SDFVdoX6q2Il
        aqqdHUwpPtGlIL2/2RNFHFNA00MY3SwOExbeOfw=
X-Google-Smtp-Source: ACHHUZ7fsOJ6Yp4YMwR5f8pgMTPyH1KciEOlp94ErYqWbvPQDQqEBj7yh7plMrGmXL3g9avlKlZqmJWnUFeqZZUuTlY=
X-Received: by 2002:a81:69d5:0:b0:565:3749:c24d with SMTP id
 e204-20020a8169d5000000b005653749c24dmr392314ywc.14.1686245316074; Thu, 08
 Jun 2023 10:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230608084407.140323-1-asavkov@redhat.com> <20230608132533.GL998233@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608132533.GL998233@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Jun 2023 10:28:24 -0700
Message-ID: <CAM9d7cguD5Qo72sa4TjYokMKBfVRkLmGKNk_Z4stF=6W0x2bSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Artem Savkov <asavkov@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Jun 8, 2023 at 6:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 08, 2023 at 10:44:05AM +0200, Artem Savkov wrote:
> > These patches add ability to start annotation browser from c2c report
> > tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].
> >
> > [1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/
>
> So what are the plans for doing IP to datatype::member resolution and
> deleting this C2C abomination?

I'm working on it and hoping to post an RFC soonish.. but no plan to kill
c2c entirely :)

Thanks,
Namhyung

>
> /me still regretting ever letting c2c happen..

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4108C738D07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjFURZh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFURZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:25:36 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C247BE2;
        Wed, 21 Jun 2023 10:25:35 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bc476bf5239so6185688276.2;
        Wed, 21 Jun 2023 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368335; x=1689960335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHngUWEw5u2Fdtltkm2omRysHcLxgGd8tyhOPSzH7GI=;
        b=TLtfrodA02NeRi7DRsIqtdOhr7e6s2gQ1DI2X334tQDQkmqvmzWzaXR0xurjqf8OlC
         cy0o376GeGwFrD7hHzRX3L2XhkwU34CDOLvteOl/Qodlyj1NEbVM9j9WDP9vapeUlqaW
         Osgd0q2w1mUCbIMrrL3TCnM62WnWn17IuwzGgXwKQvLg9LpadBxTB5rtfNMr0KewOyqt
         Dwgg/iCpIxxNdWnYphPpZQ8mbP5uIqGcM5w17s0DJ8yhWRHplZyJg4jINB/QSW7HepBF
         jWmoujz59hYawT3Gbz+ZRCR36uSimXAkJop0Nys/pJV/VfJDUbCm3uTFNDn9V1KP7UZv
         lOog==
X-Gm-Message-State: AC+VfDypWWnuOksgjrty+wFzCL0OnIn9btjkUYXp4V0nRhlV22ahuuqX
        X8TjVPfjhoIA2H9AcV7WrOdYANaU6nEDTLI5jk8=
X-Google-Smtp-Source: ACHHUZ42gBnZwcJ2JB3Hatg/ioXumzAd1h5q54bfVQRzjfSHFUV+wbxLhGDpZEIIYsBThRgg4IN/loC3ZSipCGu8QN8=
X-Received: by 2002:a5b:906:0:b0:ba7:54ab:d676 with SMTP id
 a6-20020a5b0906000000b00ba754abd676mr12497981ybq.63.1687368334881; Wed, 21
 Jun 2023 10:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230616024515.80814-1-yangjihong1@huawei.com> <CAM9d7chJtidBnLYd27Us6aW5tJKbi_n_kHj=6SRUTbTiowwi5w@mail.gmail.com>
In-Reply-To: <CAM9d7chJtidBnLYd27Us6aW5tJKbi_n_kHj=6SRUTbTiowwi5w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:25:23 -0700
Message-ID: <CAM9d7cit095kueUKgo+bq7hakam3DoTOs7sB5SGKXMEpiRViDg@mail.gmail.com>
Subject: Re: [PATCH] perf parse: Add missing newline to pr_debug message in evsel__compute_group_pmu_name()
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
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

On Tue, Jun 20, 2023 at 1:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jun 15, 2023 at 7:47 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > The newline is missing for pr_debug message in
> > evsel__compute_group_pmu_name(), fix it.
> >
> > Before:
> >
> >   # perf --debug verbose=2 record -e cpu-clock true
> >   <SNIP>
> >   No PMU found for 'cycles:u'No PMU found for 'instructions:u'------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1
> >     size                             136
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   <SNIP>
> >
> > After:
> >
> >   # perf --debug verbose=2 record -e cpu-clock true
> >   <SNIP>
> >   No PMU found for 'cycles:u'
> >   No PMU found for 'instructions:u'
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1
> >     size                             136
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   <SNIP>
> >
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

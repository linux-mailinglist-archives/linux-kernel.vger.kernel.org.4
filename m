Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DA5EEB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiI2CIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2CH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:07:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501DF8C37
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:07:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v28so9543191wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TL48+o+sJWgORfKvQPxwZdWzU7/LlXpQAEOT6jrxZNw=;
        b=fcMrUXI9Ggrlxg6pYiMz3EA1bORG/aS245jXk83+EOopI9u0QCzL9+JA1w6qRqUE78
         /bGMmXUP+dXgYRa5PTp2/+yayt//YHrw/uaJVRjopF+vrLglGaD/3MniCgkRKisuTm7w
         ucwpaUfhtubVoWtfhJ8nkrCYEb38wWvRuJrU9t9WonfJGk7/wunw4NIxy113UYotIkGF
         d5YLeCSckyUgxNIdYqJmWIX4PwwiXHWmN6X46mcPWulCoFLpeKWV3JdXeSQJuzHiYf8S
         CfxEkcaekj/ypuPrprR53MifRh7Qh2xNErSYNB4YB8JRHt06MfR8ZfNQ/2hL3oVgoDUX
         Rg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TL48+o+sJWgORfKvQPxwZdWzU7/LlXpQAEOT6jrxZNw=;
        b=1Nm6fYsZb4+XnYeG7hqF4Yv5SQsgj3swIExSkbLcH0LLuneEGW4Ra4De9fLCSeIR7U
         Gx0J4pjDVPLeUKIl1Nar9Lc76bbqBdx8Smq2iu+mxSNKHnDNuoEukoNy6sERIoh7UISL
         Lmwd9+UgxkKm5HFIPKPm1yxyDHMnS94TAVX6g1MIgmTP4J+/elP2AwPenntIW3G9qpO1
         aRyeriqFXzvvMijI2elVj0iR16AZwlsfNQvcZysxqJVLLqahiqx97iyY2fvMwnB3VASS
         vewoJKIRZX0cEnAe55b3BDIjetuzJswxmwYFOYq0eOwd/gLng0VcuzLyv6CpYBQYQlXm
         J/+Q==
X-Gm-Message-State: ACrzQf0ULjUEgxY+rsA2NfZaAGEbdhcQgxtKtvokC0NYCvar9YdDyRxq
        v8cjucgZa4Frkl9jkrZgvAvDdd4TEa4xkHeq4HzWkw==
X-Google-Smtp-Source: AMsMyM50eS3y0STGCFHpd/0kp0A5EoWtNH2dd7zjSxABe88Mpb0+8WlLrfA6AXlxCyKX1r7VdRuFQ8PTOrnevY+CP4M=
X-Received: by 2002:a5d:64a8:0:b0:226:f3f3:9914 with SMTP id
 m8-20020a5d64a8000000b00226f3f39914mr417338wrp.343.1664417276647; Wed, 28 Sep
 2022 19:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com> <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com> <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
In-Reply-To: <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 19:07:43 -0700
Message-ID: <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 27/09/22 20:28, Namhyung Kim wrote:
> > > Hi Adrian,
> > >
> > > On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>
> > >> On 24/09/22 19:57, Namhyung Kim wrote:
> > >>> The current code propagate evsel's cpu map settings to evlist when it's
> > >>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> > >>> be updated in perf_evlist__set_maps() later.  No need to do it before
> > >>> evlist's cpus are set actually.
> > >>>
> > >>> Actually we discarded this intermediate all_cpus maps at the beginning
> > >>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> > >>> an evsel is added after the evlist cpu maps are set.
> > >>
> > >> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> > >> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> > >> added to the evlist.  It can also remove an evsel from the evlist.
> > >
> > > Thanks for your review.  I think it's fine to change evsel cpus or to remove
> > > an evsel from evlist before calling evlist__create_maps().  The function
> > > will take care of setting evlist's all_cpus from the evsels in the evlist.
> > > So previous changes in evsel/cpus wouldn't be any special.
> > >
> > > After this point, adding a new evsel needs to update evlist all cpus by
> > > propagating cpu maps.  So I think hybrid cpus should be fine.
> > > Did I miss something?
> >
> > I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> > cpus from the target->cpu_list (using perf record -C) , since after this
> > patch all_cpus always starts with the target->cpu_list instead of an empty
> > list.  But then, in the hybrid case, it puts a dummy event that uses the
> > target cpu list anyway, so the result is the same.
> >
> > I don't know if there are any cases where all_cpus would actually need to
> > exclude some of the cpus from target->cpu_list.
>
> I'm not aware of other cases to reduce cpu list.  I think it'd be fine
> if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
> should have a correct list anyway and we mostly use the evsel cpus
> to do the real work.
>
> Thanks,
> Namhyung

The affinity changes made it so that we use all_cpus probably more
often than the evsel CPU maps for real work. The reason being we want
to avoid IPIs so we do all the work on 1 CPU and then move to the next
CPU in evlist all_cpus. evsel CPU maps are used to make sure the
indices are kept accurate - for example, if an uncore event is
measured with a CPU event:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404

Thanks,
Ian

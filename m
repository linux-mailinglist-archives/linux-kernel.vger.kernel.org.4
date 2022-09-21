Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B85BF2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiIUBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIUBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:33:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473446B8C0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:33:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x94so6409222ede.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8mlxxabtfKsHhMFozr251XdLHRx1F56JdRqCnZFhvTQ=;
        b=fXXKk5QlrVa6+lOdpJZ5s1kpNDwozLlk6Vb9Du7pwtM+NGL1F8gATbz68CW5jQdOvx
         VKoN9f+gGQqgQabODV4Vmev+t0bBwGBd+Gh0Dxu/vuw3p5fFzLwKTAZpB+iEsWRbdJe4
         v05uxZP4k6ZZd22R1YGgeMNOHQ3MF87ZtC8ZhSTiNrv/3Zyqv5eMTZh0klxIRn7xBM9k
         XE90n6/HGzqF3YFmY/bQN2VZHmvNRlPJZh/kyRV4LF6ljOU3Fb8/p6E3tnUSpAUtszqm
         2Itcdfma5cAHpMjPT5/FDdwxyzNZLiy00Ge05UJ0QDv7hebZr+WxnTtR9DVlEE0yic8X
         bWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8mlxxabtfKsHhMFozr251XdLHRx1F56JdRqCnZFhvTQ=;
        b=nBBgQRI/aVAPGP3INNSpds+66Wx02SdO3jt6Ykh6tvvUcW3PGMcN+fz1txjSwiOIG3
         FAUlbBKF+7JQtGEU8N1FM7VoJ/NLT4RTewKUXXnGntaL3YIt78mM8kEXXBiQs2phylu/
         mVyYN/5TCIlfhyrweAQGirYAI6utrBMAwAYsVvBoau+G1j8nhLEB1e7XFINkCULEdgup
         iL2Pq0UYg3RVkfCx6ugsfbpIAQR1+rNZy1sNM4WL+cO66yhYTdr5HXwDxll4byGtLOLG
         4gusIAVTBgSEy7ttol+nXmxYhZolktb26VuWwhJFVL6XNhBZmgeZ8KoynTBjbMUZSCsS
         9G3w==
X-Gm-Message-State: ACrzQf3L2Immf1GCZCqJeVtOc513XYqhh30Ixogu6w0x1pkLI7dnzaBN
        a/IyB18hELTLX+jxcvMOtLnNSA==
X-Google-Smtp-Source: AMsMyM4+AvKCRw/Ms46OQuuD/TNyAf1Wo1WG2BkKT0XGivbTdoE2Nt1NIovxjPRhaozmTd91g7zAEA==
X-Received: by 2002:a05:6402:1849:b0:453:ba03:9e41 with SMTP id v9-20020a056402184900b00453ba039e41mr15287552edy.202.1663724018796;
        Tue, 20 Sep 2022 18:33:38 -0700 (PDT)
Received: from leoy-yangtze.lan ([104.245.97.25])
        by smtp.gmail.com with ESMTPSA id f5-20020a056402004500b0044f1e64e9f4sm804899edu.17.2022.09.20.18.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 18:33:38 -0700 (PDT)
Date:   Wed, 21 Sep 2022 09:33:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 2/2] perf test: Introduce script for java symbol
 testing
Message-ID: <Yypp7ZAs0fozJFKT@leoy-yangtze.lan>
References: <20220918031524.26719-1-leo.yan@linaro.org>
 <20220918031524.26719-3-leo.yan@linaro.org>
 <CAM9d7ciR0b5GSASVPxn-r5sBTJW9KZXcQYEsV4zRan5bdgmRCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciR0b5GSASVPxn-r5sBTJW9KZXcQYEsV4zRan5bdgmRCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Tue, Sep 20, 2022 at 02:47:05PM -0700, Namhyung Kim wrote:

[...]

> > +if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
> > +       LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
> > +elif [ -e "$PWD/libperf-jvmti.so" ]; then
> > +       LIBJVMTI=$PWD/libperf-jvmti.so
> > +elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
> > +       LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
> > +elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
> > +       LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
> > +if [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
> 
> s/if/elif/ ?

Ouch, will fix.

> > +       LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
> > +else
> > +       echo "Fail to find libperf-jvmti.so"
> > +       # JVMTI is a build option, skip the test if fail to find lib
> > +       exit 2
> > +fi
> > +
> > +cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
> 
> Wouldn't it check if jshell is available first?

Indeed.  Will check jshell and skip the testing if jshell doesn't
exist.

Thanks for reviewing.

Leo

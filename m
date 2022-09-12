Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F95B56C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiILIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiILIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:53:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111120BE8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:53:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i19so4363256pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sgBg2H69ULck6I/fxoa6RyevZxhztNPOffv3XOmSwRc=;
        b=mPz8c0VB3jAsVn4oFHRwyS+YCdmVvdHCzHBL2o5NSgXm1+0A+710GkI7dQJCaLr1xY
         jQLkkl5F/UPs63vvdnu1EpNBQO1dZTtw8QP50Sedgs0V9M7kUbU5XIAXX33uTxDJJ0x0
         /8rgwQd4k/zk+JbJy6bhomdqEtit/pz2hwrBxd8p6gocIcfuqlwxo6mkfOF9jh5U8Mhu
         9pdlbYdOVpvHVdMOtutVseCOUCB/GslwLy2H65tPQxqzo7VsSC9gnNO4oj2bbqg7v8ju
         t5prj55OJVqJRk1VHVn4NIq6k8XtY5gdH20zT4qtzRMApCoCHPhey1EGQJlkfsbfb+5u
         1qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sgBg2H69ULck6I/fxoa6RyevZxhztNPOffv3XOmSwRc=;
        b=aDSVXsWeHxXmHFprWm5m/H8lCzYFdHFAzi3pBwgkGeqSQNRoMDjIoUNRqCZtrnJumA
         /cgt8vJ8lRrg8UY19Xpl1CBkcqEEsszQs0rdxJuRdD7m5KYf+pZuAF7ncoBTt/vDNwfB
         LXnq7/06jt7bCUnfAA9UrAbiNDJ6f+zrO/FeIsPibO8TzsoL8qO9deq3vRk02RtRbLr+
         nrVAWwyRdIW3PhRmRumyLOZK+rqie02ivwNrS10IbY8uqOwgiT52LM8TjMJrciRa7+wD
         gjuSQ0yzGHH0mPICK+nak7V0y7y6xc0HYNGgQgqg6eatVMp7j4BvPNYqbz7PBLxb58W0
         zJyQ==
X-Gm-Message-State: ACgBeo3mcnL/VsGvxvvfnO42kasRAs45/Xu3MAb4WgEim/qJuPOjbkaI
        sJnjiQbrwAt/OXiKgZBK57zGXg==
X-Google-Smtp-Source: AA6agR5fh+Nx1y20Wv8LvC4RT8AZMSHw0GQApMhqrukr/Km47/TZZrTpCDpcOl11ZEYQyeW/d/yfGw==
X-Received: by 2002:a63:86c3:0:b0:435:2d4:53e3 with SMTP id x186-20020a6386c3000000b0043502d453e3mr20564180pgd.415.1662972793012;
        Mon, 12 Sep 2022 01:53:13 -0700 (PDT)
Received: from leoy-huanghe.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id y13-20020a62640d000000b0053dfef91b0bsm4775773pfb.205.2022.09.12.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:53:12 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:53:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC v1 3/3] perf: arm_spe: Add support for SPEv1.2
 inverted event filtering
Message-ID: <Yx7zcjSQq44QD36u@leoy-huanghe.lan>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Aug 25, 2022 at 01:08:02PM -0500, Rob Herring wrote:

[...]

> +static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
> +						  struct attribute *attr,
> +						  int unused)
> +	{

Unexpected indentation. Just remind, when I used ./scripts/checkpatch.pl
to check this patch, I can see 1 error and 2 warnings.

As James pointed out the undefined instruction abort, which can be
produced on my Ampere AVA platform (Neoverse N1 CPUs).

Thanks,
Leo

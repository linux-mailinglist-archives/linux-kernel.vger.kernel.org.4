Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D56782FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjAWRYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAWRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:24:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064062D56
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:24:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m15so9618352wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h71IGBhDHLZNFeeGQl1aF8+o0T/nk2eq4RkxwD7KpTY=;
        b=FF3MTzZaNkE4Hwch3v+bue0RGlLWdy6DlHlZlkA+iKyg/XPsbov3AZsU2pdtTDoZ0O
         SsNXFVgboqllphDeta7xK3dh2mOHqEutrKuAGTWwl+WxTtiewiT1HJaOzJkhRZdpeeIT
         2p94c8QzKfjSq0dXVHBa+LHXBKVzjkvk6GWKA7hQA7mtKCYBc2O5ffLcgsUELBNAkSUb
         +moTO07sP+AXQmTLMbP6k1XL4Q9/Gb5rVEWIQx7hNV9Ti/LoiFn60lBS25d92t8Ce+SJ
         KwD5FG1RKPWEnJdSLlk3TwCF7m4dBIRerQU6NK29KQuyzcj37uQe+KI2uTdBGtaEZny4
         axUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h71IGBhDHLZNFeeGQl1aF8+o0T/nk2eq4RkxwD7KpTY=;
        b=BFUqX5bfWQdDqAUBaJyqF8thRzCHGFPefYIKTHZKtb9/nDhnvjtlhZ69IRUgshSay3
         AvH3LVXb+Q+srz4PGZ85Ake67IxBEYRsaUBaCZATxTlrMVx4gtcHUkc+3ZHxWv+yQTXx
         mcK2yvobYEoDCIIQJ+hIkufiRu/j6SDrt/aY9wRLtM69NyHLE+WRjEKrWTmmjdB4+0QV
         arsyFOO3dMxCuxka8/04RZ1ENQwB1CXAx2cLWuXjLFx24ZYijeKWWvKBDvM1cBoW01Y7
         7tvB22TR0GRCvgfiDURC6TbcshdfY96/SuBkAw41UZ7L9s99Y/ojpwjO5dlrJyq1TCDJ
         quMA==
X-Gm-Message-State: AFqh2kpOdoqIGU9C/OQ2IVc4wS3BEAnvCeEic2TmPSKt+oLpae1NUQw7
        +i2s/P8YEoyt/r2h/xHwnQC/qP46+Qps7kPx25N7bw==
X-Google-Smtp-Source: AMrXdXv9DfKM19a9yGdXvZG/oz7NHoQeRoQlQfXfVf0wyzEKp/G24S0zBpN+nXKZildbZShWXRGv8i4Q+OEc0UWfh2s=
X-Received: by 2002:a05:600c:6020:b0:3da:1bb6:ed44 with SMTP id
 az32-20020a05600c602000b003da1bb6ed44mr1858042wmb.149.1674494661461; Mon, 23
 Jan 2023 09:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20230121184648.38487-1-didi.debian@cknow.org> <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
 <3632669.kckeHSHuci@prancing-pony> <8858063.18A79QhPUa@prancing-pony>
In-Reply-To: <8858063.18A79QhPUa@prancing-pony>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 09:24:08 -0800
Message-ID: <CAP-5=fV21x38Ne8MOhRCxV2zO-GhFvg7ZVw4sAfYr8RxveNogQ@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Edward <edward.baker@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
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

On Sun, Jan 22, 2023 at 4:37 AM Diederik de Haas <didi.debian@cknow.org> wrote:
>
> Hi Ian,
>
> On Saturday, 21 January 2023 21:53:51 CET Diederik de Haas wrote:
> > On Saturday, 21 January 2023 20:25:46 CET Ian Rogers wrote:
> > > The JSON files are generated from Intel information here:
> > > https://github.com/intel/perfmon/
> > > Fixing the spelling in the tree means that when we update the
> > > incorrect spelling will be generated again. Intel are looking at the
> > > matter, I've added Edward Baker to the e-mail. To make it clearer,
> > > could you separate the JSON fixes from the tool fixes?
> >
> > Yes, I'll send a v2 patch with the JSON files excluded.
> > And I'll send a PR to the GH repo.
>
> I just did send v2 of the patch with the following command:
> git send-email --annotate -v2 HEAD~1 --to-cmd=scripts/get_maintainer.pl
>
> But that no longer included you(r email)*, so here's the link:
> https://lore.kernel.org/lkml/20230122122034.48020-1-didi.debian@cknow.org/
>
> The PR on GH is here: https://github.com/intel/perfmon/pull/44
>
> *) Still need to figure out how to properly use `git send-email` as I find the
> separation of the email contents and then only subsequently and separately
> seeing the To/CC list rather inconvenient.
> Guess I'll just use --to=/--cc= manually for now.
>
> Cheers,
>   Diederik

Thanks Diederik! There are some updates from Intel's perfmon
repository that we should pull to the perf tool pre 6.3. I believe
there is an update pending for typo fixes and hopefully these can
include yours. I'll try to keep an eye on things and send them to LKML
unless somebody beats me. Thanks Arnaldo for pulling the other change.

Ian

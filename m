Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BF6D7009
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjDDWUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:20:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CFD1980;
        Tue,  4 Apr 2023 15:20:06 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17683b570b8so36306758fac.13;
        Tue, 04 Apr 2023 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680646806;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y7XQ1d48lXRoj3hPgE3MCp/Us7AzkBz2FlHIdv2umS8=;
        b=dzoEwbLu+/V6H1H3nlbQVUpvtcdjz1w5ltLXx3FgxcT+JYmr6Fdt0wWtF9YqJVy1sR
         BNCsOrBobSNOthemZlr2tKrCO/LF60iYJfeJWDqUzHdwQgnK8Aajm3QjghBFiOS3O8pB
         eE9EswdDAnYeJ2l7yP9HyAAQgWHvpEXrWvnwIzC8mmSTBq8Y3bG6aS6NMLglsnNOqdZq
         2KC5WZc7OIR0xftERgodTYKbUbuuVIHMkY+EFGKYqwXY8ZdJ2fgdq5CyVuemqW92s9Ml
         9WW54IaoiozgM1kRwDo2b/+VNT/VQ/DoYlswIHYwbOlHLSdIdZ7z42T3MjcljxAZyKKC
         FSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646806;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7XQ1d48lXRoj3hPgE3MCp/Us7AzkBz2FlHIdv2umS8=;
        b=Z+XJ/1/uuS9k0cE85R2Glx/6euK8EqjxbnXNEtqEEdJQlsglf5GMFxO4NLZyKdnW7g
         ZHjFXT++YnWLCY8BfbVOAhnZDH2Xohqk4JuAInGxcQ+SwEibOt6Lh3D76efwSdyqk/mX
         h6MaeinPaqJGQKyU7gKwiipDgC0Eygrpg6h6pzUaEGKWd0xXD2pG1c8R/elQW/f9yc7w
         Q3xZwKjcSfPXHy3wp82RHyVd38CRnc0erhTtZR0Iu8bsgVlUaer21oRcO471tiHsD19s
         xE0qUETT/JJA7+heFy7f8kjfMjD8J4PnJlKtQXHUdVK1bkpJirbYCmSc3zr2Ywl1qyKy
         n/OQ==
X-Gm-Message-State: AAQBX9fll1dTzK+6Ntu7KqrF3UISg/ql5lV8TPbI7N++J1pwcNr/mx1+
        sABZdzV0ExImO84TvpZHhT4=
X-Google-Smtp-Source: AKy350YBAXOVJxvRcF2p1+IPgveULXaHEk33NpLb6b1FGMewG0bEKG7MYatddKg7j5KqY/qyRj1J9Q==
X-Received: by 2002:a05:6870:15ca:b0:17a:a59a:e931 with SMTP id k10-20020a05687015ca00b0017aa59ae931mr2531877oad.11.1680646805912;
        Tue, 04 Apr 2023 15:20:05 -0700 (PDT)
Received: from [127.0.0.1] (189-94-27-10.3g.claro.net.br. [189.94.27.10])
        by smtp.gmail.com with ESMTPSA id bd27-20020a056871b31b00b00177be9585desm2879498oac.1.2023.04.04.15.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 15:20:05 -0700 (PDT)
Date:   Tue, 04 Apr 2023 19:19:59 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/9] perf list: Use relative path for tracepoint scan
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM9d7cgdioP9-yiCmvaDz6Nf1iN5qZZJ0rwBT0HYKsrDa=ubKQ@mail.gmail.com>
References: <20230331202949.810326-1-namhyung@kernel.org> <20230331202949.810326-2-namhyung@kernel.org> <ZCtMLkNL80EkPvB1@kernel.org> <ZCwv4z5Dh/dHUMG6@kernel.org> <CAM9d7cgdioP9-yiCmvaDz6Nf1iN5qZZJ0rwBT0HYKsrDa=ubKQ@mail.gmail.com>
Message-ID: <8CCDAD7F-6C59-4C29-96CA-0C903D77593A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 4, 2023 7:08:31 PM GMT-03:00, Namhyung Kim <namhyung@kernel=2Eorg=
> wrote:

>> ---
>>  tools/build/Makefile=2Efeature   | 1 +
>>  tools/build/feature/Makefile   | 4 ++++
>>  tools/build/feature/test-all=2Ec | 5 +++++
>>  tools/perf/Makefile=2Econfig     | 4 ++++
>
>Maybe you forgot to add the tools/build/feature/test-scandirat=2Ec :)


Yeah , I noticed that and fixed it:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/acme/linux=2Egit/tree/=
tools/build/feature/test-scandirat=2Ec?h=3Dtmp=2Eperf-tools-next

- Arnaldo=20

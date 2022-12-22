Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE965471C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLVU1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLVU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:27:51 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C0B20991;
        Thu, 22 Dec 2022 12:27:48 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x25-20020a056830115900b00670932eff32so1745131otq.3;
        Thu, 22 Dec 2022 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Er3i+1JlgcyOFG/kVKKJjYwxWB05X+LCSTj3O90dme8=;
        b=K5DXoPdF6mYUCdv7slzx118lGzQ1ZtR1CdOXm8xo9Z3/ssV2GZFwafLyXuZmP8bucC
         WsYsVLtFTaChoetHjxVJB6mH6EiadHvWAs0VXZ3uTyq6QmgpMveUYkpZX87fXwUD0eGU
         MndWwI4RSKsspeyUCm+9mvXCdhPfokz7wEjeZKhi4+YoAbfS5wZeFDAYrfWGUm41YzhG
         wMFJ2z7viyYcozAxuZCSHbpLOS86Fp/ARrOT8c65v7PohB1I1Hvvwq31ei0svtNRllu6
         0p9PZgcSuXHH0T+4sxY+RptUjGBej0qMyrfE/gAlzqDsEPtx9reTBbM6To9QcH3hJt+g
         MsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er3i+1JlgcyOFG/kVKKJjYwxWB05X+LCSTj3O90dme8=;
        b=WGD5LgMqkCJ9ntJe+Z7zL3rT9hJJTUqfgOhirSE/71AG1HJHrR7RDdGJi+JzcLJAbB
         DWbcXZMPDGUEcitWRB8uWFhiQ/BOs06jFuwi4hBqfxC6VQSYWZbqAePubH5yu/W+8MEw
         WkwM6rF00M0jp5hOonPFaxHO9m2X9g+rBLv40u5CZkKxW6+LTKEZ70bBJ5RX/5Ldkv5P
         NTdpeQIjzMoiWZ5DZ7lYqCr3+zz+MAZS2pvzaKeztPFHs49iNDrUzkUfsWJFe/Kra7Jw
         NPSDm0jiIbOHwZlEi13sTRsZHvB7hDHCJn7Ccr66ocK+pbJ8t8jPkoNW/wMcl8l8IvB5
         QeXg==
X-Gm-Message-State: AFqh2kpIkgMEAsFrFjQKsRh/fg2DOFMP/eSg3oipj2fToZFIddLy8mDU
        wW+z5sQnMRMwEKQYxJibnGI=
X-Google-Smtp-Source: AMrXdXvjuc8mfbhTSza+sZFhmb4RoBau4oR/AZCMlqHQNhbcRlbzxyPJiSz7r9S7a1llxM3bXJ8Mpw==
X-Received: by 2002:a9d:1c3:0:b0:661:dfeb:ea29 with SMTP id e61-20020a9d01c3000000b00661dfebea29mr3491346ote.14.1671740868007;
        Thu, 22 Dec 2022 12:27:48 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u20-20020a9d4d94000000b0066871c3adb3sm757375otk.28.2022.12.22.12.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 12:27:47 -0800 (PST)
Date:   Thu, 22 Dec 2022 17:27:42 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 2nd batch
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
References: <20221222164914.508929-1-acme@kernel.org> <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
Message-ID: <DD787D2F-37D7-45CF-A310-AA5EE6F0DECA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 22, 2022 4:14:20 PM GMT-03:00, Linus Torvalds <torvalds@linux-=
foundation=2Eorg> wrote:
>On Thu, Dec 22, 2022 at 8:49 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>>         Please consider pulling,
>
>I have pulled this, because it's purely tooling=2E

Thanks=2E

>HOWEVER=2E

>You are now on my shit-list for violating the Christmas peace with a
>pull request where most of the contents were not in linux-next, and
>weren't fixes=2E

>I'm PISSED=2E  Right now I am in the mindset of "I pulled this, but I
>never *ever* want to see another pull request from this f*cker"=2E

I'll get this to heart, people on the cc list: you too=2E

>Get bent=2E

Humpf, life sucks, I have to be like that, otherwise I'll bend again=2E=2E=
=2E

We'll be back to just getting automated responses=2E

- Arnaldo=20

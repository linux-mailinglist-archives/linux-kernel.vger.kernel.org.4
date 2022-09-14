Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8875B8D42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiINQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiINQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:41:22 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF95B7B8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:41:21 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1274ec87ad5so42616499fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3mvWnq6T5YPZPNZgVATnTmoHd9GNP7UDhhBoGTP+u+s=;
        b=A9qD6mmQJj087XvxOLYSOU21EmJy/M/HpYeUVFjVwpax5g/SjgLZTff811ZJRu7jUM
         57FG4VkPfKgOJ/E2z+QGhlBPJlGO+cU6W/pq78nR9HIImyhYThhMUwVX4UT//sCrtgCI
         bBhC7auP3BVNFEfOfJSnbQgjcxAfpbtnSE+bkbNhj95XwHxwpU1grZzVpFosdnzlnm15
         64JXrxWdEQpCLY9yom5DnFdfTP99nk1Q6sq//qlOyPyQG5b3Jvs5NuDGCoF7mx/yF1Xx
         jbXaC/ixcyCMk5ASQNxJKW/C4XkJ4wVeFCQ+OGHpT3pzLniVm2vZIXHh4+jXSkWl7i4Y
         wpug==
X-Gm-Message-State: ACgBeo0SmDN6HwZv/gtocBaDbl3dbrm932qGmArHWGK6eu0cUcCKKQ4i
        3gHBSgjdvKA8HxY+cdw2HOtF0qms3f2u91n1ERK3A5M7
X-Google-Smtp-Source: AA6agR5D5Rf9nzMSu98yLmSXU3BgJuvDmNX+8YqTv7eCzCaE71VYkVw+3AdpY2uyouvxNBYXKjwL/A7hZ4QKV+hoHDs=
X-Received: by 2002:a05:6870:e748:b0:127:dcb9:c59a with SMTP id
 t8-20020a056870e74800b00127dcb9c59amr2770210oak.0.1663173680858; Wed, 14 Sep
 2022 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220914080150.5888-1-adrian.hunter@intel.com>
In-Reply-To: <20220914080150.5888-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 14 Sep 2022 09:41:09 -0700
Message-ID: <CAM9d7cjq0rDKgpGTnrTiJy9Ew282BTZ1SQZMM1-CawLqKMOP6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf test: Add tests/shell/lib/waiting.sh
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 1:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> As requested by Namhyung, move functions from test_intel_pt.sh
> to tests/shell/lib/waiting.sh, and parameterize timeouts.
>
>
> Adrian Hunter (2):
>       perf test: test_intel_pt.sh: Move helper functions for waiting
>       perf test: waiting.sh: Parameterize timeouts

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/tests/shell/lib/waiting.sh   | 77 +++++++++++++++++++++++++++++++++
>  tools/perf/tests/shell/test_intel_pt.sh | 68 ++---------------------------
>  2 files changed, 81 insertions(+), 64 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/waiting.sh
>
>
> Regards
> Adrian

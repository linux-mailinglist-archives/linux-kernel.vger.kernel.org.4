Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F261D73CD73
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFXXhh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFXXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:37:35 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1056210F4;
        Sat, 24 Jun 2023 16:37:35 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-780cdb2aa01so48858339f.0;
        Sat, 24 Jun 2023 16:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687649854; x=1690241854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsIg6m7BWrpUwxujmjQxPQdlEy5JHTyD5kBudsZOhOI=;
        b=Vya8Z0eI3dfs+aHZQxlmbRHn8E4troT+q/lGP/60lPeN1AiAsaPQ4rJSeTDoCRlFm3
         n7Xl2u1oOaCZg9WK4xE7IyZjQZL248jntN7ozsWjx+dnqJzrsFf0kyNurfKrgNaDAhuy
         OrshIVJbz5DSFRj6lSfH2X2f4FPivDPKw0hMetdZb40+xfsAPVIvSnLvdaubORqWkpmI
         EptO941a/YFsLyl3WSTOO7FZMXOl1Tv/Y5XXeYG8f4XRf9B8mStleQqRXaPhf6aH2h2G
         h70psWuHOITjqqtm22+nx3F+/hmuhHpoI9xOB9VXkWc77siMxqjksEP+7P9ppW9lDpfM
         vSFQ==
X-Gm-Message-State: AC+VfDz1XDFx0OHuHviQBv2j08JLYuJ2yRZXvu5irg2XjF37B0xgLiui
        naed3iszVTsEoxOwXs4Ico+spoGc6aoqTYmDXjU=
X-Google-Smtp-Source: ACHHUZ5DDvhzBocDBYZZW1sCOkdkJ0e/BX5o4oMvRr5BwoOggJqbLqp8VvKzyGNzdcn9yXOxJCoTLUlLtkRuI3LlD1I=
X-Received: by 2002:a05:6602:2995:b0:777:acdd:c44 with SMTP id
 o21-20020a056602299500b00777acdd0c44mr16632499ior.10.1687649853842; Sat, 24
 Jun 2023 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230623054520.4118442-1-irogers@google.com> <CAM9d7ciLAUc+0pxeLU91RCxi-oWmV5q=Nb0BQ_tP_4U=PGCtmA@mail.gmail.com>
In-Reply-To: <CAM9d7ciLAUc+0pxeLU91RCxi-oWmV5q=Nb0BQ_tP_4U=PGCtmA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Jun 2023 16:37:21 -0700
Message-ID: <CAM9d7cjM73BxHTB3Rmo5zgm_Por=iJGTZbWOaJLVNZMDkq-4Jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove symbol_name_rb_node
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 23, 2023 at 9:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Jun 22, 2023 at 10:45 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Use a sorted array of symbol pointers to avoid the potentially
> > unnecessary 3 pointers (rb_node) for the name sorted symbols. Saves
> > been 24 and 16 bytes per symbol.
> >
> > v3. Move sort by name dso lock into its own patch.
> > v2. map__find_symbol_by_name_idx so that map__find_symbol_by_name
> >     doesn't need an optional parameter. Separate out
> >     symbol_conf.sort_by_name removal.
> >
> > Ian Rogers (3):
> >   perf dso: Sort symbols under lock
> >   perf symbol: Remove symbol_name_rb_node
> >   perf symbol_conf: Remove now unused sort_by_name
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

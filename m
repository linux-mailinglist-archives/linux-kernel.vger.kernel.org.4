Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5F6C2044
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCTSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCTSrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:47:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1EB2D14D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:40:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3d7aef37dccso682761cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679337617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpfaYXXDDOEU7faI8DiWKFieDk8XViRrjAK2ROVtZfQ=;
        b=I3kz/xOalPWbO/CR0ar9RYajhPuyAIKh9PYpDyCPNsPdV5sXhr8iNhDH0/n4vf1wKT
         3ftX29zVpCdXHaAc0Q9jW5TjyfCPJFw4/rkgJRNQNxych78v3ao8588qev5rSgzYH+A+
         h+F7D/s8c9JL/onYI2CGK+IafaREheyO7KVfXhAcaU2EtwjBNAtjyk/MFeOcqlgMRtZO
         O6yjcJf/GAGz6c8gr+x8NwkDNWWOCMg+l6C5vcDpqVLADLGT41WM/VoLR566Dohe1gUm
         o3KCyqYLlMdgdXCkHArTRKJv2sI65703X5gptwa1JgDWnp/i8F8NbMmVBF8ZXVjz5RO3
         jF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpfaYXXDDOEU7faI8DiWKFieDk8XViRrjAK2ROVtZfQ=;
        b=19YuKsUr258dnjcalLURDzCIicebcrjv/tO5OHGBqv246EI85Ih8p0iv4X8GjOiaSm
         wSg+2/wrHJhC+YDLLXmdu9NKRFzW8b+RHenV4zAGO3dNcyl1umiq4qKNoqKAJTe77rfn
         5+uyoT9bp4DHSKU/k8/AZ3VQOr27nSzBm5XIRUSuSwLPQX6mbQfugChKed+aLHXt3QN7
         bLUKyFtvDN/mSoxmH9lI6ILU8J/m/38P0x4jLlMAK+Lx1GyRDaoWx/A2wW+VTNxPKVTy
         TE2uu6l+nA6x1N6VHoaz3RI3Aiuu5miSx47UyzhsRp76eDsKSgPh/RDK0Ne9+lQT0yHq
         LACw==
X-Gm-Message-State: AO0yUKWgmH/1IZX/01bRsGOLU8ip+7F3c4XAaVKyQ84m0T8PeD47PDc5
        SegpbW7J/lr7DKn+tY9TG/OqgnbJp67g5yLKR/7QTw==
X-Google-Smtp-Source: AK7set8QOk2DntJh7mcqwgfwttG/x+ZqIbXeJT8XqeAa/MNCDZE02/eXTofY/4kq/8hAg5VuU7IvQlqYrxUypdskMzA=
X-Received: by 2002:a05:622a:1a13:b0:3de:1aaa:42f5 with SMTP id
 f19-20020a05622a1a1300b003de1aaa42f5mr19529qtb.15.1679337617388; Mon, 20 Mar
 2023 11:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230320183517.15099-1-adrian.hunter@intel.com>
In-Reply-To: <20230320183517.15099-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 11:40:06 -0700
Message-ID: <CAP-5=fU56Kx_K1jQq9b5TpbW-AKTHRAUeQRxfrAvnX7d_zgZkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf intel-pt: Small updates
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:35=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> Hi
>
> Here are 2 small updates for Intel PT.
>
> The first is just a couple of new event type names.
>
> The second is a small change to Intel PT as it relates to
> Intel FRED.  The patch is standalone but, for anyone
> interested, you can search LKML for FRED to find out more
> about Intel FRED implementation.
>

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Adrian Hunter (2):
>       perf intel-pt: Add event type names UINTR and UIRET
>       perf intel-pt: Add support for new branch instructions ERETS and ER=
ETU
>
>  tools/perf/arch/x86/tests/insn-x86.c                   |  4 ++++
>  tools/perf/builtin-script.c                            |  2 +-
>  .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 18 ++++++++++++=
++++++
>  .../perf/util/intel-pt-decoder/intel-pt-insn-decoder.h |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)
>
>
> Regards
> Adrian

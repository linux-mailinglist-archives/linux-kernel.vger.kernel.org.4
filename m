Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CC72F3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbjFNEoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbjFNEn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:43:56 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31F107
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:43:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9b7de94e7so150391cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686717825; x=1689309825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xStsRUfwt3o1gdSJ2s0/TITPGbAEFU/Ue0fEGPIasQk=;
        b=o1ZcBfYUpUqhK/eDBa8d1BZLnrTaqO+mpq2YE0uVA6w8pdtdmWJP5yF5LxarZ3UOx1
         4TZEC6Hy6WEZb0qMVSxsJFbYoaGZ5MjQFAB9LTTblu/QvWo2gV2qruPsFHFyBJenIkvG
         pZu6SUqYudGDeO1jcglkIkwoYL7vMHhIQzVWJgjK3YODYqIdgDg9lYO5l7ayLdmeV53q
         cplKuBbrWLkPNWTydZ1MYxDRXlLkayeci2jXI8LRe9sjH0HptpUsTfP03OKx5P8RKlqe
         JqnojCEe6lU+4flYogW0LdPxOgsQx3YYRnhOcBD5zgSroiVS8CHzcWK+hCWIiM0YlgGu
         8shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686717825; x=1689309825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xStsRUfwt3o1gdSJ2s0/TITPGbAEFU/Ue0fEGPIasQk=;
        b=SLR7t87QsQHLcHBq1Jj58JrkjVWOtyprUR6ZHlbbfOhUj4ADiPsBmAYRFyXJhMyJQv
         +tVAG6FJsDZ6bJXZjb9eLnD6K9QQWlBmaiHfm8ktD/zfAsnalFl5E09AZ89WB5VwWJkC
         HHbSGgyF7cJcuXEHsoxyAMeIujUKeC4oY+uw8GyM3aa76xNH/v+WiyBh4nTOiJ4GqMye
         uEfT5qvPLmko9IAECubvfu80z52CoFXTKeVpz2mxkQn8kyo3JQqz7P4YepHv4+O5bhE6
         nyVtXq0alIxyyJWuuDmK92oUpDzMCqoV6Xv6uIfI+fvCslUMaemHHwzL/I2juYyZefLq
         Y3mA==
X-Gm-Message-State: AC+VfDxeGPooQ1OnonAJ/nQL6zMTRcmbju/WE+RmIxRQ+LtgSGZ/ZAC/
        JbgZdY2AIamS+fAylrmpapjksJJb2YRARvgSf9Enjw==
X-Google-Smtp-Source: ACHHUZ4OL9sIBmAtVDwp+dVs+Z6kDk/oIf/XsL/DfGPr7PN8H8rO2tnVAE26UuOfmXB4RQ4DbPv1fCriI9iSl6bvovg=
X-Received: by 2002:ac8:5743:0:b0:3fa:7dbf:f268 with SMTP id
 3-20020ac85743000000b003fa7dbff268mr55189qtx.23.1686717825150; Tue, 13 Jun
 2023 21:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230614033437.48549-1-luojianhong@cdjrlc.com> <475df60d9dd518e20ae9df396c60b69b@208suo.com>
In-Reply-To: <475df60d9dd518e20ae9df396c60b69b@208suo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 21:43:32 -0700
Message-ID: <CAP-5=fWtrQABXFnuAQWEuaFcvXJ5gaKf=gZUyTLqm8-aY9znrQ@mail.gmail.com>
Subject: Re: [PATCH] perf bench: remove unneeded variable
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 8:38=E2=80=AFPM <baomingtong001@208suo.com> wrote:
>
> fix the following coccicheck warning:
>
> tools/perf/bench/find-bit-bench.c:127:5-8: Unneeded variable: "err".
> Return "0".
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>   tools/perf/bench/find-bit-bench.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/bench/find-bit-bench.c
> b/tools/perf/bench/find-bit-bench.c
> index 7e25b0e413f6..70619bc73841 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -124,7 +124,7 @@ static int do_for_each_set_bit(unsigned int
> num_bits)
>
>   int bench_mem_find_bit(int argc, const char **argv)
>   {
> -    int err =3D 0, i;
> +    int i;
>
>       argc =3D parse_options(argc, argv, options, bench_usage, 0);
>       if (argc) {
> @@ -135,5 +135,5 @@ int bench_mem_find_bit(int argc, const char **argv)
>       for (i =3D 1; i <=3D 2048; i <<=3D 1)
>           do_for_each_set_bit(i);
>
> -    return err;
> +    return 0;
>   }

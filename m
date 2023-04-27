Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABE66F0D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjD0Ue7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244338AbjD0Uey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:34:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A372D65
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:34:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef36d814a5so822841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682627692; x=1685219692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1yyV2YzfH7rOLyHSf8GhXQSsNeJYF/6E6RCMyqSCyg=;
        b=xWHYdie28I+Dez+Z3Rys12aHD1WWeZJoHzaHoIa7wcXOPIBcUJrSIuADWRfc0FdzxP
         8e3l+bJ0YjkOB7WyI1b8J+NETOkP3kmkPs9FH1uEkMUSahlgQMCzLw7FUo6VwDEcAOH+
         KwKw2xODiy/cUdO8T3O70ZcZ+cOoKsspZOqObuLm9JKxeqRkRgaJ/Dj4jPYu34hBtIfw
         OesBLyuY6cCeCLFVB70JAVF0/PrWrbBH8zSa8RoScKsj/jSSeMgKmoe+4mDNk347ANPi
         j7dZ+HIdnJGOx1H1aiH8QrWDYrHtXaKTqFJc7lYOyU3ysXPKDXYB+SWBbYpWApHo8paB
         7j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682627692; x=1685219692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1yyV2YzfH7rOLyHSf8GhXQSsNeJYF/6E6RCMyqSCyg=;
        b=fja57bEY6s+MoAO6W1cztIby8OgZ4Q0BFM/IcSKAAyFLWmUQoLMRH5MlPdw5v4Y1Xh
         lpNXfkPftQwdjSc326h9c0VcugkcVRgbGQIG93wF1TS+UokY4lHpOogxBPniX7TZP6pt
         BdbZvPQBmhgG81/4Fx/VEQ6i0uI7TQMZ6cMVaNQMi7QBqgRZYz+4Qkt4babpLtQY6aYi
         t7X+F46wPHvaphKGmBI3vFm8gUuiBPiqddtd8CzCh+7zGNG1ayIobNhFNjC23q9qxH0P
         p0Xgb5qmQbvqbF6yqCGv+1z65SQtZ/dc7Dw7E7KO+hFq9DGRhsfHH7SeExwEp1C42AQl
         d5Rg==
X-Gm-Message-State: AC+VfDzAGvnEAfJax6mjXgTuUKrSHywxp0AGufyuUiVy/5sMB57N6LlQ
        9BdN4jYJM9a3NDbMPHkjGPiWfMnDOgb2gIDNO7l/FgoumKheHBkpLXRt2g==
X-Google-Smtp-Source: ACHHUZ4UPSDWGdGeDyVcwUFiL8hMkoisHo6Rmqr+2so+fTP3z2DsM7cV0c+3kFYv5gQRh8jeVS7NjJKQsn0vWDjJbIY=
X-Received: by 2002:ac8:5710:0:b0:3ef:5008:336f with SMTP id
 16-20020ac85710000000b003ef5008336fmr99178qtw.1.1682627691911; Thu, 27 Apr
 2023 13:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230427201112.2164776-1-peterx@redhat.com> <20230427201112.2164776-3-peterx@redhat.com>
In-Reply-To: <20230427201112.2164776-3-peterx@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 27 Apr 2023 13:34:16 -0700
Message-ID: <CADrL8HUAY62FX_TYqU9ro4wfhJhcCAC-aDW=zUS5eYQTbWx3oA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/kvm: Allow dump per-vcpu info for uffd threads
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anish Moorthy <amoorthy@google.com>
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

On Thu, Apr 27, 2023 at 1:11=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> There's one PER_VCPU_DEBUG in per-vcpu uffd threads but it's never hit.
>
> Trigger that when quit in normal ways (kick pollfd[1]), meanwhile fix the
> number of nanosec calculation.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  tools/testing/selftests/kvm/lib/userfaultfd_util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/t=
esting/selftests/kvm/lib/userfaultfd_util.c
> index 92cef20902f1..271f63891581 100644
> --- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> +++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
> @@ -70,7 +70,7 @@ static void *uffd_handler_thread_fn(void *arg)
>                         r =3D read(pollfd[1].fd, &tmp_chr, 1);
>                         TEST_ASSERT(r =3D=3D 1,
>                                     "Error reading pipefd in UFFD thread\=
n");
> -                       return NULL;
> +                       break;
>                 }
>
>                 if (!(pollfd[0].revents & POLLIN))
> @@ -103,7 +103,7 @@ static void *uffd_handler_thread_fn(void *arg)
>         ts_diff =3D timespec_elapsed(start);
>         PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n=
",
>                        pages, ts_diff.tv_sec, ts_diff.tv_nsec,
> -                      pages / ((double)ts_diff.tv_sec + (double)ts_diff.=
tv_nsec / 100000000.0));
> +                      pages / ((double)ts_diff.tv_sec + (double)ts_diff.=
tv_nsec / NSEC_PER_SEC));

I almost confused this fix for [1]. Thanks for catching this!

[1]: https://lore.kernel.org/kvm/20230223001805.2971237-1-amoorthy@google.c=
om/

>
>         return NULL;
>  }
> --
> 2.39.1
>

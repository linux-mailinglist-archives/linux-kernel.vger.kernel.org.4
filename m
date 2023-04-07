Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47986DB1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDGRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:44:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D811D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:44:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u20so26941561pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889484; x=1683481484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeevj2IXfQ5qKWd9tc/WTPMDjydGded23Wx96ttD0lI=;
        b=hhqIeBHDIU5yzroiAIHl+7N6gz1w2qhb+FwHxu6UgMzdA6Fn4bc96z4iNP6uq0+ucK
         SfTWCoqxapUnKo5o0sEdTX+d7PYT1t7QbKlAF/LAqmZ69ldi5F8mQJzcMRl21RC5Oz/D
         8ly4IetMDqXyRp7vPXLZhS56PnIh+7KUl7vAXgBWDoAX38K6hqjTcIdiPyFE2dggrMka
         S/XEHPVLEFx9yuyS15lLboTLxr3MwnU/hQq/eNMBsSCCNaHI1Ur+g+bxoYnLJIqgZNoE
         /2sMR6UuqXxesV7+iS3U77sldJTpU19MinXiiXy2icHcg2CYvxUGt8MvHCKUS2mXf1gu
         1gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889484; x=1683481484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeevj2IXfQ5qKWd9tc/WTPMDjydGded23Wx96ttD0lI=;
        b=M4s5g+xZCECWBoz8twmKL0qRqu09nV0ZQQwjM7bG+g8F9KZ7ZphpDc73KB7seBrzBo
         swr22aTSqKEBGaxZxWKCmKzrYaOcslXks/jea16RVx5+kl43C3uByCmO0taZgXK+5W+c
         xB9D44urXkvyNspuOsSadSF1V78ubFBJzP8Ssbqz3mTpDbLehb6W7P978ehyJr8BXMjv
         hrDaxZLNGZHkK4fpdGcvKfC+9R37TS4qh5oybOXK71VPm3m1hpP6qEAHAZQVP8yhuCi6
         bIl3l3SsKz8y9lGe6BZmEExRHJAeHmGF1QwACo5c0cgphpQIZ199Fo8NckOud0CmnR7a
         SpqA==
X-Gm-Message-State: AAQBX9due6VcN3Dc9qKlKGpw34VW6qZapOGj4E0RqlVFmSaJiODik3Rv
        tKw9Xob57Qdw33/qwEy3SwnEql1+5so13FiS+Ukpyw==
X-Google-Smtp-Source: AKy350bdMJ3LG9Gi/HkfohQwKo0s3+e/a281cskd8iLsjDWZHESfhkK9S3fdtxt2CrSKiJZP1lRF2TsMUY8mo8Nq91I=
X-Received: by 2002:a65:578e:0:b0:513:a488:f05f with SMTP id
 b14-20020a65578e000000b00513a488f05fmr625705pgr.1.1680889484187; Fri, 07 Apr
 2023 10:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230324175942.2653272-1-trix@redhat.com>
In-Reply-To: <20230324175942.2653272-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:44:33 -0700
Message-ID: <CAKwvOdkFK3f6zdkw4Xpa9WpTx6159GWF8J2rtMHoChStu9svVg@mail.gmail.com>
Subject: Re: [PATCH] fs: dlm: remove unused is_granted function
To:     Tom Rix <trix@redhat.com>
Cc:     ccaulfie@redhat.com, teigland@redhat.com, nathan@kernel.org,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:59=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> fs/dlm/lock.c:239:19: error: unused function
>   'is_granted' [-Werror,-Wunused-function]
> static inline int is_granted(struct dlm_lkb *lkb)
>                   ^
> This function is not used so remove it.

How about instead of remove it, we see if we can reuse it?
Grep for DLM_LKSTS_GRANTED. The comparisons on:

2668: if (lkb->lkb_status !=3D DLM_LKSTS_GRANTED)
2787: if (lkb->lkb_status =3D=3D DLM_LKSTS_GRANTED &&
3749: if (lkb->lkb_status !=3D DLM_LKSTS_GRANTED)

all look like they ought to.


>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/dlm/lock.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 1582c8b1404c..b9c124b88f15 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -236,11 +236,6 @@ static inline int is_altmode(struct dlm_lkb *lkb)
>         return test_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
>  }
>
> -static inline int is_granted(struct dlm_lkb *lkb)
> -{
> -       return (lkb->lkb_status =3D=3D DLM_LKSTS_GRANTED);
> -}
> -
>  static inline int is_remote(struct dlm_rsb *r)
>  {
>         DLM_ASSERT(r->res_nodeid >=3D 0, dlm_print_rsb(r););
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers

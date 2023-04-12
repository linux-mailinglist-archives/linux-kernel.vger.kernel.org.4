Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811406DFEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDLTs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDLTsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:48:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55C4C2E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:48:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n22so11407521ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681328896; x=1683920896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivsW0wdegcgGGPqK1SdV6k/Owfxdr2w4uEXcSN1jEOE=;
        b=3jBVuSAeXEse5i95AaF8Klk7mVw+tazc4qD7DIlU5c2+KRBjdjJoyEgHWRFeAZ0WdU
         SyF7z/LMZOl8MbcMpP17JvzzXg1PLj/pTiA3pacdm+a/x+W/OfZdEXyKTh5FWadhYExx
         DM3zFKefK0hSSxIAI9KdqU92MM3XevjKtJjnRrGoDMQvTP7MtP1TkpLph3BpIcIRxEoQ
         MlBiGx+EeeMfTJ4nz0jekMQgw+cHNztUgd2U3plVpY7vjgo/eLDPvhCJGmplcuArUU+u
         Mfz2xdZqgIoQmz7nNT+s1w59+DgB1O5ABvdLudnpa+8Ah7RyQZ5j71P9Q1rj7xhRkXsY
         PdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328896; x=1683920896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivsW0wdegcgGGPqK1SdV6k/Owfxdr2w4uEXcSN1jEOE=;
        b=RaA0tHP4sOzmnTVuswzSj5QXENHSUD8U5q0xG+f/wLJlh1bdyry0jTqcj2MtTWe8A+
         Kgy4HhPBx0mwQaIOlOcMfmuN/vMmX8UKpFPHyDHqLK9N7jUgviQIgPL9NL37sneqSRlP
         qZb9SQkyk6sSfVlbUe7ZU405h6U1bnOIgkTr0zW61nDGPB4cWM9PokZNI/OslWVvkbjK
         hGqC8k+pzXcTJ35zZyhqk8uzjSWIFU/6b6gxFcioNpoYyqEGs7mZJLcOlxi/qiiSGSJp
         HKg10qnnIjh0Nzuma1lo3KRoLc2SAcQjdPDp2+Dz/d5Ih6HVSShj1kMdG5l7GqUVejSp
         Ag1A==
X-Gm-Message-State: AAQBX9e4jcLpRlFSfJdHfn3OQAm4y4jYCwbE0MAUcGRpvTSyP9PezlI6
        4VZapxELy6cBhjapxMUs45QwpwPC4x+6vh8hqKVl7w==
X-Google-Smtp-Source: AKy350aoz5XaL5YPxBof6Akn8PaWXGQPq+FO6dRNt4wUCa5GCN0wPx73al9GgX1FRWKa4tn5UYENP76F1zAZX95RGWk=
X-Received: by 2002:a05:651c:20c:b0:2a7:8203:152c with SMTP id
 y12-20020a05651c020c00b002a78203152cmr3159739ljn.6.1681328895663; Wed, 12 Apr
 2023 12:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164257.328375-1-peterx@redhat.com>
In-Reply-To: <20230412164257.328375-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 12:47:39 -0700
Message-ID: <CAJHvVcgtAhEkqkYegHONCJz5uJoxRLRdm9Kp8DmkcnZhU=w=9g@mail.gmail.com>
Subject: Re: [PATCH v2 16/31] selftests/mm: UFFDIO_API test
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 12, 2023 at 9:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Add one simple test for UFFDIO_API.  With that, I also added a bunch of
> small but handy helpers along the way.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 109 ++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> index 6857388783be..bb492c258486 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -9,9 +9,116 @@
>
>  #ifdef __NR_userfaultfd
>
> +static void uffd_test_report(void)
> +{
> +       printf("Userfaults unit tests: pass=3D%u, skip=3D%u, fail=3D%u (t=
otal=3D%u)\n",
> +              ksft_get_pass_cnt(),
> +              ksft_get_xskip_cnt(),
> +              ksft_get_fail_cnt(),
> +              ksft_test_num());
> +}
> +
> +static void uffd_test_pass(void)
> +{
> +       printf("done\n");
> +       ksft_inc_pass_cnt();
> +}
> +
> +#define  uffd_test_start(...)  do {            \
> +               printf("Testing ");             \
> +               printf(__VA_ARGS__);            \
> +               printf("... ");                 \
> +               fflush(stdout);                 \
> +       } while (0)
> +
> +#define  uffd_test_fail(...)  do {             \
> +               printf("failed [reason: ");     \
> +               printf(__VA_ARGS__);            \
> +               printf("]\n");                  \
> +               ksft_inc_fail_cnt();            \
> +       } while (0)
> +
> +#define  uffd_test_skip(...)  do {             \
> +               printf("skipped [reason: ");    \
> +               printf(__VA_ARGS__);            \
> +               printf("]\n");                  \
> +               ksft_inc_xskip_cnt();           \
> +       } while (0)

Some of this is duplicating what's in kselftest_harness.h - e.g.
assertions, printing test summary, keeping track of pass/fail/skip
counts, etc.

I wonder how you feel about using the standard harness? E.g. is the
plan to do this (more straightforward?) refactor first, and then
switch later? Or is there some reason it can't be used?

> +
> +/*
> + * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'l=
l
> + * return 1 even if some test failed as long as uffd supported, because =
in
> + * that case we still want to proceed with the rest uffd unit tests.
> + */
> +static int test_uffd_api(bool use_dev)
> +{
> +       struct uffdio_api uffdio_api;
> +       int uffd;
> +
> +       uffd_test_start("UFFDIO_API (with %s)",
> +                       use_dev ? "/dev/userfaultfd" : "syscall");
> +
> +       if (use_dev)
> +               uffd =3D uffd_open_dev(UFFD_FLAGS);
> +       else
> +               uffd =3D uffd_open_sys(UFFD_FLAGS);
> +       if (uffd < 0) {
> +               uffd_test_skip("cannot open userfaultfd handle");
> +               return 0;
> +       }
> +
> +       /* Test wrong UFFD_API */
> +       uffdio_api.api =3D 0xab;
> +       uffdio_api.features =3D 0;
> +       if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0) {
> +               uffd_test_fail("UFFDIO_API should fail with wrong api but=
 didn't");
> +               goto out;
> +       }
> +
> +       /* Test wrong feature bit */
> +       uffdio_api.api =3D UFFD_API;
> +       uffdio_api.features =3D BIT_ULL(63);
> +       if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0) {
> +               uffd_test_fail("UFFDIO_API should fail with wrong feature=
 but didn't");
> +               goto out;
> +       }
> +
> +       /* Test normal UFFDIO_API */
> +       uffdio_api.api =3D UFFD_API;
> +       uffdio_api.features =3D 0;
> +       if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
> +               uffd_test_fail("UFFDIO_API should succeed but failed");
> +               goto out;
> +       }
> +
> +       /* Test double requests of UFFDIO_API with a random feature set *=
/
> +       uffdio_api.features =3D BIT_ULL(0);
> +       if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D 0) {
> +               uffd_test_fail("UFFDIO_API should reject initialized uffd=
");
> +               goto out;
> +       }
> +
> +       uffd_test_pass();
> +out:
> +       close(uffd);
> +       /* We have a valid uffd handle */
> +       return 1;
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -       return KSFT_PASS;
> +       int has_uffd;
> +
> +       has_uffd =3D test_uffd_api(false);
> +       has_uffd |=3D test_uffd_api(true);
> +
> +       if (!has_uffd) {
> +               printf("Userfaultfd not supported or unprivileged, skip a=
ll tests\n");
> +               exit(KSFT_SKIP);
> +       }
> +       uffd_test_report();
> +
> +       return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
>  }
>
>  #else /* __NR_userfaultfd */
> --
> 2.39.1
>

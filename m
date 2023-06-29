Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3177429FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjF2PzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjF2PzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:55:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4DC359A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso617690276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688054120; x=1690646120;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgri8fUOqQI+I7MUyONsDj9koQfNy64c7FUPlFRFGyA=;
        b=gReoJunxGhk+O7ZA1Bq4JL8qGLF5oyGv7NH3Q/vC+NhFoZ79MnNV4ZvN/QsdWodcXL
         L1r015WDcOV5fiPOG/fuhXOOyTjcqM/Ufd3gHwQBHEiEQSswPDQ5snkwH3f9t3n3Y81R
         tIc8VIE1JDHu+fmTntY3En+zbKdtdCGbXkvPLoYpHR8VoiN99uCzybXHnKtdfDq/pz+e
         NCy/0NY7ux2VYzjzaBC1jIEVnLs55kONXlRt9LmISrzGHy5UYmqYWpwjyPzFCovADx6D
         w5ZoLsMaJ0rb4RsgJic8ofviuq79K2ljmKKnlK7nvNiiQ7hvpTUkSb9Ks5bnKByNwTbU
         8uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054120; x=1690646120;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cgri8fUOqQI+I7MUyONsDj9koQfNy64c7FUPlFRFGyA=;
        b=EMeZNh1Ki8UscHuo7gtAJ1r0nAWBosjixCCIyYq/p6NSW2++rORoE0mEN3lt0tqtiK
         80JaXEwEZCHU2N5AH03mE5nBu96KNpAJl6nYibgNPMTOiZIog35IuojASIJGt2SiuBEa
         QaylH6mFkTAUe5P9a67kXpLMXmYhDW4fAoMwUd41TXY3oXqPLz1id9C2TJoRxbfZ2MBg
         Mx7ctfhKfO4eQ+lywOG65arTmjNS49x8UY5aK2WvMqQ40quI4VU/1xLXZFDtF0j1mXLC
         YzZsXWPZIQpkQVc1w6xed92PLD8T2zFvJDlvqaVHsmnYqOtKwXv6b072vIAyrVt5Ka+f
         TRjg==
X-Gm-Message-State: ABy/qLYh31+7eG2en4agh5ESAHgbI3oLfnBhymVa8zIyCbf+VpPAva3A
        7rjpwGeBM2YHe8w72HyU0RPMpeClp+c=
X-Google-Smtp-Source: APBJJlH71Yciw3xeqsl46JypVoDE/SEH7Y6DeYWgAp+jNkiLzoDpetuR+INoL7nBo38XdL/qpt5TVOqaReM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab68:0:b0:bed:d03a:fc5f with SMTP id
 u95-20020a25ab68000000b00bedd03afc5fmr2047ybi.11.1688054120441; Thu, 29 Jun
 2023 08:55:20 -0700 (PDT)
Date:   Thu, 29 Jun 2023 08:55:18 -0700
In-Reply-To: <20230629142633.86034-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230629142633.86034-1-likexu@tencent.com>
Message-ID: <ZJ2pZh4GeBytq7R2@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix the meta info of test cases in the
 header comments
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
>=20
> Fix test case names (including descriptions) in comments for
> tsc_scaling_sync and xen_shinfo_test. No functional changes intended.
>=20
> Fixes: e467b0de82b2 ("KVM: x86: Test case for TSC scaling and offset sync=
")
> Fixes: 8d4e7e80838f ("KVM: x86: declare Xen HVM shared info capability an=
d add test case")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c | 4 ++--
>  tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tool=
s/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
> index 5b669818e39a..cdb214660e0a 100644
> --- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
> +++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * svm_vmcall_test
> + * tsc_scaling_sync
>   *
>   * Copyright =EF=BF=BD 2021 Amazon.com, Inc. or its affiliates.
>   *
> - * Xen shared_info / pvclock testing
> + * Test case for TSC scaling and offset sync

I vote to delete the metadata (but leave the Copyright).  IMO it adds zero =
value,
and has a non-zero chance of becoming stale in the future.

>   */
> =20
>  #include "test_util.h"
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools=
/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index 05898ad9f4d9..60daee9f3514 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * svm_vmcall_test
> + * xen_shinfo_test
>   *
>   * Copyright =EF=BF=BD 2021 Amazon.com, Inc. or its affiliates.
>   *
>=20
> base-commit: 88bb466c9dec4f70d682cf38c685324e7b1b3d60
> --=20
> 2.32.0
>=20

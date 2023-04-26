Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEB6EF02F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbjDZIYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbjDZIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:24:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4894EDC;
        Wed, 26 Apr 2023 01:23:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4595136e87.2;
        Wed, 26 Apr 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682497418; x=1685089418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEckKHBY+EyhbEJ79Rt9F9NTlBCktVEqPj3Jh76jw70=;
        b=R7cKlO5sGeKPJMhwQBcdCrvGFCXSjQC32VK/c3xmmhbd/MV42Rne/+A/B+SxzxT7QQ
         5oMTeHL8nNnbnkkFCbUUMx/q8Dlgy23Bkixynhs/Vwt7i5Ywv+Psvd6RLB6H0fmZf6y0
         LE+vRgjhOX8LsqOa1Z60zrVNMgRLCBmO/l/lFHMw5bet7aMJgH5nWYorbFih3uDbXJC0
         AOghY2oVD7h8pasruFLv1SNqyg/3GtzQREIY5NcXnATrcUYmpP6140wXy5/ZqzuxOljQ
         F8filZX1MG/hkghKYY816gkgS4Vk6vC97H6fJr9HHx0J8CLvAVX0bJCXZtx4WxE3iS01
         Fd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682497418; x=1685089418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEckKHBY+EyhbEJ79Rt9F9NTlBCktVEqPj3Jh76jw70=;
        b=F/mvClaBYk1z8kNcWln2VmQ78+bYiEVPowzWa7bgAgX3b5Hx326yqamPRoT+MoLYSQ
         dc2cW/3LP9SSnOqg9VCr2LoxkFNUQAWStajMk+j+9G6oJYOWcqGTXhoFtNroGRIOnxVj
         rS0wWYxDQfdWIov+yTgC3EIKoHrKDXIPDhNlMebjw1Fp8fqOPy3RPsWTV+6bWhPY58Rg
         MqOv2MfY+IKgYIAkXoqWBlc4IW+w3z52GtWDeNa3bMKS+9LwCZXnN9Xfcoutunvu/JCN
         TOlDcvNeLXERH8zAwvZotrRNAsyXeCZwbtEMDgjVqaYpAIm2fVKgql+AytLDooq+ueTt
         DrDQ==
X-Gm-Message-State: AAQBX9eddIoRwqdnwtL4rAQhAa4Z52iUovhprVdIUkFHAeRROSVhVizV
        /sbF78dqxPOQ4cqEajhATMerRt3UEACaPrv7UT2FNBAH4x6mng==
X-Google-Smtp-Source: AKy350ZSRBeLRiP625ICpX7+7/HbmvGGTrid2BHs8zu3EvYQtWBopIou4QPh8ZWSDUJtc6x+H53LgILnorxYwOczVmk=
X-Received: by 2002:ac2:46cf:0:b0:4e8:d733:fde6 with SMTP id
 p15-20020ac246cf000000b004e8d733fde6mr5116772lfo.60.1682497417887; Wed, 26
 Apr 2023 01:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kXa-SgRiVhvjU7X4fa8XSJB4po9xf_V4L6Gn2o+t6T+Q@mail.gmail.com>
 <20230426081354.38922-1-amiculas@cisco.com>
In-Reply-To: <20230426081354.38922-1-amiculas@cisco.com>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Wed, 26 Apr 2023 11:23:26 +0300
Message-ID: <CAPDJoNv4NvSef-dTmXWE4HviaM6FJFxGfu3U-n7N=3dHCrZ8HA@mail.gmail.com>
Subject: Re: [PATCH] rust: Sort rust/helpers.c's #include directives
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me
Cc:     Ariel Miculas <amiculas@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My bad, I'm sending this again from my cisco account.

On Wed, Apr 26, 2023 at 11:14=E2=80=AFAM Ariel Miculas <ariel.miculas@gmail=
.com> wrote:
>
> Sort the #include directives of rust/helpers.c alphabetically and add a
> comment specifying this.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> ---
>  rust/helpers.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..73c01db0c828 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -16,15 +16,17 @@
>   *
>   * All symbols are exported as GPL-only to guarantee no GPL-only feature=
 is
>   * accidentally exposed.
> + *
> + * Sorted alphabetically.
>   */
>
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
> -#include <linux/refcount.h>
>  #include <linux/mutex.h>
> -#include <linux/spinlock.h>
> +#include <linux/refcount.h>
>  #include <linux/sched/signal.h>
> +#include <linux/spinlock.h>
>  #include <linux/wait.h>
>
>  __noreturn void rust_helper_BUG(void)
> --
> 2.40.0
>

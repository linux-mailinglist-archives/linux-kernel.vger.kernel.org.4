Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8B6CCA08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjC1Sap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjC1San (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:30:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511F19BB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:30:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p204so16291968ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680028237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuuegu1cFbRg24plQOb38sIUWOVRgzcrx7ze3bOovCw=;
        b=EisE82n2osFxVjm+P56hUIztGP0SJpbOuCu+bnFrUJjzLGGVpT2AMhxGRhRvEmA+e2
         mwHDcinzo8KSut3L9WhHnDG/sBbyKItO3o5cOrsEclcaVTAdmsgDzbiHLetqMON/2c7R
         qpZOC3CsPKMtgEHwCwx1v1wiK2iAa31b/nQXGNFHbIbIzwDXJkIOYFqK/mwHKVOKMwGS
         eoPsvPi7xFBVvhTj0e8R8qCfZ78hkH22H8NGb+a9kyQqKqEAASHKv2y/b5mhdDZAjIMc
         uBbLtidGE9RRevnYtrdZjt5I7c3DLMwMWcWbUg99OolXIxTbL0WtfU/TrRwxVn+2cC6R
         hvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuuegu1cFbRg24plQOb38sIUWOVRgzcrx7ze3bOovCw=;
        b=oFUXm7yGbx4ZkeqxAA5Ul5XWiLtqyYT9iW78uGqv3195HKDFdQ/fCbJ5eSbxknvWYK
         hM5vszKD1BRrasdfc0Zw/txE2ZAVH7txV84zVfwqZGWp+CRUeri13ExTvYv+SSCRP6qH
         TMnROkf+WeinBaoVixww//hBUeSesf4wr8UflKnBS9KfEFa3sbnv0CaIAlr7hmNDjRTL
         6p6vvcsOZVl6e3uvMZXEbZlX2hK/11I2vR4oVzEGAZ7m0NQgZbX9xPjy4x1OG6wzQIau
         JYhf8RwZMBmuU6tLQ1gumBqVb7kI3Ru1CObghJVT+C7sb0us1H4RshkkKIt68DVIPJR1
         ib1g==
X-Gm-Message-State: AAQBX9coTpoVWta9TtPtdumbv47/Vg9uSf1XCp9uCRZNeSku2fHgdQcS
        S7E1yFBItqNe/DOMRoGeLGEPwxAt0WPZQB/xAsVgvw==
X-Google-Smtp-Source: AKy350bdcqdugUTreAEdn+N2C6zWYXNTotXJWZHwzhwo68iZpT2NVGuPdqGaegdgwHn5bo8EA+DZTRUfdIbWCVZZmyQ=
X-Received: by 2002:a25:ef0e:0:b0:b6a:5594:5936 with SMTP id
 g14-20020a25ef0e000000b00b6a55945936mr10356788ybd.5.1680028237374; Tue, 28
 Mar 2023 11:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230327115331.122562-1-hca@linux.ibm.com>
In-Reply-To: <20230327115331.122562-1-hca@linux.ibm.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 28 Mar 2023 14:30:22 -0400
Message-ID: <CA+GJov6YeJA5Hed=sLOdDY43WkwVrQ9i1dPsQ_inVdDhpBjUug@mail.gmail.com>
Subject: Re: [PATCH] kunit: increase KUNIT_LOG_SIZE to 2048 bytes
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Mon, Mar 27, 2023 at 7:53=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> The s390 specific test_unwind kunit test has 39 parameterized tests. The
> results in debugfs are truncated since the full log doesn't fit into 1500
> bytes.
> Therefore increase KUNIT_LOG_SIZE to 2048 bytes in a similar way like it
> was done recently with commit "kunit: fix bug in debugfs logs of
> parameterized tests". With that the whole test result is present.
>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---

This looks good to me. I don't see an issue increasing the log size.
Maybe eventually we could create a config option or test attribute for
a large log size but for now this seems good. Glad to see people are
starting to get use of the parameterized test logs after the debugfs
fixes.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

>  include/kunit/test.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9721584027d8..57b309c6ca27 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>  struct kunit;
>
>  /* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 1500
> +#define KUNIT_LOG_SIZE 2048
>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> --
> 2.37.2
>

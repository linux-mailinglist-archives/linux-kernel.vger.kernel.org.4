Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB0604EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJSRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiJSR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:29:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340BEBF77
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:29:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v11so3367959wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SjI4Z5co0jP+dS3DaFSz22T5OkUEoxSjseAK5lz7j2I=;
        b=qEGEnfPvhrallYxSGId63ucJ5syeGHO24jd/sGBVIAk6xnp+BnJOvWTmTCX7cPCAxU
         o0L4YvNOiNrB2/+bmgnUN/KgJUcNgtxplL+1DDLsCFz/HhExm6XZW3PI49Gs68WQDafj
         wMosHixYsk5oEoE3wqikKipk5XDHBE1MtZs/hp8TDaNCq5wt0mQBLNMOgtcMb12x3HVs
         Pi0IQ/ykdGBKI91ntCHbdYvrSZBl7qWF8lnz1xvULeo9lvFMpj+OYalKZnYLjIDb536h
         SXnpDppeR2BivNvRfI3D+NlRBpkWmMRvQLqafn/5N9sdnnJ6+srWH92eX1Oa/xHJ+g59
         YFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjI4Z5co0jP+dS3DaFSz22T5OkUEoxSjseAK5lz7j2I=;
        b=RMBfDiEAxM9E9QmH+57fQY1vPT5rBiRUBXb1ZV0ZTGeCy0BwUID6Ow8Y/RKIJkGB6c
         G8/ymNWkI4pQXgI1WEf6e8uY9mJ8VFCtuwBvZIVNaOijeCR5JOePwkRjtUZCTQy61My+
         BIIhUcVUXy8gPYCNTQGIi6M2IpEdPtLcnyUhmPn32425UgFleeVXsjOJlYYC9qoq96iT
         SbelMiXjb9UNCkZTje1hG4XtKZUl3oj8wETIsgl4NFF2lk22bKtG/DQT2diS4AEsdhRC
         3wS9c/fkST222zAFLKQk9r5dSrDYmQazxjC+pO+JP7PNxoH8r1f0oSDLRAHSuBZ6raWK
         NGKQ==
X-Gm-Message-State: ACrzQf1QAIuH6ib2/a1zRHrHHZJtDAjolJ6onNNsUR5HjFP4Q1mdaXmo
        RzpJhcp5P+r4rQaBq5Zliz8=
X-Google-Smtp-Source: AMsMyM7ZQa2DiMhpN26ZGtW7L/xi7tJf2RX90DMZQvdqVwq0bPLH7ZNTlZ150wdhkXoNgXWjcPoMjA==
X-Received: by 2002:a7b:cbc4:0:b0:3b4:fd67:d70d with SMTP id n4-20020a7bcbc4000000b003b4fd67d70dmr27546343wmi.98.1666200568163;
        Wed, 19 Oct 2022 10:29:28 -0700 (PDT)
Received: from elementary ([94.73.35.102])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm603453wmm.4.2022.10.19.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:29:27 -0700 (PDT)
Date:   Wed, 19 Oct 2022 19:29:19 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        javierm@redhat.com
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
Message-ID: <20221019172919.GA5336@elementary>
References: <20221019073239.3779180-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019073239.3779180-1-davidgow@google.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 03:32:40PM +0800, David Gow wrote:
> The xrgb2101010 format conversion test (unlike for other formats) does
> an endianness conversion on the results. However, it always converts
> TEST_BUF_SIZE 32-bit integers, which results in reading from (and
> writing to) more memory than in present in the result buffer. Instead,
> use the buffer size, divided by sizeof(u32).
> 
> The issue could be reproduced with KASAN:
> ./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests \
> 	--kconfig_add CONFIG_KASAN=y --kconfig_add CONFIG_KASAN_VMALLOC=y \
> 	--kconfig_add CONFIG_KASAN_KUNIT_TEST=y \
> 	drm_format_helper_test.*xrgb2101010
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: 453114319699 ("drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is a fix for the issue reported here:
> https://lore.kernel.org/dri-devel/CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com/
> 
> Note that it may conflict with the KUNIT_EXPECT_MEMEQ() series here:
> https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairacanal@riseup.net/
> 
> Cheers,
> -- David
> 
> ---
>  drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> index 8d86c250c2ec..2191e57f2297 100644
> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -438,7 +438,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
>  	iosys_map_set_vaddr(&src, xrgb8888);
>  
>  	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
> -	buf = le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
> +	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
>  	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
>  }

Thanks a lot for fixing this bug David, I just tested it and
worked as expected.

Do you think that we should update the other calls to
le32buf_to_cpu() to follow a similar approach?

Regardless of a possible follow up patch:
Reviewed-by: José Expósito <jose.exposito89@gmail.com>

Jose

>  
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 

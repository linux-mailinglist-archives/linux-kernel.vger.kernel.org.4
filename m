Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149AC6081BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUWes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJUWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:34:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183B40560
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:34:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v11so3179293wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8ZUYzkw582B8ag/E5+DphAy2SP/fG5AqdZthlsgOkg=;
        b=jL2Gd5xVvSPH4itprSkcbvjwhI91WFR+GbCQACpb470ber3HglJQozB5ag4RcVToGu
         wPnTIpEFEe2M7RFLs6dcNmbQQpyF9XykxWtxGmWevrX1p774CgpJDApx0b2s1BUGzcwT
         FMGFFa+SIoDoDQIyEUYncH8OuHcHF1tyXss1rA7xTP5u4c+1vM0j4i6plBx6wA49/6bQ
         5dg5J8y+B9E5MptlY39cKV/O1f6F0pubQws+MZi5qsgx8d92A3pWZvWoWOUJtMrxRswL
         5j01nhNqCCtSARU2m8zude96vB3ZXXwUoAnBE21Lie8GWe5tvKc5Ruw9nyQFzCMxjVVP
         R6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8ZUYzkw582B8ag/E5+DphAy2SP/fG5AqdZthlsgOkg=;
        b=dQ+ZQjDL4/uQs70whbp4yduR/7Ln2dVMFBn80PdACOo/ASUNeqxf1x5wbGoIDsx/4X
         RubqaXYyTidIvtokWwgl3MdqxI6zd2O5iu6j7Hy3QpnO05sGxR8EmVz+lfuw/rjJIkVG
         aqr+AXXZbRWDDtA5MR0P7wsrQIo9+FFPumEneDlCU6nSVrMlRYOov2G8eRH1pSEqMQFZ
         RzI4yKD/l4owJrpGpzNurKAvf3A1C3TsAS5YZoY2Ly9W2E9Ecs37eytgrKq0z6j1yOIK
         2UiktJwqHJWN4k+2keInkUAXaXuaXXJD+mehPSPw1nz7L09od/JAr4q4qjygxVN3JcYl
         oqZA==
X-Gm-Message-State: ACrzQf1w+pN1BhivU6MbRGDLI0WM6HW+s9Stip4rFZdHDOOO6djyAVvg
        k/jFUmkt4WHyaIdWsOKDnOwZ/YivQKdJv6A10Q6o9A==
X-Google-Smtp-Source: AMsMyM5aywUekN6Y8xJpyTwBo0Fi998NdSgln/qRnagoV2Uw0QOqYGKf3bo2WxCdC0TacuRFb/YyoJJLunXXYIoxI1Q=
X-Received: by 2002:a7b:c4cb:0:b0:3c6:f83e:cf79 with SMTP id
 g11-20020a7bc4cb000000b003c6f83ecf79mr14767201wmk.112.1666391678766; Fri, 21
 Oct 2022 15:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221017162448.257173-1-wei.w.wang@intel.com>
In-Reply-To: <20221017162448.257173-1-wei.w.wang@intel.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 21 Oct 2022 15:34:02 -0700
Message-ID: <CAHVum0fEVEtC-pLrKO3VJkPy0uqPa5WfeYQrTB=9Hk2Z8jV3fw@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: selftests: name the threads
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 17, 2022 at 9:25 AM Wei Wang <wei.w.wang@intel.com> wrote:
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index f1cb1627161f..c252c912f1ba 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2021,3 +2021,50 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
>                 break;
>         }
>  }
> +
> +/*
> + * Create a named thread
> + *
> + * Input Args:
> + *   attr - the attributes for the new thread
> + *   start_routine - the routine to run in the thread context
> + *   arg - the argument passed to start_routine
> + *   name - the name of the thread
> + *
> + * Output Args:
> + *   thread - the thread to be created
> + *
> + * Create a thread with user specified name.
> + */
> +void pthread_create_with_name(pthread_t *thread, const pthread_attr_t *attr,
> +                       void *(*start_routine)(void *), void *arg, char *name)
> +{
> +       int r;
> +
> +       r = pthread_create(thread, attr, start_routine, arg);
> +       TEST_ASSERT(!r, "thread(%s) creation failed, r = %d", name, r);
> +       pthread_setname_np(*thread, name);

Since pthread_setname_np() expects "name" to be 16 chars including \0,
maybe a strnlen(name, 16) check before it will be useful.

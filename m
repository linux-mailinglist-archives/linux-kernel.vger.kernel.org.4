Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966F8723C5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbjFFI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjFFI5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:57:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0FAEA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:57:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b04706c85fso54824095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686041839; x=1688633839;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsotnkYKJJ++RTq8ZDtbyGBYv6z9/iH+HO0zFVXW2NY=;
        b=BFPBPBMOf8PaUueNf8+J6cBztMB5syO78BMYAFc1m1fjSMKH/wMqWhHONypMA29RMO
         JtBnIWN7Jsasj7/GY5Y1TAs6jlKQSn1WsWS8qDZ4F6hadfLZ7NTHz4jLdmhSp4SP2ZhM
         b/cfC+/Eg5ingZrGS8jXDxJwMuFPZzJOGSlXawGgRVQnirUI/qdJagt2EoFxzMlip5OL
         r624yUamptZtkyS0pcyo3eGZxkmqCzcS3/aQ3TudnaI2i5o0tToip0hiexqVRgyGkr0Q
         ZCykcnep9ptsT5gra0Pz2sxmMrMjenSdFGVVwMA2uJkNg8TvGyi8dYKZgfpAsVNzA2/y
         qerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041839; x=1688633839;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KsotnkYKJJ++RTq8ZDtbyGBYv6z9/iH+HO0zFVXW2NY=;
        b=eocIiUycLMHedlv0sIxyaAmp85MX8VAWKl9mdtimTbTn3y9LpAI6HJPthxYiEyHgqN
         1MWWx2m5KIdeH2N+lRbMipG6zyzXNutz53zjFfyTN1y4bKNWHuYJa3Gmlf9OKvrAUNUV
         ryWWv2v7UWrJtjaSIWxJIPIJFhNDYv6gXGbeCcXmehEpy8MJWGpWmuTpuGZ98xjzINwi
         WpVhn9YKYOalBaWqtly5E8y6ClUH2MdrK71qtw9bR5wFlF3KuZ2cJsNdF5GLcTyo/Vt5
         dYjq021GfM59AQTQ8MkO5oqy7XeN5MW9ScnqYLS3jL4ZbHdEDYGHDqlwcrJo3Krc2F9P
         OgPw==
X-Gm-Message-State: AC+VfDxJWMRSfBxZeNf8hnROfRvYxg6A58iAI5gFFh1FXOq6TFiEbNtT
        7ywIXyIQPSNCcncZiwukMLkRcnbq65U=
X-Google-Smtp-Source: ACHHUZ4vx4ct4+UKChRJItU5T4VejzTrB4ZZ6XhJCp/+chr8riquVxvwcjpWSDzxg/yW8vU2i3C7QA==
X-Received: by 2002:a17:902:db0f:b0:1b0:4bc7:31ee with SMTP id m15-20020a170902db0f00b001b04bc731eemr1570388plx.32.1686041839240;
        Tue, 06 Jun 2023 01:57:19 -0700 (PDT)
Received: from localhost ([203.221.142.9])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001a6d4ea7301sm7924557plb.251.2023.06.06.01.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:57:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 18:57:03 +1000
Message-Id: <CT5FY0YBBTYX.X4UB9DSZQCMY@wheely>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/interrupt: Don't read MSR from
 interrupt_exit_kernel_prepare()
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.14.0
References: <df36c6205ab64326fb1b991993c82057e92ace2f.1685955214.git.christophe.leroy@csgroup.eu>
In-Reply-To: <df36c6205ab64326fb1b991993c82057e92ace2f.1685955214.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 5, 2023 at 6:55 PM AEST, Christophe Leroy wrote:
> A disassembly of interrupt_exit_kernel_prepare() shows a useless read
> of MSR register. This is shown by r9 being re-used immediately without
> doing anything with the value read.
>
>   c000e0e0:       60 00 00 00     nop
>   c000e0e4:       7d 3a c2 a6     mfmd_ap r9
>   c000e0e8:       7d 20 00 a6     mfmsr   r9
>   c000e0ec:       7c 51 13 a6     mtspr   81,r2
>   c000e0f0:       81 3f 00 84     lwz     r9,132(r31)
>   c000e0f4:       71 29 80 00     andi.   r9,r9,32768
>
> This is due to the use of local_irq_save(). The flags read by
> local_irq_save() are never used, use local_irq_disable() instead.

I did have a patch that warns if you do a local_irq_disable() when
irqs are disabled which is why I did this, but it is kind of silly.

You could do 'if (!irqs_disabled()) local_irq_disable()'

Unfortunately that adds another branch but if it is not taken
frequently then maybe avoiding the mtMSR/EID would make it a win?
If you don't change that I might end up doing it if I can get that
warning patch merged (needs a few core kernel changes).

I wonder how much that would help local_irq_save too, if interrupts
are already disabled then avoid the mt? Maybe those things are not
very costly on smaller in-order cores.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Fixes: 13799748b957 ("powerpc/64: use interrupt restart table to speed up=
 return from interrupt")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/interrupt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index e34c72285b4e..f3fc5fe919d9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -368,7 +368,6 @@ void preempt_schedule_irq(void);
> =20
>  notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs=
)
>  {
> -	unsigned long flags;
>  	unsigned long ret =3D 0;
>  	unsigned long kuap;
>  	bool stack_store =3D read_thread_flags() & _TIF_EMULATE_STACK_STORE;
> @@ -392,7 +391,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(s=
truct pt_regs *regs)
> =20
>  	kuap =3D kuap_get_and_assert_locked();
> =20
> -	local_irq_save(flags);
> +	local_irq_disable();
> =20
>  	if (!arch_irq_disabled_regs(regs)) {
>  		/* Returning to a kernel context with local irqs enabled. */
> --=20
> 2.40.1


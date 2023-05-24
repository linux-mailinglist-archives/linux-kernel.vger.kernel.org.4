Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F570F769
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjEXNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjEXNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:11:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB2E1AE
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:32 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9daef8681fso848915276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933891; x=1687525891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34o3DtpNIVdQeZC8bU8U/uc6p6qXV/32Q4BzT8svKd8=;
        b=Icsnqu6He3fGmq05OHwLcujobeOkfyG2G8nArOAkoITJ9U+sYoEYGHw+aalG2x5sOr
         xmVbmSoE4gJG4LQMKSgN5Qh4JH8WgAYwUI2fyRrgjF7YIrqyMcephGatFjooQL/1tEnU
         x6ounFs0nzgCSWNK3jGIWA5+SFdWFiuAvudqSD000ESEnlaEFe1RR2WyM2tK04Q1DZ16
         9VMRb1Z/EeEC5AZagf/LZhSbrPIsjlB0ox2A9E4ITgFZfscyob8PJFW90nijA9ZVVcqB
         gEfjjQdUPigV/jMYKAY9Hqr3Pg/8rsm0koZ5ltjuGngeIXXJGFla71o5mOGDodWu/V0f
         L42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933891; x=1687525891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34o3DtpNIVdQeZC8bU8U/uc6p6qXV/32Q4BzT8svKd8=;
        b=Ss5yYPQuMRzp4YVQX/Zlpip+j7yLXG3IhNiRTJle//jVhuHnHO9N/8yiWdG5NjGO4Z
         aDyzTp9Vya781Qg9oytYAPpxdlohKfVP3ebrGE5P03MSJxlrpQV52LbgoLEZ8kA2qGfH
         so10tNbu4BoEVi9ixTPDU8eB4RgbTswqTjS1YD882TPXN8bRfBLx+nAT7ZTjA783tpj2
         5UBlW7MhlYaYpzHE2wf+0fEvOeRoOwLR9j2v7eBElpUlFYO6MwwuN8aHuaej4Zmv1pk7
         tT6GDE3HZxdTGY1RbDkLR0bSuOLUPhOSov2VZiBAQOsXeuXrCwCWu3iebjfrVl2xA6ST
         WVfg==
X-Gm-Message-State: AC+VfDyfs6ALNDSALu9lmc6ct5CvmPgrsF8gljsK7RZAJXOr2SMaouva
        j9nnEhPthC2mV6Io+hTdtI5T8IkmXFzELiQhax0GPaKp/98HeQii
X-Google-Smtp-Source: ACHHUZ5bzgKh7DOR8WmbaQ2iomRob//GbkoT3mmQrwObvRTuAj0uRzwOKYxF68C9ARu6kyv/PRO2sblahtJQlbDA7fk=
X-Received: by 2002:a25:7313:0:b0:ba7:2531:28af with SMTP id
 o19-20020a257313000000b00ba7253128afmr18473418ybc.11.1684933891295; Wed, 24
 May 2023 06:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230516202714.560929-1-arnd@kernel.org>
In-Reply-To: <20230516202714.560929-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:55 +0200
Message-ID: <CAPDyKFp0=a+cuZRDLkh-4Z7R0=zrJ4C6h7LL++KKZ6TDBeKzCA@mail.gmail.com>
Subject: Re: [PATCH] memstick r592: make memstick_debug_get_tpc_name() static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zheng Wang <zyytlz.wz@163.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 22:27, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are no other files referencing this function, apparently
> it was left global to avoid an 'unused function' warning when
> the only caller is left out. With a 'W=1' build, it causes
> a 'missing prototype' warning though:
>
> drivers/memstick/host/r592.c:47:13: error: no previous prototype for 'memstick_debug_get_tpc_name' [-Werror=missing-prototypes]
>
> Annotate the function as 'static __maybe_unused' to avoid both
> problems.
>
> Fixes: 926341250102 ("memstick: add driver for Ricoh R5C592 card reader")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/r592.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
> index 42bfc46842b8..461f5ffd02bc 100644
> --- a/drivers/memstick/host/r592.c
> +++ b/drivers/memstick/host/r592.c
> @@ -44,12 +44,10 @@ static const char *tpc_names[] = {
>   * memstick_debug_get_tpc_name - debug helper that returns string for
>   * a TPC number
>   */
> -const char *memstick_debug_get_tpc_name(int tpc)
> +static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
>  {
>         return tpc_names[tpc-1];
>  }
> -EXPORT_SYMBOL(memstick_debug_get_tpc_name);
> -
>
>  /* Read a register*/
>  static inline u32 r592_read_reg(struct r592_device *dev, int address)
> --
> 2.39.2
>

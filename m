Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0824738D86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFURqR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjFURqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:46:15 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55641BC;
        Wed, 21 Jun 2023 10:46:13 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94ea38c90ccso180735166b.1;
        Wed, 21 Jun 2023 10:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369572; x=1689961572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DU0/sapO1YMhK1JPNASXgMnNdqT8+KgHL8xl7AnUtc=;
        b=jTpNM6ZL6Fanh7BZftik8aXcl871m+j8eIGvfulUC67Vm+I1np3gjYi/nNDiYsJrDI
         PZ1fOMfk2wnMKlbjrC7JVqwmo94K3lROtoVKj2z8FJiyIPHMYuB3n6g7CUET8VEE+fUp
         CBMKAUyXvc6YkkLkspSmZCnxBX4/CekaAofWMDtmjAnn6s66QTBLdvQgFm87KXuKOQn5
         mzpFS5mCqA1kaNJox9J12HgUP+BJxbqpARTpWXEG+BQ7sCiBeMIG/+zx2zZLHh5CNzha
         bbu3JtZezdCNOJqUp8NUwQABC8h3q6ZaNCGjMvN7y5sWwYcbZCQE2F9kDJ7P1fZgZ5xX
         ip3A==
X-Gm-Message-State: AC+VfDzjGKp7qNY08bnG/NI5CLDQVMZEgF7oUA4B/qKIImuJuMDX8b9w
        YS50SRjARQwcwtqu7AFqI2he7CxtxwO3//sRucfnGEd/
X-Google-Smtp-Source: ACHHUZ7CsZfd+CGV1Ou+TL6ngpL5WVqDOdkw9/sKagHoOTlxTOIa8ma7r2vWgYT+kR+ltLnMe6RpuaZQ6nYoUpXDDEQ=
X-Received: by 2002:a17:906:4e:b0:987:6960:36cb with SMTP id
 14-20020a170906004e00b00987696036cbmr10453604ejg.6.1687369572030; Wed, 21 Jun
 2023 10:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230620094519.15300-1-yuehaibing@huawei.com>
In-Reply-To: <20230620094519.15300-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 19:46:01 +0200
Message-ID: <CAJZ5v0gAsds--SYOU4EA0UPdq3TvYkHw84dKSoJx3O3MO0Me_Q@mail.gmail.com>
Subject: Re: [PATCH -next] x86/acpi: Remove unused extern declaration acpi_copy_wakeup_routine()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:45 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> This is now unused, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/sleep.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
> index 171a40c74db6..054c15a2f860 100644
> --- a/arch/x86/kernel/acpi/sleep.h
> +++ b/arch/x86/kernel/acpi/sleep.h
> @@ -12,7 +12,6 @@ extern int wakeup_pmode_return;
>
>  extern u8 wake_sleep_flags;
>
> -extern unsigned long acpi_copy_wakeup_routine(unsigned long);
>  extern void wakeup_long64(void);
>
>  extern void do_suspend_lowlevel(void);
> --
> 2.34.1
>

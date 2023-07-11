Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893E674ECF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGKLh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKLh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:37:26 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87812F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:37:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5701e8f2b79so67758507b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689075443; x=1691667443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL2vzMFuW0de7FjZ20tWgQE7hV0B39jdTQg9rjW7/2U=;
        b=dWBQTjEwnfO92CtRKvOWUA0WqWtqTdWFjViuDKPs/E7x2PuJe706BYun5KndDPz/lF
         DF1KVQu4gt7DRlvSKTWNzZ7qQUr7cc66VaLiTn1Isi67ZlRECZ56peEV8aD5KEBR96as
         YdeF9oGk2iVRVOUuqcBIRRlY2TpGcPPd7xQ9yHavO2tV3jU1EUFAmSNBuQdfl5poie9G
         ZrCA1/rnoeWFlFptwMYkOGw2JFw6OI7GFew6/zOG5xJ2bE6T5rkbDJ/a59R7JfBytRpR
         L84kRoIxPqeEcAJVZhRGKOmaW0CrLZMkX4TwZubdKt8yfrAPHze8KwxB8JgfeNIndzk5
         UK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075443; x=1691667443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL2vzMFuW0de7FjZ20tWgQE7hV0B39jdTQg9rjW7/2U=;
        b=DkrXIx8wzNypahp8W0+Weu4TE/EWrwVy9WR3nuiFZHneLxT2sAgxNyiLGEKXNsuxZD
         3x5PsgVez6DHzyjaaBr/cDLIO0/ByKX7Pdtc7090meke1u4SSO+hTA2dXLDSmqoo0d21
         wI91wUUWehj0PdZ0+sTGXTzJ9OsJjqqwrsMdYxvSILp/YwbeWXcpiR+ak38+WXeAI41d
         VCyS0yry+pAxmTbu3Pkq6m7VLMqNyveMxlse3m0CRYm3w08yM028e1t4HeieYgrGO5i0
         ALHDPzVSNoodzceBgd+U6nAIf4wT24dGhva5YvUzDeTbNego0VSomyRcD5WXLbMwCLEn
         H75A==
X-Gm-Message-State: ABy/qLatwzEcOdhsTSpsFMy8UvIBPC/ICxXXfIc0L+HqPLa+iPjl28WP
        0K+/P2+wpltLTp9HxiVDZzFIgLqRQhg6oIr97sWNaw==
X-Google-Smtp-Source: APBJJlEybCJvpTHFTO7z1IZUbhmlIXArEvmzZz8kIYf+SpxvP87eaGZn+vFC480iQwMfHJMtULU+JkjNjsAjFBNH94I=
X-Received: by 2002:a81:4ed4:0:b0:579:efbb:cbe3 with SMTP id
 c203-20020a814ed4000000b00579efbbcbe3mr13575531ywb.43.1689075442896; Tue, 11
 Jul 2023 04:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230710131902.1459180-1-apatel@ventanamicro.com> <20230711-remission-from-581829b1ff05@wendy>
In-Reply-To: <20230711-remission-from-581829b1ff05@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 11 Jul 2023 17:07:11 +0530
Message-ID: <CAK9=C2XG9fsvUxnL98gKstxdpdOOAV3UZ3DAV66=S4DJcutzKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Misc RISC-V timer driver improvements
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 4:51=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Jul 10, 2023 at 06:49:00PM +0530, Anup Patel wrote:
> > This series does two improvements to the RISC-V timer driver:
> > 1) Keep timer interrupt enable state in-sync with interrupt subsystem
> > 2) Increase rating of clock event device when Sstc is available
> >
> > These patches can also be found in the riscv_timer_imp_v1 branch at:
> > https://github.com/avpatel/linux.git
>
> Other than wondering why you opted for 450 (curiosity really), this
> stuff looks fine to me.

It is the same as the rating for clock_event_device used by ARM arch timer.
(Refer, __arch_timer_setup() in drivers/clocksource/arm_arch_timer.c)

>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.

Regards,
Anup

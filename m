Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03368C610
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBFSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBFSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:45:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7865B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:45:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hr39so7327144ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SqMveOvFHv1j0KM6AIu8F3PHdkpRYwMXc/KGhDV5SAY=;
        b=UPH60VYrHJaUvX4zQ/YP+L1spZWWr6QDJaXfRnf5ZDVVklnA1KghHUTIDQfu6JermA
         l4+X7okmD/wctp0OtYT67eH4GVh96FzL7JiaLIsKJnD/T70vYwddHtzx/hVrnDBaXAzP
         xqgLquVV1v4pT58UMubDwwW83jlbzXddJ+Hkj8OC9gRNx54vTn68JbhXiogPHgxCQ0AD
         AorNuF9JsXDHLa1xAfCaBYzu4SRZGPUxkd0YdWeKb8kbW61t/PQ4DW9vcUHGmf7bkVHL
         dfZGM30ADCzdVa+YiIwUoMCmRPJ9XA6+N9BJ6+17F8nlD9Owdll1UhAJVE6LCPSI4z0F
         4Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqMveOvFHv1j0KM6AIu8F3PHdkpRYwMXc/KGhDV5SAY=;
        b=c/hNc+9fCWIElkDdIN1w+hcIWSGqiMWadtsUdopdEZXzcxVXwAIQ2+LDCm39QXHlxW
         dNjiseglfTTfy+sFiwHY2Ru8C/AVwqjfp0zDeYnoi+Eoos6s8/1I3yNjzlDVhBdyJMmG
         ApSL1i9PwONoRb5W/gaQ1DMzYkwBmwwUEllH1PycDK6igTu9Sln3soDpGfCPI9JhVye4
         dHuaEDye4arfbZdK6EdQp+bnjs+OqyezwZN8zRvdKsn7mduawQVas7JnQq5gw2UqFIRm
         wk9e/HeW35IIkZ0tyPe9JVXL81tCDO4RWOdfi9yG2T+gWGSRHkePlEakkU0UEkiKZEbx
         sPgg==
X-Gm-Message-State: AO0yUKV04UpXkMAmQMqcct2Wm0cVJFzWV5t7jy1n82noW3w4klPcgQ0X
        afcZiQMZumUTLZyYofPzvrGca6yK9TwnLgN9doHJAg==
X-Google-Smtp-Source: AK7set+h/sPjQ9WR518QCVPWb1cm25ZSoVgbjHBVTDioQsGUzkz+IiHVcp0SUtEztPZKp/I13s9ONprycI1sM9KUlgg=
X-Received: by 2002:a17:906:f29a:b0:88a:f44e:4878 with SMTP id
 gu26-20020a170906f29a00b0088af44e4878mr102498ejb.199.1675709131227; Mon, 06
 Feb 2023 10:45:31 -0800 (PST)
MIME-Version: 1.0
References: <da1bfb8a-5a88-5697-1c39-8e15c3c208a6@efficios.com>
In-Reply-To: <da1bfb8a-5a88-5697-1c39-8e15c3c208a6@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 6 Feb 2023 10:45:20 -0800
Message-ID: <CAFTs51XWLT_XJ0QOo8N36WJgP=5edknz37pvmdw_1=LEc4Zonw@mail.gmail.com>
Subject: Re: Request for contributor approval: Relicensing rseq selftests to MIT
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Will Deacon <will@kernel.org>,
        Xingxing Su <suxingxing@loongson.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 10:35 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi,
>
> I would like to get contributor approval to relicense the rseq selftests
> within the Linux kernel and the librseq project to MIT. This will make
> it easier to use librseq from statically built applications, and I wish
> to continue sharing code between the kernel rseq selftests and librseq.

I have no issues with this. Let me know if you need anything more formal.

Thanks,
Peter

>
> Allowing use of rseq application headers from statically built
> applications was the intent from the beginning, but it turns out that
> having the rseq.c initialization code under LGPL2.1 makes it harder than
> it should be for users.
>
> The current contributor summary commit-wise under
> tools/testing/selftests/rseq is:
>
>     269  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>       6  Michael Ellerman <mpe@ellerman.id.au>
>       5  Shuah Khan <skhan@linuxfoundation.org>
>       3  Michael Jeanson <mjeanson@efficios.com>
>       3  Peter Oskolkov <posk@google.com>
>       2  Martin Schwidefsky <schwidefsky@de.ibm.com>
>       1  Masahiro Yamada <masahiroy@kernel.org>
>       1  Paul Burton <paulburton@kernel.org>
>       1  Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>       1  Vasily Gorbik <gor@linux.ibm.com>
>       1  Vincent Chen <vincent.chen@sifive.com>
>       1  Will Deacon <will@kernel.org>
>       1  Xingxing Su <suxingxing@loongson.cn>
>
> Header files are currently dual-licensed LGPL2.1/MIT, which is
> somewhat redundant with plain MIT.
>
> rseq.c was licensed under LGPL2.1. Relicencing it to MIT will facilitate
> its integration into statically built applications.
>
> In order to facilitate eventual code sharing between tests and the
> library implementation, I would like to relicense the tests from LGPL2.1
> to MIT as well.
>
> Many of the contributions are trivial, but I prefer to kindly ask for
> approval nevertheless.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

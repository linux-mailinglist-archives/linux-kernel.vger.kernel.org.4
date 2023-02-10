Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFC691E73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjBJLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjBJLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:38:09 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFB4A1D2;
        Fri, 10 Feb 2023 03:38:08 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15ff0a1f735so6297212fac.5;
        Fri, 10 Feb 2023 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQAje8o9vKu1sVJcWpM4QT60HNT24tOCm7UUbonsHnk=;
        b=qUYpbnpitSihuJEV3O/lbnxaQO00x5IeaDYHb8975dPCFnl7B8SygHfMoXEhAhaCC6
         LIiU1g2pGB2S6ETkCqQzmKfIlGr/9ZPtpRC/8jSeB6TFHAkv57f71RgsnFgyIXnEPcht
         PxXPoBTYHbeBcxVlamzu1WrC5hAVmf86NBZKv2Xz9G0/CGjJUyvjL6lB+Dwaa8AJv9uJ
         KcUKTH7dqwEn8Lq/whTvCv6ZUg1RNvBCnz4uLAq6tN4P+t+IXEXKc3uYI1mBRWMsZGPt
         FM7lV5dESm6t96vE2CmuxKrZQuHTPKGn5UkKVqaYWdZQz63sUyZWx7z10rE1dRqXZXDI
         wWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQAje8o9vKu1sVJcWpM4QT60HNT24tOCm7UUbonsHnk=;
        b=UDckWOp/+qRT5YFLBRGoruKQGQSin3lEiIKIEs2soQ8aWVmK9W8NWjMNyIbuHYkGuN
         AmbpFO7nJRBbjJffiWqYLpgd0dNlx3WGs9eJa2QD81Rk00zAH5RpyXuVPj6zgDQdo2IU
         Ty/P0zNCmvzn/oCitVrv/hLzkRd9ZVn7GQiK9akdvdSAadt42cXB4KwBKI2D78BO4LQv
         uKlKJQ1jVF7995NoJIeBtF3CBllPOMfPTBi+rXAeddzVlT4h/p53ZdEPgpqk0wK8oU0j
         exMQhOKTIxp/GyIfXc1tXSPHWYCtJdX0Rcy55bD3reaVjtmqybyIY6I+LhEK/8rXQ2sX
         zv+w==
X-Gm-Message-State: AO0yUKW9ECrQWhwKc1Pl0ACWaOf+qwyAc+ptZRpCGUqrpgNLyfhkWhy/
        qLwuU1jgnoXRE4JAZtbROg+fDBnq347wW8gGr5U=
X-Google-Smtp-Source: AK7set+yCZllVEn/omsFqEsC7Eu7/3DWeJiJvOgrjEdNoya54mxHSCR4nA1rr870dt00x3uzT/p1O09cMK4vs666ecM=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr1840803oaq.83.1676029088227; Fri, 10
 Feb 2023 03:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
 <20230210065621.598120-3-sergio.paracuellos@gmail.com> <23d2f23f-b063-c417-e85d-40f09b509d04@linaro.org>
 <CAMhs-H-rozEWNvRV0_CA1UeAZ9YJtg8PsHWjRnwBZp8ojqOcjQ@mail.gmail.com> <cd94db40-32c1-6541-c1a7-bf937802e464@linaro.org>
In-Reply-To: <cd94db40-32c1-6541-c1a7-bf937802e464@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 12:37:57 +0100
Message-ID: <CAMhs-H9NBF1jUBzrcX_D-3fP0O+dorR_T+_G_r6i5t9Tp0gUrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:31 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 12:29, Sergio Paracuellos wrote:
> > Hi Krzysztof,
> >
> > On Fri, Feb 10, 2023 at 12:00 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 10/02/2023 07:56, Sergio Paracuellos wrote:
> >>> To allow to access system controller registers from watchdog driver code
> >>> add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
> >>
> >> ??? This does not make sense.
> >
> > What do you mean? The commit message itself? I need the phandle to
> > 'sysc' system controller node for accessing reset status registers
> > inside the watchdog driver code.
>
> The message makes sense. The message for the code does not make anymore.
> I meant, you want to access system controller registers from watchdog,
> so you add syscon to watchdog...

I got your point now, thanks. Will remove the syscon compatible from
the watchdog node.

>
> Best regards,
> Krzysztof
>
Best regards,
   Sergio Paracuellos

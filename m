Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653BC6A81F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCBMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:16:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3B37543;
        Thu,  2 Mar 2023 04:16:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x3so3778921edb.10;
        Thu, 02 Mar 2023 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRBEvtz/Fs97O4w3m3A4KNDoiiiODew3AdWhX4DhLB8=;
        b=mdapGdy92caZiIqYy37DOAImqlnnY0Z1PeHDLLjDl2/4wEZVb1JejyovgaJO9NTsx1
         jbi6PUFm6hmWJqtV8paXNKbv2igGppsQ5ZzMGdanAzYKRxYA1TLNvDfLohIqPwVeVRHS
         NnAM33wEE9DYN1yjQEOUyDNcLSoFa1w6DNrgwd3oWrUvzf56QYONM3T+fmvVy/X9Yvu6
         4f7E/Oi/o+pguOHGWnjGf+KtWkrdjLclp1oGuAvySAL9fBDWgYIrmlEwx5rW0X/zjY9+
         LkZNevW+L9gm3mpL1FT/+ij0NVcYW+MxMz2TUrpu3SyWIWa1vx9NaUlWSg5gP+ofG5u9
         BFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRBEvtz/Fs97O4w3m3A4KNDoiiiODew3AdWhX4DhLB8=;
        b=nJhIT8Y9mxmOlfFbhy9qscUFvHabJrOBXewTJUapnEkVSg9sILwDjMpW4pllvaS5NX
         o5t/ROE3fwG/b7n55/7LBkAivCom11NNDRdRMeGiMFMVQKZXx944YDp5QOuEpyd48cgd
         jch7tw8iW9CBVJFVkNUDipwtsU6b96FeWUfAMcUqF7araOWyJdtanJ2gp+MuUXe/a2Q4
         IMOZOMh4WwLKmwmtAWioz4CiZAiJJKkt0WBNO7FI7gqAl7EA0Zxw88Q/gDKe4jg3tfvv
         E5ujO5ynOE4FI1qhxolqZdVx/YwsyW9HT4B9LvLNcNea488UuidXWbs4yFISsha726wU
         MAfw==
X-Gm-Message-State: AO0yUKVM+Dru3At2W7A2WarVP2t1YMJI0re1/yTafFTNJlmcW/KCJD0v
        plBVHcysUx9mIDFrS3OaI4/e0GaIRMdEgllwdSV7Jerm0OAiCA==
X-Google-Smtp-Source: AK7set/nKxB7PMsPcx5oHQXtAWuEf4Fv4PtTKc6QoipWQUKbrrqQgtEK0vWWLQwpsPso9LKDd8cCptYBwHWYUyAZLKQ=
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr4858196eji.0.1677759381736; Thu, 02 Mar
 2023 04:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-2-keguang.zhang@gmail.com> <Y/YH20aKp+u+QEwA@surfacebook>
 <CAJhJPsVqPAC_GP0JE98nrpmvDTwXdt4m0z3SZQPX3GFCijT09w@mail.gmail.com> <5cc00c00-7dd3-4b7f-71e6-397f76acaed0@linaro.org>
In-Reply-To: <5cc00c00-7dd3-4b7f-71e6-397f76acaed0@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 2 Mar 2023 20:16:05 +0800
Message-ID: <CAJhJPsXFU5DqU1HUw402EKtU3Y7WJNP3UBE3_CQuCdAqg81UQQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: loongson1: Update copyright
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 7:40=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/03/2023 12:09, Kelvin Cheung wrote:
> > On Wed, Feb 22, 2023 at 8:18=E2=80=AFPM <andy.shevchenko@gmail.com> wro=
te:
> >>
> >> Wed, Feb 22, 2023 at 07:12:10PM +0800, Keguang Zhang kirjoitti:
> >>> This patch updates copyright and author information.
> >>
> >> ...
> >>
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>
> >> Have you talked to your lawers? This is an inequivalent to what was wr=
itten
> >> below.
> >>
> > Yes.
>
> Yes to what? You now change the license... and commit msg does not
> explain it and does not justifies it. What is even weirder that your
> lawyers agreed on GPLv3! With GPLv3 you need to open a lot from your
> products... Not mentioning that they agreed on future GPLv4 and GPLv5,
> that's even weirder because GPLv4 might be saying you need to buy me
> flowers...
>
If so, I choose to leave the license as is.
Is "GPL-2.0-only" right?

> Best regards,
> Krzysztof
>


--=20
Best regards,

Kelvin Cheung

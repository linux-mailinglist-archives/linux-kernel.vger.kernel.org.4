Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA76F1EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjD1TQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjD1TP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:15:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82126A6;
        Fri, 28 Apr 2023 12:15:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9d87dffadfso58930276.3;
        Fri, 28 Apr 2023 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682709355; x=1685301355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tat8phzj3dH3eTznCo+ElpRNyVEo+jl2/PvFuCvuY5E=;
        b=smC3hGwPmnBKSDbiWk5UMKclZegGbmzc6a6zT3GvwMIPNa5IuHdxfl1TPjBtLKFwfo
         yVpHsu8re+QnHIPj3air+5KJfZa6dYZY0OKkmOnBV9CdWHrK/ZINRInfoZIILQ3yMJOm
         CzMjimvdsK0eCKbqLyzI9b/AU6dQUrKDpsAKFGylx5QTwaIobaV7s9khdFFRGT+Lmipz
         Y/iQ6AWB7Ae1eTHoAGIhJ6zqqet+aGo8mvTz1OKWPUCP/Yg++1H+RYy4xzgo/jQzhsmP
         lfRMQnEeojsXuwHI4LbtNkxuDveGElOnY2xSCSmFtLStXtZWR3XaGCrZqkDABUJ7f2Q2
         KRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682709355; x=1685301355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tat8phzj3dH3eTznCo+ElpRNyVEo+jl2/PvFuCvuY5E=;
        b=F1ULzBP7tHk3E2UdCDd6gCa3MrfmNA5/OM04MDm83U33n+YdRh2lUNGQIzqkFSlYMM
         s8QwoQWIS2n3WBiz3LPafPJt/+8xmDCJMkwkBdpjF6UHpRmcZGLuOYqTKFOhvEDQAszT
         KjnZY844wuN/SyV6xFAMvtk8pAupysYSYjU+lpsn6JZI82hoAC/+C5i3qBy/32fxGkuj
         Jt/mtS5PN8/Hg8NzHtKbI006TZSMTWrjEbAaA4sJZsOEL9p+EK8HWJG9TJtxEMJgwkif
         3OORvQggN2+qbVNk6FhsMPNyn1cR8cq6BV5DPPVLR54euzNM91my9pbsBi2ou5uPzhJr
         sfJw==
X-Gm-Message-State: AC+VfDxaF12OoQB48ZHfKhEYd5JAILoyoB+FNM9fICUwX6vfLb8xMsOd
        oeT4uQO+0sVXWk+SEs8npmeNQh6R9tjY+clbbPo=
X-Google-Smtp-Source: ACHHUZ6UFKCoOr8/ayyLcJW3Syhh0NLJYpMAf/HjNXa6xKbxKEUmPKPEeL8k97o8DdMBQS/VvcunTl8y4N/LMhkrwGw=
X-Received: by 2002:a81:87c4:0:b0:54f:9cd0:990 with SMTP id
 x187-20020a8187c4000000b0054f9cd00990mr4552114ywf.18.1682709355642; Fri, 28
 Apr 2023 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230426184420.99945-1-samsagax@gmail.com> <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
 <CABgtM3i+HZJDearvBK-sBrWnfqdrsuNCDYfxASC3QVsn8rAy-Q@mail.gmail.com> <dfcd56d1-102d-ace6-c8b3-8f668e5f6872@roeck-us.net>
In-Reply-To: <dfcd56d1-102d-ace6-c8b3-8f668e5f6872@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Fri, 28 Apr 2023 16:15:44 -0300
Message-ID: <CABgtM3gydDb7gv-GQvu6mMku0KLAM+DSXqd4+FQDsk9jcXV3YA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't know why but the compiler would complain with the casting from
> > enum to void*.
>
> Really ? I tried with both 32 bit and 64 bit targets, and the above worke=
d
> just fine (with W=3D1). I tried with gcc 10.3 as well as 11.3. What is
> your compiler version, what exactly is the warning/error message you
> observed, and how exactly did your code look like ?

Said something about an invalid cast of an lvalue? I can=C2=B4t remember ex=
actly
and couldn't reproduce it again. Will change all to your form after
this patch gets
merged if you like, just to keep things atomic.

>
> > Found out that explicitly casting the enum literal before casting it
> > to void* works and
> > the compiler stopped complaining so I went with it.
> >
>
> You are not casting the enum literal, but a pointer to it.

Yes. I'm taking an enum literal and taking its pointer to cast it to a void=
*.
A little cumbersome, but maybe it can be avoided by using your proposed
form directly and after making sure it works.

--=20
Joaqu=C3=ADn I. Aramend=C3=ADa

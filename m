Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A36BAC18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCOJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjCOJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:25:00 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FA392A6;
        Wed, 15 Mar 2023 02:24:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id nf5so15572331qvb.5;
        Wed, 15 Mar 2023 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYZgwdHO+/SbdDLd0OXImI5iI8LCf9yFfQe54aGxAXA=;
        b=dASJgTEE7TfZx9jtA4E2/WXwxaorqUE7gvVQ1dqjKRlo/HyoQrcz89FaZkefbv0Z4+
         fmzOg1/9EfiTpeOqYyPlnccJKQ6xsX7chRc7mzrWuJ74uT0c0CpiE5cRpfFsrU6X3TFf
         T+UbUtwKzT8UN2sFocPrYYjhcLkySlbUbvNzd2Z8kxEw1QwFjpv+mX7olhlykkBdrwzY
         t/SdT9QBhx+RtrcqCtSAJgDlytgFtor7khM1cEf/Ok5+i4Vd6t5YNm3Ah0/Uj6ODEtuq
         dUwaSGNflmLBguP9BZ99UKuP0tMQ2W8am//A3wZV3iIMi19qcDz7yo0SQrleUVv93IPd
         mN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYZgwdHO+/SbdDLd0OXImI5iI8LCf9yFfQe54aGxAXA=;
        b=zzu6ElYRQ8MbPoaO6OtFD32GkmpDDkPfLkS9Bo3QI8tNrhbdDOli3mmU2wQgNNzFY0
         wm04b2dlozTCUkemzk8NfXT+o6JQTyI1GEfklBVqoBHvT/MnSHnzNiMquhV12Xnl791q
         C66Rc7NxFeH6O80AynIfC3jjaSQgbKhMq7kXwIRQOE32xY5TK8MdivKr8ym8jCCXABck
         KZXIoqJXBeBQp0f2Ulam2CjZnE+B3cCgnvv7bhTQ7kf6z6jL6g2ximr7rnV5eUcs0obQ
         9n2lsW2W/+wfbSjHE7vsG1/d6WAnU4mKK2XanDyYkuhd/jIXxt/fPmOcYGwVPbXITuzE
         QwUA==
X-Gm-Message-State: AO0yUKUIIktmOqSXZcsoU4V8F2JxZwFURCdl8/AMI6Bk8vnKiUWdIJhE
        KVbRPDqKdF3egrtfWYcotOSMvq2UkRFO7Rk0bQk=
X-Google-Smtp-Source: AK7set/hjozEKteUZvHncAdP6ZBYdBVqW6t97XT4JWUe4WUAPfmUnW74rWaU7XApW4Kg9n4bmdD8sQrTp2iGILeHjvA=
X-Received: by 2002:a05:6214:164b:b0:5ac:b3fa:e6bd with SMTP id
 f11-20020a056214164b00b005acb3fae6bdmr1373460qvw.2.1678872288559; Wed, 15 Mar
 2023 02:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230314221609.22433-1-asmaa@nvidia.com> <20230314221609.22433-2-asmaa@nvidia.com>
 <CAHp75Vd5NhPcgUokJ0i8ftqVXjSB10q4VfxH9A7wcYhei-s2wA@mail.gmail.com>
In-Reply-To: <CAHp75Vd5NhPcgUokJ0i8ftqVXjSB10q4VfxH9A7wcYhei-s2wA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Mar 2023 11:24:12 +0200
Message-ID: <CAHp75Vc1YFeMw1pC+j4fTVAPWroQjdrcmC0qrS0XNhDM9PS6EQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Wed, Mar 15, 2023 at 11:15=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 15, 2023 at 12:16=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> =
wrote:

...

> Btw, have you considered renaming that driver to pinctrl-mlxbf3?

And Subject here should be "gpio: mlxbf3: ...".

--=20
With Best Regards,
Andy Shevchenko

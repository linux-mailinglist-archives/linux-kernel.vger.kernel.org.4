Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FB5EDB75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiI1LNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI1LNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:13:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C89E122;
        Wed, 28 Sep 2022 04:11:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ml1so7929335qvb.1;
        Wed, 28 Sep 2022 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=XCsdtUh+KTdYrWYc2FDmaBtPhvceL295X+CDsOUV9JE=;
        b=kj/BwetymrWmhrtVtc2xY46zFVtm4+sS7duURUT8bQk7uSizQxkgRrceb5GKwfzq6y
         XS0tLiPmrgt19xrxsJ0DtKS0gHJMsfOlJLcVhTJ+jfTgjRgdwGNFfjUiOB+D6vGxBmyT
         CMvYC99dSbct2tZ0utTWquuWwmOCQl8jsT5/A02svWJK1vvVSJogxulzRR+XWv3IowqN
         VeZfG1/q120MiU+mxAiC+UsjULy7mGkeBM7eFnPAAdGkpC+7kCjB2pbRW+5SlNt26lbu
         9xg4EHkM/rIhzb/qiO6GQYS18A6klUkQ8+gXAh4n6TxM6pR+4+C5rgDovsYGNdlHHfla
         4bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XCsdtUh+KTdYrWYc2FDmaBtPhvceL295X+CDsOUV9JE=;
        b=fHITlvlctzAlTKA/xiL0EXFEKOKbIJl4pF/DVCLUesWZJpIM1DjzJ5OQtO0cu8ARBq
         FvRvbuX/Kir0B863KZiDhM3b5BvEeY+EKxOem7zxYw18HnJPIi4hX+B16ln13iK9gol2
         dE6h5e6GpXW7uNdS/NAi8BHQ0+ogK9ZQXZ6qedEUinLkyGwh3gzKZ/mPbl3LHJp7ZMB2
         fH6TvwTVCmtIX9QiGGOaUhit48kw5ifJsOjA3i2p1n7xK8yskNj3fSwa76PBpfxwAVXZ
         tmrs4ksXPYIrr22WAeiDSfBJ07W282HTr75zW4kgaNAsNtdLNaW2UZB6/uqlvUFECgGo
         ffJg==
X-Gm-Message-State: ACrzQf1nRtfL+uDI14QVY1LGlEWPbfFtUr1QZ13kLXJLP15gQ/t2mco8
        j8RIr+eT9jpbW6vw6VkYgCsBdVQoq3DjjmADdYg=
X-Google-Smtp-Source: AMsMyM4UTmAPZq20Ki7odKGLt+eQoYDiZf8dj1CjbGHa1N9cWFz1YLxIRFn0Cxb4CwFShbPBhBbu3trbP5GVvmZ5OIQ=
X-Received: by 2002:ad4:5966:0:b0:4ad:7832:a8ec with SMTP id
 eq6-20020ad45966000000b004ad7832a8ecmr25535024qvb.82.1664363480327; Wed, 28
 Sep 2022 04:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com> <20220928110509.13544-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220928110509.13544-4-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Sep 2022 14:10:44 +0300
Message-ID: <CAHp75Vd6OJ68BbaYt21hPpOpDbvT9pow6PSDhedGULjikGhoNg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Documentation: rs485: Mention uart_get_rs485_mode()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 2:05 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Add to rs485 documentation that serial core prepares the struct
> serial_rs485 when uart_get_rs485_mode() is called. Remove the wrong
> claim that driver must fill it by itself.

the driver

...

>     The device tree can also provide RS485 boot time parameters
> -   [#DT-bindings]_. The driver is in charge of filling this data structu=
re
> -   from the values given by the device tree.
> +   [#DT-bindings]_. The serial core fills the struct serial_rs485 from t=
he
> +   values given by the device tree when driver calls uart_get_rs485_mode=
().

the driver

Feels like this should be before the previous patch and actually have
a Fixes tag.

--=20
With Best Regards,
Andy Shevchenko

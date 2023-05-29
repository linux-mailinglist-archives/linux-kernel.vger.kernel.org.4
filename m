Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBD714C11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjE2O2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjE2O2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:28:47 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C9CA0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:28:46 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-43ad7bf4db9so421894137.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685370526; x=1687962526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IH0joYFPXL5/9kMgt+velO7TyX2N05LQsunJW9b5ICc=;
        b=GD5OFb5mFVQZgyO5rmgpZjUamSzPtXtSktW6QtEahL4YYwY3IkLBB46WCxY6BY4/N0
         ShHko8bvNP7v8TJr8m0G3hMKDRMTEawOgLq/tNYIPEafgQJzDn6d3hD0cm7yZM/JE6VR
         egMzO1OHVsC5KXGS7IpdvBfteQohhBFdz3lXOsjnz3f7Y9/sEVg4zbnQ3+uLuHdMRfKz
         jTrnnYYtK29tLiqgZr6ZNuP8s8xC9ds+0bZ06db7NsSmdMz6G4tpCzF/dxbdhsvoTFFD
         f4goOgMPCZEF7QaUR/NfH3MA8ZqXVBnd1z1Ijt5CnPi7utfXqe3dA+ehxBipS15NaMaF
         6J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370526; x=1687962526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH0joYFPXL5/9kMgt+velO7TyX2N05LQsunJW9b5ICc=;
        b=BjUzAJDN0hLIB6vdK8i/LULeJlC5muTB5IbkmhTqmQntg/RabGgqEZ1Lj+fhPChb2l
         7bOyZ5jwJ5NTv6OnZvO4pf+DfuZzAFURS7I2r06a2MGzeynw7S8fCRw7ibmtsJrPi1h7
         ixUfqcgbVJS0jUlRe+YIQ1kgYRAIZ2iUa+Uy3oGLzJOSWrUlX/JtHHYFJAVn+fy8oPdD
         DsyTK6p48X6fczEzLbrL3wkmr8UAjWSoQl2gyBFTfKXQxvgX/2/L962SbvRmtU/o/TqL
         cZ0qHXnAiHHF5imD90XXtITohUy6E8+wCwcbSnIUpKe7zNigrzi7V6EbG0/LAUrvn5fm
         dWdQ==
X-Gm-Message-State: AC+VfDxW67JhCGce4pcgHGGK1mgs9gNsn+7JEwlMXf3PlAetSq6LzHCx
        3abgraoHZyH4UOmzC0Fnmg8lZuw2jxwUlP+3uHl9Vg==
X-Google-Smtp-Source: ACHHUZ4/eO1+b8BlT75SiNnKDjV3FV+AUH3nwF/ufRa2ua69CONPA+Bmz3d6zoI1Ddh+pG188A0MHv6oob3vsTkkQzw=
X-Received: by 2002:a67:fbd9:0:b0:434:50e9:164d with SMTP id
 o25-20020a67fbd9000000b0043450e9164dmr3008176vsr.17.1685370525735; Mon, 29
 May 2023 07:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190833.565872088@linuxfoundation.org> <e98d3b88-980b-4487-baf8-4685cfe62209@roeck-us.net>
 <468bc707-0814-4d83-9087-74768d98203a@roeck-us.net>
In-Reply-To: <468bc707-0814-4d83-9087-74768d98203a@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 29 May 2023 19:58:34 +0530
Message-ID: <CA+G9fYspKgo+qF5Onq_HDz1-w6NscULrFUSw=YKp+1e=4NkBBQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/132] 4.19.284-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Mon, 29 May 2023 at 19:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, May 29, 2023 at 06:48:10AM -0700, Guenter Roeck wrote:
> > On Sun, May 28, 2023 at 08:08:59PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.19.284 release.
> > > There are 132 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> > > Anything received after that time might be too late.
> > >
> >
> > Building s390:defconfig ... failed
> > Building s390:allnoconfig ... failed
> > Building s390:tinyconfig ... failed

We do noticed these set of build failures,

Seems like the following commit might have caused this
build break

 drivers: provide devm_platform_ioremap_resource()
  [ Upstream commit 7945f929f1a77a1c8887a97ca07f87626858ff42 ]


> >
> > --------------
> > Error log:
> > s390-linux-ld: drivers/base/platform.o: in function `devm_platform_ioremap_resource':
> > drivers/base/platform.c:97: undefined reference to `devm_ioremap_resource'
> > make[1]: *** [Makefile:1061: vmlinux] Error 1
> > make: *** [Makefile:153: sub-make] Error 2
>
> This also affects um:defconfig.
>
> Guenter

- Naresh

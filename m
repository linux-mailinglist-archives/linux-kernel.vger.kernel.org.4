Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68376FCE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjEITaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEITan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:30:43 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3F4486
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:30:42 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-77d0160ed4cso1650153241.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683660642; x=1686252642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDoEr8WUcosWAB75TDES0XOSAOF70d3PYdw53BsU/vk=;
        b=ZsEvVKJUooBL3kBWnwS/yGvHSKL06QhfHH8U9mp8k1NQa6oiAay5POTOjtD2MEkkVs
         CnY0SjzBIiU/I4j4tZ3I0LBw6QO1tMsqnHUOAcyZ4UpLVVocmb7dNXei4KLphxWOZfyN
         0/+wPgLft0o3PZ6+7cNysdw4C1gsZe+uOtpauquOYh8F3ZOkJ5pynm6mmpahCAi5Flx8
         AUFhcDQVyFpT2keS7OPJmXQT1OMFd9KjWj8c3gxRRx5vf44Yu8/a+uQ70AL106SKBDF7
         2b2yluloOXQtUrtfdj/c9MFYTmaD/jfG+r749/E/ik5Ic5bWMCpGxX1znI02jwSPTz/g
         RXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660642; x=1686252642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDoEr8WUcosWAB75TDES0XOSAOF70d3PYdw53BsU/vk=;
        b=IbP5YTg+VHIreRD9WHQdXVHQmebhQRj9HA/LAPfMxi+cua/nP80Zm9xjiiGLI0IP7Z
         54Qu9mv+LagDVr5rLc/OKEONm3J14vwHjfbG9f84pb5tIRZvru1NDaGIEMZFaBsU8mY2
         aOKcZ68Hn57cZ4YjSrRD325JbcNqWxMP2OncW/oC6RtVbq+saBeMZYhf8QPNJgSXq24a
         8+3semeldNG6TaJ445x2vu+aqIK+0fzuwze8+MOnt8Zay0U+KioydgpPmyxzMPYk3ZUG
         EMG4r746gAZYApuqcHM3B55TDQYcF98MQLLo+/0Mt4Tn999RnpVPhiYan+/R6cvJEDR1
         g5yQ==
X-Gm-Message-State: AC+VfDw32s8EvgIXfB7RfEfQQ+lEAeQ8Zzy9NC3LDleK8MZXE6PDIXgw
        eBkUNCESkNsxa6LVd5x5F7LGy4oJNi4L3sko5vQbfw==
X-Google-Smtp-Source: ACHHUZ5fYrN1bZ1MeR0WEVPl0NR6Kbq8GyLkmS3HqomWcgnKMgebrUFYqSL+BI/lDoWX3+QFhnJCEqwg1ULmh/7Lxls=
X-Received: by 2002:a67:fd98:0:b0:430:e0:ac2e with SMTP id k24-20020a67fd98000000b0043000e0ac2emr4792589vsq.15.1683660641705;
 Tue, 09 May 2023 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030705.399628514@linuxfoundation.org> <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c> <2023050913-spearhead-angrily-fc58@gregkh> <20230509145806.GA8@df3c0d7ae0b0>
In-Reply-To: <20230509145806.GA8@df3c0d7ae0b0>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 May 2023 01:00:30 +0530
Message-ID: <CA+G9fYuCLSuPchYoSfqnu6y+CUV+Km3TVFr1NhGj0dik-ScEdQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 20:28, Rudi Heitbaum <rudi@heitbaum.com> wrote:
>
> On Tue, May 09, 2023 at 03:56:42PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> > > On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > > > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.3.2 release.
> > > > > There are 694 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > > Anything received after that time might be too late.
> > > >
> > > > Hi Greg,
> > > >
> > > > 6.3.2-rc2 tested.
> > >
> > > Hi Greg,
> > >
> > > Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors
> > > with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.
> >
> > Can you reproduce this without the extern, gpl-violation module loaded?

Please share the steps to reproduce
 test case / Kconfigs / device under test environment / firmware / boot loaders.

- Naresh

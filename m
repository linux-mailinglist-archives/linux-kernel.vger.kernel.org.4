Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF74B742FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjF2V40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF2V4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:56:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454730D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:56:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so1338105a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1688075780; x=1690667780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOf/JougOyhsOkb+dRe1n/eQScesKh9WdkdB5A99fRk=;
        b=dps2aQjRsOXr/g4E2iSUfNcqKD1mHXWZ6ONP5IMR3oSFjwhakhw7A5juUsLZTP8pck
         bALZOCQImGAvmlg8eN0TfsDBRHjwvinGpEx7eeHFaLbrl27tv9F6CmkODLcuvnii8653
         W0zQpdZb92H72YEaiGbUS0VOlDPLagz6/8pjl9+Sq5vgnJuCWiiP8RL8MNdiCEiaakDB
         tcmUtdurnJZ5q/nOLdw5hkBJnFjBiBcP1CkkQbZhDxoY8UUHxqzVXKOuxnaRPwYk5q5m
         hHpkEHEjHbnYPiVFFcpIQIH9XZ/uYxotgwEEcimdkmPhMxg2TfWrSwLoipB29MP97s7E
         pQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688075780; x=1690667780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOf/JougOyhsOkb+dRe1n/eQScesKh9WdkdB5A99fRk=;
        b=ZY+bXkUpijM40AblFQbbOWb9qOVtlIHL0rCmhjXiZOVa3OOmyRvLV/LU8eoiaYBgLU
         teK9KNUfPEth6XislYTI83tO2muhTRgFWtfNsDzDJDZgCrfuovEYqJqN0JH3AP4EK4+L
         b6H5sMv6vScZBrJtuM/xxSORIGkzjg4L1bXlpylxvdveuLWDmffLjCf5scSpJcK6a6rW
         E0DccDPSXITWqNix0PyVzIW0SLcMYwrCTrmJ5oqDqry6oi8qtyBEm0vs94KJhpy3AFKM
         4qajlJ+E3fBORcQpJLAqHeJAS1pCsQ4zrFK7kgdbAF7gmnORNUa0CUwGeRYhfulFi9MP
         ZvLg==
X-Gm-Message-State: ABy/qLaDo1KH0dkYIFGijwzXuxWSh12zOBti5bLVVe9mI4y6Pjy+f3Jr
        XrkFRRcptkGJ2e2GdPjGUg0iDn6Uk9NReXTyczKi7w==
X-Google-Smtp-Source: APBJJlFNR0w1BjJGgwrHeJAqiblVmG1i91+46JqLPZi03yOqFYxDfY+UqfovKXnkj4grIoEqvKwIxkiezjLHq/RQy6A=
X-Received: by 2002:aa7:c152:0:b0:51d:e4a3:3c8a with SMTP id
 r18-20020aa7c152000000b0051de4a33c8amr321502edp.3.1688075780431; Thu, 29 Jun
 2023 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.651069086@linuxfoundation.org>
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 30 Jun 2023 06:56:09 +0900
Message-ID: <CAKL4bV4hMiGuZ9c2MmbToy=pbMFmL6fHji4zOh4h0G2m0FGMUA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/30] 6.1.37-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Fri, Jun 30, 2023 at 3:46=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.37 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Jul 2023 18:41:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.37-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

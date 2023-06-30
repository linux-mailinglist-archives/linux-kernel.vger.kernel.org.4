Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6E2743969
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3Kdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjF3Kdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:33:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F92730C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6985de215so27828491fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1688121223; x=1690713223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMvg4+xf/FpT2l2ger0oTsMzr40HAUi9gV+dNJ+SQAU=;
        b=ptIyYvAGr7z2ddcaHcOP+a5GUrlPfF7+kvw9taw+/uSBqODpirNaXfrjvvaah2YJO4
         1I+MABWWd1CMrpSEEL8XCWF+dfhQzuerODUen0VCYKl61KpU4edsHLHSNb/e/8KWVpku
         iNLrIGxlbqQy2MJ2uLDoqkplGXbaoeRbvFubhmM+C1vjdZzT36cvY2cLUfGGOAlthxMy
         Kh158t2XgN9f6kdlcWlCDAev77ibQ4onJGwHEAzLSGieQ3K/ZWUP8R3qYUdsxz2QhyET
         f4xJYykbgbt91ep0t8+htl6DigRVG61IO8UFbqxQubKQCzQxU/VD0s+nXv4n4DdCNVjA
         ythA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121223; x=1690713223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMvg4+xf/FpT2l2ger0oTsMzr40HAUi9gV+dNJ+SQAU=;
        b=Ca7IRmC3jQ2WSkMito20WwYEPkCiYPxD0/YHUdOEazA4cdefjfK3E5/py/FOJcQ8jT
         E2IfdlnmX87lxW0ktQ7GJzXDPq6Gn9uxZZ4RC2q933MlKu/sdgWjADypFUhB1hFKYDxD
         FpHecIvxJ9LrzmJNrTtJtJr9EeI+dZdHtSvnzLr3EbVpRX5UOHVdQvA+VALIueVmeIks
         sDWMOhFfRncflB9NzmcuIKCKHkVRF/r3JFV9w1iNw5DrOUvq0gBJWnAUGoC7ZJPTfpS1
         vpuZ8raaWJag5g8htGLSBzx0Nt5LXkQf8WB+JeT53SISeBQH0dptrDAWhSP/43PKTm1P
         qeug==
X-Gm-Message-State: ABy/qLbbDrDd4R3TBUOSEKtW8eLBSQoTVDtno1M+aymgtVdZudRM1H1O
        CFyWZJVkjMIWhw1RpJ7RKVfxJW2RMhlTA3fKz/CmWQ==
X-Google-Smtp-Source: APBJJlG2u/xyzuJ84ph37p/iQTjUyhcv/0ujEisW8iOXdWjzS2aHJnQdoa55ieUt9lpi45BGDEBdxvotYQGcYJ/euZE=
X-Received: by 2002:a2e:9b0b:0:b0:2b6:a5bd:da2d with SMTP id
 u11-20020a2e9b0b000000b002b6a5bdda2dmr1739785lji.27.1688121222628; Fri, 30
 Jun 2023 03:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230630072124.944461414@linuxfoundation.org>
In-Reply-To: <20230630072124.944461414@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 30 Jun 2023 19:33:31 +0900
Message-ID: <CAKL4bV5Dhh3n0cLnd7wvgheMOrodFkCLa-RpzK9f3NW+n0jsKQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/33] 6.1.37-rc3 review
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Fri, Jun 30, 2023 at 4:32=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.37 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Jul 2023 07:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.37-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.37-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

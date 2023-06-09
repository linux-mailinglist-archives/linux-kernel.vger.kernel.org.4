Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB1729715
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjFIKiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjFIKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:37:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4F3A8B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:36:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-978863fb00fso299989366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1686306979; x=1688898979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYsNQRTKdujJx2uaKy6pB5AMEs2kGLaS/0Oqa5TB6fk=;
        b=V+UX/ydDBasuRYLhjYA1P8GzWnmkqERfv9AfsL7V0e7BvzxyNfyA7dGzjRDwlxWth6
         apKBfXV7pYzOL4oxWQEeoQkuk6KCb1+rMdHCB/KFlZBR9fhGZISL6VFjgCNF8TNlpxMb
         hzTksVReCv7xVpPZS3C8C9K+e6F012B3FCTNH5xBqaE74WmnYRQzupQRJOFe1Evk0tsx
         3DmK2Bam6jpfc1BD29ten5r2SHyeaqyalqaA0jGhZEiK7weKHZzlYGrHnjVznHqlN+Ql
         gm2D+JIs1IO1fERrQezclTnnYz0k449zKuWRfI/2tZ44XU7Gl36FXR1wy+o4qDX+wg4q
         KCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306979; x=1688898979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYsNQRTKdujJx2uaKy6pB5AMEs2kGLaS/0Oqa5TB6fk=;
        b=JVFvgl7RpQoaot95SG7Qqc53DdpHg+OucDUY/U5lORzxiLygMrIRDpvgGCVtgUETZS
         9FA+pO0J/tNW8VY9IQ+0b+2s79kRbds3pCQ4weT2lHBUGrUds8PKs3FO7sas0tCnYKPe
         3aT9s1g5bCkbouLJk9RWeutYxAElvRqNzoaf3j8PX35wT2OUJyeJvgisRdZ70z/wx5AO
         82MjuEs+enXAxV/6xGhOUM1jGfX+hXmi/wnIi5TzJDaByILMOiocIDiW7WPywotp77Kx
         1JU8zTXc44S3jDl/4fegjtxMHygA2Gbj7dgrO1fqTuonQQ8jFLpskw9qTtyNJsQl5d6n
         pUMA==
X-Gm-Message-State: AC+VfDw/HSbHfgqZ6FJ3gbeoU+ZNAvyD9gGTKRSYHj/ZkOmjsRTB6P8Z
        4wuVK9UAfgWGFAZsmYkB/gln8yZt31jVKS3KDfcQjQ==
X-Google-Smtp-Source: ACHHUZ5+jPqCDQMhOX/CgsZBGYIrgMvqz2bph7TIpaL4dzCNGHPGzqjekpisjQiaEJan20arvC3F8yFVGwsbATqRsO0=
X-Received: by 2002:a17:907:970a:b0:961:69a2:c8d6 with SMTP id
 jg10-20020a170907970a00b0096169a2c8d6mr1706812ejc.69.1686306978577; Fri, 09
 Jun 2023 03:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230608175726.909746266@linuxfoundation.org>
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 9 Jun 2023 19:36:07 +0900
Message-ID: <CAKL4bV5VJ_K7wRzFvWah92zchvwJOPHTAP5akKcurn6+iV4mwg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
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

On Fri, Jun 9, 2023 at 3:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.33-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.33-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E16C3DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCUWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUWhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:37:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4557509A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:37:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so65667600edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20210112.gappssmtp.com; s=20210112; t=1679438252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocTha7DGqOt2lsARrHmD/l31irURcj6Ur3gV5sNzmus=;
        b=8W5ZDfBkuOZCUXNvnGLVSBsEQVaP9mwB3g2PUxnEPf6yzSzbB5PNaHKE+lAXlCoR4t
         NVSwSmzHiBmQrbjCbtZlZg3mPoQy4Qgcevm4JCncjnhdX+eZhZ2K2WzOzK5aJY0z/dZE
         jVZBUfdZZ37YVXLUmiqsTNpiQ7rtYhRUivGBmp6jKr5AZd/uV2/DE7SDQ1LU82PH9GWC
         L5TjMPIbuzvikaiX3Eh7jz0u5RtWLYh6Yb93YYJUJZbVXW5zHEh92rgwD0K3GIL3jVGw
         UOSVmEM1V231OEywVHVZ8xCQk3KxB8BgtpzTtYtx9OJ53wmJ0Pk3wut30FZ9kxxcO5Wf
         5qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocTha7DGqOt2lsARrHmD/l31irURcj6Ur3gV5sNzmus=;
        b=x7HYRM66182VbxpGbGJN5SyGpujFXEw1RQMpqqyBewbmos/EMETrsy5wnszXmRtggx
         7WZVdz7CG7LUaxo+ueTfV/rhFtMBuBj0KZAmgyS9VcFP5bnxQQDVGDtNz78TzvZ+paqm
         eW2+sRzk1sTybsdVjqKUk+lLm8Drbvlh8E9rP0Gny0ulqZi+RQ9nxzUf43Vn23o7EwWC
         36fmap8C8WDgPrfTr3VQoxpbVVzB0c4T1Nni7tjYUEiVbBLh1Xr2xGVdNWTlP0yzGSPS
         +HXLcy+cKKF3Nvfrp8vucBl08TrqhskNrmhqYMhkgvoT2qgPK3cwUm0zIy+TMircu3Qi
         rMhg==
X-Gm-Message-State: AO0yUKVEftL5qHmfoZAVy8qdQC4GM2tMapI59aZnYdqxcIKsPjrhCG53
        LCZmxiFo5PMn2Hz1JhH7CjihTke1Ox/0hb1wjw5Fng==
X-Google-Smtp-Source: AK7set9vpRzYsNlI+JFaLX3iFRSqQZhT0xDtyIHnp7WFNAx5HG+zmZVpj8c8/6eMuUUoigdFRDyCEqvTa+T2tX7Pxqw=
X-Received: by 2002:a17:906:bccd:b0:8b1:28f6:8ab3 with SMTP id
 lw13-20020a170906bccd00b008b128f68ab3mr2299216ejb.15.1679438252083; Tue, 21
 Mar 2023 15:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230321180747.474321236@linuxfoundation.org>
In-Reply-To: <20230321180747.474321236@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Wed, 22 Mar 2023 07:37:21 +0900
Message-ID: <CAKL4bV6syYjNPkcLN0c2BfkJan3ZETwA6BfR_cS8okOYQ84LKA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/199] 6.1.21-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Wed, Mar 22, 2023 at 3:08=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.21 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Mar 2023 18:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.21-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.21-rc3 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

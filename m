Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2DC746600
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjGCXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGCXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:02:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8E10E5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:02:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so4676124a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1688425340; x=1691017340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugEEPDI78ePccslV5nFSda7Y+u/b3y8toq3vF1cGXRM=;
        b=Gxg1d296aYhiThTBErhnK4dFyBlXUAQZR1j5FPxBeNRWewzsI9EYOok18orw1+ka1x
         +bln1Pl9uVN9FKWcvin7zQoyOTdfSeP7iYT1KquHv/2Guvb2gEQwQ0bS3yurHb84tRcd
         UZn/uttOqZ42oBsM2Lu7jsF+dofR+ZkktI39f1FtTVw5cnxdpAv0WkPyPnEqoLhgumXg
         y6tUYBc+rnuSm1I4rgSIcZhOPR2nIvmgJ5+hSjhmOY/sX7RqoCZY37moGpkZjpQ94Fn6
         SwfY8aaKo0F2wt8qwbc3NJqvuyTok8oCtlw8LNWm7yoWR9iVHYiXNBGMdl+HkL7AJrLc
         BnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425340; x=1691017340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugEEPDI78ePccslV5nFSda7Y+u/b3y8toq3vF1cGXRM=;
        b=LXN20jJ9zssqMWPgGiSqIXo2nwG6aBKJI2BPjFAtcZtf27fdsldlXXczFI90mxnOrN
         RRnYJXSHME8HXVl3nsnBnQ9UIMcp9aS0lA9a7zkzKl5rsdD4KvkiZZ6E4PfEzAGfNlPZ
         AYSgraGY9tgPhFZwjeWbi3W3guD2/sDDDOuyFuWCQkZslv8BU9ALXssEN+QB1B+ChpRT
         0qbXrzyEPzwCkBP6JheYCbxFMLtp4ilqO23nWFNrCa8tB/f7SWYXOttgQwpbKK2+sGMM
         4TNaLY39TwtIiS0AY6NVdioIlwKXHJpGz1Exd5G4VdYHnHFbUKd1hyt6zDiKV07XRdcn
         2IiA==
X-Gm-Message-State: ABy/qLZaEFC90jx2/nMEhfUvjNZmYYEdbpPssMHlWfBL/MHx0Laxn3wD
        qZvU/RO13Z2rPNdU3f8odY8FtpjbGyWVX2RMJmp1cw==
X-Google-Smtp-Source: APBJJlFfCePKSzholqHXh1bDMosUBsG+EpDt5w4T90POrytUx446YR+AKSabi0OjjX5yBnw0LUAcyx0QPDihFPk1n/8=
X-Received: by 2002:aa7:c697:0:b0:51d:960d:5fce with SMTP id
 n23-20020aa7c697000000b0051d960d5fcemr6204738edq.14.1688425340062; Mon, 03
 Jul 2023 16:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230703184519.121965745@linuxfoundation.org>
In-Reply-To: <20230703184519.121965745@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 4 Jul 2023 08:02:09 +0900
Message-ID: <CAKL4bV6wTXVoYP7Ui9u0vSfx4Ga0GY+VPZeQp8TLJ+zvxjoHhQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/11] 6.1.38-rc1 review
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

On Tue, Jul 4, 2023 at 3:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.38-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.38-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

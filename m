Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A095736C28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjFTMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjFTMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:44:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BA10FA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:44:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519f6e1a16cso5495465a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1687265090; x=1689857090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Woy9uXIbm09rqBjX1mw8Ry8Yy7O1r7e9UR5ScGw9hbM=;
        b=bUq6B/fjuqhJGJhb5F4omVZxP5j6n2opJA03bG7H4M8PKjLi+kiu7BFjM5zAtTgx5v
         akG2by3SZjL0jaePtm/ixtTEeXpaxulBN1B0PtzRj5OytQtu6CGquxk9LYtodMY/zn98
         yQW4O0UVPAixNUg5QC7ADwdj5ZXawlmiuoucNKFezIhyfofpC3AKNQnvyifz2e1kiTM3
         s8l9gnD0ERusHwVd9bsfhyigW5MTch2mUkCcWUAjjlXWutQBPdc4FxjJWxxfpZvtYO7x
         anf+UraBULroMpoqLiZpH6y7jbV439DB7y72/cOqEFT1mdITl5uVPmiQYC2xWAA15Plu
         1Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265090; x=1689857090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Woy9uXIbm09rqBjX1mw8Ry8Yy7O1r7e9UR5ScGw9hbM=;
        b=e7GYRZvET9dHDF/J9P0bLbKn+s7jGxDZXOacrVmv0G4kWU860Bi8QQoRbBiXJNy6Co
         u6aVy8BAr8nGFtKp/EmrYWiPpV8wlqtB0WzOeCNXvtJqn3+QfqgjpUr93bGFQ5sQ/AQr
         CH5eI7V8aZE03S3hF2cRae8nawIjZlAgYiS8pkcDLmrqkDoXkK5GWgU9Zo6s+4zt9ZzI
         qxqkRsSwyjq4yTLN6g6gNuMVhSIOJuKyovYWBYFRSgTW9bGsGPfK0SOGfoMbbywDt8gH
         gK7arioCe/8+qvgIpY6QuWiFsEadoo6LOsiuKvv0plaPkVuisMCpnEzqzO9gZLoTBji+
         mkZQ==
X-Gm-Message-State: AC+VfDyNgKhesMJqh235Zut3PiV6E4DzQRluO8q8qU97pcchPFKFd3bE
        PDG5MIgWg2VC4oBu1elDL7HqVZ4WVptmNmMxsfpO3Q==
X-Google-Smtp-Source: ACHHUZ6+prkdM6kZZEktw29hRWVkIfpIaf/jCzXL1Y0+PKO/f1QZdU2GYr6hdrLVYRpcWNFABBLfvyTb+4mDWXeI71Y=
X-Received: by 2002:aa7:d605:0:b0:518:92a2:1697 with SMTP id
 c5-20020aa7d605000000b0051892a21697mr7702125edr.15.1687265089834; Tue, 20 Jun
 2023 05:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102154.568541872@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 20 Jun 2023 21:44:38 +0900
Message-ID: <CAKL4bV6nbRsiufHPdGEQQgCKRBDE84ApYCoAB2pJEhhfP6wdcQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
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

On Mon, Jun 19, 2023 at 7:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.35-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

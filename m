Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918C6FC3AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjEIKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjEIKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:17:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E3D074
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:17:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so8755896a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1683627432; x=1686219432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohlbAzo5ypwXbaF7pM6OkdMeUeZBKkZUohq6OEP0kZU=;
        b=ziO7DvPc9SBB23k/jehuNJYdveEYLM7h0sazR78aoaxgiajd9ybCUcuDAf3VzW35L1
         iRc4Ae/FHc1FW73mx7JrbMQoc0ReumUMiG1MHR3J9JF+5Km1utCuV5aSAHlEHNTXty4X
         ryZko4DYK2p0Sc90zohTHW4dyo8hrxyiD2zfnp/lGPrn6U2JNu45UvUsj0SkJtNdHNWV
         gK7bptIul5zh9ro5ihYQtP1pQOlLM2h2gbgoiIC+F9DzrZ4ZoHrJd5gmvbMIwLLxum0j
         BByOL1WVXyQKzJPZMk9HDEHpqAl4OvV6+NMo5J8xrw7aCX2/b23SCLAPQy1HqW1FGBcJ
         mhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627432; x=1686219432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohlbAzo5ypwXbaF7pM6OkdMeUeZBKkZUohq6OEP0kZU=;
        b=aYDrHKcW8ACZ664Wh2E7kMMrKf6DZzA2PflMOnP9J2on4DwoKjUmZgjCJc23mefZN4
         8fenDjscS8hF260y6OK2AGyUNBvpwpJptLNSkL4uK5Ps7aj89skBMh0tqeqmIdhhRve/
         FcLfVD5TDCGUKg8jpHTGvx9jPsSlXdu8jHYzrzUzMtM7g7WvJt42tsRjaL6ENec3JLuC
         RQ1vMlIw1o901U4D5wJE28b4KhDFBzZAdVnhfUvI5Wy9FZFaIGOISJzdH2hJLjT7VHd2
         DX3nKJvc//xolmdgryRdBibjyB1iMykb5fkEEOBuBI0w8E9UyipfGv6AN/Md9mBQ4hKr
         JEQw==
X-Gm-Message-State: AC+VfDwvb7udfb6wJ7yOHf2+wCg5HjOfWJ1yTPUuK3aiH5XVx1krDjnB
        oJsATVN9GXutIbC696krvektKcjtPFaxWVW7qrSerO2cdIs0dC54Tnnl2Q==
X-Google-Smtp-Source: ACHHUZ4fpHBQjFItIPZmI0/7UCEWgb0vqm/e9/KBpogQJkDgd3uL/4mLaxg2DFynAPUZl/b50gJqaip9svkToh9hxNo=
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr1058743ejc.64.1683627432167; Tue, 09
 May 2023 03:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030653.039732630@linuxfoundation.org>
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 9 May 2023 19:17:01 +0900
Message-ID: <CAKL4bV7QsdCtqJfm1O1MvkHN1WcmzGZuTaiBqmBVd7Rw59TsVQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
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

On Tue, May 9, 2023 at 12:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.28-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.28-rc2 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

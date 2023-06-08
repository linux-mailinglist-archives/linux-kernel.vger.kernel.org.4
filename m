Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7C727E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjFHLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjFHLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:20:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AC226B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:19:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977ed383b8aso90450266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1686223198; x=1688815198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJdbAv7bpcT0Rq4k4eGG4gWyo/yarCqXwYtqTBVFLOk=;
        b=04Po6YJpdWArF1GlYBipfvE+IIbc06y2oiNGq3CKx2qXTgntDKxhPSUneAsQVKYL+l
         KqQ3Fij8CYLMxnsipo/qPZYZbHIaiRfDDXqx4Bdt9DxTKnIYQkj4hgbfu6LWzHzTtt1R
         DzOvPsHmiCbwuI0mC2GhpexI0e4aSAiu7YwyLV7HMxXKAzInnjGo5PFA1tX6STep9vw7
         uDb3WD7Qq8g9qfJsFZd7skEo3GubzFpVlgQt69iSGX+M6JBwqYR4sAFzav2FS58qtAU6
         3CMI4fD1cbSTTUMgA53ZkCV9ZXQ8MTHYKMtkpb2PMLJdliuitBwgvjxfi9fl7H5MTni+
         3TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686223198; x=1688815198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJdbAv7bpcT0Rq4k4eGG4gWyo/yarCqXwYtqTBVFLOk=;
        b=S/QkwIQLlxZ6GBUhV4A8c5XiZQLZDcJkiaruAvdBk6GyLNBsrEi2+iY6+htidC5jPl
         YWcy5fnPF+erVOF5BcZMyd7Wk6w13DASTXH5cfF0dJEoHvLJTqD2FsmH1HoUFxp7bSLO
         TCX7WSuwV9isTyKkKGeCW7iscDNuH5u/yF/A6RVVyENwZHPEsqmRYscdsSmed+tkO6W0
         nwxb8D0L+B4irFRbKICmhzLxijGsViHa5aphulQH6+R88Z/nNZ1D7ojNTdZ3zTcxV8L9
         bdjoc9s5oqLmOIBopuUwHGa3fpPbeW7Rxc5/Xp1Qo2jBNuTIjacGKHHAE5UTJ0oOEjJC
         Gr6g==
X-Gm-Message-State: AC+VfDxSw1Hyi4AClgcVk/3l2UxE9UojyM1UUunt66uAjlHIuJx7dbI+
        r/tdtIeGPBF5YpCiwqzrbaduyuzREKkJonazR5QCH9TGaLWkeRk6WR5fNA==
X-Google-Smtp-Source: ACHHUZ5C+87499XG0JaDWva+8XjJb78v1brxE9fUSogkx6xplO47GKzQvdbrmj8rrGGaIBK2hGmeqQpCWWWYYsYPS1c=
X-Received: by 2002:a17:907:6d27:b0:978:66bd:d771 with SMTP id
 sa39-20020a1709076d2700b0097866bdd771mr10362972ejc.55.1686223197879; Thu, 08
 Jun 2023 04:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200913.334991024@linuxfoundation.org>
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 8 Jun 2023 20:19:47 +0900
Message-ID: <CAKL4bV4m9nXyZaWx3C5peZKyc_QgYtZg_V1=WE-Hv9=F8nfkVg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Thu, Jun 8, 2023 at 5:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.33-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

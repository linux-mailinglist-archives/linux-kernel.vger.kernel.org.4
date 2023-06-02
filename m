Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327E71F721
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFBA2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFBA16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:27:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39A123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:27:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-969f90d71d4so205484566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 17:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1685665675; x=1688257675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xJu9BcZB5C/voGBfDbupaISTWs3GOnx/oUC0CPT0tM=;
        b=EIANLU+vPLy6Zi8riN4tXuv4g1DfWX9eF4m68pwE8TOcvgIz77L9BFQrq4+9NOvWXm
         sgpHE2+2zwP8NnQzuxMxN0SPTtR+ntIsYpT/A06o7ZVi4y5jKKwhQfacGUEPxaA2MPu0
         WbVc3ehEa44Jo237ylJxYB+N2kiy+OMjkjB0hMcLkxKBEPy2LyfHleMPzgyqC8AAWPAB
         Y96JA0rhin/Vf0JtAQlzPunN2Bk7D+21FW0ulTB9aoJePJdRGFajy8awHeP4fydsPtRP
         mhE/WXn6GFSDOcuGc/2zzSr6FruoD3fVfbMMhpdsIiHSwSE3bcn9cObP67lT0ZX3Yo98
         vRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685665675; x=1688257675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xJu9BcZB5C/voGBfDbupaISTWs3GOnx/oUC0CPT0tM=;
        b=Y1QnoB5iqNlh5uM/KIHrHzMCpZj9e2BFSWBwd1UQcsD7bi4Xe3phHPYZC4aw7Ckrhp
         3IOJYTivz8dNQgIZXRu+okaFyR5vL+c/FqcjZ120b9ykVn+0JNjWn7TLixIp/SoixvXU
         wNreLLQEtnfTJg5PNoF6ex+lnh5mw/AVrlYG839BbE7BadiaEtVvVkuL4kofJYWCKbAG
         q+E4mBCz10VgnKeL0LA5xVNwfLMyry7uaagnBIV95r9RYP2HWurWg3IgEz33Uf0JmYbA
         hW00Bbl5PeqBx0HIZ7O8Hw6zndljBvUacI38Rb0y4YWV78PRvIct1TOtvXUELdfjLOYm
         cZhg==
X-Gm-Message-State: AC+VfDwrjdpaoHmAP9N6uvKNAKoLKkdyzBcOkADOwS/Ktl4MkqmW4963
        Lr1tgVf7itx9jZtMc5nohD41hFFwZPLvtZTBzbmhog==
X-Google-Smtp-Source: ACHHUZ5UWjTnIVl0uJXpREFwe5ZHMrJM1SowU7wC+uGyasbLsGv40TqMHkjkr9JXp1Day86AsISTrIDA+XY52CBNLu0=
X-Received: by 2002:a17:907:8a11:b0:973:e00c:b9a with SMTP id
 sc17-20020a1709078a1100b00973e00c0b9amr9891996ejc.4.1685665675295; Thu, 01
 Jun 2023 17:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143327.479886832@linuxfoundation.org>
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 2 Jun 2023 09:27:44 +0900
Message-ID: <CAKL4bV5hPWD+LyK1XFf5BvJrwGE91SKUZXTCtQROBkqnisVhew@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
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

On Thu, Jun 1, 2023 at 11:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.32-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.32-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

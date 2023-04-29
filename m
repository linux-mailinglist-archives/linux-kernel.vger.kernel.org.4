Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384986F2411
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjD2J5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjD2J5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:57:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462F199F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:57:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94eff00bcdaso145022866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1682762229; x=1685354229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpQfY7AACWviz6/E7CAwrIowOwi9JzyFzIOfbt2aass=;
        b=Q1/7eaNWgw4brmZ/sm7WNy5F0OBQXKJ0UTYnreg1fJKN3LN5HMmSfwsqJZAPmYhN62
         C2gjDfvzYekHC/ogxUzGRYBqpNuj0+kC70yZaT5UgtP5leKmFzqQdyV5GqPSBpcS8OyR
         Sy5wTT+ul7hE3C7z6dfvbP9oDxyefB6EYLlVsQwnlmewsEhXhG7gsmaRNTai3vVPONhB
         VOS+RE5V5tFy01QAQULpMmXUoDrvrIr7USbw7Gdm09ahiT2mGye1lB60JXswuFhnegin
         UcaLwTncJJMJWDsNtw6Nae8NnQtMotM6cGTe1vMOfmkr7D4GtJSI/0YIdNLfVWXi+NwE
         oy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682762229; x=1685354229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpQfY7AACWviz6/E7CAwrIowOwi9JzyFzIOfbt2aass=;
        b=Z2z30pfFFqDK2frcxp5Ks/ga3G92NpZvBuk/CGeAAX+/If1W3LyEooYhI9b5GubTBj
         GPwVabxAh75EBpAhK4RzrkUWFGfkpd1cIYzR4AKpSyuU7qcHtkyV3OpfJ5lGRxGrQ7Zs
         6ZcYBHJvimzx9mhoTGAwkTmdL1hwrI2X0Fqh2VWuPxQ+ZBw4YIyZlGBbgQOdTV3WrOch
         0dpf9krYSIMGlLkDfGIj7T9NNQafEYIPzGYUq/RqJlcV5QbnDKzTZeNAPJcXrmnFKO+6
         mX5Omf5lhj/eiEBC5rIe3ZTKluFV6NJzgGxDTq2OIYb6QVh1AxlhJrc7V7XH1nxB4xfh
         TQKQ==
X-Gm-Message-State: AC+VfDygzn3Zwdo+tQchsWUKJJDPsRK1SYMMkZEk5kUN7R8g3CzW0904
        VruY9+z4B6YX40Fv5cK4T8L6tI47mobvJUsUfCT/U9zFeHbgItU55AGJtwRn
X-Google-Smtp-Source: ACHHUZ4EXYi5QDB+q5VRUifKkFH2w78bL0lgC/7RQt7DxsjxqRQ88FUksIUK8WnuY+8k6PPn3xMUnxTcZbLHk0U+8MQ=
X-Received: by 2002:a17:906:eec8:b0:94f:444c:fc25 with SMTP id
 wu8-20020a170906eec800b0094f444cfc25mr7523328ejb.12.1682762228664; Sat, 29
 Apr 2023 02:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230428112040.063291126@linuxfoundation.org>
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 29 Apr 2023 18:56:57 +0900
Message-ID: <CAKL4bV6FnuQGS6pr=-BANTVgp0kAHbNSeCtujZikeCmcANc7dQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
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

On Fri, Apr 28, 2023 at 8:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.27-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.27-rc1 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

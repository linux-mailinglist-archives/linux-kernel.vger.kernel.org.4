Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243A6D7B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjDELXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbjDELXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:23:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5914200
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:23:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-942e6555947so35229766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20210112.gappssmtp.com; s=20210112; t=1680693810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfV2KWTK23dzQiE3afeURtamcrYwX7sqGIqTtLsTbro=;
        b=1RFvuNdT7bz4CAJPrNsQwQD0UrbzcRTLPCxW07F92YscwGUIslMfKrAFzh76cGAgGy
         YW94aAYWVK0XfBkh1fyb6W2ZghufSJh2EZHTamjBve09QpGRve0ILZxw2+725FLm7aEa
         WG6RYaTFgwRwmLZsngCyCIVvmpjSmTL24EgzU1/Bq3CdnX6pTJV6eijnFZAqKVOvzpl2
         jQAxOxv/u+YjkFWMGSVPJzY64R3A5ZLT+oq3zQAMLHHrMORHLgBpmDWF4cySeocvOyQx
         jr4VphkrQx9Cqh9kI4X/G7zEAf0z5FNuBzVDfcN98+NJFZnVQv/IPudFnGvSYzfB1bbY
         N+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfV2KWTK23dzQiE3afeURtamcrYwX7sqGIqTtLsTbro=;
        b=kX6vGk9PYE3FW5FD2TzcjHQazV5IA94esL/4z3LxE5IqCcBlF80sygG/9SaWLPKvm+
         x/fJrowvcL9OHQyy65aknxZeRDwYfhq4S61cRZhjiU+CnbuxrAUtpiPjx0yhcqMw0Nmd
         IntUfNro2L9yPD0KzqQTOyPmJWLlOs69SMHVeMRsMJXXu7HtsQvuyWJmZ2FWRuWheObC
         gA8Y1FXJ7Mpbs0SU7GCnBfHCrQC/Mx6OT8SO1kzcFSy7569wt/sMr3lRHaGhfKcXpRB3
         yh6NmDueLZZAJZUm3YaHt5JPWZjhu/Ehb2qeD2gpgN8+yGbmPB8tng8WDbjVQbtAbJxM
         pV7g==
X-Gm-Message-State: AAQBX9egdhUorHlEa0AOp6ymnfWIH0ejAv+A7VUDFgFP/MTMIDRjZXDj
        sIg99iY0EAEbM9h9/OggkaDYIj6U6y39OJ8591XkWw==
X-Google-Smtp-Source: AKy350Z/Ut9C1xKHKjY84iDBS6fxCvIvCKQt59xuW2g2VFOmWxh+amYNznrtGgfAJHqfLYjK5TxUes4SeiC/+uhiaPM=
X-Received: by 2002:a50:9fac:0:b0:4fc:e9ef:e033 with SMTP id
 c41-20020a509fac000000b004fce9efe033mr965995edf.7.1680693810606; Wed, 05 Apr
 2023 04:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230405100302.540890806@linuxfoundation.org>
In-Reply-To: <20230405100302.540890806@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Wed, 5 Apr 2023 20:23:19 +0900
Message-ID: <CAKL4bV74voTKWLBhsa=gmQnked2_b8TF6UkvpOf0wi-q7tVX1Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/177] 6.1.23-rc3 review
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

On Wed, Apr 5, 2023 at 7:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.23 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Apr 2023 10:02:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.23-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.23-rc3 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

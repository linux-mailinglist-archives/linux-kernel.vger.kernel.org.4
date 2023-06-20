Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18F737259
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFTRJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjFTRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:09:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227831737;
        Tue, 20 Jun 2023 10:09:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66767d628e2so1676904b3a.2;
        Tue, 20 Jun 2023 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687280975; x=1689872975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AH7smoJDEjhySYAN4Nbmd7D2SdU9xURDtaEN4YhlvK0=;
        b=pEEjPthVqnfnzDbp4Ms0Up24Q86e3kzO8/fBMIQpAbcWIRMzWzqtNc5c+b/Ss8IBHn
         LINMBN8Npu0326qCj3pL9gXxwKfDtr7g2E3OUsGoKZSxhBnNjGLDyQFD+DJP0Kp5vYod
         H2gENSgYMI7HbLJ/fG8+ydnyGYXqABDDQWzAZ/OxiJwcH2+sKfEZ2147bkqLRA4Ig410
         pCdQw9m6qyuPMNY5e0R17xMJOXBsLPLWGipVrSVe1gwkYxo36RzTMM6p9yKoJ5eE3bQl
         6kRCmLU7LZr40dHjLRibbG+wdTPzGIRlNJqR+yEJjoV/+dFFIDQe2y3IDEebJdxORA/s
         1CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280975; x=1689872975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH7smoJDEjhySYAN4Nbmd7D2SdU9xURDtaEN4YhlvK0=;
        b=c7fwjE5pFGZIcvRRiz87CtiPKqCrPS/sW39S1WBfRElCP5Xkk0JzAOCbjnP3MXuY6F
         LODyZHlNR48I6zdyz+BT50PRvbR+KtbprdV94Vpzz3mcBVnxm7LytM6iTUZCRxhI8mgC
         mvuI3vnJWbdhLcjhHN5dlAx1OEPHuEFgD6XlOdOoWTRD+Il0GtcrKlvhAb4n07iAN/cj
         Ga49H2rKJpSwR5tDY+qRLKQQSFEReakphakz/jjziqDckSBxKIADmVbel31hbqvkT97q
         lKcGQbLNsbmnAug42HbjX3xMvy5kyRAN06Odk+y3z0prjT350smhqzjYZ9+Nah2jWu7c
         FpLQ==
X-Gm-Message-State: AC+VfDwFToYaSLxbunO9HxPc4JB44hNqBLz/PbIrMsB9JJHpninpINVK
        wwYA67w8wS2YOTkUpg7q3zubwVea/aZPix1/Ovs=
X-Google-Smtp-Source: ACHHUZ60J+gO05ipD3Cd1+0tv80Qk06PK0gZxHuqqIcxxrvVPfzNaZB287U9Ed8ccLMgYURRra0i9WoIau9LmacyMIQ=
X-Received: by 2002:a05:6a00:3a24:b0:668:83b7:fd02 with SMTP id
 fj36-20020a056a003a2400b0066883b7fd02mr4526808pfb.31.1687280975538; Tue, 20
 Jun 2023 10:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102157.579823843@linuxfoundation.org>
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 20 Jun 2023 10:09:24 -0700
Message-ID: <CAJq+SaD=z96VZh=ALnwUtKLZU5HobJxO9Zr4Rev9QbLUmdmw=w@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

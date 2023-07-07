Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC474B3DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGGPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjGGPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:12:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158DE2127
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:12:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1969176f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688742727; x=1691334727;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BQgaHEs5ElhGcSE1hakyOOb4DKur9FjrT69zZjDMTtE=;
        b=eDeOV8v3euRnkTXm7Asdaoa32ka9wnAU9XwdcTU4TRBdxYTiTD+A/TNPy9S+nxQTX2
         1QWoAV30NWEIkrLdAl/8PZLCDU7a7CayxV1zwiObT0G4qZ17TCiDReytvR0JaovP1XVX
         1BDFkj8mFrH2aqP9lU0PmLcvaY0Ogyo2IgMDG7s/BJUk5mdX1unx7hfxC0oB8Su4wnYl
         tXwj+tHIecZ6FdhlCMCxQK7Krr1soCCk2KwSdaEgsqfRHbO2jb+G8K9VJ9RL2AL5nZwE
         WwpVwALG+unL9yOu4rn8Ms7SsAoUp0roQP+SZjuLBq87hCrSdayp1Gsw1n1MdChyvBJX
         tU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688742727; x=1691334727;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQgaHEs5ElhGcSE1hakyOOb4DKur9FjrT69zZjDMTtE=;
        b=fIqXtkGk9td/S25ieLDARN/D7p3dD1z4vbzCFUm4Ob8Hi5KzxNGbxsc8D9GojTjxpW
         XCEUE0ZZ9RCjw1PYWgpAp0qwZtfI/BTepW5PmAW+PwR/q3Gg1yhW46fkjpEnfUuubWO4
         k0QqXEdpTKl6upH2gkeMD1yHgwP7ks4A/CMtxyNxM3lRlqY8kYjGXyDzkaOHLxA7tPkn
         gqt9f/ZV/3ph01bIP0KgeHMWGiBWaqSml12Mvsm5IBqqu+x4vtc08qFA5VBxDkYxg9eP
         kVnAPZwUwIiY+n6IW+9hPZH6+xUpAkGO8plnik32bnCgqC61d2nr4nf81clhkSlpvXBS
         q9iQ==
X-Gm-Message-State: ABy/qLY5sLiKEqex3PdEiRk4aIeFrbOsgoWtZNEF+V0RiGFxaJZxkYvt
        nUnAcClH9A9oBB3hhVPln4FBGQ==
X-Google-Smtp-Source: APBJJlGQBnO4ZSjUTrTkR6jMlfdn1bT1yYIOs2bA+ajpmf1kEC0cZt+Rdb1eRGZokGdXhmUk4EM/FA==
X-Received: by 2002:adf:f642:0:b0:314:35c2:c4aa with SMTP id x2-20020adff642000000b0031435c2c4aamr3918202wrp.8.1688742727301;
        Fri, 07 Jul 2023 08:12:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ddd7:8c33:e081:d016? ([2a01:e0a:982:cbb0:ddd7:8c33:e081:d016])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d668b000000b003063db8f45bsm4678383wru.23.2023.07.07.08.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 08:12:06 -0700 (PDT)
Message-ID: <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org>
Date:   Fri, 7 Jul 2023 17:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org>
 <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 16:54, Ulf Hansson wrote:
> On Fri, 7 Jul 2023 at 16:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 07/07/2023 16:04, Ulf Hansson wrote:
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> Cc: Kevin Hilman <khilman@baylibre.com>
>>> Cc: Jerome Brunet <jbrunet@baylibre.com>
>>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Cc: <linux-amlogic@lists.infradead.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>    MAINTAINERS                                        | 1 +
>>>    drivers/genpd/Makefile                             | 1 +
>>>    drivers/genpd/amlogic/Makefile                     | 4 ++++
>>>    drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
>>>    drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
>>>    drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
>>>    drivers/soc/Makefile                               | 1 -
>>>    drivers/soc/amlogic/Makefile                       | 3 ---
>>>    8 files changed, 6 insertions(+), 4 deletions(-)
>>>    create mode 100644 drivers/genpd/amlogic/Makefile
>>>    rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
>>>    rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
>>>    rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 588769fab516..9b8c9ae2375d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1843,6 +1843,7 @@ F:      Documentation/devicetree/bindings/phy/amlogic*
>>>    F:  arch/arm/boot/dts/amlogic/
>>>    F:  arch/arm/mach-meson/
>>>    F:  arch/arm64/boot/dts/amlogic/
>>> +F:   drivers/genpd/amlogic/
>>>    F:  drivers/mmc/host/meson*
>>>    F:  drivers/phy/amlogic/
>>>    F:  drivers/pinctrl/meson/
>>> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
>>> index a2d5b2095915..cdba3b9f0c75 100644
>>> --- a/drivers/genpd/Makefile
>>> +++ b/drivers/genpd/Makefile
>>> @@ -1,2 +1,3 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>    obj-y                                       += actions/
>>> +obj-y                                        += amlogic/
>>> diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
>>> new file mode 100644
>>> index 000000000000..3d58abd574f9
>>> --- /dev/null
>>> +++ b/drivers/genpd/amlogic/Makefile
>>> @@ -0,0 +1,4 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>> +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>>> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>>> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
>>> similarity index 100%
>>> rename from drivers/soc/amlogic/meson-ee-pwrc.c
>>> rename to drivers/genpd/amlogic/meson-ee-pwrc.c
>>> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
>>> similarity index 100%
>>> rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
>>> rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
>>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
>>> similarity index 100%
>>> rename from drivers/soc/amlogic/meson-secure-pwrc.c
>>> rename to drivers/genpd/amlogic/meson-secure-pwrc.c
>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>>> index 3b0f9fb3b5c8..dc93e1762ca7 100644
>>> --- a/drivers/soc/Makefile
>>> +++ b/drivers/soc/Makefile
>>> @@ -23,7 +23,6 @@ obj-y                               += mediatek/
>>>    obj-y                               += microchip/
>>>    obj-y                               += nuvoton/
>>>    obj-y                               += pxa/
>>> -obj-y                                += amlogic/
>>>    obj-y                               += qcom/
>>>    obj-y                               += renesas/
>>>    obj-y                               += rockchip/
>>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>>> index 7b8c5d323f5c..c25f835e6a26 100644
>>> --- a/drivers/soc/amlogic/Makefile
>>> +++ b/drivers/soc/amlogic/Makefile
>>> @@ -2,7 +2,4 @@
>>>    obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>>>    obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>>>    obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>> -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>>    obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>>> -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>>> -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>>
>> I've a few changes for v6.6, how shall we handle that ?
> 
> I think we should continue to use the soc tree until v6.6-rc1 (or if
> Arnd have some other ideas), there are some more thoughts around this
> in the cover letter.
> 
> Beyond v6.6-rc1 I plan to help with maintenance in practice  and run
> my own separate git tree.

If it helps I can send you a PR with only the pwrc changes you can merge
before applying this serie.

Neil

> 
>>
>> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Thanks !
>> Neil
> 
> Thanks!
> 
> Kind regards
> Uffe


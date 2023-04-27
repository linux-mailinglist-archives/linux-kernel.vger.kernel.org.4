Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959376F01E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbjD0HhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbjD0HhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:37:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED2E7;
        Thu, 27 Apr 2023 00:37:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso34991345e9.0;
        Thu, 27 Apr 2023 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682581024; x=1685173024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxehQfcmJryVNtOnqjPU8dcl4daH8QR4oPGx8PetHgc=;
        b=A9A1kf0aU5n5maWaTYSpwFq+dFDGkdZCkeAcCwkLD9kYlmE85jcd+hdkN4nKiQWQe+
         RVnhbx9f5wFVudnxQnUsSqLoUc+G3JM+O42GX9gNZfKeD8PN2HWTR2M+4STfmZxQqx7A
         ULQDVvEq1TUhKtYHjEQgZl7Jn4EVzSTkmRE2Oecxpq3Lqgdq1vonGcIN3aUKzLbJD2io
         FpSv3YS013V0nX3CVl5ec1a5D04GehDx526Kyx7RUB+XA1EFrTaBRu+mhMmPRXhFDy36
         7PFiOvnoAlRW92DFpieLR1YprFoJEGerJot6aeQ7uIG8PKhFuzZejCpTBKtwwOV0mzu8
         YerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682581024; x=1685173024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxehQfcmJryVNtOnqjPU8dcl4daH8QR4oPGx8PetHgc=;
        b=f9lBoujANCu7pW2uwxeluX9nIdJjPiu6BlrLGsAqwNDa8ERC+0r5kA7wGGf4fy2S5i
         1NUfHbZeNBT3pHdisvVj6r8qUgi1zW+OxE4RKbA9Bdr81LB1wyrRMIIXc8wwyMWmPgA9
         HVn0T95cwXvJA4RFiYgIqdh3sAt6/oCJcW2Zf/Nxa9m078C2fPD3eQJFEJLwsyZ36du5
         b4F/OIBrlPcS6wINRVKyhKVUU4/3QKq0WBFzw4QxDBLQ9sT8Xv07lK2S+1/pWriW6dfr
         U/QjQCacocAvk+DME2Q912im4zFVRSMOEQi27YswnCFIdCJDiXiKiDer5MhJPLxLBXGn
         amKA==
X-Gm-Message-State: AC+VfDzhn9YNv2HPlujQCQ95vOs58Yt1C/iVNJGVwaowmKob8+Rn2vJ7
        7UqDPgOdyC1iUGavFGnnbv0=
X-Google-Smtp-Source: ACHHUZ6j08kRlenxNEOxuCRn5D3dpBgWAxIWK0iOstSqplZ+yyO01YFGKwmwZRllZUj/HWkWlwS2Ow==
X-Received: by 2002:a5d:5312:0:b0:2f0:df59:1ea7 with SMTP id e18-20020a5d5312000000b002f0df591ea7mr504125wrv.31.1682581024316;
        Thu, 27 Apr 2023 00:37:04 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d6306000000b002fed865c55esm17706733wru.56.2023.04.27.00.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:37:03 -0700 (PDT)
Message-ID: <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
Date:   Thu, 27 Apr 2023 09:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-US, ca-ES, es-ES
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2023 17:57, Rob Herring wrote:
> On Tue, Apr 25, 2023 at 2:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Rob,
>>
>> On Tue, Apr 25, 2023 at 12:16 AM Rob Herring <robh+dt@kernel.org> wrote:
>>> I have a script[1] that does the conversion written the last time this
>>> came up. Just have to agree on directory names. I think the easiest
>>> would be for Arnd/Olof to run it at the end of a merge window before
>>> rc1.
>>
>> "emev2" and "sh7" are missing for renesas.
> 
> No doubt it's been bitrotting (or I may have missed some).
> 
>> Does your script also cater for .dts files not matching any pattern,
>> but including a .dtsi file that does match a pattern?
> 
> I assume I built everything after moving, but maybe not...
> 
> That's all just "details". First, we need agreement on a) moving
> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> been stuck on a) for being 'too much churn'.
> 

I think it makes sense to move them and probably the best way to do so is, as 
you proposed: that Arnd or Olof run the script to move them just before -rc1

Regards,
Matthias

> One nice thing with subdirs is 'make CHECK_DTBS=y
> arch/arm/boot/dts/foo/' can build everything for a platform family
> without having to mess with the kconfig. Maybe most folks don't care,
> but I do. My CI job running schema checks looks like this to deal with
> grouping the arm dts files (this list is probably out of date too, but
> less so):
> 
>          if [ "$ARCH" = "arm" ]; then
>              VENDOR_LIST="alphascale alpine artpec aspeed axm bcm cx9
> (ecx|highbank) \
>                efm ep7 imx1 imx23 imx28 imx27 imx5 imx6 imx7 ls vf qcom \
>                (am3|am4|am5|dra|keystone|omap|compulab|logicpd|elpida|motorola-cpcap|da|dm)
> \
>                nspire armada dove kirkwood orion mvebu mmp2 berlin pxa
> (arm-|integ|mps|ve) \
>                (at91|sama|usb_|tny_|mpa1600|animeo_ip|aks-cdu|ethernut5|evk-pro3|pm9g45|ge86)
> \
>                exynos s3c s5p gemini (hisi|hi3|hip) mt meson moxa nuvo
> lpc owl ox8 \
>                (r7|r8|r9|emev2|sh73a|gr-|iwg) (rk|rv11) socfpga stm
> (sti|st-pin) ste \
>                spear (sun|axp) tegra uniph (vt8500|wm8) xen zynq"
>          else
>              VENDOR_LIST=$(ls arch/$ARCH/boot/dts/ | xargs)
>          fi
> 
> Rob

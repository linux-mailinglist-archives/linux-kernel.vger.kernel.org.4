Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA016F4D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEBW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjEBW6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:58:35 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E66C4481
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:58:07 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso5157942e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683067945; x=1685659945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1p8PAJD9DFCngojw0T3kSd1c2uyqBORxfNEmDK3GJ4=;
        b=BUUnQw61aCluaeaOfOjylr17lq4wyiS3svEJzNGaImPvwBFbxjY1AYjKa65LSPa2ym
         yE16k3jpuP3N8wCSlIVKGAALWKur7gs6Ffzu8U/kGAiuA1Xyx/x2hK/JJfWNLEFbZFh+
         gw5Uv9OoWoi9etQy1IAyVFsO7YWXlAUhhQim+LNTWB6y3zMhsYaevaqfbTuzGPLNMccY
         J+vqS7x9RyTltzOUQDkaayM18bum3WFZAKA4wqgFiMMBPsbYfXaNiW1/rSr4VdyK3Fqn
         5j1I0Zeq+WoDj447GF++RwHlJ/hGKjEKpd2ivZT8M021uOxvON7tTCA8VLC+2Vt7SgLR
         uLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067945; x=1685659945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1p8PAJD9DFCngojw0T3kSd1c2uyqBORxfNEmDK3GJ4=;
        b=eIi5DVEtTzK2d8PJAzxYgQO5uxNPMHa6bLaVVFjoXfsHYdBLp8bcq66knXQaW4/XZy
         WAL9a+jlxSFy0BVDF/0sWBD7LC+wJYTa3t3iHoHdrLDB5BCJ0wLgB9cq43CIWOQKu3Jf
         Y8R8pB0AdusSRuz2WvrOvLpiSs8cPlD2Ooc0euqcjuUCHX2mJO9I6Ll8fdt3au0x09do
         rTUgxoqrjG8YmFM9xR2mWfG4P8W3zuG48ywQXWye5xDQhjHGjIBgB1lOUu3G1fRmf3Gq
         SJIoWez4mBP3oZC8iqSMEvaYcMQ+kMFRv6oDVIC1j5aRcL4wE8OYWTykfI+eScUftHwd
         baCQ==
X-Gm-Message-State: AC+VfDzPIoucoXK0RV4/tZPTowt9bnPYEhuHlcBic3CMxD4zdxJzxZq0
        JSD+xOP6CWvcGR4RlAl5SyihRg==
X-Google-Smtp-Source: ACHHUZ6Oo6CNJusINV9/L7Xt1q+0o1hyr6U1jjDYvnM0ZlUDdwA1vrQ5KYtmvDXiiUxPR0FKQ1HT5g==
X-Received: by 2002:a19:c204:0:b0:4f1:223c:dc83 with SMTP id l4-20020a19c204000000b004f1223cdc83mr355945lfc.48.1683067945539;
        Tue, 02 May 2023 15:52:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r16-20020ac24d10000000b004ddaea30ba6sm5607156lfi.235.2023.05.02.15.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 15:52:24 -0700 (PDT)
Message-ID: <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
Date:   Wed, 3 May 2023 01:52:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-GB
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Olof Johansson <olof@lixom.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 22:40, Rob Herring wrote:
> On Tue, May 2, 2023 at 3:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
>>> On Tue, Apr 25, 2023 at 2:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>
>>>> Does your script also cater for .dts files not matching any pattern,
>>>> but including a .dtsi file that does match a pattern?
>>>
>>> I assume I built everything after moving, but maybe not...
>>>
>>> That's all just "details". First, we need agreement on a) moving
>>> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
>>> been stuck on a) for being 'too much churn'.
>>
>> Sorry for missing most of the discussion last week. The script sounds
>> fine to me, the only reason I didn't want to do this in the past is that
>> we had the plan to move platforms out of the kernel tree to an external
>> repository and I wanted to do this platform at a time and also only move
>> each one once. I don't think that is going to happen anytime soon now,
>> so let's just do your script.
>>
>> Can you send me the script and/or a pull request of the resulting
>> tree based on my soc/dt branch? Everything is merged upstream,
>> and I think git-merge would handle the remaining merges with any
>> other changes in mainline.
> 
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
> 
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
> 
> Here's the current mapping:
> 
> vendor_map = {
>      'alphascale' : 'alphascale',
>      'alpine' : 'alpine',
>      'artpec' : 'axis',
>      'axm' : 'lsi',
>      'cx9' : 'cnxt',
>      'ecx' : 'calxeda',
>      'highbank' : 'calxeda',
>      'ep7' : 'cirrus',
>      'mxs': 'mxs',
>      'imx23': 'mxs',
>      'imx28': 'mxs',
>      'sun' : 'allwinner',
>      'imx': 'imx',
>      'e6' : 'imx',
>      'e7' : 'imx',
>      'mba6' : 'imx',
>      'ls': 'fsl',
>      'vf': 'fsl',
>      'qcom': 'qcom',
>      'am3' : 'ti',
>      'am4' : 'ti',
>      'am5' : 'ti',
>      'dra' : 'ti',
>      'keystone' : 'ti',
>      'omap' : 'ti',
>      'compulab' : 'ti',
>      'logicpd' : 'ti',
>      'elpida' : 'ti',
>      'motorola' : 'ti',
>      'twl' : 'ti',
>      'da' : 'ti',
>      'dm' : 'ti',
>      'nspire' : 'nspire',
>      'armada' : 'marvell',
>      'dove' : 'marvell',
>      'kirkwood' : 'marvell',
>      'orion' : 'marvell',
>      'mvebu' : 'marvell',
>      'mmp' : 'marvell',
>      'berlin' : 'berlin',
>      'pxa2' : 'pxa',
>      'pxa3' : 'pxa',
>      'pxa' : 'marvell',

I'd question if it makes sense to split the pxa line. Yes, it was sold 
by Intel to Marvell, but IIRC the devices still had some inheritance. 
So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir too.

>      'arm-' : 'arm',
>      'integ' : 'arm',
>      'mps' : 'arm',
>      've' : 'arm',
>      'aspeed' : 'aspeed',
>      'ast2' : 'aspeed',
>      'facebook' : 'aspeed',
>      'ibm' : 'aspeed',
>      'openbmc' : 'aspeed',
>      'en7' : 'airoha',
>      'at91' : 'microchip',
>      'sama' : 'microchip',
>      'sam9' : 'microchip',
>      'usb_' : 'microchip',
>      'tny_' : 'microchip',
>      'mpa1600' : 'microchip',
>      'animeo_ip' : 'microchip',
>      'aks-cdu' : 'microchip',
>      'ethernut5' : 'microchip',
>      'evk-pro3' : 'microchip',
>      'pm9g45' : 'microchip',
>      'ge86' : 'microchip',
>      'bcm' : 'brcm',
>      'exynos' : 'samsung',
>      's3c' : 'samsung',
>      's5p' : 'samsung',
>      'gemini' : 'gemini',
>      'hi3' : 'hisilicon',
>      'hip' : 'hisilicon',
>      'hisi' : 'hisilicon',
>      'sd5' : 'hisilicon',
>      'hpe' : 'hpe',
>      'intel': 'intel',
>      'mt' : 'mediatek',
>      'meson' : 'meson',
>      'moxa' : 'moxa',
>      'mstar' : 'mstar',
>      'nuvo' : 'nuvoton',
>      'lpc' : 'lpc',
>      'lan96' : 'microchip',
>      'owl' : 'actions',
>      'ox8' : 'oxsemi',
>      'rda' : 'rda',
>      'rtd' : 'realtek',
>      'r7' : 'renesas',
>      'r8' : 'renesas',
>      'r9' : 'renesas',
>      'emev2' : 'renesas',
>      'sh73a' : 'renesas',
>      'gr-' : 'renesas',
>      'iwg' : 'renesas',
>      'rk' : 'rockchip',
>      'rv11' : 'rockchip',
>      'rockchip' : 'rockchip',
>      'socfpga' : 'socfpga',
>      'stm' : 'stm32',
>      'sti' : 'sti',
>      'st-pin' : 'sti',
>      'ste' : 'st-ericsson',
>      'spear' : 'spear',
>      'axp' : 'allwinner',
>      'tegra' : 'nvidia',
>      'milbeaut' : 'socionext',
>      'uniph' : 'socionext',
>      'vt8500' : 'vt8500',
>      'wm8' : 'vt8500',
>      'xen' : 'xen',
>      'zx' : 'zte',
>      'zynq' : 'xilinx',
> }
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-move-v2

-- 
With best wishes
Dmitry


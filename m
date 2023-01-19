Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6F673750
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjASLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjASLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:47:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B51DB94
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:47:17 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB8E26600871;
        Thu, 19 Jan 2023 11:47:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674128835;
        bh=0smOQh9Okjuxl91uhp2UlCaZvTxmN/YKcBXbtrktPQs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KEjW75Va4wNbyRKtmlVhPopxczdouD4uAv3+DqZRtpe1hsii52bZQ+lW6xsTzejyX
         1+KKT7nZI9V8PqP28e8QDPv0p1K0fteUYlBADCCaiDwVDdHhZ0AZGTTqUltpGpqxQ8
         ApbhHH3SHRLEGwxYu5pJw1vvVvplCDHVwGZwoY2SkH3p8UsTNc+GL/Y0pYbmkwDQ2d
         NdEuOLLPQ/4jXY8lUEwBPT/Ix8LnDdyOCIDa+BttVx3GtKjerf6rkgR0xexPC1weA1
         UCf8YwzyTmLQLg5/M92riBLRmlpZS1+Cy9gDFob2aSoJSa2l+Cpc236NCpGAlpYU0o
         WGq2WEGhQh9TQ==
Message-ID: <1add3f34-3a50-c600-c8b4-02c65771bb42@collabora.com>
Date:   Thu, 19 Jan 2023 12:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: defconfig: Enable missing configs for
 mt8192-asurada
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230112151238.1930126-1-nfraprado@collabora.com>
 <20230117155854.GE2350793@hu-bjorande-lv.qualcomm.com>
 <20230117201159.pcxnftapsjr2eotn@notapiano>
 <20230118181523.GD3322341@hu-bjorande-lv.qualcomm.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118181523.GD3322341@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/23 19:15, Bjorn Andersson ha scritto:
> On Tue, Jan 17, 2023 at 03:11:59PM -0500, Nícolas F. R. A. Prado wrote:
>> On Tue, Jan 17, 2023 at 07:58:54AM -0800, Bjorn Andersson wrote:
>>> On Thu, Jan 12, 2023 at 10:12:38AM -0500, Nícolas F. R. A. Prado wrote:
>>>> Enable missing configs in the arm64 defconfig to get all devices probing
>>>> on mt8192-asurada based machines.
>>>>
>>>> The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
>>>> PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
>>>> MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
>>>> regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
>>>> ChromeOS EC rpmsg communication, all MT8192 clocks.
>>>>
>>>> Support for DMA Restricted Pool is also enabled since it is used by the
>>>> WiFi card on this platform.
>>>>
>>>> REGULATOR_CROS_EC is enabled as builtin since it powers the MMC
>>>> controller for the SD card, making it required for booting on some
>>>> setups.
>>>
>>> I presume this implies that there's no ramdisk to carry these additional
>>> modules?
>>
>> There may or may not be, at the discretion of the user, so enable by default.
>>
> 
> As long as the dependency chain is reasonably short this is okay with me.
> 
>>>
>>>>
>>>> By enabling the support for all of this platform's devices on the
>>>> defconfig we make it effortless to test the relevant hardware both by
>>>> developers as well as CI systems like KernelCI.
>>>>
>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>
>>>> ---
>>>>
>>>>   arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
>>>>   1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index f3053e7018fe..4e806d8068f6 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>> [..]
>>>> @@ -1092,6 +1104,18 @@ CONFIG_CLK_IMX8QXP=y
>>>>   CONFIG_CLK_IMX8ULP=y
>>>>   CONFIG_CLK_IMX93=y
>>>>   CONFIG_TI_SCI_CLK=y
>>>> +CONFIG_COMMON_CLK_MT8192_AUDSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_CAMSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_IMGSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
>>>> +CONFIG_COMMON_CLK_MT8192_IPESYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_MDPSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_MFGCFG=y
>>>> +CONFIG_COMMON_CLK_MT8192_MMSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_MSDC=y
>>>> +CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
>>>> +CONFIG_COMMON_CLK_MT8192_VDECSYS=y
>>>> +CONFIG_COMMON_CLK_MT8192_VENCSYS=y
>>>
>>> Are all these clock drivers needed in order to reach a ramdisk, with
>>> working uart, where further kernel modules could be loaded?
>>
>> No, but currently these configs can't be enabled as modules. So my intention is
>> to enable all of them as builtin for now so we get the functionality there, and
>> after the drivers and configs are reworked to allow building as modules (which
>> should happen shortly after [1] is merged), I'll update the defconfig so that
>> the non-essential ones for boot are set to =m.
>>
> 
> Sounds good to me.

Adding context... on MediaTek clock drivers, I'm doing the rework [1].

There's a lot to cleanup and one first rather big series is already there,
well-reviewed and ready to be picked, but that does not change the MT8192,
nor others, non-critical clock drivers to tristate.

I'll do that for most MTK clock drivers in a second (or third) cleanup series,
which is already scheduled on my side, but that will need some time to happen
since, as I said, there's still a bit to cleanup before that and I will make
sure that nobody will forget to send a followup commit that will change the
defconfig to build the non-boot-critical clock drivers as modules as soon as
possible.

Cheers,
Angelo



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332AF5B7757
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiIMRHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiIMRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:06:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6BF8E4D9;
        Tue, 13 Sep 2022 08:56:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so21478665wrr.5;
        Tue, 13 Sep 2022 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A1Eig4ob2xruzFnrOgNkfvNevJMOsIOAHzq6wGFNTHg=;
        b=jnqG/3Xw42Vw3hCx2tkA1LUWA4X73P8JBwCXnUdjcxmH8K3BrrtIM6OMZP+btxOVPz
         kKgq37YjjtNc8PDz/BUigJobIHgg7/5eL7X9bT6YMTugqrRNy/NSTU6vOmAfrHCHrnuf
         NhF2jtGgPfuP2T39ncunefBsR0J+A78NnBBM3KBODOF6GK8W4UQoEuKaLG6jscSeHzIm
         A+JiQjmcgbKRzh7owhNRLHav15OTGXq/GHgRSpDcMN/G8pDwHGDJD6yRbm7m+BWjl/5R
         My+9qSZcL9XtCSLrVracdZpj5HHr25rBEFGxOv+0Y6Qm+r8u8IBwm8Fkm7CEBNSeGDqz
         retQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1Eig4ob2xruzFnrOgNkfvNevJMOsIOAHzq6wGFNTHg=;
        b=LlvEy651z9l9DvNAStTKy6u1zcyN50zaggUBpriDdiV8e6bn+KX2U2cFPnnuCl7cgy
         SrGmb6PmqEZ1lmb3GIan2hfwJhGMB5FmlVQOAgG3NbubQidnHC1iI3Gu2oPZp1eD+XIO
         mx1dJMihXNQfbkuG/XdWUuniLW58tRER99QK0Xxmx/AFhQHvgqSTCYZ3RYTiHjbfYlc7
         O5POzb/M/VEygaG4qrM3086ju3RJsnyBE0cxPcSC3kRInWoXPAUic50G1zfvNmV7OQGd
         X+WFM/2P1ulQi5rYQFmxnZtukBCpp1bLJXnygi/h1FPMa8zPyBxeYuUgugLTKzuanIBF
         Vrzw==
X-Gm-Message-State: ACgBeo2kIbLxVPOWbadpDcok8YYsLarFif8cu8w7VjTmT00Kh0SXhHEA
        G4mDuCSDOPn/2huQepgRF/o=
X-Google-Smtp-Source: AA6agR5MXcQhvZeL2lOM1tkCMzp/EfuKffz9Zr/BO5VivjLo3NQ+7pEPi4PF8Ub2szW7vpiCx0FbIA==
X-Received: by 2002:a05:6000:1acb:b0:226:f39d:1a1f with SMTP id i11-20020a0560001acb00b00226f39d1a1fmr18413148wry.607.1663084564686;
        Tue, 13 Sep 2022 08:56:04 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c12c800b003a844885f88sm13138699wmd.22.2022.09.13.08.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:56:02 -0700 (PDT)
Message-ID: <96cd0c78-a76d-e32c-8f05-32e127df3fb0@gmail.com>
Date:   Tue, 13 Sep 2022 17:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 00/10] ASoC: mediatek: Set i2s clock sharing from machine
 drivers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <166276355052.332114.1969052042106279493.b4-ty@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <166276355052.332114.1969052042106279493.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2022 00:45, Mark Brown wrote:
> On Thu, 8 Sep 2022 12:11:44 -0400, Nícolas F. R. A. Prado wrote:
>> The i2s ports on MediaTek SoCs only support a single data lane. In order
>> to achieve full-duplex operation thus two i2s ports, one for input and
>> one for output, need to be used together and sharing a single clock from
>> one of the ports.
>>
>> This clock sharing setting was previously read by the sound platform
>> driver from the devicetree, but given that the input/output pairing is
>> closely related to which codecs are connected to which ports, the
>> machine sound driver can infer and set it, so that no DT property is
>> required.
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [01/10] ASoC: mediatek: mt8192: Allow setting shared clocks from machine driver
>          commit: 8ae4fcfd5b11b5c33154732fcad99ad0f5843ce2
> [02/10] ASoC: mediatek: mt8192-mt6359: Make i2s9 share the clock from i2s8
>          commit: 3ffb9fa3963964a730c34f48e502ac0625efc145
> [03/10] ASoC: mediatek: mt8192: Remove clock share parsing from DT
>          commit: 9ccd51ce396a46d9d4d0c87aa6a82dd26a2f281a
> [04/10] ASoC: mediatek: mt8183: Allow setting shared clocks from machine driver
>          commit: fea84890e5c1fb65ae8e25b2f9b86363af1f45f2
> [05/10] ASoC: mediatek: mt8183: Configure shared clocks
>          commit: 4583392a135cc30409f5a6ceebb8374e550b03e0
> [06/10] ASoC: mediatek: mt8183: Remove clock share parsing from DT
>          commit: cbebe67859a0e8d51e578fdd9f927f8ef2504ba4
> [07/10] arm64: dts: mediatek: kukui: Remove i2s-share properties
>          commit: b3821f7839c2ec322926d16557aff29f4be1f4dc

DTS should go through my branch. We can see if there are any merge conflicts in 
linux-next and fix them somehow or you drop the patch and I take it through my 
tree. As you like.

Regards,
Matthias

> [08/10] ASoC: mediatek: mt8186: Allow setting shared clocks from machine driver
>          commit: 4132a778e806f77c2bd01a9a34b07edc9dd99d76
> [09/10] ASoC: mediatek: mt8186: Configure shared clocks
>          commit: 9986bdaee4776c5d595933cace9d54c6bc084e91
> [10/10] ASoC: mediatek: mt8186: Remove clock share parsing from DT
>          commit: 62da80c6a124dd68b12c4d2197ecc74b79823571
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

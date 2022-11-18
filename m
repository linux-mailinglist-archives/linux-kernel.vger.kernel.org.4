Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9E62F24B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiKRKPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiKRKPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:15:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158211174;
        Fri, 18 Nov 2022 02:15:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 445A0660298A;
        Fri, 18 Nov 2022 10:15:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766500;
        bh=h63ftO/ODQCgzVRkyDJdfweyIzYx9Zg+X/ltNAVcBso=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=QdN3amzFZ2Ss5edTGdwWTxaGHgOZ0gNrU9UhZgXwl5kzwTKrAxRvyAv7wMwd2QY4P
         fr4s7C0HwfpKwuSXbhQbWVZ8qvY2S4XF9kOATvxUxQ5xY/g5SCmr4Tjcvx+MTXYvSl
         HDv0UNSxkJjWz5dicPDg3Ds6l3ZEB2S3qJb4DtQvN59Z9QOD4/BlKnpOTb9bLMN3x2
         bsyI9YGO7o9CE/gO6fMJhmy40IoaV9IgzBMgHJXIPG1J+eksKBp2hYWM12N6450wfF
         Mt77nL4zEkQwN36DBShs+2qe0OywqcFW8xCKIRuVIL7MGGlvOJD85fRPUjKEXV2Kbz
         Fc5CmCAEVWUAw==
Message-ID: <47c92a97-cfc2-44fc-f1e4-6d5183e55432@collabora.com>
Date:   Fri, 18 Nov 2022 11:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/4] MT8195 Acer Tomato - Audio support
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EzD_CvZHv_HOd4cRB_3qzUDUYwvOBN1qkkdP4ygo862w@mail.gmail.com>
 <f12144d1-d37a-2bd7-5c28-4b15b84818ef@collabora.com>
In-Reply-To: <f12144d1-d37a-2bd7-5c28-4b15b84818ef@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/10/22 10:52, AngeloGioacchino Del Regno ha scritto:
> Il 07/10/22 10:42, Chen-Yu Tsai ha scritto:
>> Hi,
>>
>> On Thu, Sep 22, 2022 at 5:49 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> This series enables full support for audio, with DSP, on the Cherry
>>> Chromebooks.
>>> Related ALSA UCM2 configuration was already merged in its upstream
>>> repository [1]: this is fully tested and working as-is since all of
>>> the required fixes for MT8195 SOF drivers were picked and are present
>>> since `next-20220908`.
>>>
>>> [1]: 
>>> https://github.com/alsa-project/alsa-ucm-conf/commit/a59c3b1a57de8eb424c4f754bb031265e856260e
>>
>> While trying this patch, I get the following error:
>>
>> # modprobe mt8195-mt6359
>> [   44.985107] mt6359-sound mt6359-sound: ASoC: sink widget AIF1TX overwritten
>> [   44.994393] dmic-codec dmic-codec: GPIO lookup for consumer dmicen
>> [   45.000636] dmic-codec dmic-codec: using device tree for GPIO lookup
>> [   45.007165] of_get_named_gpiod_flags: can't parse 'dmicen-gpios'
>> property of node '/dmic-codec[0]'
>> [   45.016177] of_get_named_gpiod_flags: can't parse 'dmicen-gpio'
>> property of node '/dmic-codec[0]'
>> [   45.025084] dmic-codec dmic-codec: using lookup tables for GPIO lookup
>> [   45.031666] dmic-codec dmic-codec: No GPIO consumer dmicen found
>> [   45.041434] sof-audio-of-mt8195 10803000.dsp: Topology: ABI 3:22:1
>> Kernel ABI 3:23:0
>> [   45.050185] mt8195_mt6359 mt8195-sound: ASoC: Parent card not yet
>> available, widget card binding deferred
>> [   45.060566] sof-audio-of-mt8195 10803000.dsp: ipc tx error for
>> 0x30010000 (msg/reply size: 96/20): -22
>> [   45.069965] sof-audio-of-mt8195 10803000.dsp: Failed to setup widget AFE3.IN
>> [   45.077575] sof-audio-of-mt8195 10803000.dsp: error: tplg component
>> load failed -22
>> [   45.085291] sof-audio-of-mt8195 10803000.dsp: error: failed to load
>> DSP topology -22
>> [   45.093062] sof-audio-of-mt8195 10803000.dsp: ASoC: error at
>> snd_soc_component_probe on 10803000.dsp: -22
>> [   45.102880] mt8195_mt6359 mt8195-sound: ASoC: failed to instantiate card -22
>> [   45.123915] mt8195_mt6359: probe of mt8195-sound failed with error -22
>>
>> Any ideas?
> 
> We have to recheck if the firmware that was sent upstream is the right one for
> Tomato's dts topology variant, I think.
> That's surely a firmware issue that you're seeing, anyway.
> 
> sof-mt8195.ri
> 

Update to this: what you were seeing was not related to this series, which is
entirely correct, but due to an ABI breakage in SoundOpenFirmware.

After I reported that to SOF, a commit [1] was pushed to fix the same - now this
series is fully working, as expected.

[1]: 
https://lore.kernel.org/alsa-devel/20221117232120.112639-1-pierre-louis.bossart@linux.intel.com/T/#u

Chen-Yu, would you please test this again with the aforementioned commit?
Works here, should work for you as well now :-)

Cheers!
Angelo


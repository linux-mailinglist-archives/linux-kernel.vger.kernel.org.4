Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367570F886
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjEXOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjEXOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:21:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D1119;
        Wed, 24 May 2023 07:21:21 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21E976605943;
        Wed, 24 May 2023 15:21:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684938080;
        bh=hvJt7YjyA2Q4IEqhRK/UATNSLwjQita55Z4eggN8Sec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DDzb++/BzzeLQ6R1GbLy8KbEJ/cumPebTkGoHFK66V2TcIStLD9HE1jJ65Mw+TNXm
         FHuMI1xvaX1gXwKK8gUs59pTpEfy/R767P5gpsGCHKsEQHaYOyK+ZDh92x0DrxA1B1
         clXfs60YXvTlUCIRpicYerr9gLwe7NRdG2HVRWrF7NgjE29JRDiOuXG7KozI33HhhP
         JiqKZQRe1cdRTmF80vIZ1RYCltHKd0WNtaeanFThogcgHXML635kDFikzXC25mxzzE
         HFaAmBdC3li0VDw+13iD0t+RQ1HDquIGHsaiAjYdL5OxTcSnGYJGGrx/WNc6G5WakT
         tVX/oB4i6miUw==
Message-ID: <0f5765e4-484e-2ae7-dc43-c1d6e9e3e1a4@collabora.com>
Date:   Wed, 24 May 2023 17:21:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Assign ES8316 MCLK rate on
 rk3588-rock-5b
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-4-cristian.ciocaltea@collabora.com>
 <5b3e479f-366b-4de7-a4ec-5348166ebcbc@sirena.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5b3e479f-366b-4de7-a4ec-5348166ebcbc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 13:39, Mark Brown wrote:
> On Wed, May 24, 2023 at 10:41:56AM +0300, Cristian Ciocaltea wrote:
>> The I2S0_8CH_MCLKOUT clock rate on Rock 5B board defaults to 12 MHz and
>> it is used to provide the master clock (MCLK) for the ES8316 audio
>> codec.
>>
>> On sound card initialization, this limits the allowed sample rates
>> according to the MCLK/LRCK ratios supported by the codec, which results
>> in the following non-standard rates: 15625, 30000, 31250, 46875.
>>
>> Hence, the very first access of the sound card fails:
>>
>>   Broken configuration for playback: no configurations available: Invalid argument
>>   Setting of hwparams failed: Invalid argument
>>
>> However, all subsequent attempts will succeed, as the audio graph card
>> will request a correct clock frequency, based on the stream sample rate
>> and the multiplication factor.
>>
>> Assign MCLK to 12.288 MHz, which allows the codec to advertise most of
>> the standard sample rates.
> 
> Surely this is irrelevant with your previous change, and if the clock is
> freely reprogrammable as it sounds even harmful given that it'll
> restrict rates that are not available with the selected MCLK?

As mentioned in the previous patch description, there's a bad timing
with es8316_pcm_startup() being executed before the 2nd call to
es8316_set_dai_sysclk(), with the effect that the new/updated
rate constraints won't be used until the next playback attempt.

Hence the approach here was to ensure the initial list of restricted
rates is sane, by (pre)assigning a proper MCLK. Alternatively, we could
have used an unsupported MCLK and, with the help of the previous patch,
we would have ended up with no restrictions applied on es8316_pcm_startup().

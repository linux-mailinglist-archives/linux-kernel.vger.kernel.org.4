Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A497385C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjFUNze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFUNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:55:26 -0400
Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EE1730
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=egTp0AY9psN+AJQ1JWdPwx+Kv7FcC78T3v2Xv7lWJOM=;
        t=1687355723;x=1687445723; 
        b=eWFARW8Jv+IR0vpg3c74WC/5SRCpWUUJuufOFsBPHikbUtwkIP92vo1AV9Ai1Ht2Wpxl27+DZr/9LLDTg73twQFHzOBthczvlkNKrkIMHY7Tj+iirWOILNe9n9HLZMXiqPsW8lKD3hmQZkkLialfwyaA68I1TGTsy2aUAZoK1ErT9IzLPmY/RwhOboGXzhVX2Uek/febtHoX5xMKfmREFA+tU0crxtSK/6dXPz/K6iukMl1rxIAUAwK3j0es/gWg41z0czJ+Jkydam2V2aoq60rb/tv7gNxIAjvGK514nsE8PmI+KsxhyEB+R+OO6B3ufZ/xZUqF9GLun/nvkwJpHQ==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qByIp-0004m1-OD; Wed, 21 Jun 2023 16:55:20 +0300
Message-ID: <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
Date:   Wed, 21 Jun 2023 16:55:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
References: <20230621115328.156457-1-fido_max@inbox.ru>
 <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
 <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
 <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <b763d08e-f751-480c-96b6-339a53856768@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDCD825FF3AA070ECA3C2EE242F31DB0C21182A05F538085040337AC357BF6EEABB9988C747EB46B660193D5CADA5827129BF3CD1B365EBDF45
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71EEA4C46C73542F4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C925DA674483BBE06C939DE9B875A2C06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7BE2AB513042E4E129FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B28EC0646CDFC9FDDA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CAA44A86D94E7BBB043847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A594830183E0ABDC774400005583E1DF52C85383A65BEFE8D5F87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF301C75078263B9F53E1ABAF2B3354ECD447C73019EA2B43811DCEFF45A5B21789EC5AF04A575AA6CC17492877F82D9B87DBC284F6F065DEA8667B7BB3EC1A8BA21BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lzTNXQzEghHmg==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BB548BBD549DD5DC872921BC9A27DD56798CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 16:18, Mark Brown wrote:
> On Wed, Jun 21, 2023 at 04:02:34PM +0300, Maxim Kochetkov wrote:
>> On 21.06.2023 15:26, Mark Brown wrote:
> 
>>> This is configuring DSP A identically to left justified mode, it looks
>>> like the format configuration needs at least some interlock with the TDM
>>> configuration.
> 
>> According to datasheet MAX98090 supports only DSP_A (L data MSB after FRM
>> LRC) TDM mode. Allowing this mode will let us proper configure CPU audio
>> node via DT. Actual TDM mode activation is performed in
>> max98090_set_tdm_slot() via M98090_REG_TDM_FORMAT/M98090_REG_TDM_CONTROL
>> registers.
> 
> I'm saying there should be some interlock between these two settings, if
> nothing else setting DSP A mode should force TDM mode with automatically
> configured slot sizes.

At this time there is no any interlock for TDM mode in MAX98090 driver. 
We can specify dai-tdm-slot-* properties in DT and .set_tdm_slot() will 
be called to setup TDM mode. And SND_SOC_DAIFMT cannot affect it. I 
checked other codecs drivers: most of them performs TDM setup this way. 
So why do we need such interlock right now?

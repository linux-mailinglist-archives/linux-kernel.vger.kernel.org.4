Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F407386FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFUO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjFUO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:29:12 -0400
X-Greylist: delayed 9303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 07:28:46 PDT
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D91FFC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=nJT5fzG4nA8tzrxdBQpWZ2fiA00ghY68jXq6u2LA1uY=;
        t=1687357726;x=1687447726; 
        b=kjXZV41ZmG6z2/2coD4iTqB7zqdFiZfSuY7TAL8c71/8kb11dTauq1wqqLjxEJxWUnZEsJVZt4Dtj1UxM+44tE02waf1VT5MICPAW8xlZ2nD/D/MBiGtIDLL6RGBroWJL+KTRwz37i/fqjamZWduG9BQNkH2zr9KyjHDArFYQ5mTgEv+bmtrdRSC0bQeUfeNeu3ThY8yeQfZgxRiHp+dLu2Ojgpw9D8FLyJnF1AVnIF1eIuUgmu124maPPQ1Bbju+sdsSiFI4ZAhMW/tS9bx6Z+CBA4JDOBJqyz0sn8LU4zwd12ul8MzDwnuqX9E+BFs2C0kJvjw82CBfpzJn9NUIA==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qByp8-0007GW-JY; Wed, 21 Jun 2023 17:28:43 +0300
Message-ID: <0ada8334-4006-438f-8461-5c4c8e13f65d@inbox.ru>
Date:   Wed, 21 Jun 2023 17:28:41 +0300
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
 <ed9606a4-4be6-7403-6e32-1c045ac0bdf6@inbox.ru>
 <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <adbe1b82-9478-4462-ace9-968723a6ce3f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9A4B2B2E818EC31CFD224C07E85EA9859E11F1DAAA4FD1EAA182A05F5380850404C228DA9ACA6FE2708451A61ECE1571BEDF2AA667862DC52E9EB151CE0806E4B8F2E3C5D047B6D81
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70FFC2100EB7B6895EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F88016AB904663428638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87F474E91384C5365BA2C152A92F88B606F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C592797616C97AB9FA2833FD35BB23D9E625A9149C048EE9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520C65AC60A1F0286FEBDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A1DCCEB63E2F10FB089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A54D8796D2E02DF57BC10FEB1C60DA543E61549223A00EC5C2F87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3498EF79680EE3725C32F8C855525AC30190FB61CE7D78FFBFC2D122F4F6CBFAB140530F5F09079E051D7E09C32AA3244C92213DC52697EA0AFC58ACFEE110F6079CA7333006C390A040799AC538031D0DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lyoCY6f4H0wYA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B7BE4F4AB9B547BE90041AC4B0D015DA898CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.2023 17:01, Mark Brown wrote:
> On Wed, Jun 21, 2023 at 04:55:18PM +0300, Maxim Kochetkov wrote:
>> On 21.06.2023 16:18, Mark Brown wrote:
> 
>>> I'm saying there should be some interlock between these two settings, if
>>> nothing else setting DSP A mode should force TDM mode with automatically
>>> configured slot sizes.
> 
>> At this time there is no any interlock for TDM mode in MAX98090 driver. We
> 
> Yes, that's the problem I am identifying.  The driver allows TDM mode to
> be configured independently of the DAI format but the two are related.

But DSP_A mode is just bit/frame format. It is just compatible with TDM.

> 
>> can specify dai-tdm-slot-* properties in DT and .set_tdm_slot() will be
>> called to setup TDM mode. And SND_SOC_DAIFMT cannot affect it. I checked
>> other codecs drivers: most of them performs TDM setup this way. So why do we
>> need such interlock right now?
> 
> A lot of devices support TDM modes with other DAI formats, or allow the
> mode that is required for TDM to be configured even without doing TDM
> setup.  Some always configure TDM like I'm suggesting, with the explicit
> TDM configuration just being an override.  Some are just buggy and
> nobody noticed.  The issue is that the driver will claim to have
> configured DSP A mode but actually done something else unless the user
> also configures TDM.

Yep. But we have to specify TDM parameters (slot masks, slot width, etc) 
any way. Because there is no default TDM configuration like I2S and so. 
And pure DSP_A/B mode just have no sense.

Anyway. What do you suggest? Should I perform some refactoring for the 
driver? Should I move M98090_REG_TDM_FORMAT/M98090_REG_TDM_CONTROL 
registers setup to the max98090_dai_set_fmt()?

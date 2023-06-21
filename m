Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37377738450
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjFUNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjFUNC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:02:56 -0400
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52160E72
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wf/ICJJMrh33uKZt2UjF6jg7rnoHL8bjgikMojxBtZg=;
        t=1687352572;x=1687442572; 
        b=Oh4Qb+8iFlgXTBZ6dj8U60Ovr/0Aw2kSM04grV+VwEzRxNz83i5V+aS78i8bD9y0d9zmpiAPLqTlFize0WofxUlY8mlSa7Eh5/ZqLF67jgdeiNpnjSYHOHgMD10KHEndLykiixe1fh45MXhcJgOjhba/fRz1ptsk3Bpyif9TslYFpLi0f14ImdpC2YxQaybHXykoeIc1+4tITdeA2CIEDoWfpa1rH9GOxyfAwdRMc+e8SnkM0Olh5Eqltqb8SaWPfyryhveBy+XzFwrsVfdI9Ij1naupT5qmnMkxKBmBKFoDvu56pOY4I7Oa9zsxbfrBX1Dk/tpvBFDRoNyQCNdGAQ==;
Received: from [10.161.100.15] (port=36952 helo=smtpng3.i.mail.ru)
        by fallback16.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qBxU2-00D6XG-6X
        for linux-kernel@vger.kernel.org; Wed, 21 Jun 2023 16:02:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wf/ICJJMrh33uKZt2UjF6jg7rnoHL8bjgikMojxBtZg=;
        t=1687352570;x=1687442570; 
        b=Uj0SRFL8UBs1/NeUxSSmukf7/0h1knriRdhUno9l6q3r1G5Q18vFre90IeaHNt5qpw9q9hIWot+l+DHVJTC1Wq2PvUt3Us7qUcfwSd4/24un2slQU1J+xFx0rk5WSacxPh8mUhdfQ4vyqQNnWy9fESE180s57qCLtVApNjmY3X8F0RGRIP6Pm/Q22nFfEK3DSqGm+19ZHiCP26zXL0cE4Namv7rknJ9832VJnfW67pD9yG1eHVcQveH/SODavMFdpXk36Mjo/tOoPU3ywEnZBRKfHZkR4y//IQrflfSjIJHjaeVxoV6v6UtW4TX9c0+sFbEV6dv7hz43nUi84k/3Qw==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qBxTn-0004zi-Ua; Wed, 21 Jun 2023 16:02:36 +0300
Message-ID: <e6be75f6-054f-6c3b-00b4-a5e112bcefc3@inbox.ru>
Date:   Wed, 21 Jun 2023 16:02:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] ASoC: codecs: max98090: Allow dsp_a mode
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
Content-Language: en-US
From:   Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <3805dc65-113f-453a-90a9-2ae6204004ba@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC5FE2F5E6723F70B2B5A8ACCF658560FC182A05F538085040AA0B343A63EE01F5A4E8A46848515318D86C0ED6992300058D30B3D0B87D82FA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D05773942AAE9CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F28F4AF03526AA8F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8904A2E0E581E359577F9A7531E6D1F6A6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7328B01A8D746D8839FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18C26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BC7A3838EBC35966AA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C837C4FEFBD186071C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A516FBFAE3D48BF3E42CD16C872D5DE090D9A08458193250ABF87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF324597BA0D9BF0B0DB18E3A3FBB90F1CF5C0A6F738EE4D34E2F6143D8209185C257E6C4F5EEB673EC17492877F82D9B87848E4DD801FB89E0C4EE6936448917121BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lz6lVQdPRYW9A==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B41E1CDC64A4CD8BFE25CD2E9722F205C98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA543469617EE63DA4797F6ACA219C8406C3B647ED114AB003AC0E64391A4AD758F11DE6E6887C14CC76D36B460DDF9724EE8DA93F5011E7BC28
X-7FA49CB5: 0D63561A33F958A5AA41EE10A2B9E952A8FD029026C6A7809EA01900C45EFACCCACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakO2d4lTPzE8Uw==
X-Mailru-MI: C000000000000800
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



On 21.06.2023 15:26, Mark Brown wrote:
> On Wed, Jun 21, 2023 at 02:53:27PM +0300, Maxim Kochetkov wrote:
> 
>> TDM mode for max98090 is dsp_a compatible. So allow it.
> 
>>   		case SND_SOC_DAIFMT_DSP_A:
>> -			/* Not supported mode */
>> +			break;
> 
> This is configuring DSP A identically to left justified mode, it looks
> like the format configuration needs at least some interlock with the TDM
> configuration.

According to datasheet MAX98090 supports only DSP_A (L data MSB after 
FRM LRC) TDM mode. Allowing this mode will let us proper configure CPU 
audio node via DT. Actual TDM mode activation is performed in 
max98090_set_tdm_slot() via M98090_REG_TDM_FORMAT/M98090_REG_TDM_CONTROL 
registers.

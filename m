Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C4E712C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjEZSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEZSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:11:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37B189;
        Fri, 26 May 2023 11:11:55 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2CE16602338;
        Fri, 26 May 2023 19:11:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685124713;
        bh=5Vp0v9CQLgFPufyyf5L+TVgF51WKnOgrP8cqPyMHWyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PNXyJBIaI3wNOlNxvKig3Nns9gBXhDCdLGhkEmjiFdPPoMO4CmGS3ZXP6elNmMnSM
         FBmzApVAKsvs1x8/kOWvEXfa5KNUYMmPh/PufmYGe+VGUA9yxNsQtPsV5kC4euP6vL
         JMMSZa5ZaG2pye7g1wfIkffFAc4gvY/ts10Zso449C/OgpFh4TZHtQdXCQL31GIcsN
         50CnWrHV2YdS7H5H6fYSRLTBjQGpJkgnc0h+iXMQS7RXZEcgLq7R5OXFWL1S2Bcbu2
         0GTxa09nFJwItjotmi3xjGeDYkA6ckvWew7739V2zIcjbj+PM5EeW7wvKzNXVnbPKp
         bqB/KdMupOOuQ==
Message-ID: <3c6b67a4-4892-0057-3dfc-65ed6c7ebc37@collabora.com>
Date:   Fri, 26 May 2023 21:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] ASoC: es8316: Increment max value for ALC Capture
 Target Volume control
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
 <20230524074156.147387-2-cristian.ciocaltea@collabora.com>
 <5dbcbf84-602a-44de-ad99-268d4d5b4b2f@sirena.org.uk>
 <cfa23203-1626-440b-ec27-efe56cb297d2@collabora.com>
 <01fd1a9f-56c7-4864-bb2b-8b004284c8cc@sirena.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <01fd1a9f-56c7-4864-bb2b-8b004284c8cc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 16:59, Mark Brown wrote:
> On Wed, May 24, 2023 at 04:49:37PM +0300, Cristian Ciocaltea wrote:
>> On 5/24/23 13:30, Mark Brown wrote:
> 
>>> Presumably you can check the effects of changing the value?  It seems
>>> plausible that what's written in the code might be accurate and the
>>> higher values might actually change the gain but it'd be better to
>>> check.
> 
>> I haven't noticed a (measurable) change in gain when switching between
>> 10 and 11, but my testing equipment is also not that great. Will try to
>> improve the tests accuracy.
> 
> I'd expect it should be really obvious with a scope if you've got one?
> Testing with something consistent like a sine wave (eg, from
> speaker-test) should also make a 1.5dB difference noticable enough to
> check if there's at least a volume change by ear even if you can't
> specifically quantify it.

Luckily arecord & aplay provide VU meter support (via -V,
--vumeter=TYPE'), so I could easily verify this without using any
additional tools:

 Volume  |  VU meter
---------+----------
-6.0 dB  |  30-31 %
-4.5 dB  |  35-36 %
-3.0 dB  |  42-43 %
-1.5 dB  |  50-51 %
-0.0 dB  |  50-51 %

So it seems the specs are correct, and the problem is the hardware default.

Is there a better approach to handle this than extending the volume range?

Regards,
Cristian

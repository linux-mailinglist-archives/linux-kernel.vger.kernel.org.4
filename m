Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC660936A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJWNNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiJWNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:13:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F177645B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:13:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a5so4767125qkl.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZZVZxGYHwnE1PIam0i2Ywe02Lmqk/XzV+z7/E9fIPY=;
        b=V8u/hQ+wAFe2HLlBScSXqDxNPKgepGTKIfTPzyCu51pVOETTB0gLPomcBItqz6HPbl
         G9zPgraSprrqeRJevz7fn1GKZ9on1AhbhTGPMPze68F3IxToHI91fn7h4Qv8ZcDidMyd
         lqDthJ1FhWqM/pkkhCthaqS53jnJCvZiWp5rMx3dD53eZSpKQjOOplBLfkjltjOohpVK
         m8XJWE7H3boEsVlB2nGceZjelBO2Zl3TvFhRvy0G7dm+bzqqg6zk8wIAUpmX15w2ej1b
         SBDcI2eVMs7URG/xV6UyyP/MeAL2Lwn0uhhJMz9SeP9zAKwoyLp1aXeMSKHqwUvxt00P
         FCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZZVZxGYHwnE1PIam0i2Ywe02Lmqk/XzV+z7/E9fIPY=;
        b=AYjuyASfHsXxuk8o6f7G5OAJkwW5VH1e0PHOR3VDqwPZeOUrvj2FOpcTvc7VotZHZy
         vG48MBLue88B8mInM660E+wUX7PSK51JezbqyFbIyP7geNn4I5sl9hlGP/YslhJLYIcn
         nHDKxObFRgoNbZi7q+BHj5DdmTXk3QKMfFtUI85b/paV7GzMocZ05MSpA8aY9iVL/+r4
         WGMlPHxjwHtyxMx9oufAxlaSKUhhyKV/ipw3RX9cbQw+Mekckk2+VLzNIsiUBSlU0qCf
         ymDTTBURUvaJV89dwdY4slFXhJkJVhNBP+0E8mVzP2c0Q4B2AMOBHap65y/4aET/+sr4
         rBbQ==
X-Gm-Message-State: ACrzQf2sPe9cCJKTRSqIf8m0f7HRXpYCHLLai3uYmtt8xjXiXJZ3K0aa
        BE8aAdF52+f/G8dxzn4KiEmL9g==
X-Google-Smtp-Source: AMsMyM7nxzKp2ffgUCDO/X5GoslLPIunxildH8dLc0Nz0E5MubAlrLfOCbLO21902pFFqNdlkh7PSw==
X-Received: by 2002:a05:620a:2406:b0:6ec:c5f5:6304 with SMTP id d6-20020a05620a240600b006ecc5f56304mr19801640qkn.95.1666530756908;
        Sun, 23 Oct 2022 06:12:36 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a132700b006b61b2cb1d2sm12994401qkj.46.2022.10.23.06.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:12:35 -0700 (PDT)
Message-ID: <909abf31-91d9-159b-baef-6ffcfc3e07b2@linaro.org>
Date:   Sun, 23 Oct 2022 09:12:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/6] ASoC: samsung: i2s: configure PSR from sound card
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        'Mark Brown' <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104857epcas5p2a275a1d606ca066227228d13bcf5b120@epcas5p2.samsung.com>
 <20221014102151.108539-3-p.rajanbabu@samsung.com>
 <Y0lPz91gbovAub9D@sirena.org.uk>
 <04a101d8e523$30804b80$9180e280$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04a101d8e523$30804b80$9180e280$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 04:00, Padmanabhan Rajanbabu wrote:
>> It's not clear to me why the solution here is to move the configuration to
> the
>> sound card rather than to improve the I2S driver to be able to cope with
>> whatever the restrictions are on the PSR in these systems - it seems more
>> cumbersome for system integrators, especially since you've not documented
>> the issues or how to configure it.  Could you expand on what the
> constraints
>> are here and why it's not possible for the driver to figure things out
> (given
>> some quirk information)?
> 
> Thank you for reviewing the patch.
> 
> In Samsung I2S CPU controller, to derive the frame clock, we are supposed to
> configure the PSR and RFS internal dividers. i.e.
> 
> OPCLK -> PSR -> RCLK -> RFS -> Frame clock
> 
> Where:
> OPCLK - Operational clock
> PSR - Operational clock prescaler
> RCLK - Root Clock (derived from OPCLK based on PSR)
> RFS - Root frequency selection (divider)
> Frame clock - Sample frequency (derived from RCLK based on RFS)
> 
> Ultimately,
> 
> PSR = OPCLK / Frame clock / RFS
> 
> Unlike other platforms utilizing Samsung CPU DAI, FSD SoC has a limitation
> on
> operational clock, where the clock frequency is fixed (66 MHz) and cannot be
> modified. 
> 
> Assuming that an userspace application wants perform playback @44100 Hz
> and assuming that RFS divider value is configured as 256, the PSR value will
> yield to
> 
> 66 MHz / 44.1 KHz / 256 = 5
> 
> However if HW uses PSR = 5 to derive the frame clock from operational clock,
> then
> 
> RCLK = OPCLK / PSR = 66 MHz / 5 = 13.2 MHz
> Frame clock = RCLK / RFS = 13.2 MHz / 256 = 51562 Hz
> 
> The actual frame clock derived based on PSR is now different from what user
> application has intended. The situation did not improve even if the RFS is
> swept throughout the entire valid range.
> 
> We can overcome this scenario to an extent if we can get a flexibility to
> Configure both PSR as well as RFS.
> 
> i.e. to achieve frame clock of 44100 Hz, if PSR  = 23 and RFS = 64
> then frame clock = 66 MHz / 23 / 64 = 44836 Hz 
> 
> Although the sample frequency is not precise, it is very much closer to the
> Intended frequency, when compared to that of the existing solution. Since
> this
> scenario is specific to FSD SoC and has no changes in the Samsung I2S CPU
> DAI,
> the configuration is being done from the sound card of FSD SoC during
> hw_params.
> 
> Please let me know if you think this scenario can be approached in any other
> way possible, rather than configuring from sound card.

Entire new driver for this, instead of improving existing Samsung
drivers... no, it is no the way. If you followed this approach you would
send 20 drivers for each "specific" quirk difference.

Best regards,
Krzysztof


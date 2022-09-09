Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2455B3C16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiIIPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiIIPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:34:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFC146D18
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:34:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y29so2277666ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lP9I9C231dArXcMlyocTl/qVE0j3Pv37aaLeqVQ7UZU=;
        b=twITONxYLgPP9PxkRf8UDAvKbnLUZmH56aq6q+qd7igqBv9W6NMmSitWjOGWFf4it3
         LCQhRxyuGz4oj/8i+t3bY/DBVlHmyqeJ0czsSq2tS1agOxqtYqcs5Ig3ltIpR6JSGpaG
         rAHgebTzPRAZdHLod8VnLOin5og/nVCVDoRaWHZDhDN7SxfzFnushm2QkPMUEdyI31pC
         gFoixmPBfD30PnD+gsGvzQ5X4e+hbsCfU3XyyEGO6r6UMEdTPcZ0IlKDhU6bF/gGWecW
         BD7jLpreMkNBMcqA7so5sDsOkQ2C+OoxBscwm81lyVy7/1FNFUJ+YfZu3FCexn4K2KWu
         VWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lP9I9C231dArXcMlyocTl/qVE0j3Pv37aaLeqVQ7UZU=;
        b=CY8xdAQ+TEf/TBv2WNHDg3Bc1SjNeHkrZW7b98VEb3Y64QRysk2eojhh9WwcXeTHfS
         2Faa3qXfWKQEjBzukIEqTHNFsHdzkXivWZiGP2EsM+v6Up8HG4YZq4p/5YLRwp5J1ejN
         UvV6bAKK4yWMAF4w5Rncb10+HhQwxPmm73KQwvgOxV6oBrKieEi/TdWtLqLrm5q2gq/d
         k/cfXtrSfh211MTzA1IIWFKJAxnGPDhTRmrWpPlSea3Grd2o7NXIyRHGNC/1KZ1U7RvD
         ezQvx0pf52VDLQhePq/VcD0LzU4xiHyTqZhsBLLrn6lANifvfvQSOsseEaSkj4X3LGfW
         YiHQ==
X-Gm-Message-State: ACgBeo1O6f5c/5ioQZ4FkIM/IkUZSQdJ+KOJC1Btp0JyTA7Y2wHplSCo
        y4SbTeCQi2a0566VHF+ampNdUg==
X-Google-Smtp-Source: AA6agR6CrTnN/jL30qM2oy1chzWlwWkFSKzElgaz5C6XKHdy3uLj5jrCJc6y5+wmuCf2/Doyz1zYhw==
X-Received: by 2002:a05:651c:511:b0:266:c941:67ca with SMTP id o17-20020a05651c051100b00266c94167camr3956347ljp.28.1662737588111;
        Fri, 09 Sep 2022 08:33:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a2e8551000000b00261d6f45c2csm113367ljj.124.2022.09.09.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:33:07 -0700 (PDT)
Message-ID: <47eb92fc-f5ff-de82-aacd-91aa0fcc68cb@linaro.org>
Date:   Fri, 9 Sep 2022 17:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/10] ASoC: cs42l83: Extend CS42L42 support to new part
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-10-povik+lin@cutebit.org>
 <541b11a1-6b5a-cae0-73d9-f1fe8c961a15@linaro.org>
 <822926B0-CF33-4FF0-B234-8EF644DCED21@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <822926B0-CF33-4FF0-B234-8EF644DCED21@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:10, Martin Povišer wrote:
>>> +};
>>> +MODULE_DEVICE_TABLE(of, cs42l83_of_match);
>>> +
>>> +static struct i2c_driver cs42l83_i2c_driver = {
>>> +	.driver = {
>>> +		.name = "cs42l83",
>>> +		.pm = &cs42l83_i2c_pm_ops,
>>> +		.of_match_table = of_match_ptr(cs42l83_of_match),
>>
>> This should complain with compile testing. Usually it comes with
>> __maybe_unused/
> 
> Which symbol? cs42l83_of_match has maybe_unused.
> 

Ah, I missed it completely. It's fine.


Best regards,
Krzysztof

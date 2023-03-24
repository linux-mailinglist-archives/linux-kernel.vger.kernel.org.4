Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58476C7818
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCXGoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCXGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:44:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB955BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:44:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w9so3969181edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679640282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCX/SFYH/vwWzfLjx0NaL7F5JK5dcabJ3U2Bkjqieto=;
        b=VQcF+cyCC1f8OrBQq8fWy7c7wZ0CwMWosRl6X3GKeEVMv53aLT1LLpK07Fb8P3k7hE
         xJsfaDi9M2z0/td6Y+9/+rwp+o9FnmkyrnjzRcv/8ynsw8yup8oAw09c0DUuxzYAPR2b
         kUvVhTjHfSrZyBea4+snXIQyDgSxdkW4mgD5um0xvRCdy+haLAazQ7t46fZpL+nGDuk1
         rYAUX65wCYgY8Gvq8jLaGnifR+p4OFc6jEbM4o0Y94kkTM5PXm8aFW8TwXMkoQWzD+X1
         Vs7VY2XUQqGxqhSWBurxz73sgunhDVX2ki1m6AB4iWTCdWJ/tvr02vkLgnwRwlJPMvd6
         uRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCX/SFYH/vwWzfLjx0NaL7F5JK5dcabJ3U2Bkjqieto=;
        b=NBgTGdrCL2mJaQGOGeOEY1itdm/rVBAZ23TUhSLrcp66h4UcWhjHr0oMQ9m5YDGVHl
         FRvCih3fenjuPVrXM2pEo+vQFvGUXt1XvOEhI0s8dX2dp1vqpgx6gNpOSXqteDYnzz20
         RF+cRkg0lJmB9t1BPhxp9K9eLNzGqctmZ/BqWBQn8vbePDQischgJQmELUngjx83tX+m
         FbNEVo4GVTI7Bp194038zhNhIMA53J5/SNzLHqXzdycEslM6rSUuU08PlvYgeypxggzp
         VUC1OuWnmAF28iOSST8XJ71VPKQYx3zXOxPKBPBcs1KSOviyKoYvi8X1yvg1RemTNS0a
         vzUQ==
X-Gm-Message-State: AAQBX9fzpEdv/v90GtJS8R87Sn9WJWw/98lP6Wz/UPE3C5C5VbVKrgst
        SzmaqxdqRzIMAnt1jjS1TK4R0g==
X-Google-Smtp-Source: AKy350aHpVcS7kolMKTfZDwzBvwwMj2QB/Cak9w9IiM0iWmf6V+KHjzNTHdojkbwziWSVqs47kZtrg==
X-Received: by 2002:aa7:cd9a:0:b0:4ac:b687:f57e with SMTP id x26-20020aa7cd9a000000b004acb687f57emr1798860edv.1.1679640282078;
        Thu, 23 Mar 2023 23:44:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm872205edc.29.2023.03.23.23.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:44:41 -0700 (PDT)
Message-ID: <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
Date:   Fri, 24 Mar 2023 06:44:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2023 17:07, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 04:44:02PM +0000, Srinivas Kandagatla wrote:
>> In the current setup the PA is left unmuted even when the
>> Soundwire ports are not started streaming. This can lead to click
>> and pop sounds during start.
>> There is a same issue in the reverse order where in the PA is
>> left unmute even after the data stream is stopped, the time
>> between data stream stopping and port closing is long enough
>> to accumulate DC on the line resulting in Click/Pop noise
>> during end of stream.
> 
> Wow, that hardware sounds *super* fragile.
> 
>> Moving the mute/unmute to trigger stop/start respectively seems to
>> help a lot with this Click/Pop issues reported on this Codec.
> 
>> +static int wsa883x_trigger(struct snd_pcm_substream *s, int cmd,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		wsa883x_digital_mute(dai, false, 0);
>> +		break;
> 
>>   static const struct snd_soc_dai_ops wsa883x_dai_ops = {
>> +	.startup = wsa883x_startup,
>>   	.hw_params = wsa883x_hw_params,
>>   	.hw_free = wsa883x_hw_free,
>> -	.mute_stream = wsa883x_digital_mute,
>> +	.trigger = wsa883x_trigger,
> 
> The trigger is run in atomic context, can you really write safely to a
> SoundWire device there?
> 
> This feels like we should be doing it at the framework level, either
> tightening up where the mute happens in general or having some option
> that devices can select if they really need it.
That makes more sense, I can give that a try.

--srini

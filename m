Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A4725AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbjFGJhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbjFGJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:37:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF461FF1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:36:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso33380235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686130602; x=1688722602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uusdi9NyZqH+4XykGUPpTlNUQQewoUsasR8qvPU4tuE=;
        b=yDyHzNuBaw1TucGZ+SQX1GRqIUhxFfugr5lx4DYLakMuAZQIr4dsGh6XFN8lqUZEBV
         lDPGLCvJFyi5cZJkbu3Ji5PK3xVte+RAp5vlbbNOMEZLVHaBQkCcr9R3lbjTVRxvtsBM
         W+90Ve1RNJjxyo/vjIZtNY9XQrvkMSNuzXFS5sxn1fA9wmZwh4orWuIpyN4fvgAdFTY+
         ZbYrzDm/CK+mlQTaD2iOGI5bf6IAOxSRBYrNCoq7UlPhzcGlRyqEgTmz9c7YymxPL9/C
         Id5Tfy+THCUB1EghpzieWfNjDDAq0SbOkEeBjRP2LcS3b2bNKPTCu/L7ov6qC+/uohKc
         F+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130602; x=1688722602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uusdi9NyZqH+4XykGUPpTlNUQQewoUsasR8qvPU4tuE=;
        b=br8AMtqhJKVxG6C95qdbD04lEkcG7Sww0HS4LEHAB0LhPdiF7alvL3Xa5GFElYnnbw
         eAieuGgKvdU148oHckZHApik13CRMTKiYaIHBjkPJaBkTIj73y7TSEeev2GJ2vx56+jA
         rCR+/fyCGUKpuXKiIYO8z7rHH6g+Du0rNYfOOTjDQEN1TfYFh79FPz8Ya+8YHRXMKAlD
         faUoCtNnJc8g9bXEQZtuuZvzEOcybII19HZP/0Itultuku5/14V7si3gU1BWHobw/SOv
         YIMDeWMNMRltyx6a8NzsFDpC8o3qpkE/+oAV1P6V4Hwx0/UufV4FnbdrX3LhBZOPVbQg
         IQjA==
X-Gm-Message-State: AC+VfDwTSC7PFNSZuQpP6RRw5OZg8nDdAV/erGFL+Acxot5fhEOSRpa/
        JlxxZHDpXiuEaqciWS8q+4DxJw==
X-Google-Smtp-Source: ACHHUZ6P6/DuMu8DxYUDW/YBCvycHYo0qaPj8RiltXuvqGHDvtUQHEwff2rgy4PsUKrAevxyaV0D9w==
X-Received: by 2002:a05:6000:d1:b0:30e:46c3:a179 with SMTP id q17-20020a05600000d100b0030e46c3a179mr3906921wrx.30.1686130601877;
        Wed, 07 Jun 2023 02:36:41 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d8-20020adff848000000b0030ae849c70csm15019251wrq.37.2023.06.07.02.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:36:41 -0700 (PDT)
Message-ID: <5d6bcc6a-151e-ac21-2dd2-f72a91f562d5@linaro.org>
Date:   Wed, 7 Jun 2023 10:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
To:     Johan Hovold <johan@kernel.org>
Cc:     vkoul@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 10:08, Johan Hovold wrote:
> On Thu, May 25, 2023 at 02:38:08PM +0100, Srinivas Kandagatla wrote:
>> During x13s audio testing we hit few corner cases due to issues
>> in codec drivers and some obvious code bugs.
>>
>> Here are the fixes for those issues, mostly the issues are around
>> devices loosing the sync in between runtime pm suspend resume path.
>>
>> With codec fixes along with these fixes, audio on x13s is pretty stable.
>>
>> Thanks,
>> Srini
>>
>> Changes since v1:
>> 	- dropped runtime pm changes patch as unable to reproduced it anymore
>> 	- fixed clk stop flag as suggested by Pierre
>> 	- rebased on top of linux-next
> 
> I tried to update to this series on my 6.4-rc5 branch for the X13s and
> the above changes appear to lead to breakages again.
> 
These patches are based on linux next, we can not cleanly apply them on 
rc5 i guess without the depended patches.

I have tried these patches with your rc4 branch along with other 
depended patches my branch is at: 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wip/sc8280xp-v6.4-rc4

this works fine for me, not seeing any issues so far.
tested both speakers and headset.


> Specifically, with the updated clk stop flag (simple_clk_stop_capable) I
> see:
> 
> [   14.789533] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 state check1: UNATTACHED, status was 1
> [   14.789717] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
> [   14.796164] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 state check1: UNATTACHED, status was 1
> 

> and without the runtime pm patch that you dropped in v2 I get
> intermittent (e.g. twice in five boots):
> 
> [   11.527301] snd-sc8280xp sound: ASoC: adding FE link failed
> [   11.527409] snd-sc8280xp sound: ASoC: topology: could not load header: -517
Never seen this, looks like some corrupted tplg to me.. I might be wrong.

> [   11.527557] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> [   11.527640] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> [   11.528079] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> [   11.533388] snd-sc8280xp: probe of sound failed with error -22
> 
> Again, this was with 6.4-rc5, but these problems are likely still there
> also with linux-next.

Have you tried linux-next?


--srini
> 
> Johan

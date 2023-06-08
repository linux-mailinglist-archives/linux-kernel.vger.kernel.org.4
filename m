Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C52C727C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjFHKBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFHKBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:01:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CF26BB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:00:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so530781e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686218455; x=1688810455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsOWfs49wC5N4v4NWtXmUnjFbzqZWXOVySuGPn3htMg=;
        b=4tyzkukruKe8ZPA7RPnB00YrCnc3YfBJt40uG0nLFHL/S2MxEM1ID/0mg1wM6qR0Ap
         O6/bzxhLWfWakDYYZSaELapb2cid4mN9Qnf2sxD64w4Inu9p5V0q7j0Kb3j5FjK6MiEi
         9rSVcTKSTVnpx2CbhZ1k9pwKoDK+tf+kjFRRemHmgKPM8VlM5XJXahH2nLusHzlp1cL2
         lJ+1UPZmC9MQjEgSw97kO1BYmj2wLUR5IIp58Ih7u9fTwzaxTuQ6ZQQfqXUg6UNVatUT
         AKCn8JIS+6M9f9RI39+UNwbBbt1dKCMmz6jGVlDbdIifcAXhzBsnbyl6U4DkjmiB+V+E
         C6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218455; x=1688810455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsOWfs49wC5N4v4NWtXmUnjFbzqZWXOVySuGPn3htMg=;
        b=A1f+t+mT9UxXcRBPLOhgXs2uL+g3c5o6cx1pbSljp3JWjDlHP6GfAfQM2YXSVR2spz
         CeFz49kV/AnBdg/s1WYOUT5OpivMxBwIdw24w2gprYzXMDupaZgtfd4vZl8Ox06XT4W+
         g2L4QJIQssTkL7srdBHVrsaN+jdE/IHgZQnyQJRnAzhV8WDxxryDS+5XH6g+SYxwft2U
         CXHk5O5P/tM5XZ7QyrKOewpQdctdhavcudPFujCYQnE6Afud8FQ2Xj7UkRHVGAcJ0aYo
         xaGZ2jpJhh5zIJfhsobSS0KfX1sVRmFS8J8tQGika/OAj29k/yk0mbgITknBR0FzKfrg
         vaFw==
X-Gm-Message-State: AC+VfDxaVzF01nwEc2bHCsA5uMNrhpuQoKO3ns8ZYmBWXSUthP2doi9C
        W7yPHOeDnuW7xC2LKb1Vzr0tjA==
X-Google-Smtp-Source: ACHHUZ7LlWK64M5lFh/5PM74dhnqSCP79zYgwvl4PUklZhQtn1sfsWVhk/BVkBSv4bhXZyQ+/Lckrg==
X-Received: by 2002:a19:a40e:0:b0:4f1:4504:2679 with SMTP id q14-20020a19a40e000000b004f145042679mr2891573lfc.41.1686218455474;
        Thu, 08 Jun 2023 03:00:55 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f60eb72cf5sm4786261wmc.2.2023.06.08.03.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:00:55 -0700 (PDT)
Message-ID: <f4547bf6-5e95-331b-5d8e-b6d71209859d@baylibre.com>
Date:   Thu, 8 Jun 2023 12:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-6-angelogioacchino.delregno@collabora.com>
 <8bbbc852-6139-29d4-417c-a2d9c77c192f@baylibre.com>
 <a8b454e3-dded-02d6-b97a-6a7aa3420cf1@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <a8b454e3-dded-02d6-b97a-6a7aa3420cf1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 11:57, AngeloGioacchino Del Regno wrote:
>>> -    int test_done_1, test_done_2;
>>> +    u8 test_done_1, test_done_2;
>>>       int cycle_1, cycle_2;
>>
>> Shouldn't be unsigned too ?
>>
>> I'm wondering if it would be better (probably in another patch) to 
>> change the data type of the other variables too, to match their 
>> use-case. (maybe it's already the case, I'm just wondering)
>>
> 
> In theory, yes, cycle_1 and 2 should be unsigned, but the signedness of 
> this
> variable is getting used in the calibration logic later, as in the for loop
> they are both being reinitialized to -1 ... so I couldn't just switch 
> 'em to
> unsigned.

Understood, thanks for your explanation.

-- 
Regards,
Alexandre


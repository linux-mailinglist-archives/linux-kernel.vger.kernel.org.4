Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04963607773
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJUNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJUNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:01:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5826C1B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:01:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g16so1560615qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay0BwQVxXYd11MLMY4UmBn6pitnaH3n5lE3Hb7RD3Hc=;
        b=kmyxDPydcBx0CVsCnA7v6iqB+TCp+iMAk6qhEq1KREqtDNZ28OOWJQihXev3bxeW8Y
         2yotgIYRQuc+QP/0NaYCC8B15hcer8ZcP0J3NGbT6PYQzDkfnigMvvaipRmztVNKPozk
         Xb3UA+oXk/le5Z4fyOYG+8CJYXO4l8068PqoBxRX0MnD9F7IrV+LrRBjWa160abz/tC5
         78dkXrDrV8dtg7Dqhn+nXleHpmbReRjIR7OUR5grnSCGVv8HGnF63z42A5SBZqeSA00+
         wduP3hs/5ZbTk9bW1ex5JwRFaeqy9v6Nw7iabbM4ldpHdwFMxeyX1aKYYx0hs74aSxQK
         NcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay0BwQVxXYd11MLMY4UmBn6pitnaH3n5lE3Hb7RD3Hc=;
        b=BJxK9DmEUpN56WNJnFX95DhFLuB+sTc6+bAKRk0rwRCHlXpTB8E1BM/vU5sYY/0d/7
         rq1cCKd5ficz+OQLR5hxCEJgEAaJt3p7OMwdjMiPZUQa37zdnv0sCkc5VAAHwhaGDRmM
         XCLvd4l7LUcoeVJhK/D0/HywmhBF3I7dXs/u3/CSFxctDjcv9WAbUsD6+8ceflKsCEN7
         hItMgM0xMixcA5N7+hFkCt3PJn4sHm4osOjh6Y/Gvl47ImCG+DZA1mozP5H/+8XgktX1
         BJ0kYtsQdYRWiBDF40JrYl3NJx8OYFdCHsYjSQA0mzfeLl3/zX1oQ7EoVrjjKUUBJvYW
         m2pg==
X-Gm-Message-State: ACrzQf0jA/3EKW86eFazZy+lwQ+3+Gjpo0dvr4iAK/rVcVzGDnX1vnRp
        bCsPP0t1WKvDGvAd+yTp7D3pJw==
X-Google-Smtp-Source: AMsMyM57YKDsmpxT2R9I96Bphr46QmYThVVpP/MkJngBFFJ9P7c3jcxqhDYYorS13cmc31e9sdMoWQ==
X-Received: by 2002:ac8:59c2:0:b0:39c:e3b4:1265 with SMTP id f2-20020ac859c2000000b0039ce3b41265mr15515785qtf.55.1666357300726;
        Fri, 21 Oct 2022 06:01:40 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bm34-20020a05620a19a200b006ce1bfbd603sm9362091qkb.124.2022.10.21.06.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:01:39 -0700 (PDT)
Message-ID: <22272f56-ba55-5725-2dc9-8012e5903eeb@linaro.org>
Date:   Fri, 21 Oct 2022 09:01:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
 <20221014102151.108539-6-p.rajanbabu@samsung.com>
 <c11f92be-1d86-17e4-e3bb-05e7b17d5fc8@linaro.org>
 <04ba01d8e52a$0d55bee0$28013ca0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04ba01d8e52a$0d55bee0$28013ca0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 04:49, Padmanabhan Rajanbabu wrote:
>>>
>>>  	cpus {
>>> @@ -809,6 +811,42 @@
>>>  			status = "disabled";
>>>  		};
>>>
>>> +		tdm_0: tdm@140e0000 {
>>
>> Node names should be generic, so this looks like i2s.
>> https://protect2.fireeye.com/v1/url?k=2cfaa5af-4d874de8-2cfb2ee0-
>> 74fe485fff30-cb16acc0c0c574e9&q=1&e=fc8e3b54-a0ef-475e-a4f2-
>> 83626a86ac8a&u=https%3A%2F%2Fdevicetree-
>> specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-
>> basics.html%23generic-names-recommendation
> 
> Thank you for the link. I could only find audio-controller in the list and
> not i2s. so I believe I can use audio-controller node name. Please correct
> me otherwise.

All I2S controllers use node name "i2s", so if this is I2S, then use "i2s".


Best regards,
Krzysztof


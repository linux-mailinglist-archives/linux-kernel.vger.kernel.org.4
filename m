Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41D6E4D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDQPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDQPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:43:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188F49E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:43:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50674656309so2738558a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681746185; x=1684338185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJYJw6tWsqkpdYQ4hdNlQoYrkpeQHw5VAulU94/xuYk=;
        b=jeh7WSne0PW0CUOQXsjmdihDXbZKk8wM38WNp/ff41gAXcfZWMVyDwdXh4WwET1qc5
         8HVNn3IiT+COZLWyk2wQowoUIofdkaa0Ftciq8KLVYVwnWnnVmTkAgWujtef5AnPowaX
         iDCoGRPiFsTBpBKbf0Kl31rQFmA7sgwQ3RSTUJZbi2V3bT89ZeIfvI6PBIn5ZMk8cjHZ
         gBvzmxtZ3SvQGz9ExsujLCQZz2ofIReOnmqozb7pT9MOXlDVciO1rLplV6I7DW/gDCOG
         sBqS5Fp5qRYFrMpWVJ2Wer1XFSwlm1XF46r7rCvM8OJ13tqTg78NkLdRBbMi4KOvAksu
         J/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746185; x=1684338185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJYJw6tWsqkpdYQ4hdNlQoYrkpeQHw5VAulU94/xuYk=;
        b=AHvSd4KRPB7j9Kh16Zg2ODzM6MKG8UQ9umftlNaX1XisPviV8y7WErOJntmtj4Q9bA
         ED0wojqKk8+kvFxmZXQCP2VMwrtyoDUrvkpKekp9aq/z+ZTLE/+edzMZAl8uWtzc07ad
         Mm3T1p/Ejg7DCUHm5K2kDn8rqrpTkUjbVSMiqs5Gytnsr832xo6tUYpL9DxLJBSjyhq4
         k4biA8eo+kxj/pzyzJagOHZMxIc5lR9JyOQ/2ucDMkAOMGoW++ErYDpv5lJcETD9oADT
         /egd+4oflZRcAR7mbq7a3NTSrFpRQHknZvq5WbAl5vadzLtz7GLz+IrxRdPLzHFSYgJA
         EBYw==
X-Gm-Message-State: AAQBX9eTbWGHaYQhUH1tVDNOhmCwdYNbvBwzRJCW7PXxNXzmTSb4zR30
        6l/lEXJyEDmz7jTkzSPQdGMq0yd9TIDWXC5XzcCtVQ==
X-Google-Smtp-Source: AKy350aAG0b6vPN6e0SzhfdEAz6qg8I09AqiwZG7XGdDNenjTcn75aJ783EEkyKfulx8SVqsIWPqiA==
X-Received: by 2002:a50:fc05:0:b0:4fb:5089:6e01 with SMTP id i5-20020a50fc05000000b004fb50896e01mr16436227edr.6.1681746185120;
        Mon, 17 Apr 2023 08:43:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7cb51000000b004aeeb476c5bsm5894871edt.24.2023.04.17.08.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:43:04 -0700 (PDT)
Message-ID: <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
Date:   Mon, 17 Apr 2023 17:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 17:33, Mark Brown wrote:
> On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:
> 
>> Code can be a bit simpler with dev_err_probe().
> 
>> -	if (IS_ERR(wcd->if_regmap)) {
>> -		dev_err(dev, "Failed to allocate ifc register map\n");
>> -		return PTR_ERR(wcd->if_regmap);
>> -	}
>> +	if (IS_ERR(wcd->if_regmap))
>> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
>> +				     "Failed to allocate ifc register map\n");
> 
> This is a functional change.

Hmm... I don't see it. Return value is the same, same message is
printed, same condition. Did I make some copy-paste error?

Best regards,
Krzysztof


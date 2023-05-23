Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9565E70E381
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjEWRNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEWRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:13:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CB9B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so783635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684862007; x=1687454007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOCz9RmdVTOhhgpghZZJPcHjAiJmOglm8+PVBiqiJ8M=;
        b=JTmAXusTTWbezv+kPsqc/VpadaF11BibQj/KIeC96y9uQq9onicO38T4JD9dwJPb2q
         ZH7lOkREYl3UKh+dvdB9buIxpLqZsrPl3NQ4DP5rRWPfWHUHfnDKRsj7SjSENgxjGG2V
         JCBY3qvDGHvDRexp1ap9XNwVujjRZ4XcqdaKyuDRRo5y8tuPHQVc2zu0/7/QQ/G0GkX/
         s+NzAXQU4P8GP5b8d1Qtlj7szLyrQfKHsqHlXp0/jy4hjmHIVxUg5oJ/TfBewcJUD5AD
         4vGxVDKTvz8vN5AMujK+A2ZoW1+5Fv6zxrzFWipcousRaGPwmWRHlaOmPwHnt+FO4KfN
         THYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862007; x=1687454007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOCz9RmdVTOhhgpghZZJPcHjAiJmOglm8+PVBiqiJ8M=;
        b=Al16aCm6SzAAQbTtQtD9FyJ+AGDgWqxkUbCRtX/iXkWI8d2bsAvJccsz1OtGXqNtFq
         MzAtg0ei01hDuSspw2XAO74XagyyWibXaKwglPWqr+Y5wjxLHInv7Tc7ZUOUDyz4Y9U2
         Sfc4eu7EXsKzHNiNH/dNR56yrTysegN7Tftt/Dh5h557rHZm5JSOaXRiqyPFYP3xuy2o
         pc8glzExgLsM7NYqlI4INgi3BUXH2TZvd4q7nSHzeknEJV85a3NFRnLQbwYe9xLLB0qE
         TVEhOY/VivomWJxBL2N2+tBoyLOm8l9bJRhN3VD9yfWVUsHv4w7ml0aWx0p4+HBFt0/v
         7IxA==
X-Gm-Message-State: AC+VfDxfjIPL20vaUHclyDPpf3zSnR8ilyiV8lJPmdKLuvTSD575uuu2
        eQDrKGQ/lzEqPGVnFRizNRR9PBJEw1qwW19Qu9I=
X-Google-Smtp-Source: ACHHUZ5WSgfukiscV+11TkJVeTmzV96VC51JBJR1AfJN9Q4/xg4yAEFQ1pBpwNuiqAnOJ217YowYmw==
X-Received: by 2002:adf:f8c4:0:b0:30a:9cb2:badd with SMTP id f4-20020adff8c4000000b0030a9cb2baddmr2525866wrq.46.1684862007071;
        Tue, 23 May 2023 10:13:27 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a9-20020a5d5709000000b0030922ba6d0csm11587461wrv.45.2023.05.23.10.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:13:26 -0700 (PDT)
Message-ID: <1f34ca48-75cc-d824-2230-7375146ad970@linaro.org>
Date:   Tue, 23 May 2023 18:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
 <dd2d2484-13f9-4fa6-85d2-5a540f137b3a@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <dd2d2484-13f9-4fa6-85d2-5a540f137b3a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2023 17:58, Mark Brown wrote:
> On Tue, May 23, 2023 at 04:47:47PM +0100, Srinivas Kandagatla wrote:
> 
>> +	/* Only bulk writes are supported not multi-register writes */
>> +	if (config->can_multi_write)
>> +		return -ENOTSUPP;
>> +
> 
> This doesn't seem like the right fix - I'd expect us to simply choose
> not to use multiple writes, with an additional flag/check for bus
> support.
Is there a way to check if bus support multi-register writes?

All I can see from the code is that regmap can_multi_write is set based 
on regmap_config from device and write callback from bus.


--srini

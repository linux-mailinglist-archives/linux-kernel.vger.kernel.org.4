Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EE6246F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKJQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKJQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:29:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A025E89
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:29:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so3020185wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfC4NHpLNHNhyzTRF08RCCNRW08u9pH3N3PQO7wb+1M=;
        b=V2jTfLGxiiq84cKzlumki7lFSEFp7dsN8FYPyooBltSUNqqmalNRDy5W1gF/Aa3DWC
         l/ZbX3t99QrB1zfuhkQx8fraZ1E9vDcyEVCCIAwxBZYPH9BbJkaAgN2tQV5ElE5rIPS/
         OBkdViYmfecftzkRXHmSOWFDlvMQm89tJbSiCTa/fgcI0EPRdZlSi0POgvwuBTT9oh1M
         kuTaHPenNQg6+n+59LCw9J00OUR2/18ThvBPr4JhxWFvaUK12TumvLwtRZXwn4VeYvfW
         yE8R+pGQBIPXBQXzSyCG1XIZFnB99NhcxOzwCKgqA6sQilfhGjFMoAAywOw1394z07Gk
         LZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfC4NHpLNHNhyzTRF08RCCNRW08u9pH3N3PQO7wb+1M=;
        b=vV3A7rmSkDmteAz0BMmzERnmuDIlsWQ6NsWw4618mj0W2xGw1ULS7Fyx+PGdRcNtqB
         IHzltZSYAgj55lBnoAJ+xr8hMcYsCh4quUhibrrSwBoOpPLBAUwmZfDD69NNWo9Rm7U6
         QMLN/tLS0JqgDIM62dy+eVx+bwVFBMa1FhSVAQK7fF71NdkEgitfM2j1q8MD3kLWXD2C
         bPOm+0Czl8ikccG62Pr9sZsMRbCqDUocWbusJ83qEsd1LzNtlSg31hNpz8u79Bv+RAS3
         nHrB8OsYph3Y1C5a4VOzbLbVrxrg8YciudU/haJmJx4OEhTYnWA3ZdVDXve4f43XcRzE
         umFQ==
X-Gm-Message-State: ACrzQf2b94zW/0m+IzhRuboWZJNKKOsnkLd/IiGAggFrEXGw2E1CR2PC
        2V/A/TlucbDtUYx2hQn69kWhNHwptyOhNw==
X-Google-Smtp-Source: AMsMyM7XA08kW6jyaU7dizex1ODQIaRk//DoX+x3pvH2goOLsg+1/TkGbzKzNU1gDR1iidfE2EdzRQ==
X-Received: by 2002:adf:de8d:0:b0:236:6087:e07e with SMTP id w13-20020adfde8d000000b002366087e07emr41926568wrl.533.1668097783813;
        Thu, 10 Nov 2022 08:29:43 -0800 (PST)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b003a83ca67f73sm93592wmq.3.2022.11.10.08.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:29:43 -0800 (PST)
Message-ID: <9600a696-c3dd-acc5-3489-569c1590f224@sifive.com>
Date:   Thu, 10 Nov 2022 16:29:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 10/10] pwm: dwc: use clock rate in hz to avoid rounding
 issues
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-11-ben.dooks@sifive.com>
 <20221110154214.pnv7rqsftomhqvmk@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20221110154214.pnv7rqsftomhqvmk@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 15:42, Uwe Kleine-König wrote:
> Hello Ben,
> 
> On Thu, Oct 20, 2022 at 04:16:10PM +0100, Ben Dooks wrote:
>> As noted, the clock-rate when not a nice multiple of ns is probably
>> going to end up with inacurate caculations, as well as on a non pci
>> system the rate may change (although we've not put a clock rate
>> change notifier in this code yet) so we also add some quick checks
>> of the rate when we do any calculations with it.
>>
>> Signed-off-by; Ben Dooks <ben.dooks@sifive.com>
>> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> ---
>>   drivers/pwm/pwm-dwc-of.c |  2 +-
>>   drivers/pwm/pwm-dwc.c    | 29 ++++++++++++++++++++---------
>>   drivers/pwm/pwm-dwc.h    |  2 +-
>>   3 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
>> index c5b4351cc7b0..5f7f066859d4 100644
>> --- a/drivers/pwm/pwm-dwc-of.c
>> +++ b/drivers/pwm/pwm-dwc-of.c
>> @@ -50,7 +50,7 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
>>   		return dev_err_probe(dev, PTR_ERR(dwc->clk),
>>   				     "failed to get timer clock\n");
>>   
>> -	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
>> +	dwc->clk_rate = clk_get_rate(dwc->clk);
> 
> Given that clk_ns is introduced only in this series, I suggest to make
> it right from the start.

I was trying to keep the splitting of the driver and the clock changes
separate to make any possible bisection easier.

-- 
Ben


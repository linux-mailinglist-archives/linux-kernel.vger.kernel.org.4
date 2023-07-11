Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9374E453
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGKCiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGKCiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:38:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2B1A7;
        Mon, 10 Jul 2023 19:38:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66c729f5618so4513247b3a.1;
        Mon, 10 Jul 2023 19:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689043081; x=1691635081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htK6Bx0YCX3ljGdkzfVf6E0G4Hzps4I8C/q4/N4Co/Y=;
        b=dFTYRLBLesQns/vTHsOTuKgEnbf5vD1yo2pnnaDlcOrxBuKZBfEin2BqTXsjyn5m11
         e5PcbiEjzXSvm5g3YftFO+Et2I6r2jkEvWbZWRufBtiWueZxCoXkB4zfQPMHtpycdU3V
         iOe4coMKyggefDEeivoqd9bR28K4zxwk47waMmX+RIH6PBXekQPncePGffNhb2cyQy0W
         51AS0V4CTlRT/7CtsSsjw035i0PMYFXO76zPoVqdjGdFw0Y3DwTIxulD21Tl/dKuioc+
         X2q4jAoimJD3AVcEaF1L8mHrEG/E6VigprIMKf6Lid6m53XgLOhwDt9EDysHJ7OC5eEB
         JtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689043081; x=1691635081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htK6Bx0YCX3ljGdkzfVf6E0G4Hzps4I8C/q4/N4Co/Y=;
        b=P0WlOaN4FoDzRNjeN8vFAtYMx973Sik629I47Wtc17KGZw4YNXKxddV/+1pq3vAb0q
         Lq/E7ytPne6BFpnB2M+fqP9kxnX0IOtwSYpTP7+/iKbNPb+oKBg66RulwdSUigaLNlGH
         3b2gy1tkL1IoolE6ZQH193hSKw2635b7nN182ob1i4TkebqZkDKAKI2UD4/p+DkWM7nl
         xMcCMXx1jml4maqN1/g1+N0ZqJLHz8Q7Hmy6+slEeKJyPofQDWi3v6dBiuM1xDEkp0Y1
         twsNR8/NoE0nCsNHC0HwUlZbDzLTcEvQwBzKiXDJmTEFpU89cvaeFSwcZYU73EFmS2iL
         JGzQ==
X-Gm-Message-State: ABy/qLYr2r2RgOFBLoj7VUzTwKvCOunJ3SCrk4eK8RiJTw8IJbMA1dJi
        xNFvh2xvOgZ0b203iULB3PI=
X-Google-Smtp-Source: APBJJlFyqpNvpjyWMkSgCBs56NolCZ6kjbi9TzFP1tATzdIaVFCoW87MTW0QGusgaHKDx6LCy/sQpg==
X-Received: by 2002:a05:6a20:1611:b0:12e:d8ee:8f2e with SMTP id l17-20020a056a20161100b0012ed8ee8f2emr17520294pzj.27.1689043081477;
        Mon, 10 Jul 2023 19:38:01 -0700 (PDT)
Received: from [192.168.220.128] ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id t16-20020a62ea10000000b0063b898b3502sm456948pfh.153.2023.07.10.19.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 19:38:01 -0700 (PDT)
Message-ID: <177ff5f0-3f99-646a-69b0-72c51fd1db25@gmail.com>
Date:   Tue, 11 Jul 2023 10:37:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] pwm: atmel: enable clk when pwm already enabled in
 bootloader
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710144214.63343-1-aarongt.shen@gmail.com>
 <ZKwdHUWzXujfVk0R@orome> <20230710191550.7y6wukf7w44us4pd@pengutronix.de>
From:   Guiting Shen <aarongt.shen@gmail.com>
In-Reply-To: <20230710191550.7y6wukf7w44us4pd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:15:50AM GMT+8, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jul 10, 2023 at 05:00:45PM +0200, Thierry Reding wrote:
>> On Mon, Jul 10, 2023 at 10:42:14PM +0800, Guiting Shen wrote:
>>> +		err = clk_enable(atmel_pwm->clk);
>>> +		if (err) {
>>> +			dev_err(atmel_pwm->chip.dev, "enable clock error\n");
>>
>> Might be worth to include the error code in the error message to make it
>> easier to diagnose where the issue is. Something like:
>>
>> 	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %d\n", err);
> 
> Or (IMHO) still better:
> 
>  	dev_err(atmel_pwm->chip.dev, "failed to enable clock: %pe\n", ERR_PTR(err));
> 

Ok, I will add it in v2 patch.

I also found that the clk_enable() of atmel_pwm_apply() do not include
the error code in the error message. Do I also add this in v2 patch or
in separate patch?

-- 
Regards,
Guiting Shen


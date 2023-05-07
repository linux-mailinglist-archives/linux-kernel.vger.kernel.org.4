Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570066F999B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjEGQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 12:13:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF738A4C;
        Sun,  7 May 2023 09:13:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f139de8cefso23812422e87.0;
        Sun, 07 May 2023 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683476020; x=1686068020;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ+ZIAc03rR20rZw4pK+Hn7hNpvlDRNOeK5+8sWq7gQ=;
        b=E0cGtgx5xeYvapC0HmolkBj/Ti1JOQYogvNV+D0dQSTZuWUdNxC7TBL1k3HjtnBRNp
         fYI+R8K/P8h/ykZBW8XpgsRSGkgtH7C/QwVU9ON8f73q/B1gBVvyV2QAtyG0t0xnjCqZ
         B4VNDzObfZYu0MNhrhA7GSlq2XbGTUNLUD88cNOeuz3sp1Oqhn5fpi7O3pToafYUFBYf
         0nXlhJIiPgGaB1orIyZmTA6VAgOaa3JHt+RRdYCC8hjvPN0qsQ8le6nnIS3vN+4PA5Uf
         5K1m6SH0HKNnY0/np33j+3v9/FXc2vDlXd42iyEFhhMJ6XYxE7jRrLAR6B8HraTXpZSA
         +JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683476020; x=1686068020;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ+ZIAc03rR20rZw4pK+Hn7hNpvlDRNOeK5+8sWq7gQ=;
        b=FGCTQHzOAgD/qLAaoMCoFe6BgMA1VcBclxBzaTOqsUPdZiJc0nGzQhypjhOLUHn8AQ
         qQjXmmUNaS2qbty44DILtGfIpGszukP7mublVxaBmrlpKiii4nbFlZkTQEE37UFKb95h
         Fm6Z4F+N5EEZKImtBtLW8WgAUxmPl5yHN/XrryKa0hAQ+oME6jksRFwDcik9jI9wDEC9
         z60rvlAI9i+yBXHy0q21fXEnvPv/ZZ//4m5YBXICD/8KiZxpTTdSsUoS/2ei7QQo3BO6
         uA8o2UHHNH1YzT7rWfQUJ6hOgl+yTiq6ZcB0NJL8J+vL/cM2dkBq9QnWz81rsrAPc76y
         NFXw==
X-Gm-Message-State: AC+VfDz5I8AbklIhmIMKXevt/ZQt7ig3E1OSDemTS/E+Au5/jbh1dbs8
        5L0H5DWtWBohtkRXVkGq0fA=
X-Google-Smtp-Source: ACHHUZ6C66+Tx/PdPCAPL1nJo49oU1OpJmr2lkOiVdtQcbkkLtM6i7BmF9w7AY3zT5qeR0TKzd4sEQ==
X-Received: by 2002:a05:651c:483:b0:2a8:e46b:9410 with SMTP id s3-20020a05651c048300b002a8e46b9410mr2047315ljc.15.1683476019938;
        Sun, 07 May 2023 09:13:39 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e99c4000000b002ad9057fd00sm219525ljj.85.2023.05.07.09.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 09:13:39 -0700 (PDT)
Message-ID: <7cafafd3-e7a7-96db-0f8f-ac5c8bc94d13@gmail.com>
Date:   Sun, 7 May 2023 19:13:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
 <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
 <20230501152014.7789aa42@jic23-huawei>
 <91463df1-5aba-484a-92ea-f8979ec30535@fi.rohmeurope.com>
 <20230507152236.46aba096@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
In-Reply-To: <20230507152236.46aba096@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 17:22, Jonathan Cameron wrote:

>>> If there is nothing to do in the actual interrupt as it's a data ready
>>> only signal, then you should just call iio_trigger_poll() in the top half and
>>> use devm_request_irq() only as there is no thread in this interrupt (though
>>> there is one for the interrupt below the software interrupt chip).
>>
>> I haven't tested this yet so please ignore me if I am writing nonsense -
>> but... The BU27008 will keep the IRQ line asserted until a register is
>> read. We can't read the register form HW-IRQ so we need to keep the IRQ
>> disabled until the threaded trigger handler is ran. With the setup we
>> have here, the IRQF_ONESHOT, took care of this. I assume that changing
>> to call the iio_poll_trigger() from top-half means I need to explicitly
>> disable the IRQ and re-enable it at the end of the trigger thread after
>> reading the register which debounces the IRQ line?
> 
> Hmm. I'm trying to remember how this works (wrote this a very long time ago).
> I'm fairly sure it's not an issue because we use IRQF_ONESHOT down one level
> so exercise the same prevention of the threads triggering multiple times etc > 
https://elixir.bootlin.com/linux/latest/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57
> 
> It doesn't matter if the device interrupt fires again as it will still be masked
> at our software irqchip level and will then get queued up and the thread will
> run again.

After reading this I am not at all sure I am using the trigger 
correctly. I see the iio_trigger_attach_poll_func() registering threaded 
handler with the IRQF_ONESHOT which is stored in the 
iio_alloc_pollfunc() as you pointed above.

The iio_trigger_attach_poll_func() is called from sysfs callback when 
trigger is enabled. So, if this is supposed to be the device IRQ, then I 
am not at all sure the driver should be requesting the IRQ at the 
probe(). If it is not the device's IRQ, then I guess the IRQF_ONESHOT 
passed in here won't help. I need to try seeing some examples how other 
drivers are using the triggers. Getting back to this tomorrow...

Yours,
	-- Matti.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


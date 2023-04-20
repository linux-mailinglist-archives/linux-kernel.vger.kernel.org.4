Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAB6E9878
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjDTPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDTPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:37:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F51991
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:37:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so7320717ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005071; x=1684597071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApdTWhhkzb3N6QPss2Yi29YN1Urm38DCu4SfJzo1FQI=;
        b=OI42D9V5yNMUvJYFnh5KZP3SfORv1nitueVJtSxwirYdvprgf4mHQfP3mWi6vxh8p7
         jc6n1kvmWxPVFwZUqRp9zkDTthsv49ZKHfZE/ajqeT7rNcDTJAWlG+uuomQ7XWcc9IEu
         69qmu/jgVP6qiE5E3U94y9VwfIpZmJ60lzZY/OZVUS1Q356VSOoWf0b0gvlLb0willLI
         +AuwkAWPd6MndKUf7NdsTNatgvsFQTn65fKFAybNM+2k41KxAP4lQl0bC1wvVHpfgAXI
         ssT8Bo0cqfePRtiDhsfpi/7am7YKWYfLUrq9/stle7KV6a9R+vVpQxY+glFEPtTnfT0U
         Cbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005071; x=1684597071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApdTWhhkzb3N6QPss2Yi29YN1Urm38DCu4SfJzo1FQI=;
        b=SQWasKDUSbRfgolAfSBkWU+hTno4ofVci0sSktyp77PyB+q0MWr7vrNZWZbnV4y2rb
         xUIb1JgCQA7ZzwoaWvhG1PO9FCmfxp6xc2im76OSAwEtajjLLnEmm0qRFiuZrqeC37ow
         Vi3N/dFGFyEgyAseAQVXeUGjaNyvKCmW0E3IkU6CCFTquzGxO7M8vRb1H2GRzfq8Omai
         RmfElQgYp+0JYcJ+C8sO+eRuID9kud+Zs5JCgQARXZcuSc+df2I0X3z9GtFXCY6VjpE1
         4O9vhLsBqscnvL4Vv74KQsmSOE7Q9C+iQXl5gb4qkfYsXIHzWQRoBDmoAlFcE+Fy8l89
         asiA==
X-Gm-Message-State: AAQBX9fsGJTO7jWRf++ap8snCJlZSatFkwRcrcDCkKppCOqH/H5lZD0C
        zyklSs5TCYS09O8lH0jWmdLJuQ==
X-Google-Smtp-Source: AKy350bolQ8RHPDEoxQ2ZB1HmmT5FLmSChLbyJX+YfSROWHK0HuITUZs/iOaI9q4WjxA9H8o4aXbrA==
X-Received: by 2002:a17:906:a258:b0:947:4828:4399 with SMTP id bi24-20020a170906a25800b0094748284399mr1991837ejb.12.1682005070813;
        Thu, 20 Apr 2023 08:37:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906349900b0095336e8e012sm865381ejb.176.2023.04.20.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:37:50 -0700 (PDT)
Message-ID: <1da788fd-03df-1704-187e-0045876f2605@linaro.org>
Date:   Thu, 20 Apr 2023 17:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd@epcas2p4.samsung.com>
 <20230419060639.38853-5-jaewon02.kim@samsung.com>
 <88e74f8f-feee-159a-3048-736a5ffc13cd@linaro.org>
 <af95919d-f422-feec-b58d-a9b8c54af6d8@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <af95919d-f422-feec-b58d-a9b8c54af6d8@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 11:45, Jaewon Kim wrote:
>>>   static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>> -				struct spi_transfer *xfer)
>>> +				struct spi_transfer *xfer, int use_irq)
>>>   {
>>>   	void __iomem *regs = sdd->regs;
>>>   	unsigned long val;
>>> +	unsigned long time;
>>>   	u32 status;
>>>   	int loops;
>>>   	u32 cpy_len;
>>> @@ -563,17 +568,24 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>>   	int ms;
>>>   	u32 tx_time;
>>>   
>>> -	/* sleep during signal transfer time */
>>> -	status = readl(regs + S3C64XX_SPI_STATUS);
>>> -	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
>>> -		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>>> -		usleep_range(tx_time / 2, tx_time);
>>> -	}
>> You just added this code. Adding and immediately removing it, suggests
>> this should be one patch.
>>
> This code has been moved, not removed.

Move consists of remove and add. Add it in correct place since beginning.

Best regards,
Krzysztof


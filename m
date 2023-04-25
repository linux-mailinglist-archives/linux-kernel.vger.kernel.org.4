Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165596ED9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjDYBWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjDYBWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:22:47 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C06AF2F;
        Mon, 24 Apr 2023 18:22:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso6325579b3a.1;
        Mon, 24 Apr 2023 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682385763; x=1684977763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzCOnSdDe4NzflKJwmQmRs4qhB7AQM3VjlX1koyoY9k=;
        b=XYh3HmSuAA0TMHWrbbQvRQ6wf+PwcSMZ+WcfBVRncUUj2gajpx7nAjXznmNU7yuRdj
         1YPxdURRTLaE89r0rN4mI/ypjs6Hm7GYRJEuag3xf2PLRRcEQI6QqdAKHA6tgiw6o81L
         X4gZduN43LJhSaNcjLqp0/ZfnB3Gu6r34nlgd2SJo+3Uwwaz86qrG+SwpQKQvxaU//g/
         etvZz9s0Fl9V1MEX8uh3fMlYbbWV1Sjx8x11McYIwaVn7/G879pkLcQz0rRJkQAI81k3
         HOtm3sWzO35Wdz1vBDiXrwaQ+gu4m3wI+GQd4CxxSJXkC2gMlrxUTm9zFf2QRfHNrGUT
         YwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682385763; x=1684977763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzCOnSdDe4NzflKJwmQmRs4qhB7AQM3VjlX1koyoY9k=;
        b=gV9JiHBISpAAxRLWRKHB8hcCDAIH0QdFSstEWQwf/SI74Idfkt/2HcX6HB+/ou3kSW
         g//v6BfTm6E+Tx+3R19soJ5/7+Ea1ehf7shKxvfReTWeoxZ4NyOG6XU7PZ3eDtmJBUuH
         UeMWoY9pcEq9AJvps8pdQ3/jRAsplSI1S7QgQ5EfkRyAQBIyHv1UvDkg5GzEi4nb4t4z
         jJm7iKa2QvaVHXDcCs8gC9puwLhSOXJJdJXdR1rxW0TZYO1+Azrfj2tJYXQXTq6FhDFe
         gGWOkVFw4MVGgE4QUdygfUrR8k1hZhuFXPgppfPV+TdZJ5XHWVCnjtE7cS45C6ha9aIR
         qqzQ==
X-Gm-Message-State: AAQBX9c9tNyBku4lT2qPrqUQBWd/dkQa+HRcAXfUMfJEHeytw7O9NXmu
        YDJqkdPnUreJ0qlid5JGX7E=
X-Google-Smtp-Source: AKy350aBde2BHNFZbp1fgmWUK27yQobJo96nQwVnDNZJOFZCiAzzL+eN2KGgBEmxPRQOxzUiYrh17Q==
X-Received: by 2002:a05:6a00:1305:b0:63d:a0d:6fa1 with SMTP id j5-20020a056a00130500b0063d0a0d6fa1mr18234468pfu.21.1682385763431;
        Mon, 24 Apr 2023 18:22:43 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00224c00b0063d670ad850sm8231690pfu.92.2023.04.24.18.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 18:22:42 -0700 (PDT)
Message-ID: <9fb8d2bf-441e-58d9-658c-d52c80e2d2c1@gmail.com>
Date:   Tue, 25 Apr 2023 09:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 10/12] reset: Add Nuvoton ma35d1 reset driver support
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-11-ychuang570808@gmail.com>
 <20230424200253.GC30248@pengutronix.de>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230424200253.GC30248@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Philipp,



On 2023/4/25 上午 04:02, Philipp Zabel wrote:
> Hi Jacky,
>
> On Tue, Mar 28, 2023 at 02:19:10AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This driver supports individual IP reset for ma35d1. The reset
>> control registers is a subset of system control registers.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   drivers/reset/Kconfig        |   6 ++
>>   drivers/reset/Makefile       |   1 +
>>   drivers/reset/reset-ma35d1.c | 152 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 159 insertions(+)
>>   create mode 100644 drivers/reset/reset-ma35d1.c
>>
> [...]
>> diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
>> new file mode 100644
>> index 000000000000..221299e7b873
>> --- /dev/null
>> +++ b/drivers/reset/reset-ma35d1.c
>> @@ -0,0 +1,152 @@
> [...]
>> +static int ma35d1_reset_update(struct reset_controller_dev *rcdev,
>> +			       unsigned long id, bool assert)
>> +{
>> +	unsigned int reg;
>> +	int ret;
>> +	int offset = (id / RST_PRE_REG) * 4;
>> +	struct ma35d1_reset_data *data =
>> +			container_of(rcdev, struct ma35d1_reset_data, rcdev);
>> +
>> +	ret = regmap_read(data->regmap, REG_SYS_IPRST0 + offset, &reg);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (assert)
>> +		reg |= 1 << (id % RST_PRE_REG);
>> +	else
>> +		reg &= ~(1 << (id % RST_PRE_REG));
>> +
>> +	return regmap_write(data->regmap, REG_SYS_IPRST0 + offset, reg);
> This should use regmap_update_bits().
>
> [...]
>> +static int ma35d1_reset_status(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	int reg, ret;
>> +	int offset = id / RST_PRE_REG;
> Should this be
>
> 	int offset = (id / RST_PRE_REG) * 4;
>
> ?

Yes, here is a coding mistake.
As the register offset was modified to be indexed by lookup table in v7, 
this
code was obsoleted.
Thank you for pointing out this.

>> +static int ma35d1_reset_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *parent;
>> +	struct ma35d1_reset_data *reset_data;
>> +	struct ma35d1_reboot_data *reboot_data;
>> +
>> +	if (!pdev->dev.of_node) {
>> +		dev_err(&pdev->dev, "Device tree node not found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	reset_data = devm_kzalloc(dev, sizeof(*reset_data), GFP_KERNEL);
>> +	if (!reset_data)
>> +		return -ENOMEM;
>> +
>> +	reboot_data = devm_kzalloc(dev, sizeof(*reboot_data), GFP_KERNEL);
>> +	if (!reboot_data)
>> +		return -ENOMEM;
> These structures could be combined into one.

OK, we will combine them into one.

> regards
> Philipp

Best regards,
Jacky Huang



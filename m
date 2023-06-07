Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF1725D82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbjFGLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjFGLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:44:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB441BCC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:44:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so7326637f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686138287; x=1688730287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZF0bWbVqQomN3DSZfJF9QrCWL0o2iDr9KrxQLP2Njw=;
        b=3RBQjFfyDmBSo1AlYjKhIdm1beEdbNpeWKrKMomP7swI46B5yjDO5BHhe1tyU1q8ky
         t1CWplL20m0oi2y9YZQhsRKLhqNOV8jqzD8AdgCtLZSYm8GaahtxsNiV6+093izidZOc
         sDjlMaU18OGfEobAFY9ZhXQMQu8vcx4i4pxIx0eHAc4xmC1VDgVQNxvtHYGYLQfJUiF/
         QwuIQvmqz5jeI2Xrq3QtoGIG3MoKh+ZsizZHQESghrYuyfnjsEveUYtFwNYgPIELhx+F
         pwQ7zAVRDv8r6l7rv6rtyfVBq9ZfWcnQY+3VXW4YVXU/C10L3zvHPz1MXI+obInazKwJ
         EHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138287; x=1688730287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZF0bWbVqQomN3DSZfJF9QrCWL0o2iDr9KrxQLP2Njw=;
        b=UWgOwNptkGTzXU/ApXXyN0ZO7vT+ees+0vbXEaujbOurJhMUf4qJQ5XtyJdCoWBnOF
         Hudv+/xXPi1HxGYbqpB8zVZoUCvtSf1O1PgNk7Sm/EsNkYAYicttqCKWMTPv8e9Z+4mQ
         TW7DXCgrhCtc8Z/8WhQqFZNkUOVi+mzEmkvZKx190o+TAbOSRAF3aDxV5f3KRzkjLoGk
         Ek7D3GMD6VG9fQkYkgfuDjeq3TFO84KkKp1gyaftn+QbqRX4jZRFqrm3+rU4TEIYPZS6
         XXDkOifiMkXzMS5YbW0juZfHKfeBe/r8n8xlUrA0JFwsnLUbSndFG6Hdfyry8xE/Dc/e
         rPIQ==
X-Gm-Message-State: AC+VfDxim6+7DEJibLtD1zP4GtNuQ+Ylpw03Omt/X+JAl7Hv/krXfKZh
        f7bmeR3TsqkvQCLCCFcvBNDoCA==
X-Google-Smtp-Source: ACHHUZ4ag2NB29YmYf2NEyem1AS1fBVfRnebEHbs1kVzFKODnpHwBnsEXbEBUs2kQ3ajwzKCBP//Cg==
X-Received: by 2002:adf:efc7:0:b0:306:26d1:230a with SMTP id i7-20020adfefc7000000b0030626d1230amr3860283wrp.65.1686138287554;
        Wed, 07 Jun 2023 04:44:47 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4c52000000b0030ae901bc54sm15135507wrt.62.2023.06.07.04.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:44:47 -0700 (PDT)
Message-ID: <613601c2-cc98-526b-a9e3-2ad2abc68e1d@baylibre.com>
Date:   Wed, 7 Jun 2023 13:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/3] regulator: tps6594-regulator: Add driver for TI
 TPS6594 regulators
Content-Language: en-US
To:     andy.shevchenko@gmail.com, Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        aseketeli@baylibre.com, u-kumar1@ti.com
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-4-eblanc@baylibre.com> <ZG0VHnEByyMW9i4a@surfacebook>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <ZG0VHnEByyMW9i4a@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>> +	enum {
>> +		MULTI_BUCK12,
>> +		MULTI_BUCK123,
>> +		MULTI_BUCK1234,
>> +		MULTI_BUCK12_34,
> 
>> +		MULTI_FIRST = MULTI_BUCK12,
>> +		MULTI_LAST = MULTI_BUCK12_34,
>> +		MULTI_NUM = MULTI_LAST - MULTI_FIRST + 1
> 
> 		MULT_NUM
> 
> will suffice instead all this.
> 
>> +	};
> 
> But why enum at all? See below.
Just for the switch case readability.
I have to iterate across the multiphases array for look up name into 
device tree and evaluate in that order.

This can be reduced to:
	enum {
		MULTI_BUCK12,
		MULTI_BUCK123,
		MULTI_BUCK1234,
		MULTI_BUCK12_34,
		MULTI_NUM = MULTI_BUCK12_34 - MULTI_BUCK12 + 1
	};

> 
> ...
> 
>> +	/*
>> +	 * Switch case defines different possible multi phase config
>> +	 * This is based on dts buck node name.
>> +	 * Buck node name must be chosen accordingly.
>> +	 * Default case is no Multiphase buck.
>> +	 * In case of Multiphase configuration, value should be defined for
>> +	 * buck_configured to avoid creating bucks for every buck in multiphase
>> +	 */
>> +	for (multi = MULTI_FIRST; multi < MULTI_NUM; multi++) {
>> +		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
>> +		npname = of_node_full_name(np);
>> +		np_pmic_parent = of_get_parent(of_get_parent(np));
>> +		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name))
> 
> Why not of_node_full_name() in the second case?
Sure.
> 
> 
>> +			continue;
>> +		delta = strcmp(npname, multiphases[multi]);
>> +		if (!delta) {
>> +			switch (multi) {
>> +			case MULTI_BUCK12:
> 
> This all looks like match_string() reinvention.
I can go with match_string but this is not significantly changing the game:

index = match_string(multiphases, ARRAY_SIZE(multiphases), npname);
if (index >= 0) {
	switch (index) {

No question on all your other feedback. Just wondering if I missed 
something with match_string use. Looks like a good idea indeed but this 
is not drastically changing the code as you seem to expect... Let me 
know if you think I'm doing it in a wrong way.

Regards,
Jerome.

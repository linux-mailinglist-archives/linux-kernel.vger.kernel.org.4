Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D46C3E37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCUXAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:00:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2127989;
        Tue, 21 Mar 2023 16:00:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s12so19994470qtq.11;
        Tue, 21 Mar 2023 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439638;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpPsPmjtMW2eNeQfSXNf0sc4SI1/OpGjEauWnNbdQFE=;
        b=aeF6jRM8jazl/5NQnafKFjaNlovk2JN3dklR0q0PcQDP1u+maiwLLRAVIvWS189Crf
         YRLV21qHEN6c3WIQoBivF3HUg1b9re90frWXW/HRZDt5OC4ss2lXt9SfX3UHEYG9JKEJ
         /09CTa9d7wH5L5FuJIEmFea7WSAHF2mWmpuvaGWWBWciGmXiAybfprfUWMdzguTkbjj4
         Kg6oBnguCfmxNjJATvykExEYlh8imwx0I2VkmPqFBXXb7upp8MxFMzl4YPeuvM0jFRVN
         xXoaGjFodF9oyhQxZ4jRfxR0BN7OZ8TOPGAjIrnzc/7ZvhmbOHzkqIJlGEDxba3VbW5+
         DZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439638;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpPsPmjtMW2eNeQfSXNf0sc4SI1/OpGjEauWnNbdQFE=;
        b=D6eF4xX7Ndd718+80Pt25HuUhaUBX1gEzSMfvC70qvO+G33BO790jRTPhAFp5vTggG
         uCYS1tMGZ7SM4cU+O4Wfi3cOEoRfcrMY9ulvvadI2oGUFz0IvQ2jLBMoQ9Cv8knp9VaS
         0NhcKyDpFKIwjqoYiCyLyx8IzSygtgeGgG2TD0GdExmBDgIhmkzQ2uUt/X+ivZ2OaVaG
         nGlLsXLrq429rY6avYSOkNPR84jLIt6e9S2HJ0FfQJqk/4tVZ9sZSf/Ey26hRZc70km+
         Fa83kZpTLUnFPMVxGuC3iUYw11iVOcVPXLwhkHRoWMAZvh4CDJqdCCO5OBf1fioofnsi
         qPkA==
X-Gm-Message-State: AO0yUKWCK/nHl8PnaM2TJvb9lk0EMbDgNu83iZz59aLcVBKRR5saS3Xb
        eGJ5J24f1btCEHTS8xkqmcX8M831LIk=
X-Google-Smtp-Source: AK7set8PPqzUvn/9b96biNUv62vlL5dyj3GUPqLEklU3eMyvdn5T6pgrSJcB01eXMq2z/f04cZKoxA==
X-Received: by 2002:ac8:7e8d:0:b0:3ba:265d:6793 with SMTP id w13-20020ac87e8d000000b003ba265d6793mr2812396qtj.42.1679439637831;
        Tue, 21 Mar 2023 16:00:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i14-20020ac84f4e000000b003e3895903bfsm537004qtw.8.2023.03.21.16.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:00:37 -0700 (PDT)
Message-ID: <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com>
Date:   Tue, 21 Mar 2023 16:00:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset
 driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, william.zhang@broadcom.com,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
 <20230321201022.1052743-5-noltari@gmail.com>
 <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 15:57, Stephen Boyd wrote:
> Quoting Álvaro Fernández Rojas (2023-03-21 13:10:22)
>> diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-bcm63268-timer.c
>> new file mode 100644
>> index 000000000000..6a1fdd193cb5
>> --- /dev/null
>> +++ b/drivers/clk/bcm/clk-bcm63268-timer.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * BCM63268 Timer Clock and Reset Controller Driver
> [...]
>> +
>> +static inline struct bcm63268_tclkrst_hw *
>> +to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
>> +{
>> +       return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
>> +}
>> +
>> +static int bcm63268_timer_reset_update(struct reset_controller_dev *rcdev,
>> +                               unsigned long id, bool assert)
>> +{
>> +       struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
>> +       unsigned long flags;
>> +       uint32_t val;
>> +
>> +       spin_lock_irqsave(&reset->lock, flags);
>> +       val = __raw_readl(reset->regs);
> 
> Use regular ol readl() here, unless you have some need for no barrires
> or byte swapping.

These SoCs are big-endian, require native endian register access and 
have no posted writes within their bus logic (UBUS) and require no 
barriers, hence the use of __raw_readl() and __raw_writel() is adequate.
-- 
Florian


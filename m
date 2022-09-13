Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5525B6B42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiIMKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiIMKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:00:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84101CB33
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:00:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bz13so19923292wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=z1DYjwMFgjNxyimdjF3F5Xs2w+U4ihLt9S5eTJ0t/d0=;
        b=XMjgJ6hDDoMT1LSKCUX0NYvuhyRPahdHEOAl0JiD4gPQPrUR1c1/MTqRRU3SU2SYH9
         hSWmWCOSidRxpTH0NuGUonwRe5qalGlTV9zxIZNKcPQNJdWiRpin8ZhNm2nw4Rii1zlH
         HqtqAMNhhDpY1JUH+JdMcvHB5yQ1ht86Jsy+DBKP/rAELBEvhG0I6wQipCdu0nhO5xy0
         spqNsNqGfzlMV8x9YFVoXALO7KDITpWPZGNCe9dVANYvWq+rCac8SWfMB5n+urP7GftH
         JsSYeO5utH2F8hS1ICvqOtVp+IrgSsI8BMo70hvtsNCujxpkssSaAihzmQlLyR/0ADL/
         mXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z1DYjwMFgjNxyimdjF3F5Xs2w+U4ihLt9S5eTJ0t/d0=;
        b=lQaWmt9fjgCMgf0kCq3OXLZ9HPwbTWC2Afaa8jWNdiTW5tIH8utm98Lmrbxl5h3IYy
         m2t7ltEDmbidTEORRaANxKSeYhu5hJNjtgGlwH3H+yZJyJrLP8jmv+MeneiGSeq+SP80
         2aZHWhORmMZHPuEg3d8rrcyIIpQGV164n+yR7M7lI0b2rgL5FoTcvrBDvSUMvCAG6Fma
         zQNbP0HE4leeFwn112WY6X4G9v2agX1xg1a+jyGgQe2JE7vNvuEz7pNbSLQNn+yA/A+T
         wQtPb6KuHt1PR7QQePvNcU796zgx1DJPEhx9eLCk65OeDWG6+IeGtE05sD0BHX+2Mt0R
         L4Kw==
X-Gm-Message-State: ACgBeo0J59ABgWoZ9cn4GuAMEIeCYuRp4xIdk9++UWna4T7BmRZEl5sw
        tLZmNW5aLlx2dQO/a1MwxLAG9Q==
X-Google-Smtp-Source: AA6agR5mLsaYu+p3ys13sRNpzrqCm2w1hMFtzFxf9fGFT4paJAxIiG/ogCEmyOq6ESll4YRKaSpWdA==
X-Received: by 2002:a5d:6d0b:0:b0:222:764d:9e98 with SMTP id e11-20020a5d6d0b000000b00222764d9e98mr16918024wrq.189.1663063232342;
        Tue, 13 Sep 2022 03:00:32 -0700 (PDT)
Received: from [192.168.1.91] (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600000c800b002205cbc1c74sm9998852wrx.101.2022.09.13.03.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 03:00:31 -0700 (PDT)
Message-ID: <1ab23284-aec6-6817-253a-536ed5150c00@baylibre.com>
Date:   Tue, 13 Sep 2022 12:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFT] [PATCH] regulator: tps65219: Fix .bypass_val_on setting
Content-Language: en-US
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
References: <20220828120153.1512508-1-axel.lin@ingics.com>
 <f8a92b6d-ad23-24e7-2a01-73839e57cb85@baylibre.com>
 <CAFRkauDKUGRracu2ofc=q-UTjWaeef5GfevT6kHnP=MWo__BGw@mail.gmail.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <CAFRkauDKUGRracu2ofc=q-UTjWaeef5GfevT6kHnP=MWo__BGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it! And validate it.

On 13/09/2022 01:48, Axel Lin wrote:
> jerome Neanne <jneanne@baylibre.com> 於 2022年9月12日 週一 下午5:49寫道：
>> Hi Axel,
>>
>> On 28/08/2022 14:01, Axel Lin wrote:
>>> The .bypass_val_on setting does not match the .bypass_mask setting, so the
>>> .bypass_mask bit will never get set.  Fix it by removing .bypass_val_on
>>> setting, the regulator_set_bypass_regmap and regulator_get_bypass_regmap
>>> helpers will use rdev->desc->bypass_mask as val_on if the val_on is 0.
>> I think this will result in exact same behavior. val would be assigned
>> to 1 when enable is set and 0 otherwise. Anyway you are right this line
>> is useless.
> Setting .bypass_val_on=1 won't set TPS65219_LDOS_BYP_CONFIG_MASK bit.
> The TPS65219_LDOS_BYP_CONFIG_MASK is BIT(6), so you need to set BIT(6)
> instead of 1 for .bypass_val_on.
> Remove .bypass_val_on setting then it will use .bypass_mask as
> .bypass_val_on setting.

Got your point. The issue is on the get path not on the set path...

I misinterpreted val_on usage.

I was able to confirm on board that cat 
/sys/class/regulator/regulator.10/bypass
always return disabled before your fix is applied.

After your fix is applied, it accurately return enabled/disabled 
depending how LDO is set (forced at probe).

side note:

- I added virtual regulator and userspace consumer to validate (that's 
why VDDSHV_SD_IO_PMIC is regulator.10)

- This bug was missed because I did not re-validated the bypass after I 
changed from custom to standard helpers (I apologize).

Thanks for raising this

Regards,

Jerome.





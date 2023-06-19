Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020C1735BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjFSPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjFSPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:55:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A4E65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:55:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f909853509so16364675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687190128; x=1689782128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4N5dpoipWOf8XjguRYHpHwQdxrpSgiwAsJRRqnoHc4=;
        b=LwgqnVBD1fU/4SV7LuNUlwiGQEW2ZbTGfdoNVNyGsrqf+MhrrUS7ncVu6xyLJyqqAe
         va4K6Gw/eNfPJYdL3awXemcn4RYOcUmwSfvmeFhs/a/ajiVFipcIZqy+4WGshFdm7lOK
         mCGkYq46heS1NYYAnMD3gPLj/o5m3WMWKMdjPxmJML3NGSylUF0ZmJg8lLoyalihX5T3
         b2EP/AO3qfUM2ql5nImQ35KNqjtk9MIo/meeJM0uH4OFNrDQGr9/jYs1Lm3AgS0aGheb
         bqg7OzE7qlw89Xw1hm8ASDaGZBbq4TZKDcpQiVXHkmBQljH86DNLRI70SpIPwcdzZheS
         db3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687190128; x=1689782128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4N5dpoipWOf8XjguRYHpHwQdxrpSgiwAsJRRqnoHc4=;
        b=LDw/yzsuB0MYbv/sYulTDpKNMNzK5oBHJHWbCShmM4M0d5ZmItOLGRMPBXyqIzMr2O
         7TtXbkzbhrUvkuYQlFXugLOdiLGphuGkummyl5L/rxwrdm/xr7TXaIqVacEVFBFIvobx
         M7z5Mlg3geWwDzjAv/JxUwnb4i4DnYk6a9/vp5WBmSm413Hzw7D0ihoVQvfrWkNnItQq
         rrCXr5LnQ+8oxu9qvWOpRStsquozeUjhw62BP2yPWRSKwWDwSRowWb8KnsSk+30gmNdu
         JJPB5lZB4tEygmsBQ6syKmopG23Hx5J0eOzOtZAyqVnzbQRyGwD2/KX/P2dpyNNUO+fr
         tkXQ==
X-Gm-Message-State: AC+VfDyuuy9hrTyvKFqmcrFgRKbNboEXNZN/Qhveyx3qiXLrL0uI+XSQ
        zLHz2bu98odTXb/ds33gUMD5IA==
X-Google-Smtp-Source: ACHHUZ5IwS5usHztRMwX7/oGdnNG0GHU6nRGgZp8/B+DITYYL9I+wvnzN3jtFNcL0pGDxhMrBz/G3Q==
X-Received: by 2002:a7b:cb9a:0:b0:3f9:a6f2:8656 with SMTP id m26-20020a7bcb9a000000b003f9a6f28656mr2449612wmi.35.1687190128430;
        Mon, 19 Jun 2023 08:55:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id c16-20020a7bc010000000b003f7f60203ffsm11198628wmb.25.2023.06.19.08.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:55:28 -0700 (PDT)
Message-ID: <815ad411-555a-058b-683c-1cbba4806198@linaro.org>
Date:   Mon, 19 Jun 2023 17:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] clocksource/drivers/imx-gpt: Drop unused function
 mxc_timer_init()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AHrXrJZJ2NY3GN56zf=meA5r3rWpD7GVuszBL7zcye5Q@mail.gmail.com>
 <20230328103136.xafgjdkvdwnn7pwi@pengutronix.de>
 <20230530153438.yomexkg2uypjtov7@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230530153438.yomexkg2uypjtov7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 17:34, Uwe Kleine-König wrote:
> On Tue, Mar 28, 2023 at 12:31:36PM +0200, Uwe Kleine-König wrote:
>> On Tue, Mar 28, 2023 at 07:14:24AM -0300, Fabio Estevam wrote:
>>> Hi Uwe,
>>>
>>> On Tue, Mar 28, 2023 at 7:06 AM Uwe Kleine-König
>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>
>>>> The last caller is gone since v5.10-rc1~28.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>
>>> I have already submitted this change:
>>> https://lore.kernel.org/linux-arm-kernel/20230307124313.708255-1-festevam@denx.de/
>>
>> I don't care much which of them is included. Before patch #3 of my
>> series is applied, either of the two must be applied first.
> 
> OK, Fabio's patch got in. So now the way is clear for patches #2 and #3
> of this series.
> 
> FTR: b4 am -l -P2,3 20230328103136.xafgjdkvdwnn7pwi@pengutronix.de
> does the right thing.

Applied patch #3

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


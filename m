Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C934E732AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbjFPJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbjFPJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:03:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ACE4488
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-311148ea881so266660f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686906121; x=1689498121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BR1FrCtHH9AcQAwZRNbs0qHZeJ7fa75O3YybSaX975M=;
        b=viJXITiRsw+2I7ENSPHa7PamsTgeUUksl6Wk7EqFynn+345OV79Ci8ZMTJxU/nPeR6
         j4MuMmeVfNNoa5hoxMBD9pEvyd28n0Y9e+Qdxl5BLmLqZaq8IYEgzhWi3FUNS36BUh33
         7WKujaxLoiogk/2vBy9Dq+4StwnUAwLU79Fz317gPJVnFwEX0eYoG3TR72KwRZezyJFR
         k2zAuGTjqGSgKK9f9vCAODthWnUJjIbS3O14Y7KV6xX8s/Tn7VpI5BIDc2YSc21BcJ3z
         60JOezzX8xUY3wN33LVjK1JyhN9lJMvwvkivSJVu017F8iqrYk5g/0RvcDwk0j7a0KU1
         nSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906121; x=1689498121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BR1FrCtHH9AcQAwZRNbs0qHZeJ7fa75O3YybSaX975M=;
        b=F3vaEtOabocKHg7HTZ13wDV4sN62ulfNYUDR6r0ZuZngkfd1+Z0zjGdLPGp49HafgX
         Uo0GOQPn/N2+Jc4fw3XQYmaD1YiDJ5y9YOJxA0i9QRMofaztAuukLZki7+zJm+eYcY4N
         Da3zb90APWVFns/yY7Ko9EfafmLWClfF27qK+aCxcI/SkBUQHRNB6MclVmE7qlMRdSeB
         7WUg7hBzVWYJiEy/N2+cKugsTbuxtqH/zRTIeyrqvZ8Qhu1zoXd2Mz6MHeOkagHyNO5B
         71e2Mkt6kC9jgV9fBFkjdIRX/1zG8rBmRPDoSL8FVckBRR7rd6jrdmRoIJOH+EFEBBXg
         oKpA==
X-Gm-Message-State: AC+VfDwo1rVK6TVal/VNKJMYAWMONdemSJiN7VbwzjerepG6AO0RiUPl
        Y/HHzhcteLv0CXQZKefx1x/4XQ==
X-Google-Smtp-Source: ACHHUZ7Z+Qj9nzLK2MdxQhEpGKNId+ygHcs+6kNDfxumfYnqZ7O5mxfvSzNPzRH5/17HgJYEMGLi0w==
X-Received: by 2002:a7b:c4d3:0:b0:3f7:e35d:b2c3 with SMTP id g19-20020a7bc4d3000000b003f7e35db2c3mr1071663wmk.40.1686906120776;
        Fri, 16 Jun 2023 02:02:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:331d:4ff0:1778:3425? ([2a05:6e02:1041:c10:331d:4ff0:1778:3425])
        by smtp.googlemail.com with ESMTPSA id k17-20020a05600c0b5100b003f7ec896cefsm1644501wmr.8.2023.06.16.02.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 02:02:00 -0700 (PDT)
Message-ID: <be625ba9-f490-9bf0-5f15-4f403aad10d5@linaro.org>
Date:   Fri, 16 Jun 2023 11:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Peng Fan <peng.fan@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
 <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
 <3e397cf5-0ca3-fa10-b5d8-bbc7b1038a37@linaro.org>
 <DU0PR04MB9417A508A757AF8964CDAEA6885BA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <7e843caa-8369-1fb0-36c4-a4482d37b211@linaro.org>
 <60c95298-68cd-0f6c-38cc-745da7b2a6ed@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <60c95298-68cd-0f6c-38cc-745da7b2a6ed@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 03:06, Peng Fan wrote:
> 
> 
> On 6/15/2023 9:49 PM, Daniel Lezcano wrote:
>> Caution: This is an external email. Please take care when clicking 
>> links or opening attachments. When in doubt, report the message using 
>> the 'Report this email' button
>>
>>
>> On 15/06/2023 14:07, Peng Fan wrote:
>>
>> [ ... ]
>>
>>> Per i.MX8MQ Reference manual:
>>> MSITE:
>>> Monitoring site select 0 - 2. By setting the select bit for a 
>>> temperature sensor site,
>>>   it is enabled and included in all monitoring functions. For proper 
>>> operation, this
>>> field should only change when monitoring is
>>> disabled. If no site is selected, site 0 is monitored by default.
>>>
>>> ME: Before enabling the TMU for monitoring, the TMU must be configured,
>>> see section Initialization Information. Failure to properly 
>>> initialize the
>>> configuration table may result in boundedly undefined
>>> behavior.
>>>
>>> So we must set the SITEs bits before enabling ME bit. So set TMR_ME when
>>> each time call invoke mode violates the spec.
>>>
>>> As I understand, change_mode is per zone, which means per msite for TMU,
>>> but TMU_ME is a global gating bit which should not be set before all 
>>> msites
>>> are set.
>>
>> Mmh, IIUC correctly the documentation, it says the monitoring must be
>> disabled when changing the sites. So in the proposed code, we shall
>> disable the TMU, update the site and then enable the TMU.
>>
>> Can you give a try to see if that works? If yes, then can you submit a
>> patch on top of this series. Meanwhile, I'll pick those changes.
> 
> 
> I did a basic test on i.MX8MQ, it seems work. But I still have concern
> because it volitates the spec, need disable TMU before updating MSITE.
> 
> And if we disable TMU when updating MSITE in your patch, there is 
> potential risk that zone0 is reading temperature, while we disable TMU
> and update MSITE for zone1. So zone0 may get invalid temperature because
> TMU is disabled at this window.
> 
> no good idea from my side, unless we keep check TMU_ME when
> getting temperature.

Yeah, that is a good point. We are ending up to do the TMU check in the 
get_temp() any. Thanks for taking the time to look it up.

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


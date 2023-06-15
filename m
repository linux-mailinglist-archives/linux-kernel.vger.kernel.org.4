Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E7731A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjFONuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjFONtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:49:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D351BDB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:49:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8cc042ea9so17192125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686836990; x=1689428990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPpmcFOud6NSZysOaTCzx4AGcA84UMpGqpX58kQo8EI=;
        b=TqyaX7guuoPDBwsfWjLf6D9FCngXqB0SYyZpcK0HbN5G5mkq7p1pDqRXw0FqLcth2M
         Au4IWrje3awMH17yl/fOv0rTvnIFyoYOaEoVvPYMZYVaqeX/J4jcZANUtDdDQf3whnGa
         5mZ4iRnv+Bnrvlvt/kw748YPFQp0Z9ziDjKcWMO2AFMVFt+963BW0zDPn6QM+Uii3lRr
         DhFV7a1IDXBBe2LdMme4WGr4KJauolzLKpp/bufISWpG9AK0nUxrMiNjffvWUlImqSEZ
         CapdXe/U1zlen8E0GSk24x6bEwXU+YQBkL4eAiYj4sH6U8BKnHoWqCu+5GS4DP75fG3g
         uNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836990; x=1689428990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPpmcFOud6NSZysOaTCzx4AGcA84UMpGqpX58kQo8EI=;
        b=W4na3Hz4TLAW6jJDh0mm16Kpdc8mjsJmnrpizILVxa9G1Ro3iAj0CxE8V516hzxDae
         +kIOtHupjaAFzHCM+PCc8yzI6k72APuFGk+7/5yZp5LDygZZ1UZLDWXKsp9m3DcCarIr
         LzbxxdSLQBgt5+Tg9Biw68XXt1XcdxNJpvztJcmi0UOLFvWrcS9RsSbNGCx8cVHxLmFI
         4bnuc/9jaYMZDKZhQm/37jmK3HdHh5/1VR61ouary7KHV1lyLCytQNLAuPg0XCC02bCN
         QbruqIzLyFHABriIeZDcDap+i156j/xxJOPMmwmijy51WBkE9dE0MoBaQaAM/lAwn4oj
         X9qA==
X-Gm-Message-State: AC+VfDzTyhVhof54alAWhZCvXoOskQ/zTeSaaSz/F0cpbVpEkYgMQHGd
        ++cFMhGFx5jv3G+8uezFvjlYmA==
X-Google-Smtp-Source: ACHHUZ68iA8remZL5nXw7Ofgfc6bT8MuEK+ySF7H4TqrKH/J2jv/+AhmuMLuqrwDcTVkoFYnVaowFQ==
X-Received: by 2002:adf:fb07:0:b0:30f:b3d1:8f99 with SMTP id c7-20020adffb07000000b0030fb3d18f99mr9693572wrr.38.1686836989994;
        Thu, 15 Jun 2023 06:49:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:331d:4ff0:1778:3425? ([2a05:6e02:1041:c10:331d:4ff0:1778:3425])
        by smtp.googlemail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm21152969wrv.108.2023.06.15.06.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:49:49 -0700 (PDT)
Message-ID: <7e843caa-8369-1fb0-36c4-a4482d37b211@linaro.org>
Date:   Thu, 15 Jun 2023 15:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <DU0PR04MB9417A508A757AF8964CDAEA6885BA@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 15/06/2023 14:07, Peng Fan wrote:

[ ... ]

> Per i.MX8MQ Reference manual:
> MSITE:
> Monitoring site select 0 - 2. By setting the select bit for a temperature sensor site,
>   it is enabled and included in all monitoring functions. For proper operation, this
> field should only change when monitoring is
> disabled. If no site is selected, site 0 is monitored by default.
> 
> ME: Before enabling the TMU for monitoring, the TMU must be configured,
> see section Initialization Information. Failure to properly initialize the
> configuration table may result in boundedly undefined
> behavior.
> 
> So we must set the SITEs bits before enabling ME bit. So set TMR_ME when
> each time call invoke mode violates the spec.
> 
> As I understand, change_mode is per zone, which means per msite for TMU,
> but TMU_ME is a global gating bit which should not be set before all msites
> are set.

Mmh, IIUC correctly the documentation, it says the monitoring must be 
disabled when changing the sites. So in the proposed code, we shall 
disable the TMU, update the site and then enable the TMU.

Can you give a try to see if that works? If yes, then can you submit a 
patch on top of this series. Meanwhile, I'll pick those changes.

Thanks
   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


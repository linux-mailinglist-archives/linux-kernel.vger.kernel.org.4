Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A0732AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFPJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbjFPJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:04:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841A469A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fcda210cfso263757f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686906134; x=1689498134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUNnoPNkuiFRrjF8T9ixweyGU11L7PSo9N7Nhno60LU=;
        b=pzKhrKpXuNfd4MwuRVW+1dik2HMLv+JL5MQRqhO8LZHzVNOx3fQ7mbBFAq5NpOXS3W
         EIOSJyChiTol1xRaIbb0fiOowERNnfli3pRfzmgPClGBBXSznVBfRSdty6TdglucEh/G
         5VJ3cVa1qQD4YEQgQ1+HgCwzb7E9NGa1J0YkxRBP4aWlB4UBxGXrrFp/oDFrKjFQ7GbJ
         ZDsMCfXnwuyulyRsrWH6y3mcilhVmg8CcN7lEHW/yyPd43UYDS8loMSWLCoLUreYnGva
         NKoJSmACORRXz1F19IbDLBusTVFpFhpIQzK2kP8WwiJRfNwXStQ4IJfYF2B+vvv7rBQI
         93Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906134; x=1689498134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUNnoPNkuiFRrjF8T9ixweyGU11L7PSo9N7Nhno60LU=;
        b=V14NCMlL2ssP7SIY3mqeXsqbcbbr1TLUfYOa1JDDQVSb76HhApImnSrXmbgWSkZLDb
         hliVzAp+dJi+2lxZtzwHrwC39LtUjMffbO0a2jgCe/ThabfiEXoj8kEvB6MJXRWZ9ZIo
         gKsVrAWwNbvwfEMeEVBxMsTKh5j14UA+N/U0Q24sMXIgKctpBy0Y/JORIxVf9uPeBu+w
         ryEfryzAHPCYL83ChFHM9wA/UfKI0bL71NTYyxgdf/sJuJB/Vci+NDq68x+zVHpSFVcT
         oRvAbUKoSnnypXXSHuCNCp7G/JSYHQqLCGar/hnh8p1K6ahYtUUMWE4PTYzJf7pWuC/U
         a1fA==
X-Gm-Message-State: AC+VfDzMRb0GVXsc9RfkjxM5ygYJZcSBN+0HicsS6o/TiGTtZp0sRcEg
        gPFM1kzdIbQGf0KfsCBFpyg7ag==
X-Google-Smtp-Source: ACHHUZ5pUTNj0PujN1w6Q0Ci+RaPMj7Jwsu/CGS8stq7wUe0fqSyYpyB/dPhk00Bd1Jz7pzhhg/FOg==
X-Received: by 2002:adf:ec45:0:b0:30f:af06:7320 with SMTP id w5-20020adfec45000000b0030faf067320mr768376wrn.23.1686906133994;
        Fri, 16 Jun 2023 02:02:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:331d:4ff0:1778:3425? ([2a05:6e02:1041:c10:331d:4ff0:1778:3425])
        by smtp.googlemail.com with ESMTPSA id s2-20020adfecc2000000b0030aed4223e0sm22878418wro.105.2023.06.16.02.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 02:02:13 -0700 (PDT)
Message-ID: <dbf97703-1cdd-ebc8-325d-c5ce22e3d44f@linaro.org>
Date:   Fri, 16 Jun 2023 11:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, rafael@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230516083746.63436-1-peng.fan@oss.nxp.com>
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

On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 use same TMU IP as Qoriq, but with version 2.1, so update
> the driver to support 2.1.
> 
> This patch also includes a fix for i.MX8MQ
> 
> Pankit Garg (1):
>    thermal: qoriq_thermal: No need to program site adjustment register
> 
> Peng Fan (2):
>    thermal: qoriq_thermal: only enable supported sensors
>    thermal: qoriq: support version 2.1
> 
>   drivers/thermal/qoriq_thermal.c | 48 ++++++++++++++++++++-------------
>   1 file changed, 29 insertions(+), 19 deletions(-)

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


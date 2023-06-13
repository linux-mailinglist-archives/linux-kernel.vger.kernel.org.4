Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599772DCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbjFMItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbjFMIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:49:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BBE4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:49:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8cc04c2adso3631305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686646166; x=1689238166;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0I2pNeOiPYcUgKjv6OV6+sPS7erJxX4fRSV8gqz1fw=;
        b=JVPJNR2G9K5SB+ZbY//2raud+kEc/EIAVOrsIkSCHCmc2c4Oc6QBLqmbAJj6j3hweh
         dXw485acl4adLieocy3FOyHxXRAgmSs7fYxE/6DLnxURl8KbWfJgNdJokpDwb9gmRuxE
         8vi0l5DYkgzMbZHMjWiPGqZIJmixY2tpz+wUZMgxmoVIYjGHIIHg9N2A/8pft+GbW14+
         tD3UKjvjxMKY11ZJl1oYQqi7rrIoQvusSCgRULOOcpSZjoFmQoP3c7ZshW17QdSs9XKA
         gJTHWOERR1npxo0rAFS+CBJ5UZbvkh0Ami8TVlfy6pYx70reg/k1ctOhT9JFkPDRYK5R
         TSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686646166; x=1689238166;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0I2pNeOiPYcUgKjv6OV6+sPS7erJxX4fRSV8gqz1fw=;
        b=jRruX1C8kkKIeU/Mqg5CKXNviomIOZ1zmQ2Mwy4e5q4DZGIMMhc+QYa5GB+UOsu63u
         Tc6IBfqByLBJmFR0fM5NbXOO3Fki0B40olcnMTleeH5oPNLLWA9mtwWuLPDNjpBru9qj
         rX7pQ7d6ic2NH/71+GNJ8LMSkKOapAEN0Qr58QZFyGlsUk/4qrdrnjSaA2H4E5fuKAWW
         uRXCj3hnKVWB0pevSS92rUWA9QrrNVo7hbQQJN/cPo+tyPMSGS8uDXG760sx3TU7dHJa
         9Stt6SoiqCngf/wp6+VgaMDhDU6UpdJSOzzUhfzkw/8Og7d6wiCG6gRxaAn9wH6aWL8+
         YdLA==
X-Gm-Message-State: AC+VfDzuhzOR2TXjqp3H+I6KdT7N2sCmVGReBXRZUnOEVUHbF//Njeyk
        tKPaF7aH/zzJI0XxL8LbjWNSCw==
X-Google-Smtp-Source: ACHHUZ42xf9bgppziC+evXWZEQ23sTzyp1CSrHHwD55tNkhkvnVJMtZkpVFyXvbIV1n6bLMqRSDXhg==
X-Received: by 2002:a7b:c7d8:0:b0:3f6:1474:905 with SMTP id z24-20020a7bc7d8000000b003f614740905mr9375762wmk.29.1686646165959;
        Tue, 13 Jun 2023 01:49:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id z15-20020a7bc7cf000000b003f6129d2e30sm13796467wmk.1.2023.06.13.01.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:49:25 -0700 (PDT)
Message-ID: <ad78c18e-13dd-fca3-1aff-5b8e68a91c90@linaro.org>
Date:   Tue, 13 Jun 2023 10:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths
 in sun8i_ths_probe()
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Maxime Ripard <maxime@cerno.tech>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
 <ucnnixemxbpkjlbyenboydicslozt5jpyjjfbd4gjk4oye52et@fgyd3zqdqsh2>
 <u7mmywm63bm5q4zlsbnooeplscn4rrd3qnslkfq2xnquxgnkkd@n3tsnrutmfjp>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <u7mmywm63bm5q4zlsbnooeplscn4rrd3qnslkfq2xnquxgnkkd@n3tsnrutmfjp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 14:33, Ondřej Jirman wrote:
> Hi Maxime,
> 
> On Mon, May 15, 2023 at 01:54:41PM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> On Sun, May 14, 2023 at 08:46:05PM +0200, Christophe JAILLET wrote:
>>> Should an error occur after calling sun8i_ths_resource_init() in the probe
>>> function, some resources need to be released, as already done in the
>>> .remove() function.
>>>
>>> Switch to the devm_clk_get_enabled() helper and add a new devm_action to
>>> turn sun8i_ths_resource_init() into a fully managed function.
>>>
>>> Move the place where reset_control_deassert() is called so that the
>>> recommended order of reset release/clock enable steps is kept.
>>> A64 manual states that:
>>>
>>> 	3.3.6.4. Gating and reset
>>>
>>> 	Make sure that the reset signal has been released before the release of
>>> 	module clock gating;
>>>
>>> This fixes the issue and removes some LoC at the same time.
>>
>> It should really be three different patches:
>>   - One to fix the resource release, that can be backported to stable
>>     releases
>>   - One to switch to devm_clk_get_enabled
>>   - and one to change the order of clock enable vs reset deassertion
> 
> The order was correct before this patch. I don't think an incorrect order
> should be intorduced, even if temporarily between two patches.

Maxime ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


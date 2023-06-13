Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549E272DD83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbjFMJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbjFMJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:18:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510D19AE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:17:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso6422175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686647868; x=1689239868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcUX4fDs7iSlQ+LnL3iJyOLoCOfttwzDzADNkHi9/UQ=;
        b=wE7DBOHqnnNYn0JdlNZUMAi/IfQEQdPUAEbjSX8isNwHRmldZ6YyaKSsgn3OMuDejJ
         8sW04YcS18wT7UKNqDklWAHGQh87GS+qy4ckHY+X1Cecc0cbPgW5LdMM4kOLHes19lU/
         bOnTd//CbkKIH3PtJkIDj+Z6BqFplONDOXCcY4dnjYrP/sas6jvJJXID1kRSulqzx+a9
         JVRzLcfB1fb5nr41OQAOJ8jVs+suQ8AgtMIw2A/f1ejS8QqCDdl8BfLQUIQw0IKamERh
         milN0sjKNKnosNuU4flCo2TB8C9znO4syyBO1HE5+z24kMvOSxRHjsmxCsltrqlMIhSV
         ssBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686647868; x=1689239868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcUX4fDs7iSlQ+LnL3iJyOLoCOfttwzDzADNkHi9/UQ=;
        b=MXJsjbwsGuaBSPpURpz9cKqajLygUJnZsC0IuvHsQJNLcTlUM8xoR2nd70Kfu5N9e7
         OzJYHehHeEjACvfgPH7esZS/GZ2j1SclSqavpDk99ECKQofIULwPeVyeTn/p+hlT05zF
         9cZO1ryewmYdT7Cn4CfHwnG944ZAKAT/c8KxXkeErdRgbKg3Nf54M8hI5yz0WC3GPuR2
         6d30EmlUy/K6DL92roRLqfOQBvk+ydp32YpZHTKRn2Uy/ZTAdbUZZXUD67LofZB1N1H3
         biP0wsQJNODLoOP0JFcn4bgSmG6QAT0LNN1A1DZNpa+6dZO9/+o9ZfgFPgrmpcA9YzVT
         fmDA==
X-Gm-Message-State: AC+VfDwgot8FGGDwjr7rzEdt2+5HbXzULOdyeER/c7UCEtsYWEiNXx4b
        mW6Lfp2NrwhxQfUsrghRv/y1LA==
X-Google-Smtp-Source: ACHHUZ7PRirIG4e4ODfmZ78TSJJS4MY/py9QOzKFtnX3RLZe7Upxx7koRp4/SWWhSVvtEj7n/D1VUw==
X-Received: by 2002:a7b:c394:0:b0:3f8:f5d:52ee with SMTP id s20-20020a7bc394000000b003f80f5d52eemr6890301wmj.23.1686647868566;
        Tue, 13 Jun 2023 02:17:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm13769141wmj.27.2023.06.13.02.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 02:17:48 -0700 (PDT)
Message-ID: <3613a4fb-5c68-4316-0983-7bfeb5755041@linaro.org>
Date:   Tue, 13 Jun 2023 11:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths
 in sun8i_ths_probe()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
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
 <ad78c18e-13dd-fca3-1aff-5b8e68a91c90@linaro.org>
 <4j74jv53tdf4n6txibl6xjh63dzzjr3ku3uoxhv3rzodthqbqy@25eho3f7wh6y>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4j74jv53tdf4n6txibl6xjh63dzzjr3ku3uoxhv3rzodthqbqy@25eho3f7wh6y>
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

On 13/06/2023 11:16, Maxime Ripard wrote:
> On Tue, Jun 13, 2023 at 10:49:24AM +0200, Daniel Lezcano wrote:
>> On 15/05/2023 14:33, Ondřej Jirman wrote:
>>> Hi Maxime,
>>>
>>> On Mon, May 15, 2023 at 01:54:41PM +0200, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> On Sun, May 14, 2023 at 08:46:05PM +0200, Christophe JAILLET wrote:
>>>>> Should an error occur after calling sun8i_ths_resource_init() in the probe
>>>>> function, some resources need to be released, as already done in the
>>>>> .remove() function.
>>>>>
>>>>> Switch to the devm_clk_get_enabled() helper and add a new devm_action to
>>>>> turn sun8i_ths_resource_init() into a fully managed function.
>>>>>
>>>>> Move the place where reset_control_deassert() is called so that the
>>>>> recommended order of reset release/clock enable steps is kept.
>>>>> A64 manual states that:
>>>>>
>>>>> 	3.3.6.4. Gating and reset
>>>>>
>>>>> 	Make sure that the reset signal has been released before the release of
>>>>> 	module clock gating;
>>>>>
>>>>> This fixes the issue and removes some LoC at the same time.
>>>>
>>>> It should really be three different patches:
>>>>    - One to fix the resource release, that can be backported to stable
>>>>      releases
>>>>    - One to switch to devm_clk_get_enabled
>>>>    - and one to change the order of clock enable vs reset deassertion
>>>
>>> The order was correct before this patch. I don't think an incorrect order
>>> should be intorduced, even if temporarily between two patches.
>>
>> Maxime ?
> 
> I agree with Ondřej

Thanks, I applied the patch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


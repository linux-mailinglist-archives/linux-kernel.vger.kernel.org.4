Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1E6B64E0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCLKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCLKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:20:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F12943B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:20:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k10so37546874edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678616440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbAbzZV/Xdq9oZ9db4qjyR7OAM8ISoHuQdD7Lk6uW9o=;
        b=LeLPC3EEhzxRNxvRCH+b+d4kEih+ehxEiG2rXL5qSEAcOttdU4aXULt0tsRKPuCza3
         a4zWL1S0wbIAisSm1DpkMjY03lTS4tPihYnhk7Gm1YjQK92APvyRcC8nklG3T6yGr/eB
         cmYfO6IiI+lSpBExN9SZvLO/BEW9t7S9V6roCvbfm71F6OeinZvpXv7YsdI2sq3n5y3S
         naTpfbe8huSCsAPBspw/c++7JG8ovvFyJ2lQXDxaVxcosqunaSAQHdVFkePGJafuZDC5
         vyVlxtg9tFQUmMVIORvjh8TnVayopqMNlt8dEzQ3SyBjXt+WBr/6pGANCLgwwSdGLEtV
         M0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbAbzZV/Xdq9oZ9db4qjyR7OAM8ISoHuQdD7Lk6uW9o=;
        b=BqpHJc19hggBsdq8AwIktf8JC4j8sXWqJMMqvSdksLed/PvYL4IyFT0rFwjziQpIbp
         VvqZCHDtny+xyrze+nFGQesSU77p6SRC+z+T0AcJwXvwh+U8bmGWS5HkPXoUpi1+8L+W
         OM6L7B0zvypiBxVizfT2MHhtZIZzusUqXL8G1s0PqKMYFUHS6IaCg7mXLotT43ZXEMs5
         mDsaZtJVtQNqDmStDalkOg/iLoyv95atOmLNJe/H3GfdQWnhaxIPUXsKxo52+30NSD2y
         g35YsT+UmEtovlD7O8YExCatZh97if5ffu9mjmbL9sDN63VxR8dcRpEdoQATUlnz8q4o
         t2gg==
X-Gm-Message-State: AO0yUKXyAYhRQ22I/sBDPs0jsBP7ch7WlK3MAX/ZD5SDWEjBOYKoyTaz
        e/+AhE7bgorQfKlP7OkL0Xerwg==
X-Google-Smtp-Source: AK7set+j33mKv17cplWRaB2equIU/hTxgso/6lGoUsSghTcqcj9a6GMBKe+/zu/1DFJTN0Bl7w55cw==
X-Received: by 2002:a17:907:6ea6:b0:8b1:7dea:cc40 with SMTP id sh38-20020a1709076ea600b008b17deacc40mr37985220ejc.9.1678616440275;
        Sun, 12 Mar 2023 03:20:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090657d500b008b69aa62efcsm2094661ejr.62.2023.03.12.03.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:20:39 -0700 (PDT)
Message-ID: <d9b197c8-56fe-b59d-5fca-bc863ac1e7ed@linaro.org>
Date:   Sun, 12 Mar 2023 11:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/12] net: dsa: lantiq_gswip: mark OF related data as
 maybe unused
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org
References: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
 <20230311181434.lycxr5h2f6xcmwdj@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311181434.lycxr5h2f6xcmwdj@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 19:14, Vladimir Oltean wrote:
> On Sat, Mar 11, 2023 at 06:32:52PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/net/dsa/lantiq_gswip.c:1888:34: error: ‘xway_gphy_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> Do you happen to have any context as to why of_match_node() without
> CONFIG_OF is implemented as:
> 
> #define of_match_node(_matches, _node)	NULL
> 
> and not as:
> 
> static inline const struct of_device_id *
> of_match_node(const struct of_device_id *matches,
> 	      const struct device_node *node)
> {
> 	return NULL;
> }
> 
> ?
> 
> Generally, the static inline shim function model is nicer, because it
> allows us to not scatter __maybe_unused all around.

Sorry, I don't follow. I don't touch that wrappers, just fix errors
related to OF device ID tables, although in few cases it is indeed
related to of_match_node.

Best regards,
Krzysztof


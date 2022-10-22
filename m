Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B16608CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJVLdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJVLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:32:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAEB33A3A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:12:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m16so14658396edc.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkHBPe8kKp/EBO1kgCVV44yINTVx9+9WMF/ZWQU88KM=;
        b=hrLNxiuD7rGcoYoDFEG4FYJ/zZHCXK1tR2mH+JEjkDCh6yA6QjUPp6hoaTbZGI5xwI
         S0wosoyTQLKJZteniGi1EOiIC27IGNkYXTMMocUfW5VMrtxE6dN2ItO5DXXhvN+8j9gS
         H5urh1Mh8cAZU6X0H7Qk0CFxWioOf6qULmay65o9qqInJjxwFtI0329CssSoNf7bvXdv
         DGSy76oaDRXXtkJwyDKOdxWyVIXAOFDJVOdPJ22X1EPpoTGyOKXh1e3dV1UNWIv8Av3y
         9bfLKPDbpgWhV2bwmi+1h8ozn/pGs6jcFMH+3dRFmi3u3yI4CgmQ3FpOjrQCXg9ARbEA
         1ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkHBPe8kKp/EBO1kgCVV44yINTVx9+9WMF/ZWQU88KM=;
        b=1bCsSJr9SNAIUw4MnffbjqNFmA7eo1YaYjtyV9NEtmW6hA6TB9E6f+XRMu9nSIAzre
         DtvdydvCIejrzjQc2DMve5D4sWT7rmVfKQgkAYk9X+bPwkmMldjrJguSJ1/X3CvAsnyO
         brMplhIy/e7Gq1rIJ9EAO9eQOVbEJoOev042u/T38uQlsRG5735MuonwZ1IlbY2qlGBy
         /3YjmCgucFv55+OwUjuzCClGtEeZgRaqL3q6rO7+ivPD5m2iIAd5ZP9fIKUZoknh6+s9
         sQQW55uP/JZKnsOF85hOasU1Dh8y67gyfzGSlNotmBjWVObmVcqVjuTQJbCmD0oAZSPd
         yAvA==
X-Gm-Message-State: ACrzQf38ci3ZXFOlXLkm6Sg/iLP1UZpJgkN8i//JJSbhSv958JdtneCS
        S0f8M9NgehYcd4yIZyKJcMIS1g==
X-Google-Smtp-Source: AMsMyM5sbHVdjq9chPJBv2v73OaTQ6ZtNtFRPn38AtlSsWcq8cx5eu0OlB4Dk1p4BQXHMJFueZyYOg==
X-Received: by 2002:a05:6402:1911:b0:45c:be41:a879 with SMTP id e17-20020a056402191100b0045cbe41a879mr21645066edz.322.1666437144931;
        Sat, 22 Oct 2022 04:12:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id hp21-20020a1709073e1500b0079800b8173asm3338667ejc.158.2022.10.22.04.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 04:12:24 -0700 (PDT)
Message-ID: <2b0fe8c2-674a-3b44-16aa-d3008b1271c3@linaro.org>
Date:   Sat, 22 Oct 2022 13:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] thermal: rockchip: Support RK3588 SoC in the thermal
 driver
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
 <20221021174721.92468-2-sebastian.reichel@collabora.com>
 <2aafa6cc-a7de-0b7a-571f-04593ad53787@linaro.org>
 <7276280.TLKafQO6qx@archbook>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7276280.TLKafQO6qx@archbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 10:43, Nicolas Frattaroli wrote:

[ ... ]

>> What is TOP and CENTER ?
>>
>> There are 4 Bigs on this platform but two sensors ?
> 
> As far as I know, the four big cores in the SoC are arranged in two
> clusters of two cores each, so one temperature sensor for each
> cluster. As far as I can tell each CPU in a cluster shares its voltage
> with its partner CPU core in its cluster.

Ok, I found some more details on the datasheet, page 7-8.

So it is a big "Cluster" with the 4 Big cores. They share the same cache.

There is one power domain per core (cpuidle)

There are two performance domains (cpufreq x 2)

So it makes sense to have one sensor per performance domain to mitigate 
the temperature.

> If you have access to the TRM, it contains the following line in
> part 1 on page 1372:

Unfortunately no, I don't have access to the TRM. But I'll be happy if I 
can ;)

> 	Support to 7 channel TS-ADC (near chip center, A76_0/1, A76_2/3,
> 	DSU and A55_0/1/2/3, PD_CENTER, NPU, GPU)
> 
> I assume one of "TOP" and "CENTER" is "near chip center", the other is
> PD_CENTER, whatever that means (PD = power domain maybe?)

Yes certainly.

I take the opportunity to let you know there is a new tool in the linux 
tools directory called 'thermometer'. You can capture the temperature 
and use the data to create graphics.

> I agree these could be named more descriptively.
> 



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

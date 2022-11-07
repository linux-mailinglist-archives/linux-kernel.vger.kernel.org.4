Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8A61FD16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiKGSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiKGSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:15:01 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0C1AF0B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:14:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t10so17619967ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvuKD18nXs5C0f6du6Wvit7+4UGLgSc//n9KNZJnd2U=;
        b=ZeE2g8FJuwjaUrwBzqjDJ7ffHwLQMyHb4BNDQ9bSphP0A3VS5xIvw496dMkbbYQbu3
         /a+qEq5ToWhdsqapUhlEFgjaQLzySs41v9OJjptqER2dCQ+lpVdWPsqa+CPbZ6RJUeXN
         MkTMjE8MUQyH3wRJTv7QBq8+H/OuKyQV9iKjJizM+9ohu/0Pl+juTsGat8dBUNhAPtnp
         FI55nc6g8mwfAX4d9Dj6doGt+sx/V6RI+d7UdA/ruSehYZlkeLcYsbqRzLbGN6cvaYAO
         0J1wyQv4slSP9p8RGcRwD8PJdrYn4sGjX8y9E2GFH4RTxjBqKeu4VmIF/0GQnZF+L1it
         wyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvuKD18nXs5C0f6du6Wvit7+4UGLgSc//n9KNZJnd2U=;
        b=m5gOoA17iPv2D9Ps5cH0IY6GN6tXvAvu+ClqtswubBGETs38FNh3XLVaFuqy1wuKVN
         xPZjh2nUk8laSPtId6qrxoyEbOLiTaGpL6IH7b1xPnMEeNe3uNM7IJD4Bg3H3rAtSUlv
         pmy0xjtUWJItZAZmDrIeFtSs8q6NvWtnu3FaFybC79OJOJnQbI74EJzDJAHWjxjrqIjt
         v8kad4FmeE9wxTR49PuH5flAG/4uKAPLMoiAArWlA9XMpYw1Eit/jEdgxVUJkV45J1zJ
         hOQ6fwU1Dwlk2O4VY5g5kLAXeNx2ft6PAR1HG1C1q47csLPiJpcz2i6oypPyUo1lrVbZ
         C2WQ==
X-Gm-Message-State: ACrzQf3hpFK69jBgQtmONumvutCob7VKjG4gHdSptSiMA6MKe6+cPURK
        F5aLNiGQlmXd45FGaGNHaPv0fs8moFpG8w==
X-Google-Smtp-Source: AMsMyM4cUoHwZTyngzcx+bF4UO192jEYqwXF5DtB+xrdiGnSYEVJ1CIPPQHLl5OH6HQOikomQ8sJ5A==
X-Received: by 2002:a2e:98d2:0:b0:26c:66c1:87f9 with SMTP id s18-20020a2e98d2000000b0026c66c187f9mr5900566ljj.47.1667844840764;
        Mon, 07 Nov 2022 10:14:00 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t12-20020a056512208c00b00492aefd73a5sm1360716lfr.132.2022.11.07.10.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:14:00 -0800 (PST)
Message-ID: <9e0d2b3e-d3a6-0249-8cb3-29e0344708d4@linaro.org>
Date:   Mon, 7 Nov 2022 19:13:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: (subset) [PATCH 06/20] arm64: dts: Update cache properties for
 exynos
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob.Herring@arm.com, linux-samsung-soc@vger.kernel.org
References: <20221031091945.531874-1-pierre.gondois@arm.com>
 <166742051292.139492.12539582422109367063.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166742051292.139492.12539582422109367063.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 21:21, Krzysztof Kozlowski wrote:
> On Mon, 31 Oct 2022 10:19:45 +0100, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>>
>> The recently added init_of_cache_level() function checks
>> these properties. Add them if missing.
>>
>> [...]
> 
> Applied, thanks!
> 
> [06/20] arm64: dts: Update cache properties for exynos
>         https://git.kernel.org/krzk/linux/c/58710ae94589a2b2baaab6b6986064b691124b0d

Now dropped. I understand this is the intention/request of v2.

When resending be sure to use proper subject prefixes.

Best regards,
Krzysztof


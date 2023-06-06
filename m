Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62247237DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjFFGiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFFGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:38:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76E91;
        Mon,  5 Jun 2023 23:38:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso57581545e9.2;
        Mon, 05 Jun 2023 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686033525; x=1688625525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fEU/R7uNwrXrN5ufRI3K2w4J1jDo62wX5QshySlKS8=;
        b=DwTa7+n95K1HQKKXsmzPr9gwM9zVzm4EZkE46cS0gVQdUMKT9aXwvsP+6sBT34NavM
         5uiomYMmuRlRv7b8eWQE38KIVR6ro+YkduDcBoqzrKYe01jmcSFTwCwsLUeIXr32BAEf
         WwQ6i3rXE8Wqc3AhzehQeBQg24EGKzT+gN8f8dptZkua+mhPB1UFasY+Rm529PTSXv1s
         wgFqzRDeMQD8WGFuDk3cMN2+hyFKI7K35JcbycWRrqXX6QKcrJ0xLC3RodO674Yp7l5h
         tvRVxJKYJ+Xx9+3avlD8tqrjGMRNJ+nADQ56US1cOvQu0lUpr4QWI2QIEA1e4rzY1sD6
         vuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033525; x=1688625525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fEU/R7uNwrXrN5ufRI3K2w4J1jDo62wX5QshySlKS8=;
        b=UX/GIr9i7ahEmeJnsUytPyl5BGyLSO4cGJLmx8EzD1DkhgYVgh1AZoXatayjsF2maQ
         2pkmT9ysKY3G3NW2K/q5C179+whG/P/yE+xdCIR7OBmeUXS8XZ6zWObyPXbyfUG+ujra
         lduY+RSawOF3E0d1IjdJm1Ri8LqiflS6m4f5sfScFQqXzMziDzCfNoK3WwhIE62tFcm9
         VuNbilB3BK8CzgmVni2z2B3iQToz0oH4KIWOLFPmRCHN/7H3dSXiS/CpmazrggqQBc6y
         BBrHmvXKqRZspVUlGvAMCcF0DN7GOruS85h+5gn5+gHgDuHAQIsGZQacjqm79k2v8SjY
         8j3A==
X-Gm-Message-State: AC+VfDxPkHpXHjGDgkyFTzOD5qkJjlccwd6MlirOHLxQsYl3h5coyqcY
        UVHFygF8vumlHoqKOy/s3MY1Sg3Ec4OTDA==
X-Google-Smtp-Source: ACHHUZ6McQEZGjaQQTvaXPkSyIOv0cPTfkqYwCLndHUKJE5szBrihG/e54vaM6kpFk9nYG4TidsD4A==
X-Received: by 2002:a7b:c857:0:b0:3f4:447d:f74a with SMTP id c23-20020a7bc857000000b003f4447df74amr1365631wml.26.1686033524788;
        Mon, 05 Jun 2023 23:38:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b003079986fd71sm11707026wrx.88.2023.06.05.23.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:38:43 -0700 (PDT)
Message-ID: <4b2fdd36-0871-ecc7-5d64-e088d7f51987@gmail.com>
Date:   Tue, 6 Jun 2023 08:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230602183515.3778780-1-nfraprado@collabora.com>
 <01c88a42-274c-f8cf-73a6-29741579d9db@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <01c88a42-274c-f8cf-73a6-29741579d9db@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 10:21, AngeloGioacchino Del Regno wrote:
> Il 02/06/23 20:35, Nícolas F. R. A. Prado ha scritto:
>> The capacity-dmips-mhz parameter was miscalculated: this SoC runs
>> the first (Cortex-A55) cluster at a maximum of 2000MHz and the
>> second (Cortex-A76) cluster at a maximum of 2200MHz.
>>
>> In order to calculate the right capacity-dmips-mhz, the following
>> test was performed:
>> 1. CPUFREQ governor was set to 'performance' on both clusters
>> 2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
>> 3. Calculated the mean result for each cluster
>> 4. Calculated DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
>> 5. Scaled results to 1024:
>>     result_c0 = dmips_mhz_c0 / dmips_mhz_c1 * 1024
>>
>> The mean results for this SoC are:
>> Cluster 0 (LITTLE): 12016411 Dhry/s
>> Cluster 1 (BIG): 31702034 Dhry/s
>>
>> The calculated scaled results are:
>> Cluster 0: 426.953226899238 (rounded to 427)
>> Cluster 1: 1024
>>
>> Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and evaluation board 
>> dts and Makefile")
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
> 

Applied, thanks
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 

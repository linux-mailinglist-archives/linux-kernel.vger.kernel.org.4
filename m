Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198B6AC45C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCFPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCFPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:05:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2128872
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:05:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u9so39951968edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678115124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNTmcPK/a/OakyotOC2ABwm7bqjCs9B5ikZ1KDGhAKM=;
        b=vuV4Wj+bi0mYOFrswOQmM3/9OUdCeiaeyhsW/u1pnX8VJYB0t/9LQJ2gLsEXgAe+cW
         +pgF9aeRpKgCgQlnacEFFADvoJUOhCMceIGNQ/URYKyVMo57e/rsoVleGKSBB17UOdTA
         FGKsHoZUQEJW582UCatzWVVASlqvOMVipXeK8NqZ3IQQeYpppc80v+RmD6X44klPKZB8
         HPnbZqDZAmYLUufMvlsLFMBAbeR1p1/hPo8dcn79eFSOleQ50Vv6RaYeO2kWYtrRModb
         iKbAjVecCBCw5HPoy4a9U9ZiHV4d9U6cOUzXZn9eeKgh3jiGt5geRi6oGQF0IPduUsvo
         P50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678115124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNTmcPK/a/OakyotOC2ABwm7bqjCs9B5ikZ1KDGhAKM=;
        b=mM3QmmQGfaWz6kEhsmovgcaCau78hwjK+W85AsKXAW/1TLcf3TA6/Ap+YklSMFjRyd
         sLlI2+9+uSfbsoUrz+ZOtAW4AKFJxEk2YvU2DlNmgbxLNzFZtqTZCO4i8fRoEh8QcKKI
         m5KZvw8Hl7rPP3avVZnBDucr83gLtfxD72pCZw3hzqtTOmosHYPGILLyZZnQaJ4Mt5uN
         u8E6erkOzP5D3Wf85l90WWA6ZeX8B9qs5AOaXiR2XGBQKvemaY95g64pSwhIneOH8P1m
         TDvESd2kRa17JlAnV0ktesPP2Uwg6MoBJ3n4Jk45ghiHX3YlrBetcmMEp+CQwjNo38HM
         egBg==
X-Gm-Message-State: AO0yUKUeALA0c2HCzzDz9D56x51NRHAa1vd6HwP3SvdeG7JS8hwV3F10
        oGIfAgbRAzowSiv/zeNoHwmznA==
X-Google-Smtp-Source: AK7set8q/phI9/yKdS3oU02Yiq5MUx1ZZRHV7xyomcMn6iPNZOgixX+zm4nOCBa5rB7Prld5uzpX8g==
X-Received: by 2002:a17:906:4c84:b0:8b1:e78f:598b with SMTP id q4-20020a1709064c8400b008b1e78f598bmr11431619eju.50.1678115124552;
        Mon, 06 Mar 2023 07:05:24 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:c1e7:5006:98ac:f57? ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090686c600b008c44438734csm4694692ejy.113.2023.03.06.07.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:05:24 -0800 (PST)
Message-ID: <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
Date:   Mon, 6 Mar 2023 16:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v2 0/9] Tegra234 Memory interconnect support
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230220140559.28289-1-sumitg@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220140559.28289-1-sumitg@nvidia.com>
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

On 20/02/2023 15:05, Sumit Gupta wrote:
> This patch series adds memory interconnect support for Tegra234 SoC.
> It is used to dynamically scale DRAM Frequency as per the bandwidth
> requests from different Memory Controller (MC) clients.
> MC Clients use ICC Framework's icc_set_bw() api to dynamically request
> for the DRAM bandwidth (BW). As per path, the request will be routed
> from MC to the EMC driver. MC driver passes the request info like the
> Client ID, type, and frequency request info to the BPMP-FW which will
> set the final DRAM freq considering all exisiting requests.
> 
> MC and EMC are the ICC providers. Nodes in path for a request will be:
>      Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
> The patch series also adds interconnect support in below client drivers:
> 1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
>    added per cluster OPP table which will be used in the CPUFREQ driver
>    by requesting the minimum BW respective to the given CPU frequency in
>    the OPP table of given cluster.
> 2) PCIE driver to request BW required for different modes.

No dependencies or ordering written, so I am free to take memory
controller bits, I assume.

Best regards,
Krzysztof


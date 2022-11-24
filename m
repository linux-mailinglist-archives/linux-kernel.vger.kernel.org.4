Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D267163772B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKXLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKXLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:08:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724E627EC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:08:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n3so1968541wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPB19jMhZvyEVpBKn475+Cr5xWHotqcvvsxXAViZaPU=;
        b=IO1pN6Vibkb1R1OXiyH+6B69g6wuY7De8RS4j+IZAzelcUe5kls4IEzLsERyHvomF7
         WYTU2v13hkY887ycwQNlJQ6JwUqMCTsaFFAfllHoqtb0avEKhW710EL6L6ny5eaS5AVv
         2mS5bCorzVib5qAL/NYKF90ieAQEEGA8T5AdmmWGwVDNxeocoAOtdwQMu/i3w3lHI9zM
         o7O3hppPzsR7XQhXHQs7TV2eK8e59UKB5ckS8ZAkidKhJLgLalIjcJgoTx0F5F+hcuww
         qaUFt5Vw6KmZIhTteI+5rHGgtnB6EOtjdWtaNEObcfLMXnihFWq2O8gAZFWoQX95MIa0
         Cc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPB19jMhZvyEVpBKn475+Cr5xWHotqcvvsxXAViZaPU=;
        b=wfoote8bQBL4m5tUdwe6JrT6agVQwZMatsWRaLhLNt4itG7HoApIDmI/dV9zZMCTYJ
         Yn/Ypd/0LJ47m3ibWnr+7ROH07zJSXARbDznMVSnLnTY81iJ/Eb8d/aP0bPYcg24PJui
         f6v1NDNo4uefD5CuP96jRSGTiupON9Qi+fKnwUT8gGB/hguUVXhl3nyPzbVmmmjcrEXY
         HnbvHS1IB7O6p2yFePLQpUc5iI6oG2FGMjBFxQM/vVpC//6QUXRDKGL4InQ+4roTdVsv
         zRGOBboimO91mymcuxyR0Adj8AxtciNivzM9fr4Bx9ToIOSWaM9MeED5uR2wvuVVT5SS
         FF/Q==
X-Gm-Message-State: ANoB5pnMc1Jshka6muZveSCd1H6esc8pHB4zKmls/K8tYQVHk1infkmv
        MOtLrmCjJP8NaDz0MhxbeYP/XQ==
X-Google-Smtp-Source: AA0mqf5SBvq8eqFA1uFxwfZGOf2choXZwu1RhElPM+LaHZM2Un9OM42jwAmLZOz65pYdK+c+UdmU4Q==
X-Received: by 2002:a05:6000:12d1:b0:236:71fe:c9c5 with SMTP id l17-20020a05600012d100b0023671fec9c5mr19264996wrx.677.1669288081537;
        Thu, 24 Nov 2022 03:08:01 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bd9-20020a05600c1f0900b003c6bd12ac27sm1382131wmb.37.2022.11.24.03.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:08:00 -0800 (PST)
Message-ID: <83a961ef-132e-6b9a-37e0-182ea2025be4@linaro.org>
Date:   Thu, 24 Nov 2022 11:07:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/10] misc: fastrpc: Add audiopd support
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/09/2022 14:39, Abel Vesa wrote:
> This patchset adds audiopd support to fastrpc.
> 
> The v2 of this patchset is here:
> https://lore.kernel.org/all/20220902154900.3404524-1-abel.vesa@linaro.org/
> 
> Abel Vesa (10):
>    misc: fastrpc: Rename audio protection domain to root
>    misc: fastrpc: Add reserved mem support
>    dt-bindings: misc: fastrpc: Document memory-region property
>    misc: fastrpc: Add fastrpc_remote_heap_alloc
>    misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
>    misc: fastrpc: Rework fastrpc_req_munmap
>    misc: fastrpc: Add support for audiopd
>    misc: fastrpc: Safekeep mmaps on interrupted invoke
>    misc: fastrpc: Add mmap request assigning for static PD pool
>    misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
> 

Do you think you could pick these fastrpc patches as it is or should I 
collect these patches with other fastrpc patches on the list and send them?

As there are few more of fastrpc patches that could go in 6.2.

thanks,
Srini



>   .../bindings/misc/qcom,fastrpc.yaml           |   5 +
>   drivers/misc/fastrpc.c                        | 260 +++++++++++++++---
>   include/uapi/misc/fastrpc.h                   |   7 +
>   3 files changed, 240 insertions(+), 32 deletions(-)
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA587148BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjE2Lk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjE2LkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:40:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264210D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:40:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so3561488e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360410; x=1687952410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnP50kar14DpzkcsWdfhw9HR2nmUDWr1W10Tl3md5mo=;
        b=M+Z5yyhkdbMV9sJyF3AJuaqqFankJ9GPUDdwhK5KMpZwdoVMZGEGeoSiwFxyBFYYvR
         eGpNAZYsb7OZscOUdQzd8osEr8nKbGcUuw7B2UMV2xtSQ1u3sc5ZjrtftVyRuOY/ylgg
         D5oCQ8GdPjMmMNCwsYfcIJh3+Z97rF8gmdPucNV0b40KPYt1wgnfvMrPVNXqtGNgAoSJ
         8PSyDsg2VbNuYJJyXsNdkCjoOP5WzbIH5ntHoayXOb0OSs5p/eTDMZgPL5NBQmsyMYMK
         TYZm4X4h4Wl0pGSVosFkGYqYcKaMKoAIrhV5bpmZSz0f7ma0ueECqEX7zfMx5KnlQVPh
         wIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360410; x=1687952410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnP50kar14DpzkcsWdfhw9HR2nmUDWr1W10Tl3md5mo=;
        b=WaNfuvMkxt+gw7hnqI1jUNNckdno0/eYLniolnvK1N4AmxaZWHnVPx7zdC1rsrjhaD
         3WR1aHwVovOCOVMTtO/OL2qUys7r36c6vB6u8EFpbA0uVuIa4kWNx+M23SC0CLXMaTUF
         m9fxrZpJAaa5YNpkbMNVKhlKL6rLwv/1h47bIqOrV48d5UuxEootMI4qc5w+ci/anWDA
         PoguyMXlVp3mjVVSoO9am2pv+T7tFrxjcC87lzSIRPcvUpa6LlI10b18Nn2ihjTDUOaa
         3WSeQp1vnbCe0WTSKhHtHRq8lbZvbIm5ym3imWha9xaIm+TeIDomnShz6R+tZlad4W2K
         R+og==
X-Gm-Message-State: AC+VfDyO6aApOglTQCDTZiLJTOQ+y9KJALRyGk2l2bh6SWzkrOcv2i8Z
        1Hqvb15Y1UiUuSOXkJ8BV5ItZA==
X-Google-Smtp-Source: ACHHUZ7fI48ej5TXXqJctqcq03UNXCtn8FPIkCvh/I191Cx43aGKacvHHbK0WRyjIl/dICELADhWEQ==
X-Received: by 2002:ac2:4893:0:b0:4f4:4cd4:6df4 with SMTP id x19-20020ac24893000000b004f44cd46df4mr3764153lfc.25.1685360410337;
        Mon, 29 May 2023 04:40:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f4cabba7desm1934981lfn.74.2023.05.29.04.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:40:10 -0700 (PDT)
Message-ID: <8a2eb4ff-8a27-0a37-b9cc-1f522ddd1fa8@linaro.org>
Date:   Mon, 29 May 2023 13:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.05.2023 12:38, Georgi Djakov wrote:
> Hi Konrad,
> 
> On 26.05.23 12:17, Konrad Dybcio wrote:
>> Currently it's not possible to set just the bandwidth if the OPP
>> describes other properties (required-opps, opp-hz etc.).
>>
>> Introduce dev_pm_opp_set_bw() to solve this problem.
>>
> 
> Who is going to use this?
I wanted to use it with Adreno for fine-grained control during system
suspend/resume. It turned out that I was essentially then trying to power
on the hardware without its power supply.


https://lore.kernel.org/linux-kernel/8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org/T/#t

Konrad
> 
> BR,
> Georgi
> 

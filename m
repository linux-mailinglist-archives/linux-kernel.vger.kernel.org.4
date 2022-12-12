Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51464A1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiLLNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiLLNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:45:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A214D28
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:44:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p36so18617305lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHiKffR78TQm2drFlpAGS/qoww/hvaTuXfC1hf+5dBc=;
        b=s01zQqA8WlClp1xDYLNBuxnkJ3UG4KODJFvMh35ZqrCqN4E4h3sgmyXJJ0d5UCI3Ys
         JnhLL4qMAemepJM7xEceFZ8ZnlEpVJJjyBHqZmM3g+pKNTeh6B03m738/eMYiEeyKuw4
         H5pEkuCr0XEwPGGd6v3UdbeoxBeF7YWd4qZDtUwD5VMDO2I0OJYivaehrjVpT5Hjm1ET
         gfh8CppFtY5rYQehxgCBIowAdtdW7tFjbaLr8V50SEQK5O9QLcwF6ri0IDdXpJGWc2tl
         Ml1PAbmXwfML1Bhhaba100CaORf7+i3pJgE5KPYrkHdT7QcJfKgMWFOXSQGYaXnHCen8
         RZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHiKffR78TQm2drFlpAGS/qoww/hvaTuXfC1hf+5dBc=;
        b=f5LAl3UB25NqhzfkWj2Rtyy42M81g8SHNH+XnDEkUhZuDTiJPFBdYtHeqd4IeW1p23
         HpIWVObcrYfA5kDkn1XKqp8WG68LPxwuZkWUPPHnV4aoTDwN8u8EXtGPhfmyvILxzY/i
         P2tJ0dQs31Ncq+sjDTi3inV2wHPZC67sDNIjzeWUc/VOazCNUf8ndM44tnPv3qhOQKOJ
         ajHM8U5ALPec9kTIVDx4zLHy82QJBfLUNjz9zIK/qXjBCojHWIoVdtmAT0IkPjk8OeAW
         RiZlKWt5fu/eOgjcF3+SjvBAWToM2NniVcoH9u8f8r3lReca4zSrZ3R/xh9Ud7idITHP
         4i1g==
X-Gm-Message-State: ANoB5pn2urLyZi/lRc/Z4l5dNIs6OjKcmVPGp0rv4U3661dqdk+FiGik
        X/IIAyrWN3u6L0D9GjFEOpMKmQ==
X-Google-Smtp-Source: AA0mqf5GOca6Yz6tdzS6k9U/mHdrRc6WjqFv22z/KGI+vQ5DkEhLGEW6xMb8aPCLwcoCTPYOxdvvxg==
X-Received: by 2002:ac2:51af:0:b0:4b5:91b9:4d8d with SMTP id f15-20020ac251af000000b004b591b94d8dmr5531891lfk.19.1670852668002;
        Mon, 12 Dec 2022 05:44:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v27-20020ac2559b000000b0049a4862966fsm1632385lfg.146.2022.12.12.05.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:44:27 -0800 (PST)
Message-ID: <827ab36b-fe72-6d57-2ff8-66b78251c6f7@linaro.org>
Date:   Mon, 12 Dec 2022 14:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: correct SPMI bus address
 cells
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
 <93ad9c5d-784e-3cba-a34b-84f2ce4d3964@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93ad9c5d-784e-3cba-a34b-84f2ce4d3964@linaro.org>
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

On 12/12/2022 14:35, Konrad Dybcio wrote:
> 
> 
> On 12.12.2022 14:32, Krzysztof Kozlowski wrote:
>> The SPMI bus uses two address cells and zero size cells (secoond reg
> secoond sounds very Dutch ;)

Indeed...

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E60601FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJRAwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJRAvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:51:52 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C38980C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:51:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id p127so13369410oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++YEm2X3VpuQkbISsUK8GFhQZpmQpyZfoXHzrDKbz1o=;
        b=FVgkFmaH5sGeiw8duNFK9UsXWLj8kC1JBekA5Cj6dQZ1ludhryEMsAr6RzjdsK5HV2
         PBV3PUPaSsPwxpRgdbFMXYTgrO15rMM5PlPso9FoK6GNHKdSOFKfQFQsMmpW8r2rf+hA
         6ARbRWqT4FdIeeukuMTRCcYIm+TxyI1meXLyJP2UQZoK98htSDYda2KQ4xH/RhN+sA7q
         e/yYucYRrzQC7khDZW+2yu/va+tiiIsVYIYqmxDukkfZ6p4/a9JWrCN1raoepb2outp6
         Glts4V3KlsDCNJdp4V53rFKgio+URBj+osxPG6/Ciwr9m6F3VN9KHkfljkOrq8VklHox
         4khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++YEm2X3VpuQkbISsUK8GFhQZpmQpyZfoXHzrDKbz1o=;
        b=7giIfGPHGOfC7hCnZVBK2aEdW0aXE1GG9MqD+JnD+ray/NHuzT0fDi6Lt40iHWMovy
         l5AjOq0Zg3a0iv/jfp4C6gkwDYUc3NbJSxPti0B6QiexPm8rUojEVjyo73nLpna6+Sby
         cV0WKZdXqjM+knBPPibXZi4P6JsCWqcA0iQ7mshzoSboLbDnHZiZexUOVXa3/AO9tqXc
         5wnDKQH7GgQvZlraR7KhLQCzfKetpPf0gJlc6UcMGyVr737E/5eGAwDSVn39ZqRpueJ6
         PVE7w54W8DoIdRgfnetzfmQCODBfodYJLOpX0HEULg1zAwLsxgMHpKlFu472kaMhiZgc
         9BZA==
X-Gm-Message-State: ACrzQf2hTTq9yz/iYCIBySj6XcxdO2jDQtBiarSN7kwIBek8AZTT2g1/
        0DT65DT+9ndr/c8CIme6Sq2YGQ==
X-Google-Smtp-Source: AMsMyM4CniTbhUJ1/68vEI9m58DAMK115zJlcpKJ7av3jsu3SBoMHOKICrjw9TiACHsFIxsIysePwQ==
X-Received: by 2002:a05:6808:30a4:b0:354:92c2:3978 with SMTP id bl36-20020a05680830a400b0035492c23978mr14461123oib.212.1666054307691;
        Mon, 17 Oct 2022 17:51:47 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id v24-20020a4ae058000000b00480ba1434a6sm3701639oos.34.2022.10.17.17.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:51:47 -0700 (PDT)
Message-ID: <bc96324f-c560-3baf-a771-beef6955a537@kali.org>
Date:   Mon, 17 Oct 2022 19:51:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] clk: qcom: Add SC8280XP display clock controller
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926203800.16771-1-quic_bjorande@quicinc.com>
 <20220926203800.16771-3-quic_bjorande@quicinc.com>
 <a8bf3887-b4fb-1f60-14e4-998f71b84181@kali.org>
In-Reply-To: <a8bf3887-b4fb-1f60-14e4-998f71b84181@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Round 2 because the patch is too long for the mailing lists, I hope it 
is okay to strip out a bit of the patch

On 10/17/22 6:09 PM, Steev Klimaszewski wrote:
> Hi Bjorn,
>
> On 9/26/22 3:38 PM, Bjorn Andersson wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> The Qualcomm SC8280XP platform has two display clock controller
>> instances, add support for these. Duplication between the two
>> implementations is reduced by reusing any constant data between the two
>> sets of clock data.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> ---
>>
>> Changes since v1:
>> - Lowercased hex numbers
>> - Changed "DISP CC 0" in error print, to work for second dispcc as well.
>>
>>   drivers/clk/qcom/Kconfig           |    9 +
>>   drivers/clk/qcom/Makefile          |    1 +
>>   drivers/clk/qcom/dispcc-sc8280xp.c | 3218 ++++++++++++++++++++++++++++
>>   3 files changed, 3228 insertions(+)
>>   create mode 100644 drivers/clk/qcom/dispcc-sc8280xp.c
>>
Tested on Lenovo Thinkpad X13s

Tested-by: Steev Klimaszewski <steev@kali.org>

